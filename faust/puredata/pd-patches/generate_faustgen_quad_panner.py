"""Build quadraphonic panning for PureData.

``STEM`` identifies faust/dsp/faustgen-quad-panner.dsp and the exported files.
Project-specific routing is explicit in build_patch; reusable native blocks
live in pd_helpers, while analysis and the CLI live in common.faust.
Portable source is written next to the .pd; the .svg previews its routing.

Usage: ``python generate_faustgen_quad_panner.py [--output-dir DIRECTORY] [--faust EXECUTABLE]
[--check]``. --check verifies exports without changing existing files.
Importing this module generates nothing: its __main__ block runs the CLI for STEM.
"""

from pd_helpers import (
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

STEM = "faustgen-quad-panner"


def build_patch(project):
    """Build the PureData patch for quadraphonic panning in memory.

    Args:
        project: FaustProject loaded for STEM; source, ports, and controls come from
            the shared DSP. This builder does not invoke the compiler itself.

    Returns:
        Native Patcher validated by finish_patch, without writing any files.

    Mono hardware input → panning → four outputs.
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
