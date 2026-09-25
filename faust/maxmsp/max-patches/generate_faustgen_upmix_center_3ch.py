"""Build Stereo Upmix 2 to 3, adaptive center extraction for Max/MSP.

``STEM`` identifies faust/dsp/faustgen-upmix-center-3ch.dsp and the exported files.
Project-specific routing is explicit in build_patch; reusable native blocks
live in max_helpers, while analysis and the CLI live in common.faust.
Faust source is embedded in the .maxpat JSON; no separate .dsp is written.

Usage: ``python generate_faustgen_upmix_center_3ch.py [--output-dir DIRECTORY] [--faust EXECUTABLE]
[--check]``. --check verifies exports without changing existing files.
Importing this module generates nothing: its __main__ block runs the CLI for STEM.
"""

from max_helpers import (
    add_audio_output,
    add_controls,
    add_faust,
    add_loadbang,
    add_runtime_controls,
    add_stereo_scene_input,
    create_patch,
    finish_patch,
    main,
)

STEM = "faustgen-upmix-center-3ch"

# Faust outputs FL, FR, C, in order, to the studio's M layer (1.24 m high,
# closest to ear level) and to AtmoC, the center at the same height.
# Hardware output = physical index + 1 in faust/dsp/libraries/grame_studio_layout.lib.
SPEAKERS = [
    11,  # FL -> M1
    12,  # FR -> M2
    28,  # C -> AtmoC
]


def build_patch(project):
    """Build the Max/MSP patch for Stereo Upmix 2 to 3, adaptive center extraction in memory.

    Args:
        project: FaustProject loaded for STEM; source, ports, and controls come from
            the shared DSP. This builder does not invoke the compiler itself.

    Returns:
        Native Patcher validated by finish_patch, without writing any files.

    Stereo input, or the test scene (a breathing centered 440 Hz sine over
    independent noises)
    → upmix → FL M1 (11), FR M2 (12), C AtmoC (28). mc.dac~ sends MC channel c to the c-th listed hardware output.
    The test scene is initially disabled in favor of the real inputs.
    Numeric widgets and initial values are added after audio routing. Runtime
    commands are host-specific; this builder does not automatically enable the DSP.
    Helper errors are propagated.
    """
    patch = create_patch(project)
    load = add_loadbang(patch)
    dsp = add_faust(patch, project)
    add_stereo_scene_input(patch, dsp, load, project)
    add_audio_output(patch, dsp, load, project, hardware=SPEAKERS)
    add_controls(patch, dsp, load, project)
    add_runtime_controls(patch, dsp)
    return finish_patch(patch)


if __name__ == "__main__":
    main(STEM)
