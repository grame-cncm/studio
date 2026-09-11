#!/usr/bin/env python3
"""Generate the per-input 8×16 VBAP patch with one reverb per output."""

from pathlib import Path
import sys


THIS_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(THIS_DIR / "py2max"))

from py2max import Patcher
from generate_faustgen_8x16_per_input_panner import add_control, make_faust_source


OUTPUT = THIS_DIR / "faustgen-8x16-per-input-vbap-reverb.maxpat"


def make_reverb_source() -> str:
    """Extend the VBAP processor with 16 independent mono Freeverb instances."""
    source = make_faust_source()
    prefix, process = source.rsplit("\nprocess(", 1)
    prefix = prefix.replace(
        'ho = library("hoa.lib");',
        'ho = library("hoa.lib");\nre = library("reverbs.lib");',
    )
    reverb_definitions = r'''

// Each instance in the following `par` is a separate mono reverb state.
reverb_wet = hslider("reverb_wet", 0.25, 0, 1, 0.01);
reverb_feedback1 = hslider("reverb_feedback1", 0.78, 0, 0.99, 0.01);
reverb_feedback2 = hslider("reverb_feedback2", 0.70, 0, 0.99, 0.01);
reverb_damping = hslider("reverb_damping", 0.20, 0, 1, 0.01);
reverb_spread = hslider("reverb_spread", 24, 0, 46, 1);

channel_reverb(wet, fb1, fb2, damp, width) = _ <:
    (_, re.mono_freeverb(fb1, fb2, damp, width)) : (*(1 - wet), *(wet)) : +;
'''
    process = process.replace(
        ") :> si.bus(16);",
        ") :> si.bus(16) : par(i, 16, channel_reverb(reverb_wet, "
        "reverb_feedback1, reverb_feedback2, reverb_damping, reverb_spread));",
    )
    return prefix + reverb_definitions + "\nprocess(" + process


FAUST_SOURCE = make_reverb_source()


def add_reverb_control(
    patcher: Patcher,
    faustgen,
    loadbang,
    name: str,
    label: str,
    initial: float,
    minimum: float,
    maximum: float,
    y: float,
) -> None:
    add_control(
        patcher, faustgen, loadbang, name, label, initial, minimum, maximum,
        1010.0, y,
    )


def main() -> None:
    patcher = Patcher(
        OUTPUT,
        title="Faustgen 8×16 VBAP panner with per-output reverberation",
        semantic_ids=True,
    )
    patcher.rect = [60.0, 60.0, 1500.0, 1110.0]

    patcher.add_comment(
        "Faustgen — 8 inputs / 16 outputs VBAP with independent output reverbs",
        patching_rect=[30.0, 20.0, 800.0, 28.0],
        fontsize=18.0,
    )
    patcher.add_comment(
        "Each source has azimuth, spread, and gain. The resulting 16 VBAP channels "
        "each pass through a separate mono Freeverb instance before mc.dac~.",
        patching_rect=[30.0, 55.0, 1000.0, 38.0],
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
        varname="faustgen_8x16_vbap_reverb",
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

    patcher.add_comment("Reverb shared parameters — separate state per output",
                        patching_rect=[1010.0, 155.0, 390.0, 22.0], fontsize=14.0)
    reverb_controls = [
        ("reverb_wet", "Wet", 0.25, 0.0, 1.0),
        ("reverb_feedback1", "Feedback 1", 0.78, 0.0, 0.99),
        ("reverb_feedback2", "Feedback 2", 0.70, 0.0, 0.99),
        ("reverb_damping", "Damping", 0.20, 0.0, 1.0),
        ("reverb_spread", "Spread", 24.0, 0.0, 46.0),
    ]
    for index, (name, label, initial, minimum, maximum) in enumerate(reverb_controls):
        add_reverb_control(
            patcher, faustgen, loadbang, name, label, initial, minimum, maximum,
            190.0 + index * 105.0,
        )

    patcher.save()


if __name__ == "__main__":
    main()
