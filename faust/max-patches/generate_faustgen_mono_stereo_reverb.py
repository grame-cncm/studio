#!/usr/bin/env python3
"""Generate a mono-to-stereo spatial reverb patch using mc.faustgen~."""

from pathlib import Path
import sys


THIS_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(THIS_DIR.parent / "py2max"))

from py2max import Patcher


OUTPUT = THIS_DIR / "faustgen-mono-stereo-spatial-reverb.maxpat"

# The low-level Zita implementation is used directly so every reverb parameter
# is addressable from Max rather than being hidden inside the Zita Light UI.
FAUST_SOURCE = r'''declare name "Mono to stereo spatial reverb";
declare description "Equal-power stereo panner with configurable Zita Rev1 stereo reverb";
declare author "GRAME";

import("stdfaust.lib");
re = library("reverbs.lib");

pan = hslider("pan", 0.5, 0, 1, 0.001);
reverb_mix = hslider("reverb_mix", 0.30, 0, 1, 0.01);
zita_predelay = hslider("zita_predelay", 60, 20, 100, 1);
zita_lf_x = hslider("zita_lf_x", 200, 50, 1000, 1);
zita_low_rt60 = hslider("zita_low_rt60", 3, 1, 8, 0.1);
zita_mid_rt60 = hslider("zita_mid_rt60", 2, 1, 8, 0.1);
zita_hf_damping = hslider("zita_hf_damping", 6000, 1500, 20000, 1);
output_gain = hslider("output_gain", 0.80, 0, 1, 0.01);

panned(x) = x * cos(ma.PI * 0.5 * pan), x * sin(ma.PI * 0.5 * pan);
mix(dry_l, dry_r, wet_l, wet_r) = output_gain * ((1 - reverb_mix) * dry_l + reverb_mix * wet_l),
                                      output_gain * ((1 - reverb_mix) * dry_r + reverb_mix * wet_r);

// The direct form exposes every zita_rev1_stereo FDN parameter in Max.
process = panned : _,_ <: re.zita_rev1_stereo(zita_predelay, zita_lf_x,
          zita_hf_damping, zita_low_rt60, zita_mid_rt60, 48000),_,_ : mix;
'''


def add_control(patcher: Patcher, faustgen, loadbang, name: str, label: str,
                initial: float, minimum: float, maximum: float, x: float, y: float):
    """Add a float box, Faust parameter message, and load-time default."""
    patcher.add_comment(label, patching_rect=[x, y, 125.0, 20.0])
    value = patcher.add_floatbox(
        minimum=minimum, maximum=maximum,
        patching_rect=[x, y + 23.0, 78.0, 22.0], varname=f"{name}_value",
    )
    message = patcher.add_message(
        f"{name} $1", patching_rect=[x + 86.0, y + 23.0, 112.0, 22.0]
    )
    initial_message = patcher.add_message(
        f"set {initial}", patching_rect=[x, y + 51.0, 78.0, 22.0]
    )
    patcher.add_line(value, message)
    patcher.add_line(message, faustgen)
    patcher.add_line(loadbang, initial_message)
    patcher.add_line(initial_message, value)


def main() -> None:
    patcher = Patcher(OUTPUT, title="Faustgen mono-to-stereo spatial reverb", semantic_ids=True)
    patcher.rect = [80.0, 80.0, 1030.0, 590.0]

    patcher.add_comment(
        "Faustgen — mono input to stereo spatial reverb",
        patching_rect=[30.0, 20.0, 580.0, 28.0], fontsize=18.0,
    )
    patcher.add_comment(
        "mc.faustgen~ embeds the Faust DSP: equal-power panning followed by a "
        "fully configurable stereo Zita Rev1 reverb (re.zita_rev1_stereo).",
        patching_rect=[30.0, 55.0, 850.0, 38.0], linecount=2,
    )

    loadbang = patcher.add_textbox("loadbang", id="loadbang_1", patching_rect=[30.0, 120.0, 58.0, 22.0])
    adc = patcher.add_textbox(
        "mc.adc~ 1", id="adc_1", numinlets=1, numoutlets=1,
        outlettype=["multichannelsignal"], patching_rect=[180.0, 120.0, 72.0, 22.0],
    )
    faustgen = patcher.add_textbox(
        "mc.faustgen~", id="faustgen_1", numinlets=1, numoutlets=3,
        outlettype=["multichannelsignal", "", ""], patching_rect=[390.0, 120.0, 94.0, 22.0],
        sourcecode=FAUST_SOURCE, sourcecode_size=len(FAUST_SOURCE.encode("utf-8")),
        sample_format=1, version="1.83", varname="faustgen_mono_stereo_spatial_reverb",
    )
    dac = patcher.add_textbox(
        "mc.dac~ 1 2", id="dac_1", numinlets=1, numoutlets=0,
        patching_rect=[640.0, 120.0, 92.0, 22.0],
    )
    patcher.add_line(adc, faustgen)
    patcher.add_line(faustgen, dac)
    patcher.add_comment("Mono MC input", patching_rect=[175.0, 92.0, 110.0, 20.0])
    patcher.add_comment("Stereo MC output (1–2)", patching_rect=[620.0, 92.0, 180.0, 20.0])

    controls = [
        ("pan", "Input pan (0 = L, 1 = R)", 0.5, 0.0, 1.0, 30.0, 205.0),
        ("reverb_mix", "Reverb mix", 0.30, 0.0, 1.0, 270.0, 205.0),
        ("zita_predelay", "Zita pre-delay (ms)", 60.0, 20.0, 100.0, 510.0, 205.0),
        ("zita_lf_x", "Zita LF crossover (Hz)", 200.0, 50.0, 1000.0, 750.0, 205.0),
        ("zita_low_rt60", "Zita low RT60 (s)", 3.0, 1.0, 8.0, 30.0, 330.0),
        ("zita_mid_rt60", "Zita mid RT60 (s)", 2.0, 1.0, 8.0, 270.0, 330.0),
        ("zita_hf_damping", "Zita HF damping (Hz)", 6000.0, 1500.0, 20000.0, 510.0, 330.0),
        ("output_gain", "Output gain", 0.80, 0.0, 1.0, 750.0, 330.0),
    ]
    for name, label, initial, minimum, maximum, x, y in controls:
        add_control(patcher, faustgen, loadbang, name, label, initial, minimum, maximum, x, y)

    patcher.add_comment(
        "Signal path: MC input 1 → Faust equal-power panner → re.zita_rev1_stereo "
        "→ MC outputs 1–2. All Zita FDN parameters, mix and gain are exposed above. "
        "Start audio in Max and feed input 1 to audition it.",
        patching_rect=[30.0, 465.0, 850.0, 38.0], linecount=2,
    )
    patcher.save()


if __name__ == "__main__":
    main()
