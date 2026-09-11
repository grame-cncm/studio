#!/usr/bin/env python3
"""Generate the Max UI directly from the controls declared in a Faust DSP file."""

from __future__ import annotations

import argparse
from dataclasses import dataclass
from pathlib import Path
import re
import sys


THIS_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(THIS_DIR.parent / "py2max"))

from py2max import Patcher


DSP_PATH = THIS_DIR / "faustgen-mono-6out-zita.dsp"
OUTPUT = THIS_DIR / "faustgen-mono-6out-zita.maxpat"
NUMBER = r"[-+]?(?:\d+(?:\.\d*)?|\.\d+)"
HSLIDER = re.compile(
    rf'^\s*(?P<name>[A-Za-z_]\w*)\s*=\s*hslider\("(?P<label>[^"]+)",\s*'
    rf'(?P<initial>{NUMBER}),\s*(?P<minimum>{NUMBER}),\s*(?P<maximum>{NUMBER}),\s*'
    rf'(?P<step>{NUMBER})\);\s*$',
    re.MULTILINE,
)


@dataclass(frozen=True)
class Parameter:
    name: str
    address: str
    initial: float
    minimum: float
    maximum: float


def read_dsp() -> str:
    """Read the standalone Faust source and reject malformed UI declarations."""
    source = DSP_PATH.read_text(encoding="utf-8")
    if "re.zita_rev1_stereo" not in source or "process" not in source:
        raise ValueError("The DSP must use re.zita_rev1_stereo and declare process.")
    return source


def parameters_from(source: str) -> list[Parameter]:
    """Use Faust hslider definitions as the only UI parameter specification."""
    parameters = [
        Parameter(
            name=match["name"],
            address=match["label"].split("[", 1)[0].strip(),
            initial=float(match["initial"]),
            minimum=float(match["minimum"]), maximum=float(match["maximum"]),
        )
        for match in HSLIDER.finditer(source)
    ]
    if not parameters:
        raise ValueError("No hslider parameter was found in the DSP source.")
    names = [parameter.name for parameter in parameters]
    if len(names) != len(set(names)):
        raise ValueError("Faust parameter names must be unique.")
    if any(parameter.name != parameter.address for parameter in parameters):
        raise ValueError(
            "Each hslider label must be the matching identifier so Max can address it reliably."
        )
    return parameters


def add_control(patcher: Patcher, faustgen, loadbang, parameter: Parameter,
                x: float, y: float) -> None:
    """Create a Max control and send its initial value reliably after load."""
    patcher.add_comment(
        parameter.name.replace("_", " ").replace("rt60", "RT60").title(),
        patching_rect=[x, y, 190.0, 20.0],
    )
    value = patcher.add_floatbox(
        minimum=parameter.minimum, maximum=parameter.maximum,
        patching_rect=[x, y + 23.0, 78.0, 22.0], varname=f"{parameter.name}_value",
    )
    parameter_message = patcher.add_message(
        f"{parameter.address} $1", patching_rect=[x + 86.0, y + 23.0, 116.0, 22.0],
    )
    # A numeric message, unlike "set <value>", emits a value to Faust as well
    # as displaying it in the Max number box.
    initial_message = patcher.add_message(
        f"{parameter.initial:g}", patching_rect=[x, y + 51.0, 78.0, 22.0],
    )
    patcher.add_line(value, parameter_message)
    patcher.add_line(parameter_message, faustgen)
    patcher.add_line(loadbang, initial_message)
    patcher.add_line(initial_message, value)
    patcher.add_line(initial_message, parameter_message)


def build_patch(source: str, parameters: list[Parameter]) -> None:
    """Create a 1-in / 6-out MC patch from the supplied Faust source."""
    patcher = Patcher(OUTPUT, title="Faustgen mono-to-six Zita spatial reverb", semantic_ids=True)
    patcher.rect = [70.0, 70.0, 1250.0, 700.0]
    patcher.add_comment(
        "Faustgen — mono input to six-speaker Zita spatial reverb",
        patching_rect=[30.0, 20.0, 650.0, 28.0], fontsize=18.0,
    )
    patcher.add_comment(
        "The UI is generated from the hslider declarations in faustgen-mono-6out-zita.dsp. "
        "Three re.zita_rev1_stereo instances feed loudspeaker pairs 1–2, 3–4 and 5–6.",
        patching_rect=[30.0, 55.0, 1090.0, 38.0], linecount=2,
    )

    loadbang = patcher.add_textbox("loadbang", id="loadbang_1", patching_rect=[30.0, 120.0, 58.0, 22.0])
    adc = patcher.add_textbox(
        "mc.adc~ 1", id="adc_1", numinlets=1, numoutlets=1,
        outlettype=["multichannelsignal"], patching_rect=[170.0, 120.0, 72.0, 22.0],
    )
    test_tone = patcher.add_textbox(
        "mc.cycle~ 220", id="test_tone_1", numinlets=2, numoutlets=1,
        outlettype=["multichannelsignal"], patching_rect=[170.0, 160.0, 92.0, 22.0],
    )
    test_toggle = patcher.add_textbox(
        "toggle", id="test_toggle_1", maxclass="toggle", numinlets=1, numoutlets=1,
        outlettype=["int"], patching_rect=[280.0, 160.0, 24.0, 24.0],
    )
    test_offset = patcher.add_textbox("+ 1", id="test_offset_1", patching_rect=[315.0, 160.0, 35.0, 22.0])
    selector = patcher.add_textbox(
        "mc.selector~ 2", id="source_selector_1", numinlets=3, numoutlets=1,
        outlettype=["multichannelsignal"], patching_rect=[370.0, 120.0, 96.0, 22.0],
    )
    faustgen = patcher.add_textbox(
        "mc.faustgen~", id="faustgen_1", numinlets=1, numoutlets=3,
        outlettype=["multichannelsignal", "", ""], patching_rect=[540.0, 120.0, 94.0, 22.0],
        sourcecode=source, sourcecode_size=len(source.encode("utf-8")), sample_format=1,
        version="1.83", varname="faustgen_mono_6out_zita",
    )
    dac = patcher.add_textbox(
        "mc.dac~ 1 2 3 4 5 6", id="dac_1", numinlets=1, numoutlets=0,
        patching_rect=[730.0, 120.0, 168.0, 22.0],
    )
    patcher.add_comment("Input 1", patching_rect=[165.0, 92.0, 80.0, 20.0])
    patcher.add_comment("Enable internal 220 Hz test tone", patching_rect=[170.0, 190.0, 215.0, 20.0])
    patcher.add_comment("Six-channel MC output", patching_rect=[730.0, 92.0, 200.0, 20.0])
    patcher.add_line(adc, selector, inlet=1)
    patcher.add_line(test_tone, selector, inlet=2)
    patcher.add_line(test_toggle, test_offset)
    patcher.add_line(test_offset, selector)
    patcher.add_line(selector, faustgen)
    patcher.add_line(faustgen, dac)

    for index, parameter in enumerate(parameters):
        x = 30.0 + (index % 4) * 295.0
        y = 255.0 + (index // 4) * 115.0
        add_control(patcher, faustgen, loadbang, parameter, x, y)

    patcher.add_comment(
        "Test protocol: enable audio, turn on the 220 Hz test tone, then move Azimuth. "
        "At 0, 1/6, … 5/6 turns, the dry signal is respectively focused on outputs 1 … 6; "
        "the three Zita stereo pairs provide the wet field.",
        patching_rect=[30.0, 535.0, 1120.0, 42.0], linecount=2,
    )
    patcher.save()


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="validate the DSP and generated patch")
    args = parser.parse_args()
    source = read_dsp()
    parameters = parameters_from(source)
    build_patch(source, parameters)
    if args.check:
        print(f"Generated {OUTPUT.name} from {DSP_PATH.name} with {len(parameters)} Faust parameters.")


if __name__ == "__main__":
    main()
