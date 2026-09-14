"""Generate Mnemosphere: record 25 HOA channels, listen through stereo preview."""

from pd_helpers import (
    add_audio_input, add_controls, add_faust, add_loadbang, add_runtime_controls,
    create_patch, finish_patch, main,
)

STEM = "faustgen-mnemosphere-hoa4"


def build_patch(project):
    patch = create_patch(project)
    load = add_loadbang(patch)
    dsp = add_faust(patch, project)
    add_audio_input(patch, dsp, load, project, test_tone=True)
    recorder = patch.add("writesf~ 25", x_pos=750, y_pos=200)
    dac = patch.add("dac~ 1 2", x_pos=950, y_pos=200)
    for channel in range(25):
        patch.link(dsp, recorder, outlet=channel + 1, inlet=channel)
    for channel in range(2):
        patch.link(dsp, dac, outlet=26 + channel, inlet=channel)
    patch.add_comment("25 HOA channels: ACN 0..24 / SN3D", x_pos=650, y_pos=175)
    patch.add_comment("Stereo preview / preecoute stereo", x_pos=950, y_pos=175)
    open_file = patch.add_bang(label="choose-WAV", x_pos=650, y_pos=60)
    panel = patch.add("savepanel", x_pos=650, y_pos=100)
    prepend = patch.add("list prepend open -bytes 4", x_pos=650, y_pos=130)
    trim = patch.add("list trim", x_pos=650, y_pos=150)
    patch.link(open_file, panel)
    patch.link(panel, prepend)
    patch.link(prepend, trim)
    patch.link(trim, recorder)
    for text, x in (("start", 800), ("stop", 900)):
        patch.link(patch.add_msg(text, x_pos=x, y_pos=300), recorder)
    patch.add_comment("Record HOA / enregistrer le champ HOA", x_pos=650, y_pos=275)
    add_controls(patch, dsp, load, project)
    add_runtime_controls(patch, dsp)
    return finish_patch(patch)


if __name__ == "__main__":
    main(STEM)
