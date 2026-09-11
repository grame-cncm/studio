#!/usr/bin/env python3
"""Generate a 1→6 MC Max patch from abclib's abc_2d_vbap6 DSP and JSON UI."""

from __future__ import annotations

import argparse
from dataclasses import dataclass
import json
from pathlib import Path
import subprocess
import sys
import tempfile


THIS_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(THIS_DIR.parent / "py2max"))

from py2max import Patcher


ABCLIB_ROOT = Path("/Users/letz/Developpements/abclib")
DSP_PATH = ABCLIB_ROOT / "faustCodes/abc_2d_vbaps/abc_2d_vbap6.dsp"
LIBRARY_PATH = ABCLIB_ROOT / "faustCodes/library"
FAUSTGEN_RESOURCES = Path(
    "/Users/letz/Documents/Max 9/Packages/faustgen/externals/msp/"
    "faustgen~.mxo/Contents/Resources"
)
OUTPUT = THIS_DIR / "faustgen-abclib-2d-vbap6.maxpat"


@dataclass(frozen=True)
class Parameter:
    """A Faust UI item, extracted from the compiler's JSON description."""

    shortname: str
    address: str
    initial: float
    minimum: float
    maximum: float
    step: float
    unit: str | None


def faust_json() -> dict:
    """Compile abclib's DSP to JSON using its local Faust library directory."""
    with tempfile.TemporaryDirectory(prefix="abclib-vbap-") as directory:
        output_dir = Path(directory)
        subprocess.run(
            [
                "faust", "-json", "-I", str(LIBRARY_PATH), "-O", str(output_dir),
                "-o", "abc_2d_vbap6.cpp", str(DSP_PATH),
            ],
            check=True,
        )
        return json.loads((output_dir / "abc_2d_vbap6.dsp.json").read_text(encoding="utf-8"))


def collect_parameters(items: list[dict]) -> list[Parameter]:
    """Flatten Faust JSON groups into addressable sliders, entries and buttons."""
    parameters: list[Parameter] = []
    for item in items:
        if "items" in item:
            parameters.extend(collect_parameters(item["items"]))
            continue
        if item.get("type") not in {"hslider", "vslider", "nentry", "button", "checkbox"}:
            continue
        metadata = {key: value for entry in item.get("meta", []) for key, value in entry.items()}
        parameters.append(
            Parameter(
                shortname=item["shortname"], address=item["address"],
                initial=float(item.get("init", 0)), minimum=float(item.get("min", 0)),
                maximum=float(item.get("max", 1)), step=float(item.get("step", 1)),
                unit=metadata.get("unit"),
            )
        )
    return parameters


def parameter_label(parameter: Parameter) -> str:
    """Give the generated Max UI a readable label without changing DSP address."""
    label = "Source azimuth" if parameter.shortname == "theta" else f"Speaker {parameter.shortname[1:]} angle"
    return f"{label} ({parameter.unit})" if parameter.unit else label


def add_control(patcher: Patcher, faustgen, loadbang, parameter: Parameter,
                x: float, y: float) -> None:
    """Use Faust's JSON address, never a hand-derived control selector."""
    patcher.add_comment(parameter_label(parameter), patching_rect=[x, y, 210.0, 20.0])
    value = patcher.add_floatbox(
        minimum=parameter.minimum, maximum=parameter.maximum,
        patching_rect=[x, y + 23.0, 78.0, 22.0], varname=f"{parameter.shortname}_value",
    )
    message = patcher.add_message(
        f"{parameter.address} $1", patching_rect=[x + 86.0, y + 23.0, 140.0, 22.0],
    )
    initial = patcher.add_message(
        f"{parameter.initial:g}", patching_rect=[x, y + 51.0, 78.0, 22.0],
    )
    patcher.add_line(value, message)
    patcher.add_line(message, faustgen)
    patcher.add_line(loadbang, initial)
    patcher.add_line(initial, value)
    patcher.add_line(initial, message)


def build_patch(source: str, parameters: list[Parameter]) -> None:
    patcher = Patcher(OUTPUT, title="abclib 2D VBAP — 1 input to 6 outputs", semantic_ids=True)
    patcher.rect = [60.0, 60.0, 1160.0, 660.0]
    patcher.add_comment(
        "abclib — 2D VBAP spatializer, 1 input → 6 loudspeakers",
        patching_rect=[30.0, 20.0, 670.0, 28.0], fontsize=18.0,
    )
    patcher.add_comment(
        "DSP: abc_2d_vbap6.dsp. Parameters come from `faust -json`; messages use their "
        "full Faust addresses (/vbap/…). Set each speaker angle to the real layout.",
        patching_rect=[30.0, 55.0, 1000.0, 38.0], linecount=2,
    )

    loadbang = patcher.add_textbox("loadbang", id="loadbang_1", patching_rect=[30.0, 120.0, 58.0, 22.0])
    adc = patcher.add_textbox(
        "mc.adc~ 1", id="adc_1", numinlets=1, numoutlets=1,
        outlettype=["multichannelsignal"], patching_rect=[170.0, 120.0, 72.0, 22.0],
    )
    tone = patcher.add_textbox(
        "mc.cycle~ 220", id="tone_1", numinlets=2, numoutlets=1,
        outlettype=["multichannelsignal"], patching_rect=[170.0, 160.0, 92.0, 22.0],
    )
    tone_toggle = patcher.add_textbox(
        "toggle", id="tone_toggle_1", maxclass="toggle", numinlets=1, numoutlets=1,
        outlettype=["int"], patching_rect=[280.0, 160.0, 24.0, 24.0],
    )
    tone_offset = patcher.add_textbox("+ 1", id="tone_offset_1", patching_rect=[315.0, 160.0, 35.0, 22.0])
    selector = patcher.add_textbox(
        "mc.selector~ 2", id="selector_1", numinlets=3, numoutlets=1,
        outlettype=["multichannelsignal"], patching_rect=[370.0, 120.0, 96.0, 22.0],
    )
    faustgen = patcher.add_textbox(
        "mc.faustgen~", id="faustgen_1", numinlets=1, numoutlets=3,
        outlettype=["multichannelsignal", "", ""], patching_rect=[540.0, 120.0, 94.0, 22.0],
        sourcecode=source, sourcecode_size=len(source.encode("utf-8")), sample_format=1,
        version="1.83", library_path0=f"{LIBRARY_PATH}/",
        library_path1=f"{FAUSTGEN_RESOURCES}/", varname="abclib_2d_vbap6",
    )
    dac = patcher.add_textbox(
        "mc.dac~ 1 2 3 4 5 6", id="dac_1", numinlets=1, numoutlets=0,
        patching_rect=[730.0, 120.0, 168.0, 22.0],
    )
    patcher.add_comment("Input 1", patching_rect=[170.0, 92.0, 80.0, 20.0])
    patcher.add_comment("Internal 220 Hz test tone", patching_rect=[170.0, 190.0, 200.0, 20.0])
    patcher.add_comment("MC outputs 1–6", patching_rect=[730.0, 92.0, 160.0, 20.0])
    patcher.add_line(adc, selector, inlet=1)
    patcher.add_line(tone, selector, inlet=2)
    patcher.add_line(tone_toggle, tone_offset)
    patcher.add_line(tone_offset, selector)
    patcher.add_line(selector, faustgen)
    patcher.add_line(faustgen, dac)

    for index, parameter in enumerate(parameters):
        x = 30.0 + (index % 4) * 275.0
        y = 255.0 + (index // 4) * 115.0
        add_control(patcher, faustgen, loadbang, parameter, x, y)

    patcher.add_comment(
        "Test: enable audio and the 220 Hz tone. With the default circular layout, set Source azimuth "
        "to 0°, 60°, 120°, 180°, 240° and 300° to focus the source successively on outputs 1–6.",
        patching_rect=[30.0, 510.0, 1050.0, 42.0], linecount=2,
    )
    patcher.save()


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true")
    arguments = parser.parse_args()
    source = DSP_PATH.read_text(encoding="utf-8")
    description = faust_json()
    parameters = collect_parameters(description["ui"])
    if description["inputs"] != 1 or description["outputs"] != 6:
        raise ValueError("abc_2d_vbap6 no longer has a 1-in/6-out DSP signature.")
    if {parameter.address for parameter in parameters} != {
        "/vbap/a0", "/vbap/a1", "/vbap/a2", "/vbap/a3", "/vbap/a4", "/vbap/a5", "/vbap/theta",
    }:
        raise ValueError("Unexpected abclib VBAP UI address map.")
    build_patch(source, parameters)
    if arguments.check:
        print(f"Generated {OUTPUT.name}: {description['inputs']} input, {description['outputs']} outputs, {len(parameters)} JSON controls.")


if __name__ == "__main__":
    main()
