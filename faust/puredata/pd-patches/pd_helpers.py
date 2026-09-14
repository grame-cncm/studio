"""PureData building blocks for the explicit per-project generators."""

from pathlib import Path
import re
import sys

from py2pd import Patcher
from py2pd.ast import PdDeclare

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parents[1]))
from common.faust import FaustProject, generation_cli, load_project, project_builder  # noqa: E402


def pd_name(label: str) -> str:
    """Match faustgen2~'s ASCII parameter-name mangling."""
    return re.sub(r"[^A-Za-z0-9]+", "-", label).strip("-")


def initial(p: Patcher, load, target, value, *, inlet=0, x=30, y=260):
    message = p.add_msg(str(value), x_pos=x, y_pos=y)
    p.link(load, message)
    p.link(message, target, inlet=inlet)


def mono_source(p: Patcher, adc, load):
    """Select the microphone or an optional 220 Hz sine without starting DSP."""
    tone = p.add("osc~ 220", x_pos=30, y_pos=140)
    choice = p.add_toggle(label="test-220Hz", x_pos=200, y_pos=100)
    invert = p.add("== 0", x_pos=200, y_pos=140)
    real_gain = p.add("*~", x_pos=30, y_pos=200)
    tone_gain = p.add("*~", x_pos=200, y_pos=200)
    summed = p.add("+~", x_pos=300, y_pos=200)
    p.link(choice, invert)
    p.link(invert, real_gain, inlet=1)
    p.link(choice, tone_gain, inlet=1)
    p.link(adc, real_gain)
    p.link(tone, tone_gain)
    p.link(real_gain, summed)
    p.link(tone_gain, summed, inlet=1)
    initial(p, load, choice, 0, x=300, y=100)
    return summed


def midi_input(p: Patcher, dsp, load):
    p.add_comment("MIDI input / entree MIDI", x_pos=30, y_pos=95)
    notes = p.add("notein", x_pos=30, y_pos=120)
    packed = p.add("pack f f f", x_pos=30, y_pos=160)
    for port in range(3):
        p.link(notes, packed, outlet=port, inlet=port)
    p.link(packed, msg := p.add_msg("note $1 $2 $3", x_pos=30, y_pos=200))
    p.link(msg, dsp)
    cc = p.add("ctlin", x_pos=200, y_pos=120)
    packed = p.add("pack f f f", x_pos=200, y_pos=160)
    for port in range(3):
        p.link(cc, packed, outlet=port, inlet=port)
    p.link(packed, msg := p.add_msg("ctl $1 $2 $3", x_pos=200, y_pos=200))
    p.link(msg, dsp)
    p.add_comment("Play a note or chord / jouer une note ou un accord", x_pos=30, y_pos=720)
    pitch = p.add_numberbox(min_val=0, max_val=127, init_value=60,
                            label="MIDI-note", x_pos=30, y_pos=770)
    play = p.add_bang(label="play", x_pos=130, y_pos=770)
    p.link(play, pitch)
    make = p.add("makenote 100 250", x_pos=30, y_pos=840)
    p.link(pitch, make)
    chord = p.add_bang(label="C-major", x_pos=240, y_pos=770)
    for index, note in enumerate((60, 64, 67)):
        p.link(chord, msg := p.add_msg(str(note), x_pos=240 + index * 60, y_pos=810))
        p.link(msg, make)
    packed = p.add("pack f f 1", x_pos=30, y_pos=880)
    p.link(make, packed)
    p.link(make, packed, outlet=1, inlet=1)
    p.link(packed, msg := p.add_msg("note $1 $2 $3", x_pos=30, y_pos=920))
    p.link(msg, dsp)
    for index, (name, value, maximum) in enumerate((("velocity", 100, 127),
                                                   ("duration-ms", 250, 5000))):
        x = 450 + index * 200
        widget = p.add_numberbox(min_val=1, max_val=maximum, label=name,
                                 x_pos=x, y_pos=810)
        p.link(widget, make, inlet=index + 1)
        initial(p, load, widget, value, x=x, y=770)
    panic = p.add_bang(label="all-notes-off", x_pos=850, y_pos=810)
    p.link(panic, dsp)
    mute = p.add_toggle(label="mute", x_pos=1050, y_pos=810)
    p.link(mute, invert := p.add("== 0", x_pos=1050, y_pos=850))
    p.link(invert, msg := p.add_msg("active $1", x_pos=1050, y_pos=890))
    p.link(msg, dsp)
    initial(p, load, mute, 0, x=1140, y=810)


def create_patch(project: FaustProject) -> Patcher:
    height = max(700, 350 + ((len(project.controls) + 3) // 4) * 85,
                 1000 if project.voices else 0)
    patch = Patcher(canvas_width=1380, canvas_height=height, font_size=12)
    patch.add_comment(project.title, x_pos=30, y_pos=20)
    patch.add_comment(f"Audio: {project.inputs} inputs / entrees -> {project.outputs} outputs / sorties",
                      x_pos=30, y_pos=50)
    return patch


def add_loadbang(p: Patcher):
    return p.add("loadbang", x_pos=400, y_pos=50)


def add_faust(p: Patcher, project: FaustProject):
    dsp = p.add(f"faustgen2~ {project.stem}", num_inlets=project.inputs + 1,
                num_outlets=project.outputs + 1, x_pos=450, y_pos=200)
    p.link(dsp, p.add(f"print {project.stem}", x_pos=450, y_pos=250))
    p.link(p.add("r $0-faust", x_pos=450, y_pos=150), dsp)
    return dsp


def add_audio_input(p: Patcher, dsp, load, project: FaustProject, *, test_tone=False):
    adc = p.add("adc~ " + " ".join(map(str, range(1, project.inputs + 1))), x_pos=30, y_pos=100)
    source = mono_source(p, adc, load) if test_tone else adc
    for channel in range(project.inputs):
        p.link(source, dsp, outlet=channel, inlet=channel + 1)


def add_audio_output(p: Patcher, dsp, load, project: FaustProject, *, master_level=None):
    dac = p.add("dac~ " + " ".join(map(str, range(1, project.outputs + 1))), x_pos=850, y_pos=200)
    volume = None
    if master_level is not None:
        volume = p.add_numberbox(min_val=0, max_val=1, label="output-level", x_pos=800, y_pos=100)
        initial(p, load, volume, master_level, x=800, y=60)
    for channel in range(project.outputs):
        if volume is None:
            p.link(dsp, dac, outlet=channel + 1, inlet=channel)
        else:
            amp = p.add("*~", x_pos=800 + channel * 100, y_pos=150)
            p.link(volume, amp, inlet=1)
            p.link(dsp, amp, outlet=channel + 1)
            p.link(amp, dac, inlet=channel)


def add_controls(p: Patcher, dsp, load, project: FaustProject):
    names = [pd_name(item.label) for item in project.controls]
    if any(not name for name in names) or len(set(names)) != len(names):
        raise ValueError("Faust control labels must have unique Pd names.")
    for index, (item, name) in enumerate(zip(project.controls, names)):
        x, y = 30 + index % 4 * 330, 350 + index // 4 * 85
        label = name + (f" ({item.unit})" if item.unit else "")
        p.add_comment(label, x_pos=x, y_pos=y - 20)
        widget = p.add_numberbox(min_val=item.minimum, max_val=item.maximum, x_pos=x, y_pos=y)
        p.link(widget, msg := p.add_msg(f"{name} $1", x_pos=x + 90, y_pos=y))
        p.link(msg, dsp)
        initial(p, load, widget, item.initial, x=x, y=y + 30)


def add_runtime_controls(p: Patcher, dsp):
    p.link(p.add_msg("compile", x_pos=1050, y_pos=60), dsp)
    auto = p.add_toggle(label="autocompile", x_pos=1050, y_pos=110)
    p.link(auto, msg := p.add_msg("autocompile $1 100", x_pos=1080, y_pos=150))
    p.link(msg, dsp)
    audio = p.add_toggle(label="DSP", x_pos=1050, y_pos=250)
    p.link(audio, msg := p.add_msg("dsp $1", x_pos=1100, y_pos=250))
    p.link(msg, p.add("s pd", x_pos=1200, y_pos=250))


def finish_patch(p: Patcher) -> Patcher:
    p.add_comment("Edit .dsp then compile / modifier le .dsp puis compiler",
                  x_pos=30, y_pos=p.canvas_height - 30)
    p.validate_connections()
    return p


def generate(stem: str, output_dir: Path = HERE, faust: str = "faust") -> tuple[Path, ...]:
    project = load_project(stem, faust)
    output_dir.mkdir(parents=True, exist_ok=True)
    target = output_dir / f"{stem}.dsp"
    target.write_text(project.source)
    patch = project_builder(HERE, stem)(project)
    pd_path, svg_path = target.with_suffix(".pd"), target.with_suffix(".svg")
    patch.save_svg(str(svg_path))
    # PdDeclare is unindexed. Insert it after py2pd's indexed validation/SVG,
    # but before object creation in the serialized patch.
    declare = patch.add_declare(PdDeclare(paths=("../pd-faustgen/external",), libs=("faustgen2~",)))
    patch.nodes.remove(declare)
    patch.nodes.insert(0, declare)
    patch.save(str(pd_path))
    return pd_path, svg_path, target


def main(stem: str | None = None):
    generation_cli(generate, HERE, stem)
