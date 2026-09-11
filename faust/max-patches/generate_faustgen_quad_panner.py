#!/usr/bin/env python3
"""Generate a four-speaker Faustgen panner Max patch with py2max."""

from pathlib import Path
import sys


THIS_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(THIS_DIR / "py2max"))

from py2max import Patcher


OUTPUT = THIS_DIR / "faustgen-quad-panner.maxpat"

# A mono source is distributed on a clockwise ring: front, right, rear, left.
# ``spread`` crossfades from directional panning to an equal four-speaker mix.
FAUST_SOURCE = r'''declare name "Quadraphonic panner";
declare description "Constant-sum circular panner for four loudspeakers";
declare author "GRAME";

import("stdfaust.lib");

azimuth = hslider("azimuth", 0, 0, 1, 0.001); // one clockwise turn
spread = hslider("spread", 0, 0, 1, 0.01);    // 0: point source, 1: omni
level = hslider("level", 0.8, 0, 1, 0.01);

theta = 2 * ma.PI * azimuth;
front = max(0, cos(theta));
right = max(0, sin(theta));
rear  = max(0, 0 - cos(theta));
left  = max(0, 0 - sin(theta));
normalization = front + right + rear + left + 0.000001;

speaker(gain) = level * ((1 - spread) * gain / normalization + spread * 0.25);

process(input) = input * speaker(front), input * speaker(right),
                 input * speaker(rear), input * speaker(left);
'''


def add_control(
    patcher: Patcher,
    faustgen,
    loadbang,
    name: str,
    initial: float,
    minimum: float,
    maximum: float,
    x: float,
) -> None:
    """Create a Max control, parameter message, and load-time display value."""
    patcher.add_comment(name, patching_rect=[x, 265.0, 90.0, 20.0])
    value = patcher.add_floatbox(
        minimum=minimum,
        maximum=maximum,
        varname=f"{name}_value",
        patching_rect=[x, 288.0, 74.0, 22.0],
    )
    message = patcher.add_message(
        f"{name} $1", patching_rect=[x + 82.0, 288.0, 90.0, 22.0]
    )
    initial_value = patcher.add_message(
        f"set {initial}", patching_rect=[x, 316.0, 74.0, 22.0]
    )
    patcher.add_line(value, message)
    patcher.add_line(message, faustgen)
    patcher.add_line(loadbang, initial_value)
    patcher.add_line(initial_value, value)


def main() -> None:
    patcher = Patcher(OUTPUT, title="Faustgen quadraphonic panner", semantic_ids=True)
    patcher.rect = [80.0, 80.0, 980.0, 540.0]

    patcher.add_comment(
        "Faustgen — four-speaker circular panner",
        patching_rect=[30.0, 20.0, 450.0, 28.0],
        fontsize=18.0,
    )
    patcher.add_comment(
        "Input: mono source from ezadc~. Outputs: 1 front, 2 right, 3 rear, "
        "4 left. The Faust source is embedded directly in faustgen~.",
        patching_rect=[30.0, 55.0, 720.0, 38.0],
        linecount=2,
    )

    loadbang = patcher.add_textbox(
        "loadbang", id="loadbang_1", patching_rect=[30.0, 115.0, 58.0, 22.0]
    )
    faustgen = patcher.add_textbox(
        "faustgen~",
        id="faustgen_1",
        numinlets=1,
        numoutlets=4,
        outlettype=["signal", "signal", "signal", "signal"],
        patching_rect=[640.0, 180.0, 72.0, 22.0],
        sourcecode=FAUST_SOURCE,
        sourcecode_size=len(FAUST_SOURCE.encode("utf-8")),
        sample_format=1,
        version="1.83",
        varname="faustgen_quad_panner",
    )

    adc = patcher.add_textbox(
        "ezadc~", maxclass="ezadc~", numinlets=1, numoutlets=2,
        outlettype=["signal", "signal"], patching_rect=[470.0, 175.0, 48.0, 48.0],
    )
    dac = patcher.add_textbox(
        "dac~ 1 2 3 4", numinlets=4, numoutlets=0,
        patching_rect=[640.0, 390.0, 105.0, 22.0],
    )
    patcher.add_line(adc, faustgen)
    for outlet in range(4):
        patcher.add_line(faustgen, dac, inlet=outlet, outlet=outlet)

    patcher.add_comment("Audio input", patching_rect=[455.0, 145.0, 90.0, 20.0])
    patcher.add_comment("1: front   2: right   3: rear   4: left",
                        patching_rect=[610.0, 430.0, 310.0, 20.0])

    add_control(patcher, faustgen, loadbang, "azimuth", 0.0, 0.0, 1.0, 30.0)
    add_control(patcher, faustgen, loadbang, "spread", 0.0, 0.0, 1.0, 230.0)
    add_control(patcher, faustgen, loadbang, "level", 0.8, 0.0, 1.0, 430.0)

    patcher.add_comment(
        "Azimuth: 0 = front, 0.25 = right, 0.5 = rear, 0.75 = left. "
        "Spread = 1 sends an equal signal to all four speakers.",
        patching_rect=[30.0, 370.0, 540.0, 38.0],
        linecount=2,
    )
    patcher.save()


if __name__ == "__main__":
    main()
