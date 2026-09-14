"""Validate Mnemosphere's HOA4 coefficients and granular recordings.

Run ``python -m pytest faust/puredata/tests/test_mnemosphere.py``. Faust and a
C++ compiler provide numerical references; recordings require the built Pd and
external. pytest markers skip tests according to their checked prerequisites.
Pd launch helpers come from test_projects.

All C++, binaries, patches, and WAV files are created under tmp_path. Real
components use ACN 0..24 ordering and SN3D normalization, without the
Condon-Shortley phase. The DSP's last two outputs provide a separate preview.
"""

from array import array
import math
from pathlib import Path
import shutil
import struct
import subprocess
import sys

import pytest

ROOT = Path(__file__).resolve().parents[2]
PATCHES = ROOT / "puredata/pd-patches"
sys.path[:0] = [str(ROOT), str(PATCHES)]
from common.faust import DSP_DIR, include_options, load_project, project_builder  # noqa: E402
from test_projects import command, run, scheduled  # noqa: E402

STEM = "faustgen-mnemosphere-hoa4"
requires_faust = pytest.mark.skipif(shutil.which("faust") is None, reason="faust not found")
requires_cxx = pytest.mark.skipif(shutil.which("c++") is None, reason="C++ compiler not found")
requires_pd = pytest.mark.skipif(
    not (ROOT / "puredata/pd-faustgen/pure-data/src/pd").is_file(), reason="build Pd first",
)


def spherical_harmonics(azimuth, elevation):
    """Compute an independent reference for the 25 real HOA4 spherical harmonics.

    Args:
        azimuth: Horizontal angle in radians.
        elevation: Elevation in radians, within the geometric range -pi/2..pi/2.

    Returns:
        ACN-ordered list with orders m=-l..l for each degree l; index l(l+1)+m.
        Associated Legendre polynomials use a recurrence without Condon-Shortley
        phase, then SN3D normalization. Negative orders use sin, the others cos.
        The omnidirectional coefficient equals 1.

    This Python reference calls no function from the Faust implementation.
    """
    x = math.sin(elevation)
    result = []
    for degree in range(5):
        for order in range(-degree, degree + 1):
            # Orders +/-m share the polynomial; only the sin/cos factor differs.
            m = abs(order)
            diagonal = 1.0
            for k in range(1, m + 1):
                diagonal *= (2 * k - 1) * math.sqrt(1 - x * x)
            if degree == m:
                # The P_m^m diagonal initializes the recurrence for each order m.
                legendre = diagonal
            else:
                previous, legendre = diagonal, (2 * m + 1) * x * diagonal
                for k in range(m + 2, degree + 1):
                    previous, legendre = legendre, (
                        (2 * k - 1) * x * legendre - (k + m - 1) * previous
                    ) / (k - m)
            norm = math.sqrt((2 if m else 1) * math.factorial(degree - m) /
                             math.factorial(degree + m))
            # Order m=0 omits the sqrt(2) factor used by real +/-m components.
            angular = math.sin(m * azimuth) if order < 0 else math.cos(m * azimuth)
            result.append(norm * legendre * angular)
    return result


@requires_faust
@requires_cxx
@pytest.mark.parametrize("exported", [False, True])
def test_mnemosphere_has_true_fourth_order_acn_sn3d(tmp_path, exported):
    """Compile original/exported sources and compare their coefficients to HOA4 references.

    Args:
        tmp_path: Directory for the header, C++ measurement program, and binary.
        exported: Compile the exported Pd .dsp if True, the shared reference otherwise.

    Effects and motion are disabled and focus=1. After sine stabilization, each
    output's correlation with W is divided by W's energy to recover its angular
    coefficient independently of signal level. Check 25 coefficients at 23°/17°,
    unit energy per degree, and actual contribution from all nine fourth-order
    components, beyond merely counting outputs.
    """
    source = (PATCHES if exported else DSP_DIR) / f"{STEM}.dsp"
    header = tmp_path / "field.h"
    subprocess.run(["faust", *include_options(source), "-o", str(header), str(source)],
                   check=True, capture_output=True, text=True)
    cpp = tmp_path / "field.cpp"
    cpp.write_text(r'''
#include <algorithm>
#include <cmath>
#include <cstdint>
#include <iostream>
#include <memory>
#include <faust/dsp/dsp.h>
#include <faust/gui/MapUI.h>
#include <faust/gui/meta.h>
#include "field.h"
int main() {
    auto instance = std::make_unique<mydsp>();
    auto& dsp = *instance; dsp.init(48000);
    MapUI ui; dsp.buildUserInterface(&ui);
    for (const auto& p : {"grain_mix", "orbit_hz", "diffraction", "breathing", "running"})
        ui.setParamValue(p, 0);
    ui.setParamValue("focus", 1);
    float input[64], output[27][64];
    float* in[] = {input}; float* out[27];
    double energy = 0, correlation[25] = {};
    for (int c = 0; c < 27; ++c) out[c] = output[c];
    for (int b = 0; b < 800; ++b) {
        for (int s = 0; s < 64; ++s) input[s] = 0.1f * sin(2*M_PI*220*(b*64+s)/48000.0);
        dsp.compute(64, in, out);
        if (b < 400) continue;
        for (int s = 0; s < 64; ++s) {
            energy += output[0][s] * output[0][s];
            for (int c = 0; c < 25; ++c) correlation[c] += output[c][s] * output[0][s];
        }
    }
    if (dsp.getNumInputs() != 1 || dsp.getNumOutputs() != 27 || energy < 0.01) return 2;
    for (double value : correlation) std::cout << value / energy << " ";
}
''')
    binary = tmp_path / "field"
    subprocess.run(["c++", "-std=c++17", "-O2", "-I/usr/local/include", str(cpp), "-o", str(binary)],
                   check=True, capture_output=True, text=True)
    actual = list(map(float, subprocess.check_output([str(binary)], text=True).split()))
    expected = spherical_harmonics(math.radians(23), math.radians(17))
    assert len(actual) == 25
    assert actual == pytest.approx(expected, abs=0.0005)
    for degree in range(5):
        assert sum(value * value for value in actual[degree ** 2:(degree + 1) ** 2]) == pytest.approx(1, abs=0.001)
    assert any(abs(value) > 0.1 for value in actual[16:25])


def read_float_wave(path):
    """Read a little-endian RIFF WAV containing interleaved float32 samples.

    Args:
        path: File generated by writesf~, loaded entirely into memory.

    Returns:
        Tuple (channel count, sample rate, array('f')).

    Unknown chunks are skipped and odd sizes are padded to an even byte boundary.
    fmt accepts direct IEEE float or the IEEE float subtype of WAVE EXTENSIBLE.
    Samples are byte-swapped on a big-endian machine.

    This test helper assumes a valid WAV with fmt before data; it is not a general
    audio reader. Assertions reject unsupported encoding or missing data; file and
    structural errors are propagated.
    """
    blob = path.read_bytes()
    assert blob[:4] == b"RIFF" and blob[8:12] == b"WAVE"
    position = 12
    data = None
    while position + 8 <= len(blob):
        tag, size = struct.unpack_from("<4sI", blob, position)
        chunk = blob[position + 8:position + 8 + size]
        if tag == b"fmt ":
            encoding, channels, rate, _, _, bits = struct.unpack_from("<HHIIHH", chunk)
            if encoding == 0xFFFE:
                # The EXTENSIBLE subtype GUID starts at byte 24 of the fmt chunk.
                encoding = struct.unpack_from("<I", chunk, 24)[0]
            assert encoding == 3 and bits == 32
        elif tag == b"data":
            data = array("f")
            data.frombytes(chunk)
            if sys.byteorder != "little":
                data.byteswap()
        position += 8 + size + size % 2
    assert data is not None
    return channels, rate, data


@requires_faust
@requires_pd
def test_granular_memory_records_25_channels_and_a_stereo_preview(tmp_path):
    """Record the field and preview, then verify activity and memory after input silence.

    tmp_path receives portable source, an instrumented patch, and two float32 WAVs
    (25 and 2 channels at 48 kHz). Noise stops at 1600 ms, recording runs from
    100 to 3400 ms, and Pd quits at 3500 ms. WAV windows are therefore relative
    to recording start rather than loadbang.

    Every channel must stay finite, below amplitude 1, active during excitation,
    and energetic after it stops. Embedded source must remain compact and preserve
    the LGPL exception notice from the libraries used.
    """
    project = load_project(STEM)
    assert len(project.source) < 250_000
    assert "EXCEPTION TO THE LGPL LICENSE" in project.source
    p = project_builder(PATCHES, STEM)(project)
    (tmp_path / f"{STEM}.dsp").write_text(project.source)
    load = next(node for node in p.nodes if node.parameters.get("text") == "loadbang")
    dsp = next(node for node in p.nodes if node.parameters.get("text") == f"faustgen2~ {STEM}")
    hoa_writer = next(node for node in p.nodes if node.parameters.get("text") == "writesf~ 25")
    monitor_writer = p.add("writesf~ 2")
    for channel in range(2):
        p.link(dsp, monitor_writer, outlet=26 + channel, inlet=channel)
    source = p.add("*~ 0.05")
    p.link(p.add("noise~"), source)
    p.link(source, dsp, inlet=1)
    p.link(load, msg := p.add_msg("dsp 1"))
    p.link(msg, p.add("s pd"))
    for writer, name in ((hoa_writer, "hoa.wav"), (monitor_writer, "preview.wav")):
        p.link(load, msg := p.add_msg(f"open -bytes 4 {tmp_path / name}"))
        p.link(msg, writer)
        for time, message in ((100, "start"), (3400, "stop")):
            p.link(scheduled(p, load, time), msg := p.add_msg(message))
            p.link(msg, writer)
    p.link(scheduled(p, load, 1600), msg := p.add_msg("0"))
    p.link(msg, source, inlet=1)
    p.link(scheduled(p, load, 3500), msg := p.add_msg("quit"))
    p.link(msg, p.add("s pd"))
    path = tmp_path / "memory-recording.pd"
    p.save(path)
    run(command(path) + ["-batch"])
    for name, expected_channels in (("hoa.wav", 25), ("preview.wav", 2)):
        channels, rate, data = read_float_wave(tmp_path / name)
        assert (channels, rate) == (expected_channels, 48000)
        assert all(math.isfinite(value) and abs(value) < 1 for value in data)
        for channel in range(channels):
            active = data[int(rate * 0.3) * channels + channel:int(rate * 1.3) * channels:channels]
            tail = data[int(rate * 1.8) * channels + channel:int(rate * 2.5) * channels:channels]
            assert sum(value * value for value in active) / len(active) > 1e-9, (name, channel)
            assert sum(value * value for value in tail) / len(tail) > 1e-13, (name, channel)
