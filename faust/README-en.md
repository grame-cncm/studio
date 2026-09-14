# Faust in Max/MSP and PureData

[Version française](README.md)

This folder provides two environments for creating audio instruments and
effects: signal processing is written in **Faust**, while patches, interfaces
and connections are generated in **Python**.

## Max/MSP

The [`maxmsp/`](maxmsp/) folder uses **py2max** to generate `.maxpat` patches.
Faust code is embedded in **`mc.faustgen~`**, which compiles it inside Max.
Max's multichannel objects let you adapt the audio routing.

- [`maxmsp/py2max/`](maxmsp/py2max/): patch generation tool;
- [`maxmsp/max-patches/`](maxmsp/max-patches/): Python generators and patches ready to open in Max;
- **User guides:** [English](maxmsp/README-en.md) ·
  [français](maxmsp/README.md).

## PureData

The [`puredata/`](puredata/) folder uses **py2pd** to generate `.pd` patches.
The **`faustgen2~`** object, provided by the
[`sletz/pd-faustgen`](https://github.com/sletz/pd-faustgen) fork, loads a `.dsp`
file next to the patch and compiles it inside PureData. Each audio channel
is connected separately.

- [`puredata/py2pd/`](puredata/py2pd/): patch generation tool;
- [`puredata/pd-faustgen/`](puredata/pd-faustgen/): Faust external for PureData;
- [`puredata/pd-patches/`](puredata/pd-patches/): Python generators, exported DSPs
  and patches ready to open in PureData;
- **User guides:** [English](puredata/README-en.md) ·
  [français](puredata/README.md).

## Get started

Choose your environment, then follow its guide to install the tools and
generate your first patch. Open the result in Max or PureData, configure
your audio device and enable DSP.

## A common workflow

Run this guide’s commands from the repository root. To generate both hosts’
patches with the same Python, use Python **3.13 or newer** and install both
tools in the same virtual environment:

```bash
git submodule update --init
python -m pip install -e faust/maxmsp/py2max -e faust/puredata/py2pd
```

The eight projects use the same [Faust sources in `dsp/`](dsp/).
Parameters, ranges and defaults are defined in these files; interfaces are
created from the JSON produced by Faust. The
[`abclib` submodule](dsp/libraries/abclib/) provides libraries in
`faustCodes/library/`.

1. Edit the `.dsp` in `dsp/` to change the sound or parameters.
2. Edit `build_patch()` in each environment's `generate_*.py` script to change
   its layout or routing.
3. Regenerate the patches and open them in Max or PureData.

```bash
python faust/maxmsp/max-patches/generate_all.py
python faust/puredata/pd-patches/generate_all.py
```

The eight project generators accept `--output-dir directory`,
`--faust compiler-path`, and `--check` to compare existing files without modifying them. Individual
project generators accept the same options as `generate_all.py`.

Max embeds Faust in the `.maxpat`. PureData receives a `.dsp` copy beside its
`.pd`. Regeneration replaces these copies: copy any edits made in Max or in
the DSP loaded by Pd back to `dsp/` to preserve them. For abclib, libraries are
automatically incorporated into the exported DSP.

To add a project, create its `.dsp` in `dsp/`, register its name and title in
`PROJECTS` in [`common/faust.py`](common/faust.py), and start from an existing
`generate_*.py` in each environment. Keep a `build_patch()` function that
assembles audio, controls and, when needed, MIDI. Reusable blocks live in
[`max_helpers.py`](maxmsp/max-patches/max_helpers.py) and
[`pd_helpers.py`](puredata/pd-patches/pd_helpers.py).
