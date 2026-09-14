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

The eight projects use the same [Faust sources](../dsp/) as
[Max/MSP](../maxmsp/README-en.md):

| Project | Audio inputs → outputs | Patch |
| --- | --- | --- |
| Additive MIDI synthesis, 16 voices | 0 → 2 | [Additive MIDI](pd-patches/faustgen-additive-poly-midi.pd) |
| Circular quadraphonic panning | 1 → 4 | [Quad panner](pd-patches/faustgen-quad-panner.pd) |
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

## Resources

- [py2pd guide](py2pd/README.md) and [API documentation](py2pd/docs/index.md)
- [pd-faustgen guide](https://github.com/sletz/pd-faustgen)
- [PureData](https://puredata.info)
