"""Validate the technique-independent GRAME studio loudspeaker layout."""

from pathlib import Path
import shutil
import sys

import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))

from common import faust  # noqa: E402


FAUST = shutil.which("faust")
LIBRARY = faust.DSP_DIR / "libraries/grame_studio_layout.lib"


@pytest.mark.skipif(FAUST is None, reason="Faust compiler is not installed")
@pytest.mark.parametrize(
    ("expression", "outputs"),
    [
        ("gsl.speakerCount", 1),
        ("gsl.speakerCartesian(0)", 3),
        ("gsl.speakerSpherical(27)", 3),
        ("gsl.speakerSphericalAt(0, 0.0, 0.0, 1.24)", 3),
        ("gsl.ringHardwareOutput(4, 0)", 1),
        ("gsl.ringCartesian(6, 5)", 3),
        ("gsl.ringSpherical(8, 7)", 3),
    ],
)
def test_public_layout_signatures(tmp_path, expression, outputs):
    """Geometry accessors must compile without an Ambisonic dependency."""
    source = tmp_path / "layout.dsp"
    source.write_text(
        'gsl = library("grame_studio_layout.lib");\n'
        f"process = {expression};\n"
    )
    metadata = faust.analyze_dsp(source, FAUST)
    assert metadata["inputs"] == 0
    assert metadata["outputs"] == outputs


def test_layout_follows_csv_order_and_conventional_ring_mappings():
    """Keep the physical-index and host-routing contract reviewable."""
    source = LIBRARY.read_text()
    assert "speaker-description/gramestudio-speaker-setup.csv" in source
    assert "hardwareOutput(I) = I + 1" in source
    assert "16 * (P == 4)" in source
    assert "10 * (P == 6)" in source
    assert "2 * (P == 8)" in source
    assert "isSubwoofer(I) = (I == 25) | (I == 26)" in source


def test_public_symbols_follow_faust_library_documentation_conventions():
    """Public API entries carry prefix headers, tests, and license metadata."""
    source = LIBRARY.read_text()
    public = [
        "speakerCount", "speakerX", "speakerY", "speakerZ",
        "speakerAzimuth", "speakerDistance", "speakerElevation",
        "speakerCartesian", "speakerSpherical", "speakerSphericalAt",
        "speakerGroup", "isSubwoofer", "isAtmoCenter", "hardwareOutput",
        "ringSpeakerIndex", "ringHardwareOutput", "ringCartesian",
        "ringSpherical", "ringSphericalAt",
    ]
    assert "Its official prefix is `gsl`" in source
    for name in public:
        assert f"`(gsl).{name}`" in source
        assert f'declare {name} license "CC-BY-NC-SA-4.0";' in source
        assert f"{name}_test" in source
