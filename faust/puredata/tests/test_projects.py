"""Check the PureData ports against their Faust DSPs, including MIDI polyphony."""

import math
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys

import pytest

from py2pd import Patcher

ROOT = Path(__file__).resolve().parents[1]
PATCHES = ROOT / "pd-patches"
sys.path.insert(0, str(PATCHES))
from pd_helpers import generate, pd_name  # noqa: E402
from common.faust import (  # noqa: E402
    DSP_DIR, PROJECTS, analyze_dsp, include_options, load_project, parameters, project_builder,
)

PD = Path(os.environ.get("PD_BIN", ROOT / "pd-faustgen/pure-data/src/pd"))
EXTERNAL = Path(os.environ.get("FAUSTGEN_EXTERNAL", ROOT / "pd-faustgen/external/faustgen2~.pd_darwin"))
SYNTH = "faustgen-additive-poly-midi"
MNEMOSPHERE = "faustgen-mnemosphere-hoa4"
requires_pd = pytest.mark.skipif(not PD.is_file() or not EXTERNAL.is_file(), reason="build pd-faustgen first")
requires_faust = pytest.mark.skipif(shutil.which("faust") is None, reason="faust not found")


def command(*paths, preload=True):
    args = [str(PD.resolve()), "-noprefs", "-nostdpath", "-nogui", "-noaudio", "-stderr", "-r", "48000"]
    if preload:
        args += ["-lib", str(EXTERNAL.resolve().with_suffix(""))]
    for path in paths:
        args += ["-open", str(path.resolve())]
    return args


def run(args):
    result = subprocess.run(args, capture_output=True, text=True, timeout=90)
    console = result.stdout + result.stderr
    assert result.returncode == 0, console
    assert "error:" not in console.lower() and "couldn't create" not in console, console
    return console


@requires_faust
def test_all_generated_projects_are_current_and_portable(tmp_path):
    for stem in PROJECTS:
        for path in generate(stem, tmp_path):
            assert path.read_bytes() == (PATCHES / path.name).read_bytes(), stem
        dsp = (tmp_path / f"{stem}.dsp").read_text()
        assert "/Users/" not in dsp and "/private/" not in dsp
    assert (DSP_DIR / "libraries/abclib/faustCodes/library/abc.lib").is_file()
    assert (tmp_path / "faustgen-abclib-2d-vbap6.dsp").read_bytes() == (
        PATCHES / "faustgen-abclib-2d-vbap6.dsp").read_bytes()


@requires_pd
@requires_faust
@pytest.mark.parametrize("stem", PROJECTS)
def test_saved_patch_loads_external_and_initializes_controls(stem):
    metadata = analyze_dsp(PATCHES / f"{stem}.dsp")
    params = parameters(metadata["ui"])
    # Legacy-polyphony parameter queries in this upstream revision send to a
    # null outlet on secondary voices. MIDI/control writes do not use queries.
    queries = [] if stem == SYNTH else [f"{stem} {pd_name(item['label'])}" for item in params]
    console = run(command(PATCHES / f"{stem}.pd", preload=False) +
                  ["-send", "; ".join(queries + ["pd quit"])])
    assert f"faustgen2~ {stem} ({metadata['inputs']}/{metadata['outputs']})" in console
    if stem == SYNTH:
        assert "[16 voice polyphony (nvoices:16)]" in console
    else:
        for item in params:
            name = pd_name(item["label"])
            found = re.search(rf"^{stem}: {name} ([-+\d.eE]+)$", console, re.M)
            assert found, console
            assert float(found[1]) == pytest.approx(item.get("init", 0), abs=1e-6)


@requires_pd
def test_saved_projects_can_coexist_in_one_pd_process():
    console = run(command(*(PATCHES / f"{stem}.pd" for stem in PROJECTS), preload=False)
                  + ["-send", "pd quit"])
    for stem in PROJECTS:
        assert f"faustgen2~ {stem} (" in console


def settings(stem):
    initial, changed = {}, {}
    if stem == "faustgen-stereo-orbit":
        initial = {"running": 0, "speed": 0}
        return initial, initial | {"azimuth": 0.125, "spread": 0.3}
    if "zita" in stem or "spatial-reverb" in stem:
        initial["reverb_mix"] = 0
    if "vbap-reverb" in stem:
        initial["reverb_wet"] = 0
    if "per-input" in stem:
        changed = {"input1_azimuth": 0.03125, "input3_gain": 0.5}
    elif "abclib" in stem:
        changed = {"theta": 30}
    elif "spatial-reverb" in stem:
        changed = {"pan": 0.125, "output_gain": 0.5}
    else:
        changed = {"azimuth": 0.125}
    return initial, initial | changed


def reference(tmp_path, stem, values):
    """Compute original Faust output in C++, independently of the Pd graph."""
    source = DSP_DIR / f"{stem}.dsp"
    header = tmp_path / "reference.h"
    subprocess.run(["faust", *include_options(source), "-o", str(header), str(source)], check=True,
                   capture_output=True, text=True)
    cpp = tmp_path / "reference.cpp"
    cpp.write_text(r'''
#include <algorithm>
#include <cmath>
#include <cstdint>
#include <iostream>
#include <vector>
#include <faust/dsp/dsp.h>
#include <faust/gui/MapUI.h>
#include <faust/gui/meta.h>
#include "reference.h"
int main(int argc, char** argv) {
    mydsp dsp;
    dsp.init(48000);
    MapUI ui;
    dsp.buildUserInterface(&ui);
    for (int i = 1; i < argc; ++i) {
        std::string arg(argv[i]);
        auto pos = arg.find('=');
        auto key = arg.substr(0, pos);
        if (!ui.getParamZone(key)) return 2;
        ui.setParamValue(key, std::stof(arg.substr(pos+1)));
    }
    std::vector<std::vector<float>> ins(dsp.getNumInputs(), std::vector<float>(64));
    std::vector<std::vector<float>> outs(dsp.getNumOutputs(), std::vector<float>(64));
    std::vector<float*> in, out;
    for (int i = 0; i < dsp.getNumInputs(); ++i) {
        std::fill(ins[i].begin(), ins[i].end(), 0.05f * (i+1));
        in.push_back(ins[i].data());
    }
    for (auto& buffer : outs) out.push_back(buffer.data());
    for (int i = 0; i < 400; ++i) dsp.compute(64, in.data(), out.data());
    for (auto& buffer : outs) std::cout << buffer.back() << " ";
}
''')
    binary = tmp_path / "reference"
    subprocess.run(["c++", "-std=c++17", "-O2", "-I/usr/local/include", str(cpp), "-o", str(binary)],
                   check=True, capture_output=True, text=True)
    result = subprocess.check_output([str(binary), *(f"{key}={value}" for key, value in values.items())], text=True)
    return [float(value) for value in result.split()]


def scheduled(p, load, time):
    delay = p.add(f"delay {time}")
    p.link(load, delay)
    return delay


@requires_pd
@requires_faust
@pytest.mark.skipif(shutil.which("c++") is None, reason="C++ compiler not found")
@pytest.mark.parametrize("stem", [name for name in PROJECTS if name not in {SYNTH, MNEMOSPHERE}])
def test_every_audio_channel_matches_faust_after_controls_and_compile(tmp_path, stem):
    metadata = analyze_dsp(PATCHES / f"{stem}.dsp")
    before, after = settings(stem)
    expected_before = reference(tmp_path, stem, before)
    expected_after = reference(tmp_path, stem, after)
    if "per-input" in stem:
        # The eight default source positions coincide with every other speaker.
        assert expected_before == pytest.approx(
            [0.05 * (channel // 2 + 1) if channel % 2 == 0 else 0 for channel in range(16)],
            abs=1e-6,
        )
    assert expected_before != pytest.approx(expected_after, abs=1e-6)
    shutil.copyfile(PATCHES / f"{stem}.dsp", tmp_path / f"{stem}.dsp")
    p = Patcher()
    load = p.add("loadbang")
    dsp = p.add(f"faustgen2~ {stem}", num_inlets=metadata["inputs"] + 1,
                num_outlets=metadata["outputs"] + 1)
    for channel in range(metadata["inputs"]):
        p.link(p.add(f"sig~ {0.05 * (channel + 1)}"), dsp, inlet=channel + 1)
    p.link(load, msg := p.add_msg("dsp 1"))
    p.link(msg, p.add("s pd"))
    for values, trigger in ((before, load), (after, scheduled(p, load, 700))):
        for key, value in values.items():
            p.link(trigger, msg := p.add_msg(f"{pd_name(key)} {value}"))
            p.link(msg, dsp)
    p.link(scheduled(p, load, 1000), msg := p.add_msg("compile"))
    p.link(msg, dsp)
    for stage, time in (("INITIAL", 500), ("UPDATED", 950), ("RECOMPILED", 1600)):
        trigger = scheduled(p, load, time)
        for channel in range(metadata["outputs"]):
            snap = p.add("snapshot~")
            p.link(dsp, snap, outlet=channel + 1)
            p.link(trigger, snap)
            p.link(snap, p.add(f"print {stage}_{channel}"))
    p.link(scheduled(p, load, 1700), msg := p.add_msg("quit"))
    p.link(msg, p.add("s pd"))
    path = tmp_path / "probe.pd"
    p.save(path)
    console = run(command(path) + ["-batch"])
    for stage, expected in (("INITIAL", expected_before), ("UPDATED", expected_after),
                             ("RECOMPILED", expected_after)):
        for channel, value in enumerate(expected):
            found = re.search(rf"^{stage}_{channel}: ([-+\d.eE]+)$", console, re.M)
            assert found, console
            assert math.isfinite(float(found[1])), console
            assert float(found[1]) == pytest.approx(value, abs=2e-6, rel=1e-5), console


@requires_pd
def test_midi_chord_has_simultaneous_voices_and_releases(tmp_path):
    """Use individual fundamental projections to distinguish a chord from one voice."""
    p = Patcher()
    load = p.add("loadbang")
    shutil.copyfile(PATCHES / f"{SYNTH}.dsp", tmp_path / f"{SYNTH}.dsp")
    dsp = p.add(f"faustgen2~ {SYNTH}", num_inlets=1, num_outlets=3)
    p.link(load, msg := p.add_msg("dsp 1"))
    p.link(msg, p.add("s pd"))
    # Remove harmonics so energy at all three fundamentals proves polyphony.
    for name, value in (("partial2", 0), ("partial3", 0), ("partial4", 0),
                         ("sustain", 1), ("release", 0.01)):
        p.link(load, msg := p.add_msg(f"{name} {value}"))
        p.link(msg, dsp)
    for note in (60, 64, 67):
        p.link(scheduled(p, load, 10), msg := p.add_msg(f"note {note} 100 1"))
        p.link(msg, dsp)
    for channel in (1, 2):
        energy = p.add("env~ 4096")
        p.link(dsp, energy, outlet=channel)
        store = p.add("f")
        p.link(energy, store, inlet=1)
        p.link(scheduled(p, load, 300), store)
        p.link(store, p.add(f"print CHORD_{channel}"))
        released = p.add("f")
        p.link(energy, released, inlet=1)
        p.link(scheduled(p, load, 700), released)
        p.link(released, p.add(f"print RELEASED_{channel}"))
    for note in (60, 64, 67):
        frequency = 440 * 2 ** ((note - 69) / 12)
        filt = p.add(f"bp~ {frequency} 80")
        p.link(dsp, filt, outlet=1)
        energy = p.add("env~ 4096")
        p.link(filt, energy)
        store = p.add("f")
        p.link(energy, store, inlet=1)
        p.link(scheduled(p, load, 300), store)
        p.link(store, p.add(f"print NOTE_{note}"))
    # A bang is the external's all-notes-off command.
    p.link(scheduled(p, load, 400), dsp)
    p.link(scheduled(p, load, 800), msg := p.add_msg("quit"))
    p.link(msg, p.add("s pd"))
    path = tmp_path / "midi.pd"
    p.save(path)
    console = run(command(path) + ["-batch"])
    for label in ("CHORD_1", "CHORD_2", "NOTE_60", "NOTE_64", "NOTE_67"):
        match = re.search(rf"^{label}: ([-+\d.eE]+)$", console, re.M)
        assert match and float(match[1]) > 60, console
    for channel in (1, 2):
        match = re.search(rf"^RELEASED_{channel}: ([-+\d.eE]+)$", console, re.M)
        assert match and float(match[1]) == 0, console


@requires_pd
@requires_faust
@pytest.mark.parametrize("stem", ["faustgen-mono-stereo-spatial-reverb", "faustgen-mono-6out-zita",
                                 "faustgen-8x16-per-input-vbap-reverb"])
def test_reverb_tail_reaches_all_output_channels(tmp_path, stem):
    metadata = analyze_dsp(PATCHES / f"{stem}.dsp")
    shutil.copyfile(PATCHES / f"{stem}.dsp", tmp_path / f"{stem}.dsp")
    p = Patcher()
    load = p.add("loadbang")
    dsp = p.add(f"faustgen2~ {stem}", num_inlets=metadata["inputs"] + 1,
                num_outlets=metadata["outputs"] + 1)
    sources = []
    for channel in range(metadata["inputs"]):
        source = p.add("*~ 0.03")
        p.link(p.add("noise~"), source)
        p.link(source, dsp, inlet=channel + 1)
        sources.append(source)
    p.link(load, msg := p.add_msg("dsp 1"))
    p.link(msg, p.add("s pd"))
    wet = "reverb_wet" if "vbap-reverb" in stem else "reverb_mix"
    p.link(load, msg := p.add_msg(f"{pd_name(wet)} 1"))
    p.link(msg, dsp)
    if "vbap-reverb" in stem:
        for channel in range(metadata["inputs"]):
            p.link(load, msg := p.add_msg(f"input{channel + 1}-spread 1"))
            p.link(msg, dsp)
    p.link(scheduled(p, load, 500), msg := p.add_msg("0"))
    for source in sources:
        p.link(msg, source, inlet=1)
    for channel in range(metadata["outputs"]):
        energy = p.add("env~ 4096")
        p.link(dsp, energy, outlet=channel + 1)
        store = p.add("f")
        p.link(energy, store, inlet=1)
        p.link(scheduled(p, load, 900), store)
        p.link(store, p.add(f"print TAIL_{channel}"))
    p.link(scheduled(p, load, 1000), msg := p.add_msg("quit"))
    p.link(msg, p.add("s pd"))
    path = tmp_path / "tail.pd"
    p.save(path)
    console = run(command(path) + ["-batch"])
    for channel in range(metadata["outputs"]):
        match = re.search(rf"^TAIL_{channel}: ([-+\d.eE]+)$", console, re.M)
        assert match and math.isfinite(float(match[1])) and float(match[1]) > 20, console


@requires_faust
@pytest.mark.skipif(shutil.which("c++") is None, reason="C++ compiler not found")
@pytest.mark.parametrize("spread", [0, 1])
def test_stereo_orbit_point_and_diffuse_energy(tmp_path, spread):
    values = {"running": 0, "speed": 0, "width": 0, "azimuth": 0,
              "spread": spread, "level": 0.5}
    actual = reference(tmp_path, "faustgen-stereo-orbit", values)
    # Inputs 0.05 + 0.10, both at the front. Allow float smoothing roundoff.
    expected = [0.075 / math.sqrt(8)] * 8 if spread else [0.075, 0, 0, 0, 0, 0, 0, 0]
    assert actual == pytest.approx(expected, abs=5e-6)
    assert sum(value * value for value in actual) == pytest.approx(0.075 ** 2, abs=5e-7)


@requires_pd
def test_stereo_orbit_rotates_freezes_and_reverses(tmp_path):
    stem = "faustgen-stereo-orbit"
    shutil.copyfile(PATCHES / f"{stem}.dsp", tmp_path / f"{stem}.dsp")
    p = Patcher()
    load = p.add("loadbang")
    dsp = p.add(f"faustgen2~ {stem}", num_inlets=3, num_outlets=9)
    p.link(p.add("sig~ 1"), dsp, inlet=1)
    p.link(p.add("sig~ 0"), dsp, inlet=2)
    p.link(load, msg := p.add_msg("dsp 1"))
    p.link(msg, p.add("s pd"))
    for key, value in {"width": 0, "speed": 1, "running": 1, "level": 1}.items():
        p.link(load, msg := p.add_msg(f"{key} {value}"))
        p.link(msg, dsp)
    for time, messages in ((1150, ("running 0",)),
                           (1500, ("speed -1", "running 1"))):
        trigger = scheduled(p, load, time)
        for message in messages:
            p.link(trigger, msg := p.add_msg(message))
            p.link(msg, dsp)
    stages = {f"MOVE{index}": 200 + 125 * index for index in range(8)}
    stages.update({"FROZEN1": 1300, "FROZEN2": 1450, "REVERSE1": 1800, "REVERSE2": 1925})
    for stage, time in stages.items():
        trigger = scheduled(p, load, time)
        for channel in range(8):
            snapshot = p.add("snapshot~")
            p.link(dsp, snapshot, outlet=channel + 1)
            p.link(trigger, snapshot)
            p.link(snapshot, p.add(f"print {stage}_{channel}"))
    p.link(scheduled(p, load, 2000), msg := p.add_msg("quit"))
    p.link(msg, p.add("s pd"))
    path = tmp_path / "orbit-motion.pd"
    p.save(path)
    console = run(command(path) + ["-batch"])
    samples = {}
    for stage in stages:
        values = []
        for channel in range(8):
            match = re.search(rf"^{stage}_{channel}: ([-+\d.eE]+)$", console, re.M)
            assert match, console
            values.append(float(match[1]))
        assert all(math.isfinite(value) for value in values), console
        assert sum(value * value for value in values) == pytest.approx(1, abs=0.001), console
        samples[stage] = values
    def strongest(values):
        return max(range(8), key=values.__getitem__)
    positions = [strongest(samples[f"MOVE{index}"]) for index in range(8)]
    assert len(set(positions)) == 8, positions
    assert all((b - a) % 8 == 1 for a, b in zip(positions, positions[1:])), positions
    assert samples["FROZEN1"] == pytest.approx(samples["FROZEN2"], abs=1e-6)
    assert (strongest(samples["REVERSE2"]) - strongest(samples["REVERSE1"])) % 8 == 7


@requires_pd
@requires_faust
def test_stereo_orbit_internal_tones_reach_all_outputs_and_switch_off(tmp_path):
    stem = "faustgen-stereo-orbit"
    project = load_project(stem)
    p = project_builder(PATCHES, stem)(project)
    (tmp_path / f"{stem}.dsp").write_text(project.source)
    load = next(node for node in p.nodes if node.parameters.get("text") == "loadbang")
    dsp = next(node for node in p.nodes if node.parameters.get("text") == f"faustgen2~ {stem}")
    choice = next(node for node in p.nodes if node.parameters.get("label") == "test-tones")
    for time, value in ((50, 1), (600, 0)):
        p.link(scheduled(p, load, time), msg := p.add_msg(str(value)))
        p.link(msg, choice)
    p.link(scheduled(p, load, 60), msg := p.add_msg("spread 1"))
    p.link(msg, dsp)
    p.link(load, msg := p.add_msg("dsp 1"))
    p.link(msg, p.add("s pd"))
    for channel in range(8):
        energy = p.add("env~ 4096")
        p.link(dsp, energy, outlet=channel + 1)
        for stage, time in (("ON", 500), ("OFF", 1000)):
            selected = p.add("f")
            p.link(energy, selected, inlet=1)
            p.link(scheduled(p, load, time), selected)
            p.link(selected, p.add(f"print {stage}_{channel}"))
    p.link(scheduled(p, load, 1100), msg := p.add_msg("quit"))
    p.link(msg, p.add("s pd"))
    path = tmp_path / "orbit-tones.pd"
    p.save(path)
    console = run(command(path) + ["-batch"])
    for channel in range(8):
        on = re.search(rf"^ON_{channel}: ([-+\d.eE]+)$", console, re.M)
        off = re.search(rf"^OFF_{channel}: ([-+\d.eE]+)$", console, re.M)
        # Two independent 0.1-amplitude sines, level 0.5, uniform eight-way gain.
        expected_db = 100 + 20 * math.log10(0.1 * 0.5 / math.sqrt(8))
        assert on and float(on[1]) == pytest.approx(expected_db, abs=0.05), console
        assert off and float(off[1]) == 0, console
