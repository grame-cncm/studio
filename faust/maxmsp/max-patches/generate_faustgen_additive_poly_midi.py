"""Generate faustgen-additive-poly-midi for Max/MSP from the common Faust source."""

from max_helpers import (
    add_audio_output,
    add_controls,
    add_faust,
    add_loadbang,
    add_runtime_controls,
    create_patch,
    finish_patch,
    main,
    midi_input,
)

STEM = "faustgen-additive-poly-midi"


def build_patch(project):
    """Compose this project's native audio routing and interface."""
    patch = create_patch(project)
    load = add_loadbang(patch)
    dsp = add_faust(patch, project)
    add_audio_output(patch, dsp, load, project, master_level=0.2)
    midi_input(patch, dsp, load)
    add_controls(patch, dsp, load, project)
    add_runtime_controls(patch, dsp)
    return finish_patch(patch)


if __name__ == "__main__":
    main(STEM)
