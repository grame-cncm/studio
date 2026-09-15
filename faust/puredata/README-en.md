# Faust in PureData with py2pd

[Version française](README.md)

[`py2pd`](https://github.com/shakfu/py2pd) lets you create, read and edit
PureData patches (`.pd`) in Python. With
[`pd-faustgen`](https://github.com/sletz/pd-faustgen), you can also write
the DSP in Faust and generate its interface and connections with py2pd.

## Installation

You need Python **3.13 or newer**, `uv`, and PureData to open and listen to
patches. Faust projects also require the **Faust** compiler available as `faust`.
Run these commands from the repository root:

```bash
git submodule update --init
uv venv faust/puredata/.venv --python 3.13
uv pip install --python faust/puredata/.venv/bin/python -e faust/puredata/py2pd
. faust/puredata/.venv/bin/activate
```

## Create a patch in Python

Add objects, connect their ports, then save the patch:

```python
from py2pd import Patcher

patch = Patcher("my-patch.pd")
osc = patch.add("osc~ 440")
gain = patch.add("*~ 0.1")
dac = patch.add("dac~ 1 2")
patch.link(osc, gain)
patch.link(gain, dac)
patch.link(gain, dac, inlet=1)
patch.save()
patch.save_svg("my-patch.svg")
```

Ports are numbered from zero. `link()` uses port 0 by default;
`inlet=` and `outlet=` select other ports.
Use `add_msg()` for messages, `add_comment()` for comments, and
`add_hslider()`, `add_toggle()` or `add_numberbox()` for controls.

## Edit an existing patch

```python
from py2pd import parse_file, to_builder

patch = to_builder(parse_file("input.pd"))
patch.add_comment("Edited with py2pd")
patch.save("edited.pd")
```

## Coding Faust in PureData with faustgen2~

The object `faustgen2~ my-effect` loads `my-effect.dsp` from the patch's
folder and compiles the DSP inside PureData, like `mc.faustgen~` in Max.
Each audio channel has its own connection in Pd.

### Install the external

The [`sletz/pd-faustgen`](https://github.com/sletz/pd-faustgen) fork is included
in the [`pd-faustgen/`](pd-faustgen/) submodule.
On macOS, the supplied script builds it using a Faust installation with
LLVM support, plus CMake, make, Autotools and `llvm-config`:

```bash
python faust/puredata/scripts/build_faustgen.py
```

Specify your installation paths if needed:

```bash
python faust/puredata/scripts/build_faustgen.py \
  --faust-library /usr/local/lib/libfaustwithllvm.a \
  --llvm-config /opt/local/bin/llvm-config
```

In your regular PureData installation, add
`faust/puredata/pd-faustgen/external` to Pd's search path,
then restart PureData.

When connecting `faustgen2~` yourself, inlet and outlet 0 are for control;
audio ports start at 1. A stereo DSP with two inputs and two outputs therefore
needs `num_inlets=3` and `num_outlets=3` in py2pd.

## Available Faust projects

The ten projects use the same [Faust sources](../dsp/) as
[Max/MSP](../maxmsp/README-en.md):

| Project | Audio inputs → outputs | Patch |
| --- | --- | --- |
| Additive MIDI synthesis, 16 voices | 0 → 2 | [Additive MIDI](pd-patches/faustgen-additive-poly-midi.pd) |
| Circular quadraphonic panning | 1 → 4 | [Quad panner](pd-patches/faustgen-quad-panner.pd) |
| Two stereo orbits on eight speakers | 2 → 8 | [Stereo Orbit](pd-patches/faustgen-stereo-orbit.pd) |
| HOA4 granular memory decoded for the studio | 1 → 26 speakers | [Mnemosphere](pd-patches/faustgen-mnemosphere-hoa4.pd) |
| Rotating field of eight sources | 8 → 16 | [8×16 panner](pd-patches/faustgen-8x16-panner.pd) |
| Independent VBAP for each input | 8 → 16 | [8×16 per-input](pd-patches/faustgen-8x16-per-input-panner.pd) |
| Independent VBAP and Freeverb per output | 8 → 16 | [VBAP + Freeverb](pd-patches/faustgen-8x16-per-input-vbap-reverb.pd) |
| Stereo panning and Zita Rev1 | 1 → 2 | [Stereo Zita](pd-patches/faustgen-mono-stereo-spatial-reverb.pd) |
| Circular panning and three stereo Zita reverbs | 1 → 6 | [Six-output Zita](pd-patches/faustgen-mono-6out-zita.pd) |
| abclib VBAP with adjustable speaker angles | 1 → 6 | [abclib VBAP6](pd-patches/faustgen-abclib-2d-vbap6.pd) |

Generate all these patches and their SVG previews:

```bash
python faust/puredata/pd-patches/generate_all.py
```

Each project reads its [common Faust file in `../dsp/`](../dsp/).
Its `generate_*.py` script contains an explicit `build_patch()` that assembles
audio, controls and optional MIDI using
[`pd_helpers.py`](pd-patches/pd_helpers.py).

For lasting sound changes, edit the common `.dsp` and regenerate both hosts'
patches. To customize Pd's interface or routing, edit the generator's
`build_patch()`. See the [common workflow](../README-en.md#a-common-workflow).

You can regenerate one project:

```bash
python faust/puredata/pd-patches/generate_faustgen_mono_6out_zita.py
```

Every project generator accepts `--output-dir directory`,
`--faust compiler-path`, and `--check` to compare patches, DSPs and previews without modifying them.
The `.dsp` beside the patch is a copy replaced during regeneration. Copy any
edits back to `../dsp/` to preserve them.

Open the `.pd`, configure the required number of audio channels and enable
**DSP**. Mono effects provide a **test-220Hz** toggle to select an internal
sine wave instead of the audio input. Adjust the controls, then use
**compile** or **autocompile** after editing Faust. In Pd messages, separators
in Faust labels become hyphens: control `input1_azimuth` with
`input1-azimuth $1`.

For the synthesizer, select a MIDI input in PureData, or use **MIDI-note**
and **play**, or the **C-major** button to play a chord. **velocity** and
**duration-ms** adjust notes played on screen; **output-level** sets the
volume, **mute** silences the sound and **all-notes-off** releases notes.
MIDI controllers 1 to 4 control the four partials.

For abclib, edit
[`faustgen-abclib-2d-vbap6.dsp`](../dsp/faustgen-abclib-2d-vbap6.dsp),
then run `generate_abclib_2d_vbap6.py`. The generator produces a self-contained
`.dsp` using the
[abclib submodule libraries](../dsp/libraries/abclib/faustCodes/library/),
which the patch loads directly. **theta** sets the source angle; **a0** to **a5** set
the six speaker angles, in degrees.

## Stereo Orbit

Open [the patch](pd-patches/faustgen-stereo-orbit.pd), configure eight
audio outputs and enable **DSP**. Connect a stereo source to inputs 1 and 2,
or enable **test-tones** to hear two sine waves at 220 and 330 Hz. Place the
speakers in a circle: output 1 at the front, then outputs 2 to 8 clockwise
at 45° intervals.

**speed** sets revolutions per second (negative values reverse direction);
set **running** to 0 to freeze motion and to 1 to resume. **azimuth** shifts
the center and **width** sets the initial separation between channels, in
turns. Set **counterrotate** to 1 for opposite rotations or to 0 for a shared
rotation. **spread** distributes each source around the ring (0: two adjacent
speakers, 1: all speakers), and **level** sets the output level. Start with
**test-tones** enabled, `speed = 0.08`, `counterrotate = 1`, `spread = 0`
and `level = 0.5`.

## Mnemosphere HOA4

Open [the patch](pd-patches/faustgen-mnemosphere-hoa4.pd), enable **DSP**
and **test-220Hz**, or connect a voice, instrument or percussion source to
input 1. Four granulators explore the recent past of the input and project
their grains along alternating trajectories in the sphere. Spatial precision
breathes while echoes gradually spread between ambisonic components.

**grain_ms** sets grain size, **memory_ms** sets memory depth, **scarcity**
reduces grain density, and **grain_feedback** sets persistence. **grain_mix**
blends the directly encoded source (0) with the granular field (1).
**orbit_hz** sets signed trajectory speed; **running** at 0 freezes positions
and breathing while the sonic memory continues. **azimuth**, **elevation**
and **latitude** place the clouds and set their vertical excursion.
**focus** at 1 favors precision, and at 0 an omnidirectional field;
**breathing** modulates precision. **diffraction**, **echo_ms** and
**echo_feedback** control spatial echoes; **level** sets the overall level.
**decoder** selects the decoder (`0`: abclib direct, `1`: Ambitools max-rE
SAD) with a smoothed crossfade; **decoder_gain** is the final calibration trim
in dB.

For particle rain, try `grain_ms = 35`, `scarcity = 0.6`, `grain_mix = 1`
and `orbit_hz = 0.09`. For suspended memory, try `grain_ms = 180`,
`memory_ms = 1800`, `grain_feedback = 0.45` and `running = 0`. Keep the
level moderate and adjust diffraction by ear.

The internal field remains **fourth-order 3D HOA, ACN/SN3D**, then the
[studio decoder library](../dsp/libraries/README-en.md) produces 26 speaker
feeds. DSP outputs 1–25 target hardware outputs 1–25; DSP output 26 is AtmoC
and targets hardware output 28. Hardware outputs 26–27 remain reserved for the
subwoofers and receive no HOA component.

For a non-Ambisonic multi-output DSP, use the
[geometry library](../dsp/libraries/grame_studio_layout-en.md) directly. Its
presets associate 2 outputs with L/R, 4 with L1–L4, 6 with M1–M6, and 8 with
C1–C8. They describe routing without processing audio: the Pure Data generator
must connect DSP outputs to the `dac~` channels returned by
`ringHardwareOutput(P,I)`.

To record the field, click **choose-WAV**, choose a filename ending in `.wav`,
then click **start** and **stop**. `writesf~ 26` records the 26 decoded feeds
as 32-bit float.

The recorded WAV contains speaker feeds, not an HOA file to decode again. The
[common DSP](../dsp/faustgen-mnemosphere-hoa4.dsp) uses abclib’s granulator,
3D encoder, wider and decorrelator, followed by the abclib/Ambitools decoders.
Importing Ambitools places this DSP under CC-BY-NC-SA-4.0.

## Resources

- [py2pd guide](py2pd/README.md) and [API documentation](py2pd/docs/index.md)
- [pd-faustgen guide](https://github.com/sletz/pd-faustgen)
- [PureData](https://puredata.info)
