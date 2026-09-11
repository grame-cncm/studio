#!/usr/bin/env python3
"""Generate the Faustgen additive polyphonic MIDI Max patch with py2max."""

from pathlib import Path
import sys


THIS_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(THIS_DIR / "py2max"))

from py2max import Patcher


OUTPUT = THIS_DIR / "faustgen-additive-poly-midi.maxpat"

# This source is stored directly in the faustgen~ object.  The three standard
# voice parameters are intentionally named /freq, /gain, and /gate so that
# faustgen~ can receive the MIDI events emitted by midiformat.
FAUST_SOURCE = r'''declare name "Additive polyphonic synthesizer";
declare description "Four-partial additive synthesizer for faustgen~";
declare author "GRAME";
declare nvoices "16";

import("stdfaust.lib");

freq = nentry("/freq", 440, 20, 20000, 1);
gain = nentry("/gain", 0.35, 0, 1, 0.01);
gate = button("/gate");

attack = hslider("attack", 0.01, 0.001, 2, 0.001);
decay = hslider("decay", 0.20, 0.001, 2, 0.001);
sustain = hslider("sustain", 0.70, 0, 1, 0.01);
release = hslider("release", 0.30, 0.001, 4, 0.001);

partial1 = hslider("partial1 [midi:ctrl 1]", 1.0, 0, 1, 0.01);
partial2 = hslider("partial2 [midi:ctrl 2]", 0.50, 0, 1, 0.01);
partial3 = hslider("partial3 [midi:ctrl 3]", 0.25, 0, 1, 0.01);
partial4 = hslider("partial4 [midi:ctrl 4]", 0.125, 0, 1, 0.01);

tone = partial1 * os.osc(freq)
     + partial2 * os.osc(2 * freq)
     + partial3 * os.osc(3 * freq)
     + partial4 * os.osc(4 * freq);

process = tone * en.adsr(attack, decay, sustain, release, gate) * gain <: _, _;
'''


def add_parameter(patcher: Patcher, name: str, initial: float, minimum: float,
                  maximum: float, x: float, y: float):
    """Add a labelled float UI control and its faustgen parameter message."""
    patcher.add_comment(name, patching_rect=[x, y, 105.0, 20.0])
    value = patcher.add_floatbox(
        minimum=minimum,
        maximum=maximum,
        patching_rect=[x, y + 22.0, 72.0, 22.0],
        varname=f"{name}_value",
    )
    message = patcher.add_message(
        f"{name} $1", patching_rect=[x + 78.0, y + 22.0, 96.0, 22.0]
    )
    initial_message = patcher.add_message(
        f"set {initial}", patching_rect=[x, y + 50.0, 72.0, 22.0]
    )
    patcher.add_line(value, message)
    return value, message, initial_message


def main() -> None:
    patcher = Patcher(
        OUTPUT,
        title="Faustgen additive polyphonic MIDI synthesizer",
        semantic_ids=True,
    )
    patcher.rect = [80.0, 80.0, 1120.0, 780.0]

    patcher.add_comment(
        "Faustgen — additive polyphonic MIDI synthesizer",
        patching_rect=[30.0, 20.0, 570.0, 30.0],
        fontsize=18.0,
    )
    patcher.add_comment(
        "The Faust source is embedded in faustgen~. Send MIDI from a keyboard "
        "or the on-screen kslider; CC 1–4 control the partial amplitudes.",
        patching_rect=[30.0, 55.0, 720.0, 40.0],
        linecount=2,
    )

    faustgen = patcher.add_textbox(
        "faustgen~",
        numinlets=1,
        numoutlets=4,
        outlettype=["signal", "signal", "", ""],
        patching_rect=[700.0, 450.0, 70.0, 22.0],
        sourcecode=FAUST_SOURCE,
        sourcecode_size=len(FAUST_SOURCE.encode("utf-8")),
        sample_format=1,
        version="1.83",
        varname="faustgen_additive",
    )
    dac = patcher.add_textbox(
        "ezdac~", maxclass="ezdac~", numinlets=2, numoutlets=0,
        patching_rect=[700.0, 520.0, 48.0, 48.0],
    )
    patcher.add_line(faustgen, dac)
    patcher.add_line(faustgen, dac, inlet=1, outlet=1)

    loadbang = patcher.add_textbox("loadbang", patching_rect=[30.0, 115.0, 58.0, 22.0])
    polyphony = patcher.add_message("polyphony 16", patching_rect=[100.0, 115.0, 90.0, 22.0])
    patcher.add_line(loadbang, polyphony)
    patcher.add_line(polyphony, faustgen)

    patcher.add_comment("MIDI input", patching_rect=[30.0, 165.0, 95.0, 20.0])
    midiin = patcher.add_textbox("midiin", patching_rect=[30.0, 190.0, 52.0, 22.0])
    midiparse = patcher.add_textbox("midiparse", patching_rect=[95.0, 190.0, 78.0, 22.0])
    patcher.add_line(midiin, midiparse)
    patcher.add_line(midiparse, faustgen, outlet=7)

    patcher.add_comment("On-screen keyboard", patching_rect=[260.0, 165.0, 130.0, 20.0])
    keyboard = patcher.add_textbox(
        "kslider", maxclass="kslider", numinlets=1, numoutlets=2,
        outlettype=["int", "int"], patching_rect=[260.0, 190.0, 370.0, 55.0],
    )
    makenote = patcher.add_textbox("makenote 100 250", patching_rect=[260.0, 260.0, 105.0, 22.0])
    join = patcher.add_textbox("join", patching_rect=[380.0, 260.0, 34.0, 22.0])
    midiformat = patcher.add_textbox("midiformat", patching_rect=[430.0, 260.0, 80.0, 22.0])
    patcher.add_line(keyboard, makenote)
    patcher.add_line(keyboard, makenote, inlet=1, outlet=1)
    patcher.add_line(makenote, join)
    patcher.add_line(makenote, join, inlet=1, outlet=1)
    patcher.add_line(join, midiformat)
    patcher.add_line(midiformat, faustgen, outlet=1)

    mute = patcher.add_textbox("toggle", maxclass="toggle", numinlets=1, numoutlets=1,
                               outlettype=["int"], patching_rect=[30.0, 310.0, 24.0, 24.0])
    mute_message = patcher.add_message("mute $1", patching_rect=[65.0, 311.0, 60.0, 22.0])
    patcher.add_comment("Mute", patching_rect=[30.0, 340.0, 60.0, 20.0])
    patcher.add_line(mute, mute_message)
    patcher.add_line(mute_message, faustgen)

    controls = [
        ("freq", 440.0, 20.0, 20000.0, 30.0, 390.0),
        ("gain", 0.35, 0.0, 1.0, 230.0, 390.0),
        ("attack", 0.01, 0.001, 2.0, 430.0, 390.0),
        ("decay", 0.20, 0.001, 2.0, 630.0, 390.0),
        ("sustain", 0.70, 0.0, 1.0, 30.0, 490.0),
        ("release", 0.30, 0.001, 4.0, 230.0, 490.0),
        ("partial1", 1.0, 0.0, 1.0, 430.0, 490.0),
        ("partial2", 0.5, 0.0, 1.0, 630.0, 490.0),
        ("partial3", 0.25, 0.0, 1.0, 30.0, 590.0),
        ("partial4", 0.125, 0.0, 1.0, 230.0, 590.0),
    ]
    for name, initial, minimum, maximum, x, y in controls:
        _, message, initial_message = add_parameter(
            patcher, name, initial, minimum, maximum, x, y
        )
        patcher.add_line(message, faustgen)
        patcher.add_line(loadbang, initial_message)
        patcher.add_line(initial_message, message)

    patcher.save()


if __name__ == "__main__":
    main()
