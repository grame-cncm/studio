# GRAME studio HOA decoding

[Version française](README.md)

Shared geometry is now isolated in
[`grame_studio_layout.lib`](grame_studio_layout.lib). This non-Ambisonic library
describes all 28 speakers and 2-, 4-, 6-, and 8-channel multi-output presets.
See its [complete documentation](grame_studio_layout-en.md).

[`grame_studio_hoa.lib`](grame_studio_hoa.lib) reuses that geometry and provides
two reusable 3D decoders: the **abclib** ACN/SN3D direct decoder and the
**Ambitools** max-rE Sampling Ambisonic Decoder (SAD). A DSP importing it gets
an HOA-to-real-loudspeaker matrix instead of an abstract HOA bus that still
lacks decoding and routing.

## Usage

From a DSP located in `faust/dsp/`:

```faust
gs = library("libraries/grame_studio_hoa.lib");

// 25 fourth-order HOA inputs, 26 outputs: speakers 1..25, then AtmoC.
process = gs.abclibDecoder26(4, 1.0);
```

To try the Ambitools path with the same ACN/SN3D input:

```faust
gs = library("libraries/grame_studio_hoa.lib");
process = gs.samplingDecoder26(4, 1.0);
```

Compilable examples are in [`examples/`](examples/). The Max/PureData
generators automatically add `faust/dsp/libraries` to Faust's search path and
embed local libraries when exporting.

## Geometry and routing

Positions come from `grame_studio_layout.lib`, which is itself synchronized
with
[`speaker-description/gramestudio-speaker-setup.csv`](../../../speaker-description/gramestudio-speaker-setup.csv).
The axes are `x` to the right, `y` to the front and `z` upwards, in metres.
Azimuth is 0° at the front (`+y`) and increases towards the right (`+x`).

Default decoding directly uses the CSV's `A` and `E` columns and therefore does
not assume an ear height missing from the file. Functions ending in `At`
recompute angles from `X/Y/Z` and a compile-time listener position `(lx,ly,lz)`.
For example, `(0,0,1.24)` places the origin at the height of all six M speakers
and AtmoC. Rounded spherical values in the CSV are not perfectly identical to
Cartesian recomputation (notably for L/R); this explicit choice keeps the two
data sets distinct.

The library offers two layouts:

- `25` outputs: CSV speakers 1 through 25;
- `26` outputs: CSV speakers 1 through 25, followed by AtmoC (CSV speaker 28).

The SW1+L and SW2+R subwoofers (CSV 26 and 27) never directly receive HOA
components. Bass management, filtering and summation remain separate tasks.

| Decoder output | Speaker | Hardware output |
|---:|:---|---:|
| 1–25 | L, R, C1–C8, M1–M6, L1–L4, H1–H5 | 1–25 |
| 26 | AtmoC | 28 |

`hardwareOutput(i)` formalizes this mapping for a zero-based Faust index `i`.
Faust outputs remain contiguous: the host patch must connect decoder output 26
to hardware output 28 and reserve hardware outputs 26–27 for the subs.

## API

All decoders take `(N+1)^2` **ACN/SN3D** channels, with `N` constant at compile
time. `gain` is a final linear gain. `P` must be 25 or 26; other values do not
describe a supported studio layout.

| Function | Description |
|:---|:---|
| `abclibDecoder(N,P,gain)` | abclib direct matrix with published A/E |
| `abclibDecoderAt(N,P,gain,lx,ly,lz)` | Same matrix from another origin |
| `abclibDecoder25/26(N,gain)` | Shortcuts for both layouts |
| `abclibMaxReDecoder…` | abclib cosine max-rE optimization before the matrix |
| `samplingDecoder(N,P,gain)` | Ambitools max-rE SAD with published A/E |
| `samplingDecoderAt(N,P,gain,lx,ly,lz)` | SAD from another origin |
| `samplingDecoder25/26(N,gain)` | Shortcuts for both layouts |
| `speakerCartesian(I)` | Published X/Y/Z tuple |
| `speakerSpherical(I)` | Published A/D/E tuple |
| `speakerSphericalAt(I,lx,ly,lz)` | A/D/E recomputed from a supplied origin |
| `hardwareOutput(I)` | One-based hardware output number |

The library's official prefix is `gs`. Helper symbols beginning with `_` are
private and are not part of the stable API.

## Decoder choices

### abclib path

`abclibDecoder` directly calls `decoder3D` from `hoa2.lib`. It evaluates SN3D
harmonics in each speaker direction and applies abclib's `2/P` normalization.
This is the simplest path and matches the abclib encoders already used by the
repository's DSPs.

`abclibMaxReDecoder` adds abclib's optimizer, whose degree-`l` weight is
`cos(l π/(2N+2))`. Do not use it if the HOA components are already max-rE
weighted.

### Ambitools path

`samplingDecoder` uses `ylm` and `wre` directly from
`ambitools/faust/ylm.lib`. Ambitools operates in ACN/N3D; the library converts
each SN3D degree `l` to N3D with `sqrt(2l+1)`, exactly like
`ambitools/faust/converter.dsp`, then computes for each speaker:

```text
s_n = sum_l sum_m [ sqrt(2l+1) b_SN3D(l,m)
                    w_max-rE(l) Y_N3D(l,m, az_n, el_n) ]
```

The max-rE weights are Ambitools' Daniel-root approximation, normalized by the
sum across degrees. This differs from abclib's cosine approximation, so `gain`
values are not directly comparable between paths.

The original Ambitools file derives Cartesian azimuth with `atan2(y,x)`. Here,
angles are passed directly to `ylm` in the HOA bus convention: 0° at the front,
positive to the right. The axes must not be converted a second time.

## Limitations and precautions

- **Irregular does not mean optimized.** Both methods sample harmonics at the
  real directions, but neither computes a pseudoinverse, density-aware
  quadrature weights, AllRAD, EPAD or a joint energy/pressure decoder. Dense
  parts of the dome may be overweighted.
- **No NFC.** The Ambitools path is equivalent to `nfcon=0`. Distances are
  exposed for diagnostics but do not affect gain, delay or radial response.
  This avoids duplicating delays/EQ already stored in the speakers. Enabling
  NFC would require the actual listening position, speed of sound, sample rate
  and knowledge of the calibration in use.
- **One listening point.** Ordinary decoders use A/E as published. `At` variants
  calculate directions from one origin; moving it does not create an extended
  listening area.
- **AtmoC is optional.** Compare the 25- and 26-output variants by measurement;
  the zenith speaker may overemphasize the upper region at some orders.
- **No dynamic protection.** `gain` prevents neither clipping nor speaker
  overload. Calibrate through noise/measurement, then add system limiters and
  safety crossovers.
- **Order and speaker count.** Fourth order requires 25 inputs. The output count
  is algebraically sufficient, but the geometry and lack of speakers below the
  audience limit true spherical reconstruction.
- **HOA formats.** FuMa, SID, N3D or a different channel order must be converted
  first. Both public interfaces expect ACN/SN3D.

## License and provenance

abclib is LGPL with an exception for compiled Faust code. The local Ambitools
copy declares **CC-BY-NC-SA-4.0**. Because this library imports Ambitools code,
the combined library is declared CC-BY-NC-SA-4.0: attribution, non-commercial
use and share-alike terms apply. They also apply when a DSP embeds this path.
Commercial distribution requires separate Ambitools permission or an
independent compatible implementation.

Algorithmic references:

- P. Lecomte, *Ambitools: Tools for Sound Field Synthesis with Higher Order
  Ambisonics*, Faust Conference, 2018;
- P. Lecomte et al., *A Fifty-Node Lebedev Grid and Its Applications to
  Ambisonics*, JAES 64(11), 2016;
- F. Zotter and M. Frank, *Ambisonics: A Practical 3D Audio Theory for Recording,
  Studio Production, Sound Reinforcement, and Virtual Reality*, Springer, 2019.

## Faust documentation convention

Documentation embedded in `grame_studio_hoa.lib` follows the
[official Faust Libraries convention](https://faustlibraries.grame.fr/contributing/):
`//###` library header, `//===` sections, `//---` function blocks, official `gs`
prefix, `#### Usage` with input/output shape, upper-case constant parameters,
extractable tests, and one SPDX license declaration per public symbol. Helpers
prefixed with `_` remain private. Documentation can be checked or extracted
without creating an output file with:

```bash
faust2md -f faust/dsp/libraries/grame_studio_hoa.lib
```

## Validation

From the repository root:

```bash
faust -I faust/dsp/libraries \
  -I faust/dsp/libraries/abclib/faustCodes/library \
  -json -o /tmp/grame-abclib.cpp \
  faust/dsp/libraries/examples/grame_studio_abclib_order4.dsp

faust -I faust/dsp/libraries \
  -I faust/dsp/libraries/abclib/faustCodes/library \
  -json -o /tmp/grame-sampling.cpp \
  faust/dsp/libraries/examples/grame_studio_sampling_order4.dsp
```

Each example must report 25 inputs and 26 outputs. This validates compilation
and the interface, not the dome's measured acoustic behavior or listening
comparison.
