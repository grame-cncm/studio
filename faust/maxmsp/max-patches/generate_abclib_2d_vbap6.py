"""Build abclib 2D VBAP, one input to six speakers for Max/MSP.

``STEM`` identifies faust/dsp/faustgen-abclib-2d-vbap6.dsp and the exported files.
Project-specific routing is explicit in build_patch; reusable native blocks
live in max_helpers, while analysis and the CLI live in common.faust.
Faust source is embedded in the .maxpat JSON; no separate .dsp is written.

Usage: ``python generate_abclib_2d_vbap6.py [--output-dir DIRECTORY] [--faust EXECUTABLE]
[--check]``. --check verifies exports without changing existing files.
Importing this module generates nothing: its __main__ block runs the CLI for STEM.
"""

from max_helpers import (
    add_audio_input,
    add_audio_output,
    add_controls,
    add_faust,
    add_loadbang,
    add_runtime_controls,
    create_patch,
    finish_patch,
    main,
)

STEM = "faustgen-abclib-2d-vbap6"


def build_patch(project):
    """Build the Max/MSP patch for abclib 2D VBAP, one input to six speakers in memory.

    Args:
        project: FaustProject loaded for STEM; source, ports, and controls come from
            the shared DSP. This builder does not invoke the compiler itself.

    Returns:
        Native Patcher validated by finish_patch, without writing any files.

    Real mono input or 220 Hz sine → abclib VBAP → six outputs.
    The optional test source is initially disabled in favor of the real inputs.
    Numeric widgets and initial values are added after audio routing. Runtime
    commands are host-specific; this builder does not automatically enable the DSP.
    Helper errors are propagated.
    """
    patch = create_patch(project)
    load = add_loadbang(patch)
    dsp = add_faust(patch, project)
    add_audio_input(patch, dsp, load, project, test_tone=True)
    add_audio_output(patch, dsp, load, project)
    add_controls(patch, dsp, load, project)
    add_runtime_controls(patch, dsp)
    return finish_patch(patch)


if __name__ == "__main__":
    main(STEM)
