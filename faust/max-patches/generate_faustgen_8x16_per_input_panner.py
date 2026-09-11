#!/usr/bin/env python3
"""Generate an 8-input / 16-output MC Faustgen panner with per-input controls."""

from pathlib import Path
import sys


THIS_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(THIS_DIR / "py2max"))

from py2max import Patcher


OUTPUT = THIS_DIR / "faustgen-8x16-per-input-panner.maxpat"


def make_faust_source() -> str:
    """Build the embedded Faust source with azimuth, spread, and gain per input."""
    controls = []
    for source in range(1, 9):
        controls.extend(
            [
                f'input{source}_azimuth = hslider("input{source}_azimuth", '
                f'{(source - 1) / 8:.3f}, 0, 1, 0.001);',
                f'input{source}_spread = hslider("input{source}_spread", 0, 0, 1, 0.01);',
                f'input{source}_gain = hslider("input{source}_gain", 1, 0, 1, 0.01);',
            ]
        )

    inputs = ", ".join(f"in{index}" for index in range(1, 9))
    source_buses = ",\n    ".join(
        f"(in{source} : source_panner(input{source}_azimuth, "
        f"input{source}_spread, input{source}_gain))"
        for source in range(1, 9)
    )

    return f'''declare name "8 to 16 per-input loudspeaker panner";
declare description "Independent azimuth, spread, and gain for eight inputs";
declare author "GRAME";

import("stdfaust.lib");
ho = library("hoa.lib");

{chr(10).join(controls)}

// `circularScaledVBAP` computes the 16 VBAP gains from the actual speaker
// angles.  Spread crossfades its directional output with an equal 16-channel
// distribution while preserving the individual input gain.
speakers = (0, 22.5, 45, 67.5, 90, 112.5, 135, 157.5,
            180, 202.5, 225, 247.5, 270, 292.5, 315, 337.5);
directional(azimuth, spread) = ho.circularScaledVBAP(speakers, azimuth * 360)
    : par(i, 16, *(1 - spread));
diffuse(spread) = _ <: par(i, 16, *(spread / 16.0));
source_panner(azimuth, spread, gain) = *(gain) <:
    (directional(azimuth, spread), diffuse(spread)) :> par(i, 16, +);

process({inputs}) =
    ({source_buses}) :> si.bus(16);
'''


FAUST_SOURCE = make_faust_source()


def add_control(patcher: Patcher, faustgen, loadbang, name: str, label: str,
                initial: float, minimum: float, maximum: float,
                x: float, y: float) -> None:
    """Add one labelled float control and message connection to mc.faustgen~."""
    patcher.add_comment(label, patching_rect=[x, y, 70.0, 20.0])
    value = patcher.add_floatbox(
        minimum=minimum,
        maximum=maximum,
        varname=f"{name}_value",
        patching_rect=[x, y + 20.0, 72.0, 22.0],
    )
    message = patcher.add_message(
        f"{name} $1", patching_rect=[x + 78.0, y + 20.0, 145.0, 22.0]
    )
    initial_value = patcher.add_message(
        f"set {initial}", patching_rect=[x, y + 47.0, 72.0, 22.0]
    )
    patcher.add_line(value, message)
    patcher.add_line(message, faustgen)
    patcher.add_line(loadbang, initial_value)
    patcher.add_line(initial_value, value)


def main() -> None:
    patcher = Patcher(
        OUTPUT,
        title="Faustgen 8×16 panner with independent input controls",
        semantic_ids=True,
    )
    patcher.rect = [60.0, 60.0, 1420.0, 1110.0]

    patcher.add_comment(
        "Faustgen — 8 inputs to 16 loudspeakers: independent input controls",
        patching_rect=[30.0, 20.0, 720.0, 28.0],
        fontsize=18.0,
    )
    patcher.add_comment(
        "Each input has independent azimuth (0–1 turn), spread (directional to diffuse), "
        "and gain. The embedded Faust processor outputs one MC signal with 16 channels.",
        patching_rect=[30.0, 55.0, 960.0, 38.0],
        linecount=2,
    )

    loadbang = patcher.add_textbox(
        "loadbang", id="loadbang_1", patching_rect=[30.0, 120.0, 58.0, 22.0]
    )
    input_channels = " ".join(str(index) for index in range(1, 9))
    output_channels = " ".join(str(index) for index in range(1, 17))
    adc = patcher.add_textbox(
        f"mc.adc~ {input_channels}", numinlets=1, numoutlets=1,
        outlettype=["multichannelsignal"], patching_rect=[180.0, 120.0, 175.0, 22.0],
    )
    faustgen = patcher.add_textbox(
        "mc.faustgen~",
        id="faustgen_1",
        numinlets=1,
        numoutlets=3,
        outlettype=["multichannelsignal", "", ""],
        patching_rect=[500.0, 120.0, 94.0, 22.0],
        sourcecode=FAUST_SOURCE,
        sourcecode_size=len(FAUST_SOURCE.encode("utf-8")),
        sample_format=1,
        version="1.83",
        varname="faustgen_8x16_per_input_panner",
    )
    dac = patcher.add_textbox(
        f"mc.dac~ {output_channels}", numinlets=1, numoutlets=0,
        patching_rect=[730.0, 120.0, 290.0, 22.0],
    )
    patcher.add_line(adc, faustgen)
    patcher.add_line(faustgen, dac)

    patcher.add_comment("8-channel MC input", patching_rect=[180.0, 92.0, 150.0, 20.0])
    patcher.add_comment("16-channel MC loudspeaker output",
                        patching_rect=[730.0, 92.0, 260.0, 20.0])

    for source in range(1, 9):
        y = 190.0 + (source - 1) * 105.0
        patcher.add_comment(
            f"Input {source}", patching_rect=[30.0, y + 22.0, 80.0, 22.0],
            fontsize=14.0,
        )
        add_control(
            patcher, faustgen, loadbang, f"input{source}_azimuth", "Azimuth",
            (source - 1) / 8, 0.0, 1.0, 130.0, y,
        )
        add_control(
            patcher, faustgen, loadbang, f"input{source}_spread", "Spread",
            0.0, 0.0, 1.0, 410.0, y,
        )
        add_control(
            patcher, faustgen, loadbang, f"input{source}_gain", "Gain",
            1.0, 0.0, 1.0, 690.0, y,
        )

    patcher.save()


if __name__ == "__main__":
    main()
