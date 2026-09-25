# Faust in Max/MSP with py2max

[Version française](README.md)

[`py2max`](py2max/) creates Max patches (`.maxpat`) in Python.
Audio processing is written in Faust and embedded in `mc.faustgen~`.
The projects use the same [Faust sources](../dsp/) as PureData and follow the
[common workflow](../README-en.md#a-common-workflow).

## Installation

You need Max with the **faustgen** package, Python **3.9 or newer**, and the
**Faust** compiler available as `faust`. From the repository root:

```bash
git submodule update --init
python3 -m venv .venv
. .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -e faust/maxmsp/py2max
```

## Generate the patches

Generate every project:

```bash
python faust/maxmsp/max-patches/generate_all.py
```

Or run one project's generator:

```bash
python faust/maxmsp/max-patches/generate_faustgen_mono_6out_zita.py
```

Scripts also accept `--output-dir directory`, `--faust compiler-path`, and
`--check`, which compares existing patches without modifying them.

Open the `.maxpat` in Max, configure your audio device and channel count, and
enable **DSP**. Controls display the defaults defined in Faust and control
the DSP. Mono effects include **test-220Hz** to select an internal sine wave
instead of the audio input.

For the synthesizer, use a MIDI input or the on-screen keyboard.
**C-major** plays a chord; **velocity** and **duration-ms** adjust on-screen
notes. **output-level** adjusts volume, **mute** silences output, and
**all-notes-off** releases the notes. MIDI controllers 1–4 adjust the partials.

## Edit the sound and interface

Edit the corresponding `.dsp` in [`../dsp/`](../dsp/), then regenerate the Max
and PureData patches. Controls, ranges and defaults come from Faust JSON;
you only need to define them once in the DSP.

You can also double-click `mc.faustgen~` in Max and choose **Edit DSP code**
to edit the embedded Faust. Copy those edits back to the common file to
preserve them when regenerating. For abclib, edit
[`faustgen-abclib-2d-vbap6.dsp`](../dsp/faustgen-abclib-2d-vbap6.dsp);
required libraries are incorporated into the embedded code.

Each `generate_*.py` contains a `build_patch()` function describing the
project's blocks and routing. Edit it to customize the interface or
connections. Reusable functions live in
[`max_helpers.py`](max-patches/max_helpers.py).

When creating a project with an LLM, specify its purpose, Faust algorithm,
channels and controls. Ask for a common `.dsp` file and a generator per
environment, starting from an existing project.

## Available projects

| Project | Audio inputs → outputs | Patch |
| --- | --- | --- |
| Additive MIDI synthesis, 16 voices | 0 → 2 | [Additive MIDI](max-patches/faustgen-additive-poly-midi.maxpat) |
| Circular quadraphonic panning | 1 → 4 | [Quad panner](max-patches/faustgen-quad-panner.maxpat) |
| Two stereo orbits on eight speakers | 2 → 8 | [Stereo Orbit](max-patches/faustgen-stereo-orbit.maxpat) |
| HOA4 granular memory decoded for the studio | 1 → 26 speakers | [Mnemosphere](max-patches/faustgen-mnemosphere-hoa4.maxpat) |
| Rotating field of eight sources | 8 → 16 | [8×16 panner](max-patches/faustgen-8x16-panner.maxpat) |
| Independent VBAP for each input | 8 → 16 | [8×16 per-input](max-patches/faustgen-8x16-per-input-panner.maxpat) |
| Independent VBAP and Freeverb per output | 8 → 16 | [VBAP + Freeverb](max-patches/faustgen-8x16-per-input-vbap-reverb.maxpat) |
| Stereo panning and Zita Rev1 | 1 → 2 | [Stereo Zita](max-patches/faustgen-mono-stereo-spatial-reverb.maxpat) |
| Circular panning and three stereo Zita reverbs | 1 → 6 | [Six-output Zita](max-patches/faustgen-mono-6out-zita.maxpat) |
| abclib VBAP with adjustable speaker angles | 1 → 6 | [abclib VBAP6](max-patches/faustgen-abclib-2d-vbap6.maxpat) |
| Stereo upmix, adaptive center extraction | 2 → 3 | [Upmix 2→3](max-patches/faustgen-upmix-center-3ch.maxpat) |
| Stereo upmix to 5.0, decorrelated ambience | 2 → 5 | [Upmix 2→5.0](max-patches/faustgen-upmix-surround-5ch.maxpat) |
| Stereo upmix to 7.0, side and rear surrounds | 2 → 7 | [Upmix 2→7.0](max-patches/faustgen-upmix-surround-7ch.maxpat) |
| Stereo upmix to 7.0, four analysis bands | 2 → 7 | [Upmix 2→7.0 multiband](max-patches/faustgen-upmix-surround-7ch-multiband.maxpat) |

## Stereo Orbit

Open [the patch](max-patches/faustgen-stereo-orbit.maxpat), configure eight
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

Open [the patch](max-patches/faustgen-mnemosphere-hoa4.maxpat), enable **DSP**
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
C1–C8. They describe routing without processing audio: the Max generator must
apply the numbers returned by `ringHardwareOutput(P,I)` to `mc.dac~`.

To record the field, click **open**, choose a **WAV** file, then click the message
under **record** and **0** under **stop**. `mc.sfrecord~ 26` records the 26
decoded feeds as 32-bit float. Open a file again for each new take.

The recorded WAV contains speaker feeds, not an HOA file to decode again. The
[common DSP](../dsp/faustgen-mnemosphere-hoa4.dsp) uses abclib’s granulator,
3D encoder, wider and decorrelator, followed by the abclib/Ambitools decoders.
Importing Ambitools places this DSP under CC-BY-NC-SA-4.0.

## Stereo Upmix

Four patches spread a stereo source over the studio speakers:
[2 → 3](max-patches/faustgen-upmix-center-3ch.maxpat) extracts a center,
[2 → 5.0](max-patches/faustgen-upmix-surround-5ch.maxpat) adds two surrounds,
[2 → 7.0](max-patches/faustgen-upmix-surround-7ch.maxpat) splits them between
side and rear, and [2 → 7.0 multiband](max-patches/faustgen-upmix-surround-7ch-multiband.maxpat)
analyzes the stereo image in four bands instead of one. There is no LFE.

Connect a stereo source to inputs 1 and 2, enable **DSP**, or enable
**test-scene**: a centered 440 Hz sine, playing every other second, over two
independent noises. The centered sound goes to the center; during its pauses,
the decorrelated noise moves to the surrounds.

The outputs follow the studio's M layer, at ear height, and AtmoC:

| DSP output | Speaker | Hardware output |
| --- | --- | --- |
| FL, FR | M1, M2 (±37.8°) | 11, 12 |
| C | AtmoC (0°) | 28 |
| Ls, Rs (5.0) or Lss, Rss (7.0) | M3, M4 (±90°) | 13, 14 |
| Lrs, Rrs (7.0) | M5, M6 (±139.5°) | 15, 16 |

**center extraction** sets how much of the centered sound goes to the center
(0: no center) and **analysis time** the time constant of the analysis, in ms.
**rear relocation** (5.0) or **surround relocation** (7.0) sets how much of the
ambience goes to the surrounds; 0 mutes them. **decorrelation** decorrelates the
surrounds from the fronts and from each other (0: copies of the ambience,
1: maximum decorrelation, with a comb coloration of each surround).
**surround delay** delays the surrounds, in ms, so that direct sound leaking
into them stays localized in front. Each control sends its full Faust path, for example
`/Adaptive_surround_2_to_5/center_extraction $1`.

Only the 200 Hz–5 kHz band is analyzed; low and high frequencies stay in front.
A centered sound is only partly extracted while ambience plays in the same band:
the multiband version separates the two better. The processing does not
compensate for speaker distances (M3 and M4 are closer than M1 and M2). The
shared DSP imports [`upmix.lib`](../dsp/libraries/upmix.lib), whose functions
cite the papers they use.

## Resources

- [py2max guide](py2max/README.md)
- [Generators and patches](max-patches/)
- [PureData environment](../puredata/README-en.md)
