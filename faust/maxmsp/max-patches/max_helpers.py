"""Build the Max/MSP blocks shared by explicit project generators.

``HERE`` fixes the script/export directory. The sys.path bootstrap makes py2max
available from its submodule and ``common`` from the Faust directory. Each
``add_*`` function modifies its Patcher argument; objects and connections stay
in memory until ``generate``. Port indices are zero-based.

Max carries multichannel audio through a single MC cable. mc.faustgen~ receives
audio and messages on inlet 0, emits audio on outlet 0, and diagnostics on
outlet 1. Controls come from the shared Faust JSON. Patch construction does
not automatically enable Max's audio engine.
"""

from __future__ import annotations

from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent / "py2max"))
sys.path.insert(0, str(HERE.parents[1]))

from py2max import Patcher  # noqa: E402 - local submodule bootstrap
from common.faust import FaustProject, generation_cli, load_project, project_builder  # noqa: E402


def create_patch(project: FaustProject) -> Patcher:
    """Create a Max canvas with a title, audio signature, and semantic identifiers.

    Args:
        project: Its control count and polyphony determine the canvas height.

    Returns:
        New Patcher, 1380 pixels wide and at least 700 high (1000 for MIDI projects).

    Object ports are specified explicitly and checked by finish_patch because the
    py2max maxref database is unreliable for some MIDI objects.
    """
    height = max(700, 350 + ((len(project.controls) + 3) // 4) * 85,
                 1000 if project.voices else 0)
    # py2max's maxref database reports zero midiformat inlets. Validate the
    # explicit native port counts in finish_patch instead of that database.
    p = Patcher(title=project.title, semantic_ids=True)
    p.rect = [70.0, 70.0, 1380.0, float(height)]
    p.add_comment(project.title, patching_rect=[30, 20, 1000, 28], fontsize=18)
    p.add_comment(f"Audio: {project.inputs} inputs / entrees -> {project.outputs} outputs / sorties",
                  patching_rect=[30, 55, 900, 20])
    return p


def add_loadbang(p: Patcher):
    """Add and return the shared loadbang with the stable identifier loadbang_1.

    Args:
        p: Patcher to modify. Its loadbang initializes widgets, source selection,
            and recorder settings.

    Returns:
        py2max object to connect to initialization messages.
    """
    return p.add_textbox("loadbang", id="loadbang_1", patching_rect=[400, 90, 58, 22])


def initial(p: Patcher, load, target, value, *, x=30, y=260):
    """Connect load to target through a numeric message sent on patch loading.

    Args:
        p: Patcher to modify.
        load: Trigger object, normally the patch's loadbang.
        target: Widget/object receiving the value on inlet 0.
        value: Number formatted with ``g`` as the message text.
        x: Initialization message's horizontal position.
        y: Initialization message's vertical position.

    Returns:
        None. The message and both connections are added to the patch.

    Sending through the widget triggers its output to Faust. A widget's displayed
    value alone does not guarantee DSP initialization when the patch loads.
    """
    msg = p.add_message(f"{value:g}", patching_rect=[x, y, 78, 22])
    p.add_line(load, msg)
    p.add_line(msg, target)


def add_faust(p: Patcher, project: FaustProject):
    """Add mc.faustgen~, its local receiver, and its diagnostic printer.

    Args:
        p: Patcher to modify.
        project: Portable source and identifier used for persistence and varname.

    Returns:
        mc.faustgen~ object (faustgen_1), declaring one inlet and three outlets.

    The source is stored in the Max JSON; sourcecode_size counts its UTF-8 bytes.
    ``r #0-faust`` accepts messages local to this patch instance. The object uses
    single precision (sample_format=1), with no generated machine-code cache.
    """
    dsp = p.add_textbox("mc.faustgen~", id="faustgen_1", numinlets=1, numoutlets=3,
                        outlettype=["multichannelsignal", "", ""],
                        patching_rect=[500, 200, 100, 22], sourcecode=project.source,
                        sourcecode_size=len(project.source.encode("utf-8")),
                        sample_format=1, version="1.83", varname=project.stem.replace("-", "_"))
    receiver = p.add_textbox("r #0-faust", numinlets=0, patching_rect=[500, 150, 100, 22])
    p.add_line(receiver, dsp)
    printer = p.add_textbox(f"print {project.stem}", numoutlets=0, patching_rect=[500, 250, 300, 22])
    p.add_line(dsp, printer, outlet=1)
    return dsp


def add_audio_input(p: Patcher, dsp, load, project: FaustProject, *, test_tone=False):
    """Connect MC hardware inputs, optionally adding selectable test tones.

    Args:
        p: Patcher to modify.
        dsp: Faust object receiving the audio bus on inlet 0.
        load: Initialization trigger for source selection.
        project: Audio input count; mc.adc~ hardware channels are numbered 1 to N.
        test_tone: Add a microphone/test switch initialized to the microphone.

    Returns:
        None. Mono testing uses mc.cycle~ 220. Multichannel testing supplies each
        input with a sine at ``220 + 110 * channel`` Hz, attenuated by 0.1 and
        assembled with mc.pack~. The 0/1 toggle becomes 1/2 for mc.selector~ 2.

    Use this for effects with at least one input. An input-free synth uses midi_input.
    This function does not start the audio engine.
    """
    channels = " ".join(map(str, range(1, project.inputs + 1)))
    adc = p.add_textbox(f"mc.adc~ {channels}", id="adc_1", numinlets=1, numoutlets=1,
                        outlettype=["multichannelsignal"], patching_rect=[30, 100, 220, 22])
    source = adc
    if test_tone:
        if project.inputs == 1:
            tone = p.add_textbox("mc.cycle~ 220", numinlets=2, numoutlets=1,
                                 outlettype=["multichannelsignal"], patching_rect=[30, 150, 100, 22])
        else:
            tone = p.add_textbox(f"mc.pack~ {project.inputs}", numinlets=project.inputs,
                                 numoutlets=1, outlettype=["multichannelsignal"],
                                 patching_rect=[30, 230, 120, 22])
            for channel in range(project.inputs):
                oscillator = p.add_textbox(f"cycle~ {220 + channel * 110}", numinlets=2,
                                           numoutlets=1, outlettype=["signal"],
                                           patching_rect=[30 + channel * 130, 150, 110, 22])
                gain = p.add_textbox("*~ 0.1", numinlets=2, numoutlets=1, outlettype=["signal"],
                                     patching_rect=[30 + channel * 130, 190, 70, 22])
                p.add_line(oscillator, gain)
                p.add_line(gain, tone, inlet=channel)
        choice_x = 200 if project.inputs == 1 else 300
        toggle = p.add_textbox("toggle", maxclass="toggle", numinlets=1, numoutlets=1,
                               outlettype=["int"], patching_rect=[choice_x, 150, 24, 24])
        offset = p.add_textbox("+ 1", numinlets=2, patching_rect=[choice_x + 40, 150, 40, 22])
        source = p.add_textbox("mc.selector~ 2", numinlets=3, numoutlets=1,
                               outlettype=["multichannelsignal"],
                               patching_rect=[300, 200 if project.inputs == 1 else 270, 100, 22])
        p.add_comment("test-220Hz" if project.inputs == 1 else "test-tones",
                      patching_rect=[choice_x, 125, 100, 20])
        p.add_line(adc, source, inlet=1)
        p.add_line(tone, source, inlet=2)
        p.add_line(toggle, offset)
        # mc.selector~ numbers sources from 1: toggle 0 selects the ADC,
        # toggle 1 selects the oscillators after adding the offset.
        p.add_line(offset, source)
        initial(p, load, toggle, 0, x=300, y=100)
    p.add_line(source, dsp)


def add_audio_output(p: Patcher, dsp, load, project: FaustProject, *, master_level=None):
    """Connect every Faust output to the MC DAC, with optional master gain.

    Args:
        p: Patcher to modify.
        dsp: MC bus source on outlet 0.
        load: Trigger initializing the master level, if present.
        project: Output count, mapped to hardware channels 1 to N.
        master_level: Initial mc.*~ gain, or None for a direct connection. The widget
            offers a 0..1 range; no audio limiter is added.

    Returns:
        None. The DAC uses the stable identifier dac_1.

    Mnemosphere's generator uses custom routing to separate 25 HOA components from
    the two preview channels instead of using this block.
    """
    channels = " ".join(map(str, range(1, project.outputs + 1)))
    dac = p.add_textbox(f"mc.dac~ {channels}", id="dac_1", numinlets=1, numoutlets=0,
                        patching_rect=[850, 200, 360, 22])
    source = dsp
    if master_level is not None:
        p.add_comment("output-level", patching_rect=[800, 75, 100, 20])
        volume = p.add_floatbox(minimum=0, maximum=1, patching_rect=[800, 100, 78, 22],
                                varname="output_level")
        source = p.add_textbox("mc.*~", numinlets=2, numoutlets=1,
                               outlettype=["multichannelsignal"], patching_rect=[800, 150, 60, 22])
        p.add_line(dsp, source)
        p.add_line(volume, source, inlet=1)
        initial(p, load, volume, master_level, x=900, y=100)
    p.add_line(source, dac)


def control_address(project: FaustProject, parameter) -> str:
    # Polyphony adds /Polyphonic/Voices around the compiled UI. Unique labels
    # remain stable in mspUI when this wrapper changes the full paths.
    """Choose a stable Max selector for a Faust parameter.

    Args:
        project: Indicates whether a polyphonic allocator wraps the DSP.
        parameter: Parameter providing the label or full address.

    Returns:
        Label for polyphony, whose wrapper changes UI paths; full address otherwise.
        add_controls checks the resulting selectors for uniqueness.
    """
    return parameter.label if project.voices else parameter.address


def add_controls(p: Patcher, dsp, load, project: FaustProject):
    """Build numeric controls and Faust messages in a four-column layout.

    Args:
        p: Patcher to modify.
        dsp: Recipient of ``selector $1`` messages on inlet 0.
        load: Trigger for initial values extracted from JSON.
        project: Faust UI parameters, bounds, and units, excluding reserved MIDI controls.

    Raises:
        ValueError: Two parameters use the same Max selector.

    Each floatbox receives Faust bounds and a varname based on shortname. Initial
    values travel through floatbox and message to the DSP. Units are displayed;
    the Faust step is retained in the model but is not configured on the widget.
    """
    names = [control_address(project, item) for item in project.controls]
    if len(set(names)) != len(names):
        raise ValueError("Faust controls must have unique Max selectors.")
    for index, (item, name) in enumerate(zip(project.controls, names)):
        # Modulo selects the column; integer division selects the control row.
        x, y = 30 + index % 4 * 330, 350 + index // 4 * 85
        label = item.label + (f" ({item.unit})" if item.unit else "")
        p.add_comment(label, patching_rect=[x, y - 20, 300, 20])
        value = p.add_floatbox(minimum=item.minimum, maximum=item.maximum,
                               patching_rect=[x, y, 78, 22], varname=f"{item.shortname}_value")
        msg = p.add_message(f"{name} $1", patching_rect=[x + 90, y, 230, 22])
        p.add_line(value, msg)
        p.add_line(msg, dsp)
        initial(p, load, value, item.initial, x=x, y=y + 30)


def midi_input(p: Patcher, dsp, load):
    """Add MIDI input, virtual keyboard, chord, All Notes Off, and mute controls.

    Args:
        p: Polyphonic Patcher to modify.
        dsp: mc.faustgen~ object receiving MIDI events and mute messages.
        load: Trigger initializing velocity=100, duration=250 ms, and mute=0.

    Hardware routing is midiin → midiparse (outlet 7) → Faust. Keyboard and chord
    60/64/67 use makenote → join → midiformat (outlet 1). makenote emits note-off
    events after the selected duration. ``midievent 176 123 0`` sends All Notes Off
    on channel 1; the mute toggle sends ``mute $1``. The Faust source declares
    polyphony; this routing does not create the voice allocator. Return None.
    """
    p.add_comment("MIDI input / entree MIDI", patching_rect=[30, 95, 300, 20])
    midi = p.add_textbox("midiin", numinlets=1, numoutlets=1, patching_rect=[30, 120, 55, 22])
    parse = p.add_textbox("midiparse", numinlets=1, numoutlets=8, patching_rect=[200, 120, 90, 22])
    p.add_line(midi, parse)
    p.add_line(parse, dsp, outlet=7)
    p.add_comment("On-screen keyboard / clavier", patching_rect=[30, 720, 350, 20])
    keyboard = p.add_textbox("kslider", maxclass="kslider", numinlets=1, numoutlets=2,
                             outlettype=["int", "int"], patching_rect=[30, 770, 370, 55])
    make = p.add_textbox("makenote 100 250", numinlets=3, numoutlets=2, patching_rect=[30, 840, 130, 22])
    join = p.add_textbox("join", numinlets=2, numoutlets=1, patching_rect=[30, 880, 40, 22])
    fmt = p.add_textbox("midiformat", numinlets=7, numoutlets=2, patching_rect=[30, 920, 100, 22])
    p.add_line(keyboard, make)
    p.add_line(keyboard, make, outlet=1, inlet=1)
    for port in range(2):
        p.add_line(make, join, outlet=port, inlet=port)
    p.add_line(join, fmt)
    p.add_line(fmt, dsp, outlet=1)
    chord = p.add_message("60, 64, 67", patching_rect=[240, 840, 100, 22])
    p.add_comment("C-major", patching_rect=[240, 815, 100, 20])
    p.add_line(chord, make)
    for index, (name, value, maximum) in enumerate((("velocity", 100, 127), ("duration-ms", 250, 5000))):
        x = 450 + index * 200
        p.add_comment(name, patching_rect=[x, 785, 150, 20])
        widget = p.add_floatbox(minimum=1, maximum=maximum, patching_rect=[x, 810, 78, 22])
        p.add_line(widget, make, inlet=index + 1)
        initial(p, load, widget, value, x=x, y=770)
    panic = p.add_message("midievent 176 123 0", patching_rect=[850, 810, 180, 22])
    p.add_comment("all-notes-off", patching_rect=[850, 785, 180, 20])
    p.add_line(panic, dsp)
    mute = p.add_textbox("toggle", maxclass="toggle", numinlets=1, numoutlets=1,
                         outlettype=["int"], patching_rect=[1050, 810, 24, 24])
    p.add_comment("mute", patching_rect=[1050, 785, 100, 20])
    msg = p.add_message("mute $1", patching_rect=[1050, 850, 90, 22])
    p.add_line(mute, msg)
    p.add_line(msg, dsp)
    initial(p, load, mute, 0, x=1140, y=810)


def add_runtime_controls(p: Patcher, dsp):
    """Add dump to Faust and mc.ezdac~ as Max's global DSP switch.

    Args:
        p: Patcher to modify.
        dsp: Recipient of dump, whose response uses the diagnostic printer.

    mc.ezdac~ has no audio connections because mc.dac~ already receives the signals.
    The user enables it manually. Return None.
    """
    dump = p.add_message("dump", patching_rect=[1050, 100, 80, 22])
    p.add_line(dump, dsp)
    p.add_comment("DSP", patching_rect=[1050, 225, 80, 20])
    p.add_textbox("mc.ezdac~", maxclass="mc.ezdac~", numinlets=2, numoutlets=0,
                  patching_rect=[1050, 250, 48, 48])


def finish_patch(p: Patcher) -> Patcher:
    """Add the editing hint and validate every native port index.

    Args:
        p: Completed Patcher; its height places the comment at the canvas bottom.

    Returns:
        The same Patcher, ready for serialization, without writing files.

    Raises:
        ValueError: An inlet or outlet index exceeds the declared port count.

    Validation uses py2max's internal objects/lines and the generators' explicit
    port counts rather than the Max reference database.
    """
    p.add_comment("Double-click mc.faustgen~ to edit Faust / double-cliquer pour modifier le Faust",
                  patching_rect=[30, p.rect[3] - 30, 1100, 20])
    for line in p._lines:
        source, outlet = line.source
        target, inlet = line.destination
        if not 0 <= outlet < p._objects[source].numoutlets:
            raise ValueError(f"Invalid outlet: {source}[{outlet}]")
        if not 0 <= inlet < p._objects[target].numinlets:
            raise ValueError(f"Invalid inlet: {target}[{inlet}]")
    return p


def generate(stem: str, output_dir: Path = HERE, faust: str = "faust") -> tuple[Path, ...]:
    """Analyze a project, build its Max patch, and write the .maxpat JSON.

    Args:
        stem: Identifier in the shared catalog.
        output_dir: Destination created recursively; defaults to HERE.
        faust: Compiler forwarded to load_project.

    Returns:
        Tuple containing the single exported path, ``stem.maxpat``.

    An existing file is replaced. Faust source is embedded in the patch; no separate
    .dsp is written. Analysis, construction, and write errors are propagated, with
    no transactional guarantee for the destination file.
    """
    project = load_project(stem, faust)
    patch = project_builder(HERE, stem)(project)
    output_dir.mkdir(parents=True, exist_ok=True)
    path = output_dir / f"{stem}.maxpat"
    patch.save_as(path)
    return (path,)


def main(stem: str | None = None):
    """Run the Max CLI for stem, or the entire catalog if stem is None.

    generation_cli handles --output-dir, --faust, and --check. This entry point reads
    sys.argv; use generate for programmatic calls.
    """
    generation_cli(generate, HERE, stem)
