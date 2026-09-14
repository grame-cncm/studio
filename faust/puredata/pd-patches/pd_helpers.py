"""Build the PureData blocks shared by explicit project generators.

py2pd must be installed in the Python environment; ``common`` is added to
sys.path from the Faust directory. Blocks modify an in-memory Patcher.
``HERE`` locates the scripts and the default export destination.

Port indices are zero-based: faustgen2~ reserves inlet/outlet 0 for messages
and exposes audio channels from index 1. Pd uses one cable per channel.
generate exports .pd, .svg, and .dsp files together. Patch generation does
not automatically enable Pd's audio engine.
"""

from pathlib import Path
import re
import sys

from py2pd import Patcher
from py2pd.ast import PdDeclare

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parents[1]))
from common.faust import FaustProject, generation_cli, load_project, project_builder  # noqa: E402


def pd_name(label: str) -> str:
    """Convert a label into an ASCII selector using faustgen2~ naming rules.

    Args:
        label: Faust label, possibly containing spaces or punctuation.

    Returns:
        String containing only ASCII letters, digits, and hyphens. Runs of other
        characters become a hyphen, stripped from both ends. Empty strings and
        collisions are possible and are rejected by add_controls.
    """
    return re.sub(r"[^A-Za-z0-9]+", "-", label).strip("-")


def initial(p: Patcher, load, target, value, *, inlet=0, x=30, y=260):
    """Add a value message and connect it from the trigger to the target widget.

    Args:
        p: Patcher to modify.
        load: Trigger object, normally loadbang.
        target: Object receiving str(value).
        value: Value to serialize in the Pd message.
        inlet: Target inlet index; defaults to 0.
        x: Message's horizontal position.
        y: Message's vertical position.

    Returns:
        None. Passing the message through the widget also sends its value to the DSP.
        A graphical init_value property alone does not replace this connection.
    """
    message = p.add_msg(str(value), x_pos=x, y_pos=y)
    p.link(load, message)
    p.link(message, target, inlet=inlet)


def mono_source(p: Patcher, adc, load):
    """Add a mono ADC/220 Hz sine selector, initialized to the ADC.

    Args:
        p: Patcher to modify.
        adc: Object whose outlet 0 supplies the real input.
        load: Trigger initializing the toggle to 0.

    Returns:
        +~ object summing two *~ branches. The toggle controls the sine gain;
        ``== 0`` controls the microphone gain. Exactly one path is open for 0 or 1.

    The mono sine is not attenuated here. This block does not open an additional
    hardware device or start the DSP.
    """
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
    """Add Pd MIDI routing and synth performance controls.

    Args:
        p: Polyphonic Patcher to modify.
        dsp: faustgen2~ receiving control messages on inlet 0.
        load: Trigger initializing velocity=100, duration=250 ms, and mute=0.

    notein is assembled as ``note pitch velocity channel``; ctlin as ``ctl value
    controller channel``. The play button and chord 60/64/67 use makenote, then
    ``pack f f 1`` for channel 1. makenote generates note-off events. A bang sent
    to Faust stops all notes; mute is inverted into ``active``. The cold pack
    inlets receive velocity/channel, while pitch triggers the list on its hot inlet.
    The DSP's nvoices declaration determines polyphony. Return None.
    """
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
    """Create a titled Pd canvas sized for the controls and polyphony.

    Args:
        project: Shared description providing the title and audio signature.

    Returns:
        New Patcher, 1380 pixels wide, font size 12, at least 700 high or 1000
        for a MIDI synth. Controls are arranged in four columns.
    """
    height = max(700, 350 + ((len(project.controls) + 3) // 4) * 85,
                 1000 if project.voices else 0)
    patch = Patcher(canvas_width=1380, canvas_height=height, font_size=12)
    patch.add_comment(project.title, x_pos=30, y_pos=20)
    patch.add_comment(f"Audio: {project.inputs} inputs / entrees -> {project.outputs} outputs / sorties",
                      x_pos=30, y_pos=50)
    return patch


def add_loadbang(p: Patcher):
    """Add and return the loadbang used to initialize patch p."""
    return p.add("loadbang", x_pos=400, y_pos=50)


def add_faust(p: Patcher, project: FaustProject):
    """Add faustgen2~ loading stem.dsp, its local receiver, and diagnostics.

    Args:
        p: Patcher to modify.
        project: DSP identifier and compiled audio port counts.

    Returns:
        Object with inputs+1 inlets and outputs+1 outlets. Port 0 is reserved for
        messages; audio signals start at index 1.

    ``r $0-faust`` receives patch-local commands; outlet 0 connects to print.
    generate writes the source separately next to the .pd file.
    """
    dsp = p.add(f"faustgen2~ {project.stem}", num_inlets=project.inputs + 1,
                num_outlets=project.outputs + 1, x_pos=450, y_pos=200)
    p.link(dsp, p.add(f"print {project.stem}", x_pos=450, y_pos=250))
    p.link(p.add("r $0-faust", x_pos=450, y_pos=150), dsp)
    return dsp


def add_audio_input(p: Patcher, dsp, load, project: FaustProject, *, test_tone=False):
    """Connect adc~ to Faust audio inputs, optionally adding test sines.

    Args:
        p: Patcher to modify.
        dsp: faustgen2~ whose audio inlets start at index 1.
        load: Trigger initializing selection to the hardware inputs.
        project: ADC channel count, numbered 1 to N in the Pd object.
        test_tone: Add a toggle selecting microphone or sine for every channel.

    For mono, mono_source supplies a 220 Hz sine. For multiple channels, frequencies
    are ``220 + 110 * channel`` Hz and sines are attenuated by 0.1 before selection
    gains. ADC outlet c reaches Faust inlet c+1. The toggle and its inverse control
    two gains summed per channel. Use this for DSPs with inputs, not the MIDI synth.
    Return None.
    """
    adc = p.add("adc~ " + " ".join(map(str, range(1, project.inputs + 1))), x_pos=30, y_pos=100)
    if test_tone and project.inputs > 1:
        choice = p.add_toggle(label="test-tones", x_pos=200, y_pos=100)
        invert = p.add("== 0", x_pos=300, y_pos=100)
        p.link(choice, invert)
        initial(p, load, choice, 0, x=300, y=60)
        for channel in range(project.inputs):
            x = 30 + channel * 180
            tone = p.add(f"osc~ {220 + channel * 110}", x_pos=x, y_pos=140)
            quiet = p.add("*~ 0.1", x_pos=x, y_pos=175)
            tone_gain = p.add("*~", x_pos=x, y_pos=210)
            real_gain = p.add("*~", x_pos=x + 80, y_pos=175)
            summed = p.add("+~", x_pos=x, y_pos=260)
            p.link(tone, quiet)
            p.link(quiet, tone_gain)
            p.link(choice, tone_gain, inlet=1)
            p.link(adc, real_gain, outlet=channel)
            p.link(invert, real_gain, inlet=1)
            p.link(real_gain, summed)
            p.link(tone_gain, summed, inlet=1)
            p.link(summed, dsp, inlet=channel + 1)
        # Each channel already has its sum and connection; do not also wire
        # the ADC to the DSP through the direct branch below.
        return
    source = mono_source(p, adc, load) if test_tone else adc
    for channel in range(project.inputs):
        p.link(source, dsp, outlet=channel, inlet=channel + 1)


def add_audio_output(p: Patcher, dsp, load, project: FaustProject, *, master_level=None):
    """Connect Faust outputs to dac~, optionally adding shared master gain.

    Args:
        p: Patcher to modify.
        dsp: faustgen2~ whose audio outlets start at index 1.
        load: Initialization trigger for the master level.
        project: Channel count sent to hardware DAC channels 1 to N.
        master_level: Initial 0..1 level, or None for direct routing.

    When a level is requested, one *~ per channel shares the same volume widget.
    Faust outlet c+1 reaches DAC inlet c. No limiter is added and the DSP is not
    enabled. Mnemosphere uses custom HOA/preview routing. Return None.
    """
    dac = p.add("dac~ " + " ".join(map(str, range(1, project.outputs + 1))), x_pos=850, y_pos=200)
    volume = None
    if master_level is not None:
        volume = p.add_numberbox(min_val=0, max_val=1, label="output-level", x_pos=800, y_pos=100)
        initial(p, load, volume, master_level, x=800, y=60)
    for channel in range(project.outputs):
        # Faust outlet 0 carries messages, whereas dac~ audio inlets start at 0.
        if volume is None:
            p.link(dsp, dac, outlet=channel + 1, inlet=channel)
        else:
            amp = p.add("*~", x_pos=800 + channel * 100, y_pos=150)
            p.link(volume, amp, inlet=1)
            p.link(dsp, amp, outlet=channel + 1)
            p.link(amp, dac, inlet=channel)


def add_controls(p: Patcher, dsp, load, project: FaustProject):
    """Add numeric widgets, parameter messages, and initialization values.

    Args:
        p: Patcher to modify.
        dsp: Recipient on control inlet 0.
        load: Trigger sending init values from the Faust JSON.
        project: Exposed parameters and their bounds/units.

    Raises:
        ValueError: pd_name produces an empty selector or duplicate selectors.

    Widgets occupy four columns. Each feeds a ``name $1`` message, then Faust.
    Bounds are copied from the DSP. The step is not configured on the native widget.
    Return None.
    """
    names = [pd_name(item.label) for item in project.controls]
    if any(not name for name in names) or len(set(names)) != len(names):
        raise ValueError("Faust control labels must have unique Pd names.")
    for index, (item, name) in enumerate(zip(project.controls, names)):
        # Use the same grid as Max: four columns, with rows spaced 85 pixels apart.
        x, y = 30 + index % 4 * 330, 350 + index // 4 * 85
        label = name + (f" ({item.unit})" if item.unit else "")
        p.add_comment(label, x_pos=x, y_pos=y - 20)
        widget = p.add_numberbox(min_val=item.minimum, max_val=item.maximum, x_pos=x, y_pos=y)
        p.link(widget, msg := p.add_msg(f"{name} $1", x_pos=x + 90, y_pos=y))
        p.link(msg, dsp)
        initial(p, load, widget, item.initial, x=x, y=y + 30)


def add_runtime_controls(p: Patcher, dsp):
    """Add manual compilation, source monitoring, and Pd's DSP switch.

    Args:
        p: Patcher to modify.
        dsp: Recipient of compile and ``autocompile $1 100`` (100 ms polling period).

    The DSP toggle sends ``dsp $1`` to ``s pd``, affecting the global engine rather
    than just this Faust instance. No loadbang enables it. Return None.
    """
    p.link(p.add_msg("compile", x_pos=1050, y_pos=60), dsp)
    auto = p.add_toggle(label="autocompile", x_pos=1050, y_pos=110)
    p.link(auto, msg := p.add_msg("autocompile $1 100", x_pos=1080, y_pos=150))
    p.link(msg, dsp)
    audio = p.add_toggle(label="DSP", x_pos=1050, y_pos=250)
    p.link(audio, msg := p.add_msg("dsp $1", x_pos=1100, y_pos=250))
    p.link(msg, p.add("s pd", x_pos=1200, y_pos=250))


def finish_patch(p: Patcher) -> Patcher:
    """Add the editing hint and validate the connections in Patcher p.

    Returns:
        The same patch, ready for SVG export and Pd serialization.

    py2pd validates connections before insertion of the unindexed declare directive.
    Validation exceptions are propagated; no files are written.
    """
    p.add_comment("Edit .dsp then compile / modifier le .dsp puis compiler",
                  x_pos=30, y_pos=p.canvas_height - 30)
    p.validate_connections()
    return p


def generate(stem: str, output_dir: Path = HERE, faust: str = "faust") -> tuple[Path, ...]:
    """Export a project's portable source, Pd patch, and SVG preview.

    Args:
        stem: Identifier in the shared Faust catalog.
        output_dir: Destination created recursively; defaults to HERE.
        faust: Compiler forwarded to load_project.

    Returns:
        Tuple of paths in ``(.pd, .svg, .dsp)`` order.

    The .dsp is written before patch construction. SVG export precedes the declare
    directive, whose unindexed entry loads ../pd-faustgen/external and faustgen2~.
    The directive is serialized before the objects so the library is available when
    they are created, without shifting their connection indices.

    Existing files are replaced. A failure can leave partial exports: writes are
    not transactional. Exceptions are propagated. Exports moved elsewhere must
    retain an appropriate external search path.
    """
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
    """Run the PureData CLI for stem, or all projects if stem is None.

    generation_cli reads --output-dir, --faust, and --check from sys.argv.
    Call generate directly for programmatic generation without CLI parsing.
    """
    generation_cli(generate, HERE, stem)
