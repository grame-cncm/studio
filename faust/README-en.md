# Building Max patches with Faust, an interface, and `py2max`

[Version française](README.md)

This directory gathers a workflow for producing complete Max patches: the DSP
is written in **Faust** and embedded in `mc.faustgen~`, while the Max topology
and interface are generated in **Python** with [`py2max`](py2max/). Examples
generated with this workflow are in [`max-patches/`](max-patches/).

This approach is especially suitable for collaboration with an LLM: it can
write or modify the Python script that drives `py2max`, the Faust code, and the
connections; the script then produces a `.maxpat` JSON file that Max opens
normally. The result remains a readable Max patch that can be edited by hand.
This method is more reliable than asking an LLM to write a Max patch directly
in JSON format.

## Prerequisites

- Max with the **faustgen** package installed;
- Python 3.9 or newer;
- the `py2max` submodule initialized.

After cloning the main repository:

```bash
git submodule update --init --recursive
python3 -m venv .venv
. .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -e faust/py2max
```

`py2max` uses a modern build backend declared in `pyproject.toml`; an older
version of `pip` cannot install it in editable mode. After activating the
virtual environment, therefore use `python -m pip` rather than the `pip`
binary.

To work directly from the clone without installing it, the generation script
can also add `faust/py2max` to `sys.path`.

## Patch architecture

A complete patch usually has the following four layers:

1. **Faust DSP** — the Faust text is stored in the `sourcecode` property of
   `mc.faustgen~`. Its controls (`hslider`, `nentry`, `button`, etc.) become
   addressable parameters in Max.
2. **Max inputs and outputs** — `mc.adc~`/`mc.ezadc~`, MIDI, or a Max source
   feed `mc.faustgen~`; its audio outputs go to `mc.ezdac~`, `mc.dac~`, or
   subsequent processing.
3. **User interface** — `flonum`, `live.dial`, `slider`, `toggle`, `kslider`,
   and comments are connected to messages of the form `parameterName $1`, sent
   to `mc.faustgen~`.
4. **Initialization** — `loadbang` and number messages provide predictable
   starting values to widgets and the DSP. Do not use only `set value`: that
   message updates a widget but does not send the value to the DSP.

Existing examples, including
[`generate_faustgen_additive_poly_midi.py`](max-patches/generate_faustgen_additive_poly_midi.py),
illustrate this structure for a polyphonic additive synthesizer.

### Multichannel rule

Prefer **MC**-format Max objects (`mc.*`) whenever an equivalent is available,
so that the patch can preserve and evolve its channel count without duplicating
wiring. In particular, use `mc.faustgen~` instead of `faustgen~`, and prefer
`mc.ezadc~`, `mc.ezdac~`, `mc.mixdown~`, and so on. Non-MC objects remain
appropriate for control, MIDI, and objects that have no MC equivalent.

## Workflow with an LLM

Give the LLM the audio and interface brief, along with the contents of
[`max-patches/PROMPT.md`](max-patches/PROMPT.md). Ask it to start from an
existing generator and create a new `generate_my_patch.py` file rather than
editing the `.maxpat` JSON by hand.

An effective brief specifies:

- the patch role (synthesizer, effect, spatialization), inputs, and outputs;
- the desired Faust algorithm;
- every parameter: name, initial value, range, and widget type;
- audio and MIDI routing;
- layout conventions, titles, and help text.

Example request:

> Create a `py2max` generator for a stereo effect. Embed a Faust delay in
> `mc.faustgen~` with `time`, `feedback`, and `mix` parameters. Add labelled
> `live.dial` controls, initialize them with `loadbang`, connect `mc.ezadc~`
> to the DSP and the DSP to `mc.ezdac~`. Use a readable layout and keep the
> Faust code in a `FAUST_SOURCE` constant.

The LLM should generate a verifiable Python script. Run it, open the patch in
Max, then listen and refine the Faust code or interface. This loop is
preferable to generating JSON directly: `py2max` manages boxes, their IDs,
patch cords, and `.maxpat` serialization.

## Generator skeleton

```python
from pathlib import Path
from py2max import Patcher

OUT = Path(__file__).with_name("my-effect.maxpat")
FAUST_SOURCE = r'''import("stdfaust.lib");
time = hslider("time", 250, 1, 1000, 1);
feedback = hslider("feedback", 0.35, 0, 0.95, 0.01);
mix = hslider("mix", 0.5, 0, 1, 0.01);
echo(x) = x + de.delay(65536, int(time)) * feedback;
process = _,_ : echo,echo : *(mix),*(mix);
'''

p = Patcher(OUT, semantic_ids=True, validate_connections=True)
p.rect = [80.0, 80.0, 800.0, 500.0]
p.add_comment("My Faust effect", patching_rect=[30, 20, 300, 28], fontsize=18)

source = p.add_textbox("mc.ezadc~", maxclass="mc.ezadc~", numinlets=1, numoutlets=2,
                       patching_rect=[30, 100, 48, 48])
dsp = p.add_textbox("mc.faustgen~", numinlets=2, numoutlets=2,
                    outlettype=["signal", "signal"], sourcecode=FAUST_SOURCE,
                    sourcecode_size=len(FAUST_SOURCE.encode("utf-8")),
                    patching_rect=[300, 110, 70, 22])
output = p.add_textbox("mc.ezdac~", maxclass="mc.ezdac~", numinlets=2, numoutlets=0,
                       patching_rect=[600, 100, 48, 48])
p.add_line(source, dsp)
p.add_line(source, dsp, outlet=1, inlet=1)
p.add_line(dsp, output)
p.add_line(dsp, output, outlet=1, inlet=1)

loadbang = p.add_textbox("loadbang", patching_rect=[30, 180, 58, 22])
for name, value, lo, hi, y in [("time", 250, 1, 1000, 220),
                                ("feedback", 0.35, 0, .95, 290),
                                ("mix", .5, 0, 1, 360)]:
    p.add_comment(name, patching_rect=[30, y, 100, 20])
    control = p.add_floatbox(minimum=lo, maximum=hi,
                             patching_rect=[130, y, 70, 22])
    message = p.add_message(f"{name} $1", patching_rect=[215, y, 100, 22])
    initial = p.add_message(str(value), patching_rect=[330, y, 50, 22])
    p.add_line(control, message)
    p.add_line(message, dsp)
    p.add_line(loadbang, initial)
    p.add_line(initial, control)

p.save()
```

Adjust the number of `mc.faustgen~` inputs and outputs to the Faust `process`.
For a polyphonic MIDI instrument, use the standard `/freq`, `/gain`, and
`/gate` parameters and the MIDI objects shown in the additive example.

## Reproducible alternative: standalone Faust DSP, generated interface, and tests

For more complex effects, especially those with many parameters, prefer this
variant. The Faust DSP, Max generator, and tests are separate, so each layer
has a single responsibility:

```text
faustgen-my-effect.dsp
        ↓ extracted hslider parameters
generate_faustgen_my_effect.py  ──→  faustgen-my-effect.maxpat
        ↓                                      ↓
test_faustgen_my_effect.py  ─────→  validation in Max
```

The complete example is a mono-to-six-output spatializer using Zita Rev1:

- [`max-patches/faustgen-mono-6out-zita.dsp`](max-patches/faustgen-mono-6out-zita.dsp)
  contains only the DSP. It distributes dry sound on a ring of six
  loudspeakers and uses three stereo `re.zita_rev1_stereo` instances for pairs
  1–2, 3–4, and 5–6.
- [`max-patches/generate_faustgen_mono_6out_zita.py`](max-patches/generate_faustgen_mono_6out_zita.py)
  reads the `hslider` declarations, creates the Max widgets and messages, then
  writes the `.maxpat` with `py2max`.
- [`max-patches/test_faustgen_mono_6out_zita.py`](max-patches/test_faustgen_mono_6out_zita.py)
  regenerates the patch and checks its structural contract.

This organization avoids copying Faust parameter default values and ranges into
Python. Every Faust control (`hslider`, `nentry`, `button`, etc.) must however
have a **unique** label in the DSP. By default, use its stable identifier as
the label, for example:
`zita_predelay = hslider("zita_predelay", 60, 20, 100, 1);`.
Faustgen uses this label as the parameter address; two controls with the same
label are ambiguous, and a label containing spaces cannot reliably be sent by
a Max message of the form `name $1`.

When a DSP must retain more elaborate labels or a group hierarchy, do not guess
its address from the Faust source: generate its JSON with
`faust -json my-effect.dsp`, then use the `shortname` field or the `path`
field associated with each control to produce Max messages. These fields then
form the linking identifier between DSP and interface. The six-output example
generator follows the simple convention and rejects declarations where the
Faust identifier and label differ; it derives a more readable Max comment from
that identifier.

Initial values are sent through a numeric message connected both to the widget
and to the parameter message. The displayed values and DSP values are thus
synchronized as soon as the patch opens, without relying on the silent `set`
behavior.

### Run the loop

```bash
# Generates the patch and checks DSP, parameters, embedded source, and MC topology.
python3 faust/max-patches/test_faustgen_mono_6out_zita.py

# Final test: open the patch in Max and check the console.
open -a Max faust/max-patches/faustgen-mono-6out-zita.maxpat
```

The Python test checks that the embedded `sourcecode` is identical to the
`.dsp` file, that the object is `mc.faustgen~`, that output routing is
`mc.dac~ 1 2 3 4 5 6`, that all three Zita instances are present, and that each
of the eight Faust parameters has a Max message. The Max test remains
necessary: it validates actual Faustgen compilation and must print
`Compilation from source code succeeded, 1 input(s), 6 output(s)`.

The patch also includes an optional internal 220 Hz sine wave. It lets you
check panning without connecting a physical input: enable audio, enable this
source, then set `azimuth` to `0`, `1/6`, … `5/6` to check that dry sound is
focused successively on outputs 1 through 6.

## Generate and check the result

```bash
python3 faust/max-patches/generate_faustgen_additive_poly_midi.py
python3 -m py2max preview faust/max-patches/faustgen-additive-poly-midi.maxpat
```

Then open the `.maxpat` in Max. Check that `mc.faustgen~` finds Faust and
compiles without errors, that every widget modifies its stated parameter, and
that the audio channels match the intended routing. Keep the Python script and
the generated patch together: the former is the reproducible source of the
latter.

## Resources

- [`py2max/README.md`](py2max/README.md): installation, API, validation,
  layouts, and SVG preview;
- [`py2max/docs/user_guide/quickstart.md`](py2max/docs/user_guide/quickstart.md):
  patch-building principles;
- [`max-patches/`](max-patches/): the project’s Faust/Max generators and
  patches.
