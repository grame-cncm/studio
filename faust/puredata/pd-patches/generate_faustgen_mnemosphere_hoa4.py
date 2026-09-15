"""Build Mnemosphere, fourth-order ambisonic granular memory for PureData.

``STEM`` identifies faust/dsp/faustgen-mnemosphere-hoa4.dsp and the exported files.
Project-specific routing is explicit in build_patch; reusable native blocks
live in pd_helpers, while analysis and the CLI live in common.faust.
Portable source is written next to the .pd; the .svg previews its routing.

Usage: ``python generate_faustgen_mnemosphere_hoa4.py [--output-dir DIRECTORY] [--faust EXECUTABLE]
[--check]``. --check verifies exports without changing existing files.
Importing this module generates nothing: its __main__ block runs the CLI for STEM.
"""

from pd_helpers import (
    add_audio_input, add_controls, add_faust, add_loadbang, add_runtime_controls,
    create_patch, finish_patch, main,
)

STEM = "faustgen-mnemosphere-hoa4"


def build_patch(project):
    """Build the PureData patch for Mnemosphere, fourth-order ambisonic granular memory in memory.

    Args:
        project: FaustProject loaded for STEM; source, ports, and controls come from
            the shared DSP. This builder does not invoke the compiler itself.

    Returns:
        Native Patcher validated by finish_patch, without writing any files.

    Real mono input or sine → DSP → 26 decoded studio-speaker channels.
    Pd control outlet 0 is excluded: audio outlets 1..25 target hardware 1..25,
    and audio outlet 26 targets AtmoC on hardware 28. All 26 feeds also reach
    writesf~ 26. savepanel opens a WAV with four bytes per sample; start/stop
    remain manual actions.
    Numeric widgets and initial values are added after audio routing. Runtime
    commands are host-specific; this builder does not automatically enable the DSP.
    Helper errors are propagated.
    """
    patch = create_patch(project)
    load = add_loadbang(patch)
    dsp = add_faust(patch, project)
    add_audio_input(patch, dsp, load, project, test_tone=True)
    recorder = patch.add("writesf~ 26", x_pos=750, y_pos=200)
    outputs = list(range(1, 26)) + [28]
    dac = patch.add("dac~ " + " ".join(map(str, outputs)), x_pos=950, y_pos=200)
    # Offset by +1: faustgen2~ reserves outlet 0 for control messages.
    for channel in range(26):
        patch.link(dsp, recorder, outlet=channel + 1, inlet=channel)
        patch.link(dsp, dac, outlet=channel + 1, inlet=channel)
    patch.add_comment("Decoded speakers 1..25 + AtmoC -> hardware 28", x_pos=650, y_pos=175)
    open_file = patch.add_bang(label="choose-WAV", x_pos=650, y_pos=60)
    panel = patch.add("savepanel", x_pos=650, y_pos=100)
    # The list preserves the chosen path as an argument before converting
    # its first element "open" into the command selector for writesf~.
    prepend = patch.add("list prepend open -bytes 4", x_pos=650, y_pos=130)
    trim = patch.add("list trim", x_pos=650, y_pos=150)
    patch.link(open_file, panel)
    patch.link(panel, prepend)
    patch.link(prepend, trim)
    patch.link(trim, recorder)
    for text, x in (("start", 800), ("stop", 900)):
        patch.link(patch.add_msg(text, x_pos=x, y_pos=300), recorder)
    patch.add_comment("Record decoded feeds / enregistrer les sorties decodees", x_pos=650, y_pos=275)
    add_controls(patch, dsp, load, project)
    add_runtime_controls(patch, dsp)
    return finish_patch(patch)


if __name__ == "__main__":
    main(STEM)
