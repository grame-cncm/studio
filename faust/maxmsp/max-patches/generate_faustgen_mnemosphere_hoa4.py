"""Build Mnemosphere, fourth-order ambisonic granular memory for Max/MSP.

``STEM`` identifies faust/dsp/faustgen-mnemosphere-hoa4.dsp and the exported files.
Project-specific routing is explicit in build_patch; reusable native blocks
live in max_helpers, while analysis and the CLI live in common.faust.
Faust source is embedded in the .maxpat JSON; no separate .dsp is written.

Usage: ``python generate_faustgen_mnemosphere_hoa4.py [--output-dir DIRECTORY] [--faust EXECUTABLE]
[--check]``. --check verifies exports without changing existing files.
Importing this module generates nothing: its __main__ block runs the CLI for STEM.
"""

from max_helpers import (
    add_audio_input, add_controls, add_faust, add_loadbang, add_runtime_controls,
    create_patch, finish_patch, main,
)

STEM = "faustgen-mnemosphere-hoa4"


def build_patch(project):
    """Build the Max/MSP patch for Mnemosphere, fourth-order ambisonic granular memory in memory.

    Args:
        project: FaustProject loaded for STEM; source, ports, and controls come from
            the shared DSP. This builder does not invoke the compiler itself.

    Returns:
        Native Patcher validated by finish_patch, without writing any files.

    Real mono input or sine → DSP → 26 decoded studio-speaker channels.
    DSP indices 0..24 target hardware outputs 1..25; index 25 is AtmoC and targets
    hardware output 28. All feeds are also repacked for mc.sfrecord~ 26. The
    recorder is configured for float32 on loading but does not start automatically.
    Numeric widgets and initial values are added after audio routing. Runtime
    commands are host-specific; this builder does not automatically enable the DSP.
    Helper errors are propagated.
    """
    patch = create_patch(project)
    load = add_loadbang(patch)
    dsp = add_faust(patch, project)
    add_audio_input(patch, dsp, load, project, test_tone=True)
    split = patch.add_textbox("mc.unpack~ 26", id="speaker_split", numinlets=1, numoutlets=26,
                              outlettype=["signal"] * 26, patching_rect=[650, 200, 150, 22])
    speakers = patch.add_textbox("mc.pack~ 26", id="speaker_bus", numinlets=26, numoutlets=1,
                                 outlettype=["multichannelsignal"], patching_rect=[650, 100, 150, 22])
    outputs = list(range(1, 26)) + [28]
    dac = patch.add_textbox("mc.dac~ " + " ".join(map(str, outputs)), id="dac_1",
                            numinlets=1, numoutlets=0, patching_rect=[900, 200, 300, 22])
    recorder = patch.add_textbox("mc.sfrecord~ 26 @bitdepth 32", id="speaker_recorder",
                                 numinlets=1, numoutlets=1, outlettype=["signal"],
                                 patching_rect=[850, 100, 220, 22])
    patch.add_line(dsp, split)
    for channel in range(26):
        patch.add_line(split, speakers, outlet=channel, inlet=channel)
    patch.add_line(speakers, dac)
    patch.add_line(speakers, recorder)
    patch.add_comment("Decoded speakers 1..25 + AtmoC -> hardware 28",
                      patching_rect=[650, 65, 450, 20])
    patch.add_comment("Choose WAVE / choisir WAV", patching_rect=[650, 270, 260, 20])
    patch.add_line(patch.add_message("open", patching_rect=[650, 300, 70, 22]), recorder)
    patch.add_line(patch.add_message("samptype float32, 1", patching_rect=[800, 300, 180, 22]), recorder)
    patch.add_line(patch.add_message("0", patching_rect=[1020, 300, 40, 22]), recorder)
    patch.add_comment("record", patching_rect=[800, 275, 80, 20])
    patch.add_comment("stop", patching_rect=[1020, 275, 80, 20])
    fmt = patch.add_message("samptype float32", patching_rect=[800, 140, 160, 22])
    # Preparing the format does not open a file or start recording.
    patch.add_line(load, fmt)
    patch.add_line(fmt, recorder)
    add_controls(patch, dsp, load, project)
    add_runtime_controls(patch, dsp)
    return finish_patch(patch)


if __name__ == "__main__":
    main(STEM)
