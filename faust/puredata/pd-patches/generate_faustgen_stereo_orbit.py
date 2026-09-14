"""Generate faustgen-stereo-orbit for PureData from the common Faust source."""

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

STEM = "faustgen-stereo-orbit"


def build_patch(project):
    """Compose this project's native audio routing and interface."""
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
