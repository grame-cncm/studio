#!/usr/bin/env python3
"""Generate an eight-input, sixteen-output Faustgen panner with py2max."""

from pathlib import Path
import sys


THIS_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(THIS_DIR / "py2max"))

from py2max import Patcher


OUTPUT = THIS_DIR / "faustgen-8x16-panner.maxpat"


def make_faust_source() -> str:
    """Build the 8-in/16-out Faust processor embedded in faustgen~."""
    inputs = ", ".join(f"in{index}" for index in range(1, 9))
    norm_terms = " + ".join(f"weight(source, {speaker})" for speaker in range(16))
    outputs = []
    for speaker in range(16):
        terms = " + ".join(
            f"in{source + 1} * speaker_gain({source}, {speaker})"
            for source in range(8)
        )
        outputs.append(f"    {terms}")
    output_text = ",\n".join(outputs)

    return f'''declare name "8 to 16 loudspeaker panner";
declare description "Rotating eight-source field distributed over sixteen loudspeakers";
declare author "GRAME";

import("stdfaust.lib");

azimuth = hslider("azimuth", 0, 0, 1, 0.001); // one clockwise turn
spread = hslider("spread", 0, 0, 1, 0.01);    // 0: directional, 1: diffuse
level = hslider("level", 0.8, 0, 1, 0.01);

// Eight sources lie at equal positions around the ring.  The positive cosine
// lobe distributes each source between the sixteen adjacent loudspeakers.
weight(source, speaker) = max(0, cos(2 * ma.PI *
    (azimuth + source / 8.0 - speaker / 16.0)));
normalization(source) = {norm_terms} + 0.000001;
speaker_gain(source, speaker) = level *
    ((1 - spread) * weight(source, speaker) / normalization(source)
     + spread / 16.0);

process({inputs}) =
{output_text};
'''


FAUST_SOURCE = make_faust_source()


def add_control(patcher: Patcher, faustgen, loadbang, name: str, initial: float,
                minimum: float, maximum: float, x: float) -> None:
    patcher.add_comment(name, patching_rect=[x, 250.0, 90.0, 20.0])
    value = patcher.add_floatbox(
        minimum=minimum,
        maximum=maximum,
        varname=f"{name}_value",
        patching_rect=[x, 273.0, 74.0, 22.0],
    )
    message = patcher.add_message(
        f"{name} $1", patching_rect=[x + 82.0, 273.0, 90.0, 22.0]
    )
    initial_value = patcher.add_message(
        f"set {initial}", patching_rect=[x, 301.0, 74.0, 22.0]
    )
    patcher.add_line(value, message)
    patcher.add_line(message, faustgen)
    patcher.add_line(loadbang, initial_value)
    patcher.add_line(initial_value, value)


def main() -> None:
    patcher = Patcher(OUTPUT, title="Faustgen 8×16 loudspeaker panner", semantic_ids=True)
    patcher.rect = [70.0, 70.0, 1420.0, 600.0]

    patcher.add_comment(
        "Faustgen — 8 inputs to 16 loudspeakers",
        patching_rect=[30.0, 20.0, 470.0, 28.0],
        fontsize=18.0,
    )
    patcher.add_comment(
        "Inputs 1–8 form an evenly spaced ring. Outputs 1–16 drive a clockwise "
        "sixteen-loudspeaker ring; azimuth rotates the complete sound field.",
        patching_rect=[30.0, 55.0, 850.0, 38.0],
        linecount=2,
    )

    loadbang = patcher.add_textbox(
        "loadbang", id="loadbang_1", patching_rect=[30.0, 120.0, 58.0, 22.0]
    )
    input_channels = " ".join(str(index) for index in range(1, 9))
    output_channels = " ".join(str(index) for index in range(1, 17))
    adc = patcher.add_textbox(
        f"mc.adc~ {input_channels}", numinlets=1, numoutlets=1,
        outlettype=["multichannelsignal"], patching_rect=[190.0, 125.0, 175.0, 22.0],
    )
    faustgen = patcher.add_textbox(
        "mc.faustgen~",
        id="faustgen_1",
        numinlets=1,
        numoutlets=3,
        outlettype=["multichannelsignal", "", ""],
        patching_rect=[530.0, 125.0, 72.0, 22.0],
        sourcecode=FAUST_SOURCE,
        sourcecode_size=len(FAUST_SOURCE.encode("utf-8")),
        sample_format=1,
        version="1.83",
        varname="faustgen_8x16_panner",
    )
    dac = patcher.add_textbox(
        f"mc.dac~ {output_channels}", numinlets=1, numoutlets=0,
        patching_rect=[700.0, 125.0, 290.0, 22.0],
    )
    patcher.add_line(adc, faustgen)
    patcher.add_line(faustgen, dac)

    patcher.add_comment("8-channel MC input", patching_rect=[190.0, 95.0, 150.0, 20.0])
    patcher.add_comment("16-channel MC loudspeaker output",
                        patching_rect=[835.0, 95.0, 260.0, 20.0])

    add_control(patcher, faustgen, loadbang, "azimuth", 0.0, 0.0, 1.0, 30.0)
    add_control(patcher, faustgen, loadbang, "spread", 0.0, 0.0, 1.0, 230.0)
    add_control(patcher, faustgen, loadbang, "level", 0.8, 0.0, 1.0, 430.0)

    patcher.add_comment(
        "Azimuth: 0–1 = one full clockwise rotation. Spread: 0 = directional "
        "distribution, 1 = equal level on all 16 outputs.",
        patching_rect=[30.0, 365.0, 650.0, 38.0],
        linecount=2,
    )
    patcher.save()


if __name__ == "__main__":
    main()
