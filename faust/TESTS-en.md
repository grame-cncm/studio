# Testing the Faust projects

[Version française](TESTS.md)

This document describes how the studio's Faust projects are checked, from the
`.dsp` file to the sound that comes out of PureData. It complements the
[general README](README-en.md), which describes how the patches are generated.

## Principle

Each project starts from a single source, the `.dsp` in [`dsp/`](dsp/). The
Python generators derive a `.maxpat` and a `.pd` from it. The tests check
every step between that source and the sound produced:

1. the studio's Faust libraries compile and keep their contract;
2. both generators produce equivalent patches from the same DSP;
3. the committed files are exactly what the generators produce;
4. the PureData patches load, initialize, and compute the same sound as a C++
   reference compiled from the same DSP;
5. dedicated scenarios check what a constant input does not show: MIDI,
   reverberation, motion, ambisonics, upmix;
6. the `faustgen2~` external correctly recompiles a modified source.

The checks range from reading files to running PureData. Max is never
launched: its patches are checked as JSON documents.

## Requirements

Run the tests from the repository root, with:

- Python 3.13 or newer, `pytest`, and `py2max` and `py2pd` installed in the
  same environment, as described in the [general README](README-en.md);
- the `faust` compiler in the `PATH`;
- a `c++` compiler and the Faust headers installed under `/usr/local/include`,
  for the numerical references;
- PureData and `faustgen2~` built in the `puredata/pd-faustgen` submodule, as
  described in the [PureData guide](puredata/README-en.md#install-the-external).

The `PD_BIN` and `FAUSTGEN_EXTERNAL` variables select another Pd binary or
another external. A test whose requirement is missing is reported as
*skipped* instead of failing: read the `pytest` summary to know what was
actually checked.

## Running the tests

Generation contracts and libraries, without an audio host:

```bash
python -m pytest faust/common/tests
```

PureData, loading and audio:

```bash
python -m pytest faust/puredata/tests
```

A single file or test:

```bash
python -m pytest faust/puredata/tests/test_upmix.py
```

Exported files up to date, for each environment:

```bash
python faust/maxmsp/max-patches/generate_all.py --check
```

```bash
python faust/puredata/pd-patches/generate_all.py --check
```

Checks specific to two Max patches, run directly:

```bash
python faust/maxmsp/max-patches/test_faustgen_mono_6out_zita.py
```

```bash
python faust/maxmsp/max-patches/test_abclib_2d_vbap6.py
```

These two scripts use `assert`: do not run them with `python -O`.

## What each level checks

### 1. Studio libraries

[`common/tests/test_studio_layout_library.py`](common/tests/test_studio_layout_library.py)
and [`common/tests/test_studio_hoa_library.py`](common/tests/test_studio_hoa_library.py)
check the geometry and HOA decoding libraries:

- **Signatures**: each public function compiles with the expected number of
  inputs and outputs (25 inputs and 26 outputs for an HOA4 decoder, for
  example).
- **Contracts written in the source**: the link to
  `gramestudio-speaker-setup.csv`, the numbering
  `hardwareOutput(I) = I + 1`, the rings of 4, 6 and 8 speakers, the exclusion
  of subwoofers 25 and 26. The test looks for these lines in the source:
  changing them requires changing the test too, hence doing it on purpose.
- **Faust library conventions**: each public symbol has its header with the
  official prefix, a declared license, and a `_test` function.
- **Portability**: the combined library can be embedded in a DSP without local
  paths.

### 2. Generation contracts

[`common/tests/test_generation.py`](common/tests/test_generation.py)
generates, for each project in `PROJECTS`, the `.maxpat` and the `.pd` in a
temporary folder, then reads them as data. No host is launched.

- **Signature**: the `SIGNATURES` list sets the number of inputs and outputs
  of each project, in the order of `PROJECTS`. A DSP that changes them must
  update this list.
- **Same source**: the Faust embedded in `mc.faustgen~`, the `.dsp` copy next
  to the `.pd`, and the catalog source are identical; the UTF-8 size declared
  in the `.maxpat` is exact; the source contains no `/Users/` or `/private/`
  path.
- **Max wiring**: every connection targets an inlet and an outlet that exist.
- **Controls**: each widget has the bounds of the JSON produced by Faust; the
  initial value follows the chain `loadbang → value → widget → message → DSP`
  and equals the DSP's `init`; the matching Pd message exists.
- **Outputs to the speakers**: `mc.dac~ 1 … n` in general; Mnemosphere sends
  AtmoC to output 28; the upmixes send FL, FR, C, then the surrounds to M1,
  M2, AtmoC, M3 … M6. These numbers are read back from the studio CSV, which
  is also used to check their common height and that each left speaker has a
  negative azimuth and each right speaker a positive one.
- **The source drives both generators**: the DSP folder is temporarily
  replaced by a test DSP (three control types, a unit, a step); the bounds,
  initial values, and ports of both patches must follow it.
- **`--check`**: on up-to-date files it succeeds without changing their
  content or their date; after a line is appended to an exported file, it
  fails with `Regenerate` without repairing the file.

### 3. Exported files up to date

`test_all_generated_projects_are_current_and_portable`, in
[`puredata/tests/test_projects.py`](puredata/tests/test_projects.py),
regenerates every project in a temporary folder and compares each file, byte
for byte, with the one in the repository. `--check` does the same comparison
for one generator or for `generate_all.py`.

A failure at this level means that the repository contains patches that no
longer match their DSP or their generator, or that another Faust version
produces a different JSON: regenerate, then review the diff.

### 4. Loading and audio in PureData

[`puredata/tests/test_projects.py`](puredata/tests/test_projects.py) runs the
submodule's Pd with `-nogui -noaudio -noprefs -stderr -r 48000`. Pd computes
audio without opening a sound card. In `-batch` mode, `delay` objects advance
in logical time: a measurement scheduled at 1600 ms is reproducible and takes
only a few milliseconds. The Pd console must contain neither `error:` nor
`couldn't create`.

- **Loading**: each `.pd` in the repository loads `faustgen2~` through its own
  `declare` directive, without preloading. The external announces
  `(inputs/outputs)`, matching the Faust JSON, and each queried parameter
  equals its initial value within 1e-6.
- **Projects together**: all projects opened in one Pd process announce
  themselves and shut down cleanly.
- **Comparison with a C++ reference**: `faust` compiles the DSP to C++, which
  is built with `MapUI`. Input c receives the constant 0.05 × (c + 1); after
  400 blocks of 64 samples, the last sample of each output is the reference.
  Pd receives the same inputs and is measured at 500 ms (initial state), at
  950 ms after a control change at 700 ms, and at 1600 ms after a `compile`
  message at 1000 ms. Each output must be finite and equal to the reference
  within `abs=2e-6, rel=1e-5`. The two control states must give different
  references: otherwise the test would not prove that a control acts on the
  sound.

The C++ reference shares the DSP but not the Pd graph, the routing, or the
external's JIT: a mismatch therefore points at the patch, the routing, or the
external.

### 5. Dedicated scenarios

Some projects cannot be checked with constant inputs. They have their own
scenario, written as a Pd patch or a C++ program:

- **MIDI synthesizer**: the 60/64/67 chord, with upper partials removed, must
  give energy at the three fundamentals (`bp~` with Q 80), which proves three
  simultaneous voices; after *All Notes Off*, both outputs must be silent.
- **Reverberations**: after a noise excitation, the tail must reach every
  output.
- **Orbit**: energy is preserved for a point source as for a diffuse one
  (level divided by √8); the source visits each speaker in order, stops when
  `running` is 0, and moves back when `speed` is −1; the internal test tones
  reach the eight outputs, then switch off.
- **Mnemosphere**
  ([`puredata/tests/test_mnemosphere.py`](puredata/tests/test_mnemosphere.py)):
  the 25 HOA4 coefficients are compared with spherical harmonics recomputed
  in Python (ACN order, SN3D normalization, no Condon-Shortley phase), for the
  `dsp/` source as for the exported copy; the recording of the 25 channels and
  of the stereo preview is read back as 32-bit float WAV.
- **Upmix** ([`puredata/tests/test_upmix.py`](puredata/tests/test_upmix.py)):
  the test instruments the generated patch itself, so the scene selector, the
  routing, and the control names are the user's. The test scene places a
  440 Hz sine in the center, playing around 0, 2 and 4 s and silent around 1
  and 3 s, over decorrelated noise. While the sine plays, C must exceed FL by
  at least 6 dB at 440 Hz; while it rests, each surround must exceed C by at
  least 10 dB; with `center extraction` and the relocation depth at 0, C and
  the surrounds must be exactly silent and the sine must return to the
  fronts. The thresholds come from measurements, not estimates: the test's
  docstring justifies them.

Levels are read with `env~`, which follows the Pd convention: 100 dB for an
RMS of 1, and 0 for silence.

### 6. `faustgen2~` just-in-time compilation

[`puredata/tests/test_faustgen.py`](puredata/tests/test_faustgen.py) uses a
minimal DSP (a stereo gain), independent of the projects:

- a generated patch loads, initializes, and closes cleanly, with or without
  clearing the canvas before quitting;
- the audio follows a parameter change and keeps it after a manual `compile`,
  which must actually recompile;
- after the test modifies the `.dsp`, automatic recompilation doubles the gain
  while keeping the control value. This test runs in real time, so that Python
  can modify the source while Pd runs.

### Max side

Max is not launched. Its patches are checked by `--check`, by the contracts of
[`test_generation.py`](common/tests/test_generation.py), and by two scripts in
[`maxmsp/max-patches/`](maxmsp/max-patches/) that read the JSON of a specific
patch (embedded source, `mc.dac~`, control messages).

## Writing a test

The existing tests follow these rules:

- **Isolation**: everything a test produces goes into its `tmp_path`. The DSPs
  in `dsp/` and the exported files in the repository are only read.
- **Independent oracle**: the expected value does not come from the code under
  test. The C++ reference, the spherical harmonics recomputed in Python, and
  the studio CSV are the current oracles.
- **Proof that the test can fail**: a control change must change the
  reference; `--check` must fail on a modified file.
- **The user's patch**: when a project has a selector or a test scene,
  instrument the generated patch (`project_builder`) rather than a patch
  rebuilt separately.
- **Justified thresholds**: a tolerance or a dB margin is explained in the
  docstring, from a measurement or a calculation.
- **Declared requirements**: use the `requires_pd`, `requires_faust`, or
  `skipif` markers on `c++`, so that a missing tool gives a *skip* and not a
  failure.
- **Logical time**: schedule messages and measurements with `scheduled()` and
  run Pd with `-batch`. Use real time only when Python must act during the
  run.

A new project added to `PROJECTS` must also be added to `SIGNATURES`. It is
then covered by levels 2, 3, and 4. If constant inputs are not enough to
check it, exclude it from the C++ comparison with a comment saying why, and
give it a scenario, as for the upmix.

## Which tests after which change

| Change | Checks |
| --- | --- |
| DSP in `dsp/` | regenerate both environments, `--check`, `faust/common/tests`, `faust/puredata/tests` |
| Library in `dsp/libraries/` | the same, since the DSPs that import it change |
| `build_patch()` of a Max generator | regenerate Max, `--check`, `faust/common/tests` |
| `build_patch()` of a Pd generator | regenerate Pd, `--check`, `faust/common/tests`, `faust/puredata/tests` |
| `max_helpers.py`, `pd_helpers.py`, `common/faust.py` | regenerate everything and rerun everything |
| Faust version | regenerate everything and review the diff of the exports |

## Limitations

- No test launches Max: the sound of `mc.faustgen~` is not measured.
- All audio measurements go through PureData; Max's behavior is only inferred
  from the identity of the sources and controls.
- The C++ reference only checks a steady state under constant inputs;
  time- or frequency-dependent processing needs a dedicated scenario.
- The exports depend on the Faust version: another version can produce a
  different JSON and make level 3 fail without any error in the project.
