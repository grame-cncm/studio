"""Generate Mnemosphere: record 25 HOA channels, listen through stereo preview."""

from max_helpers import (
    add_audio_input, add_controls, add_faust, add_loadbang, add_runtime_controls,
    create_patch, finish_patch, main,
)

STEM = "faustgen-mnemosphere-hoa4"


def build_patch(project):
    patch = create_patch(project)
    load = add_loadbang(patch)
    dsp = add_faust(patch, project)
    add_audio_input(patch, dsp, load, project, test_tone=True)
    split = patch.add_textbox("mc.unpack~ 27", id="hoa_split", numinlets=1, numoutlets=27,
                              outlettype=["signal"] * 27, patching_rect=[650, 200, 150, 22])
    hoa = patch.add_textbox("mc.pack~ 25", id="hoa_bus", numinlets=25, numoutlets=1,
                            outlettype=["multichannelsignal"], patching_rect=[650, 100, 150, 22])
    monitor = patch.add_textbox("mc.pack~ 2", numinlets=2, numoutlets=1,
                                outlettype=["multichannelsignal"], patching_rect=[850, 200, 90, 22])
    dac = patch.add_textbox("mc.dac~ 1 2", id="dac_1", numinlets=1, numoutlets=0,
                            patching_rect=[950, 200, 100, 22])
    recorder = patch.add_textbox("mc.sfrecord~ 25 @bitdepth 32", id="hoa_recorder", numinlets=1, numoutlets=1,
                                 outlettype=["signal"], patching_rect=[800, 100, 220, 22])
    patch.add_line(dsp, split)
    for channel in range(25):
        patch.add_line(split, hoa, outlet=channel, inlet=channel)
    for channel in range(2):
        patch.add_line(split, monitor, outlet=25 + channel, inlet=channel)
    patch.add_line(monitor, dac)
    patch.add_line(hoa, recorder)
    patch.add_comment("25 HOA channels: ACN 0..24 / SN3D", patching_rect=[650, 65, 400, 20])
    patch.add_comment("Stereo preview / preecoute stereo", patching_rect=[850, 175, 450, 20])
    patch.add_comment("Choose WAVE / choisir WAV", patching_rect=[650, 270, 260, 20])
    patch.add_line(patch.add_message("open", patching_rect=[650, 300, 70, 22]), recorder)
    patch.add_line(patch.add_message("samptype float32, 1", patching_rect=[800, 300, 180, 22]), recorder)
    patch.add_line(patch.add_message("0", patching_rect=[1020, 300, 40, 22]), recorder)
    patch.add_comment("record", patching_rect=[800, 275, 80, 20])
    patch.add_comment("stop", patching_rect=[1020, 275, 80, 20])
    fmt = patch.add_message("samptype float32", patching_rect=[800, 140, 160, 22])
    patch.add_line(load, fmt)
    patch.add_line(fmt, recorder)
    add_controls(patch, dsp, load, project)
    add_runtime_controls(patch, dsp)
    return finish_patch(patch)


if __name__ == "__main__":
    main(STEM)
