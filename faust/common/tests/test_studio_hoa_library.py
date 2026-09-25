"""Compile and embed the reusable GRAME studio HOA decoder library."""

import json
from pathlib import Path
import shutil
import subprocess
import sys

import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

from common import faust  # noqa: E402


FAUST = shutil.which("faust")
LIBRARY = faust.DSP_DIR / "libraries/grame_studio_hoa.lib"


@pytest.mark.skipif(FAUST is None, reason="Faust compiler is not installed")
@pytest.mark.parametrize(
    ("expression", "outputs"),
    [
        ("gs.abclibDecoder25(4, 1.0)", 25),
        ("gs.abclibDecoder26(4, 1.0)", 26),
        ("gs.abclibMaxReDecoder26(4, 1.0)", 26),
        ("gs.samplingDecoder25(4, 1.0)", 25),
        ("gs.samplingDecoder26(4, 1.0)", 26),
        ("gs.samplingDecoderAt(4, 26, 1.0, 0.0, 0.0, 1.24)", 26),
    ],
)
def test_order4_decoder_signatures(tmp_path, expression, outputs):
    """Every public decoder variant must accept 25 ACN/SN3D channels."""
    source = tmp_path / "decoder.dsp"
    source.write_text(
        'gs = library("grame_studio_hoa.lib");\n'
        f"process = {expression};\n"
    )
    metadata = faust.analyze_dsp(source, FAUST)
    assert metadata["inputs"] == 25
    assert metadata["outputs"] == outputs


@pytest.mark.skipif(FAUST is None, reason="Faust compiler is not installed")
def test_combined_library_can_be_embedded_without_local_paths(tmp_path):
    """The Max/Pd fallback bundler must recursively embed both local backends."""
    source = (
        'gs = library("libraries/grame_studio_hoa.lib");\n'
        "process = gs.samplingDecoder26(4, 1.0);\n"
    )
    bundled = faust.bundle_local_libraries(source, faust.DSP_DIR)
    # The usage examples of the libraries keep their library() line in
    # comments; only code must no longer refer to the local files.
    code = "\n".join(line.split("//", 1)[0] for line in bundled.splitlines())
    assert 'abc = library("abclib/' not in code
    assert 'ambi = library("ambitools/' not in code
    assert 'gsl = library("grame_studio_layout.lib")' not in code
    assert "/Users/" not in bundled
    dsp = tmp_path / "bundled.dsp"
    output = tmp_path / "bundled.cpp"
    dsp.write_text(bundled)
    subprocess.run(
        [FAUST, "-json", "-o", str(output), str(dsp)],
        check=True,
        capture_output=True,
        text=True,
    )
    metadata = json.loads(dsp.with_suffix(".dsp.json").read_text())
    assert metadata["inputs"] == 25
    assert metadata["outputs"] == 26


def test_library_documents_the_csv_geometry_and_subwoofer_exclusion():
    """Keep the source-level geometry contract visible and reviewable."""
    source = LIBRARY.read_text()
    assert 'gsl = library("grame_studio_layout.lib")' in source
    assert "subwoofers and are intentionally not decoded" in source
    assert "_hoaSpeakerIndex(i) = i + 2 * (i == 25)" in source
    assert "hardwareOutput(I) = gsl.hardwareOutput(_hoaSpeakerIndex(I))" in source


def test_public_symbols_follow_faust_library_documentation_conventions():
    """Public API entries carry prefix headers, usage/tests, and SPDX licenses."""
    source = LIBRARY.read_text()
    public = [
        "speakerCartesian", "speakerSpherical", "speakerSphericalAt",
        "hardwareOutput", "abclibDecoderAt", "abclibDecoder",
        "abclibDecoder25", "abclibDecoder26", "abclibMaxReDecoderAt",
        "abclibMaxReDecoder", "abclibMaxReDecoder25",
        "abclibMaxReDecoder26", "samplingDecoderAt", "samplingDecoder",
        "samplingDecoder25", "samplingDecoder26",
    ]
    assert "Its official prefix is `gs`" in source
    for name in public:
        assert f"`(gs).{name}`" in source
        assert f"declare {name} license \"CC-BY-NC-SA-4.0\";" in source
        assert f"{name}_test" in source
