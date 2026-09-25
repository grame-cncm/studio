"""Build Stereo Upmix 2 to 7.0, center, side and rear surrounds for PureData.

``STEM`` identifies faust/dsp/faustgen-upmix-surround-7ch.dsp and the exported files.
Project-specific routing is explicit in build_patch; reusable native blocks
live in pd_helpers, while analysis and the CLI live in common.faust.
Portable source is written next to the .pd; the .svg previews its routing.

Usage: ``python generate_faustgen_upmix_surround_7ch.py [--output-dir DIRECTORY] [--faust EXECUTABLE]
[--check]``. --check verifies exports without changing existing files.
Importing this module generates nothing: its __main__ block runs the CLI for STEM.
"""

from pd_helpers import (
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

STEM = "faustgen-upmix-surround-7ch"

# Faust outputs FL, FR, C, Lss, Rss, Lrs, Rrs, in order, to the studio's M layer (1.24 m high,
# closest to ear level) and to AtmoC, the center at the same height.
# Hardware output = physical index + 1 in faust/dsp/libraries/grame_studio_layout.lib.
SPEAKERS = [
    11,  # FL -> M1
    12,  # FR -> M2
    28,  # C -> AtmoC
    13,  # Lss -> M3
    14,  # Rss -> M4
    15,  # Lrs -> M5
    16,  # Rrs -> M6
]


def build_patch(project):
    """Build the PureData patch for Stereo Upmix 2 to 7.0, center, side and rear surrounds in memory.

    Args:
        project: FaustProject loaded for STEM; source, ports, and controls come from
            the shared DSP. This builder does not invoke the compiler itself.

    Returns:
        Native Patcher validated by finish_patch, without writing any files.

    Stereo input, or the test scene (a breathing centered 440 Hz sine over
    independent noises)
    → upmix → FL M1 (11), FR M2 (12), C AtmoC (28), Lss M3 (13), Rss M4 (14), Lrs M5 (15), Rrs M6 (16). Faust audio outlet c+1 reaches dac~ inlet c, played on the c-th listed output.
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
