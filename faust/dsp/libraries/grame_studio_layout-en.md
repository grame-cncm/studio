# GRAME studio geometry and routing

[Version française](grame_studio_layout.md)

[`grame_studio_layout.lib`](grame_studio_layout.lib) describes all 28 studio
loudspeakers without imposing Ambisonics or any other signal processing. It is
the single source of truth for coordinates, physical groups, and hardware
output mappings.

It can therefore be used by ordinary multi-output DSPs. A four-output DSP still
produces four contiguous signals; the library only tells the host which
loudspeakers and hardware outputs to use. Max/MSP, Pure Data, or the audio
system performs the final connection.

## Coordinates and indices

Values come from
[`speaker-description/gramestudio-speaker-setup.csv`](../../../speaker-description/gramestudio-speaker-setup.csv).
Faust indices `0..27` exactly follow CSV loudspeaker rows `1..28`. Hardware
outputs are one-based: `hardwareOutput(I) = I + 1`.

- `x` points right, `y` points forward, and `z` points upwards;
- Cartesian coordinates and distances are expressed in metres;
- azimuth is 0° at the front (`+y`) and increases towards the right (`+x`);
- elevation is 0° in the horizontal plane and 90° at the zenith.

Published A/D/E coordinates are exposed unchanged. Functions ending in `At`
recompute them from X/Y/Z and a supplied listening position.

## Multi-output configurations

The `ring…` presets associate common channel counts with physical studio groups:

| DSP outputs | Loudspeakers | Physical indices | Hardware outputs |
|---:|:---|:---|:---|
| 2 | L, R | 0–1 | 1–2 |
| 4 | L1–L4 | 16–19 | 17–20 |
| 6 | M1–M6 | 10–15 | 11–16 |
| 8 | C1–C8 | 2–9 | 3–10 |

To obtain the hardware output for the third channel of a six-output DSP:

```faust
gsl = library("libraries/grame_studio_layout.lib");
output = gsl.ringHardwareOutput(6, 2); // 13
```

The preset neither transforms the signal nor performs panning. In Max, a
four-output DSP should for example be connected to `mc.dac~ 17 18 19 20`. In
Pure Data, its four audio outputs should be connected to channels 17 through 20
of `dac~`.

The compilable
[`examples/grame_studio_ring4_mapping.dsp`](examples/grame_studio_ring4_mapping.dsp)
produces the four hardware numbers as constant diagnostic signals.

## Physical groups

`speakerGroup(I)` returns a numeric compile-time code:

| Code | Group | Indices | Loudspeakers |
|---:|:---|:---|:---|
| 0 | front pair | 0–1 | L, R |
| 1 | C ring | 2–9 | C1–C8 |
| 2 | M ring | 10–15 | M1–M6 |
| 3 | L ring | 16–19 | L1–L4 |
| 4 | H group | 20–24 | H1–H5 |
| 5 | subwoofers | 25–26 | SW1+L, SW2+R |
| 6 | Atmos centre | 27 | AtmoC |

`isSubwoofer(I)` and `isAtmoCenter(I)` avoid direct dependence on those codes
for the two special cases. The library performs no bass management: subwoofers
remain described hardware destinations, but their feed must be computed
separately.

## API

| Function | Result |
|:---|:---|
| `speakerCount` | total loudspeaker count, 28 |
| `speakerX/Y/Z(I)` | one published Cartesian coordinate |
| `speakerAzimuth/Distance/Elevation(I)` | one published spherical coordinate |
| `speakerCartesian(I)` | X/Y/Z tuple |
| `speakerSpherical(I)` | published azimuth/distance/elevation tuple |
| `speakerSphericalAt(I,lx,ly,lz)` | tuple recomputed from an origin |
| `speakerGroup(I)` | physical group code |
| `isSubwoofer(I)` | 1 for indices 25 and 26 |
| `isAtmoCenter(I)` | 1 for index 27 |
| `hardwareOutput(I)` | hardware output for a physical index |
| `ringSpeakerIndex(P,I)` | physical index for a 2/4/6/8-output preset |
| `ringHardwareOutput(P,I)` | corresponding hardware output |
| `ringCartesian(P,I)` | channel X/Y/Z position in the preset |
| `ringSpherical(P,I)` | channel's published A/D/E position |
| `ringSphericalAt(P,I,lx,ly,lz)` | channel A/D/E recomputed from an origin |

The official prefix is `gsl`. `I` and `P` must be compile-time constant
expressions. Only sizes `2`, `4`, `6`, and `8` are defined for `ring…`
functions.

## Relationship with the HOA library

[`grame_studio_hoa.lib`](grame_studio_hoa.lib) imports this library and keeps
its historical 25- or 26-output API. HOA index 25 represents AtmoC and is
therefore mapped to physical index 27. Physical indices 25 and 26 are the
subwoofers and remain excluded from HOA decoding.

## Limitations

- Positions are compile-time constants, not measurements of live speaker
  positions.
- The 4/6/8 presets denote GRAME studio rings; they do not claim to implement
  international formats such as 5.1 or 7.1.
- Selecting a preset creates no extra audio outputs and cannot automatically
  reconfigure the host audio device.
- No gain, delay, filtering, equalization, limiting, or distance processing is
  applied. Those parameters belong in a separate calibration library.
- A panner such as VBAP or DBAP may consume the coordinates but must provide its
  own algorithm.

## Documentation and validation

The source follows the
[official Faust Libraries convention](https://faustlibraries.grame.fr/contributing/):
`//###` header, `//===` sections, `//---` public blocks, declared prefix,
`Usage` and `Test` examples, camelCase names, and a license declaration for
every public symbol.

```bash
faust2md -f faust/dsp/libraries/grame_studio_layout.lib

faust -I faust/dsp/libraries \
  -json -o /tmp/grame-ring4.cpp \
  faust/dsp/libraries/examples/grame_studio_ring4_mapping.dsp
```

## License

Copyright © 2026 GRAME, Centre national de création musicale. The library is
released under **CC-BY-NC-SA-4.0**.
