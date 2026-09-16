# Comparison of abclib, Ambitools, and Spat5 Ambisonic decoders

[Version française](AMBISONIC-DECODERS-COMPARISON.md)

Analysis date: September 16, 2026.

## Purpose

This document compares the two decoders currently exposed by
[`dsp/libraries/grame_studio_hoa.lib`](dsp/libraries/grame_studio_hoa.lib) with
the methods provided by
[IRCAM **Spat5**](https://forum.ircam.fr/projects/detail/spat/). It focuses on
the irregular GRAME studio dome described by
[`dsp/libraries/grame_studio_layout.lib`](dsp/libraries/grame_studio_layout.lib).

These three names do not refer to tools of the same scope:

- the **abclib** path is a very simple direct matrix;
- the **Ambitools** path is a max-rE Sampling Ambisonic Decoder (SAD) here;
- **Spat5** is a toolbox containing several decoder families, geometry
  diagnostics, and separate calibration tools.

It is therefore correct to say that “Spat5 handles an irregular dome better”
only when a suitable method such as EPAD, AllRAD+, CSAD, or RMMAD is selected.
Spat5's SAD/direct-sampling mode retains the same fundamental limitation as the
simple paths in the Faust library.

## Summary

| Property | abclib direct | Local Ambitools SAD | Spat5 |
|:---|:---:|:---:|:---:|
| Uses actual directions | yes | yes | yes |
| Optimizes the matrix for irregularity | no | no | method-dependent |
| Pseudo-inverse/regularization | no | no | MMAD/RMMAD |
| Redistribution through virtual speakers | no | no | AllRAD/AllRAD+ |
| Spatial-spread equalization | no | no | CSAD |
| Layout-aware energy preservation | no | no | EPAD |
| Layout diagnostics | no | no | yes |
| Phantom speakers | no | no | yes |
| Decoder uses distance | no | no | no |
| Separate gain/delay compensation | external | external | `spat5.align~`/calibration |
| Cost and Faust integration | very low | low | external Max engine |

## What the current Faust decoders do

### abclib: direct decoding

The abclib path calls `decoder3D` from
[`dsp/libraries/abclib/faustCodes/library/hoa2.lib`](dsp/libraries/abclib/faustCodes/library/hoa2.lib).
For each loudspeaker, the function:

1. evaluates the ACN/SN3D spherical harmonics in its direction;
2. computes a dot product with the HOA bus;
3. applies a global normalization based on the loudspeaker count;
4. applies the requested final gain.

In other words, the matrix is essentially the transpose of the harmonic matrix
sampled at the loudspeaker directions. It does not solve a layout-specific
inverse problem.

The abclib documentation itself describes `decoder3D` as a regular decoder
intended for a spherical array. Accepting an arbitrary list of azimuths and
elevations does not turn this method into an irregular-array optimizer.

#### Advantages

- short, deterministic implementation that is easy to compile into a Faust DSP;
- low computational cost;
- native ACN/SN3D bus, consistent with the abclib encoders used in the
  repository;
- identical omnidirectional-channel gain to every loudspeaker;
- optional upstream abclib cosine max-rE weights.

#### Limitations

- no compensation for angular loudspeaker density;
- no pseudo-inverse, SVD, or regularization;
- no virtual speaker or gap compensation;
- no rank, conditioning, or orthonormality-error measurement;
- no distance, delay, or calibration-gain processing;
- max-rE weights improve the perceptual behavior of the field but do not fix
  irregular geometry.

On an irregular dome, a region containing many loudspeakers is sampled more
heavily than a sparse region. The decoder has no quadrature weights to
compensate for this density.

### Ambitools: max-rE Sampling Ambisonic Decoder

The Ambitools path in `grame_studio_hoa.lib`:

1. converts each ACN/SN3D degree to ACN/N3D using `sqrt(2l+1)`;
2. applies the Ambitools `wre` max-rE weights;
3. evaluates the N3D harmonics in each loudspeaker direction;
4. computes the corresponding dot product.

This is a **Sampling Ambisonic Decoder**. The signal of an ideal continuous
distribution is simply sampled at the actual array positions.

#### Advantages

- clearly defined and reproducible method;
- more elaborate max-rE weighting than the abclib cosine approximation;
- scalable order at compile time;
- equal result on every loudspeaker for a field containing only the W channel;
- Faust code that can be embedded directly in repository DSPs.

#### Limitations

- SAD is accurate when nodes regularly sample the sphere or have suitable
  quadrature weights;
- the local wrapper uses no weights specific to the GRAME dome density;
- it computes neither a pseudo-inverse nor a layout-optimized matrix;
- dense regions may be overrepresented while gaps remain poorly reconstructed;
- equal W-channel outputs do not prove localization quality for the other
  components;
- its levels cannot be compared directly with the abclib path because the
  normalizations and max-rE weights differ.

The Spat5 developer
[confirms that “direct sampling” is an alias for SAD and that it is not
recommended for an irregular layout](https://discussion.forum.ircam.fr/t/problem-decoding-omnidirectional-b-format-file/142903).
It is therefore expected that the local Ambitools path does not by itself solve
the dome's defects.

### What the Ambitools wrapper does not enable

The original Ambitools file
[`dsp/libraries/ambitools/faust/sampling_decoder.dsp`](dsp/libraries/ambitools/faust/sampling_decoder.dsp)
can enable Near-Field Compensation, or NFC. In that mode it applies:

- degree- and distance-dependent radial filters;
- attenuation equalization;
- propagation-delay compensation.

The studio wrapper intentionally implements the `nfcon=0` case. Layout
distances therefore affect neither gain, delay, nor radial response. This avoids
duplicating calibration already performed in the loudspeakers or mixing desk,
but this wrapper limitation must be distinguished from the capabilities of the
original Ambitools program.

NFC does not fix the angular non-uniformity of the array. It handles radius and
propagation, not decoder-matrix conditioning.

## Why irregularity is a problem

For Ambisonic order `N`, a 3D bus contains `(N+1)^2` components. At fourth order
it therefore contains 25 components.

The main studio layout uses:

- 25 loudspeakers without AtmoC;
- 26 loudspeakers with AtmoC.

The first variant is exactly square: 25 components for 25 loudspeakers. The
second adds only one equation. A sufficient number of outputs does not guarantee
that the directions properly sample every harmonic. If matrix rows are nearly
dependent, direct inversion strongly amplifies errors and may generate excessive
gains.

### Numerical diagnosis of the GRAME layout

The real fourth-order N3D harmonic matrix was evaluated for the studio
directions. The values below give its rank and condition number
`κ = sigma_max/sigma_min`:

| Layout | Direction origin | Rank | Condition `κ` |
|:---|:---|---:|---:|
| 25 loudspeakers | published A/E | 25/25 | `9.31 × 10^5` |
| 25 loudspeakers | XYZ from `(0,0,0)` | 25/25 | `1.54 × 10^6` |
| 25 loudspeakers | XYZ from `(0,0,1.24)` | 25/25 | `1.49 × 10^5` |
| 26 loudspeakers | published A/E | 25/25 | `1.98 × 10^5` |
| 26 loudspeakers | XYZ from `(0,0,0)` | 25/25 | `2.73 × 10^4` |
| 26 loudspeakers | XYZ from `(0,0,1.24)` | 25/25 | `5.40 × 10^4` |

These figures depend on normalization and the reference point; they are not by
themselves a perceptual quality score. They nevertheless show three robust
facts:

1. the matrix has full algebraic rank;
2. it is strongly, or even very strongly, ill-conditioned;
3. an unregularized pseudo-inverse would be highly sensitive to coordinates and
   liable to create large gain requirements.

Adding AtmoC generally improves redundancy but does not turn the layout into a
regular spherical grid.

### Importance of the listening position

With the physical positions used for the 25- or 26-loudspeaker layouts:

- `(0,0,0)` is outside the convex hull of the array;
- `(0,0,1.24)` is inside that convex hull.

For most loudspeakers, the published A/E values are close to a calculation from
the `z=0` plane. They therefore place every loudspeaker above the reference,
which is unfavorable for 3D HOA decoding. The `...DecoderAt` variant with a
realistic listening height is geometrically more defensible.

Spat5 checks this type of situation and reports warnings or errors when the
[reference is outside the array or the 3D layout is inappropriate](https://discussion.forum.ircam.fr/t/how-to-design-an-irregular-speaker-arrangement-in-spat5/54184),
or when
[several loudspeakers have almost the same direction](https://discussion.forum.ircam.fr/t/error-message-when-positioning-speakers-randomly/65504).
The current Faust decoders silently accept these cases.

## What Spat5 adds

The comparison must address `spat5.hoa.decoder~`, not Spat5 as though it were a
single algorithm. The
[public Spat 5.3.7 release announced in February 2026](https://discussion.forum.ircam.fr/t/spat-5-3-7-panoramix-1-7-3-and-admix-0-5-7-released/170493)
inherits several methods introduced throughout the 5.x releases.

### SAD or direct sampling

Spat5 can reproduce a SAD-type method. This mode is useful as a reference and
produces identical gains for a W-only channel, but it is no better suited to
strong irregularity than the local Ambitools path.

### MMAD and RMMAD

The Mode-Matching Ambisonic Decoder builds a matrix that attempts to invert
loudspeaker re-encoding. It therefore genuinely takes the geometry into account.

On an ill-conditioned layout, however, MMAD can generate very large
coefficients. RMMAD adds regularization to this inversion. It accepts a
controlled reconstruction error to reduce extreme gains and improve stability.
The addition of
[RMMAD to `spat5.hoa.decoder~` is documented in the Spat 5.1.7 release notes](https://discussion.forum.ircam.fr/t/spat-5-1-7-released/22002).

For the GRAME layout, the condition numbers above make the regularized variant
far more relevant than a raw pseudo-inverse.

### EPAD

The Energy-Preserving Ambisonic Decoder seeks a better-controlled energy
distribution over the actual array. It is the default mode identified by the
Spat5 developer in his
[explanation of EPAD versus SAD on an irregular dome](https://discussion.forum.ircam.fr/t/problem-decoding-omnidirectional-b-format-file/142903).
Unlike SAD, the W output is not necessarily identical on every loudspeaker of
an irregular array: this difference can be the intentional result of adapting
energy to the layout.

EPAD is generally a better starting point for an irregular array, but it does
not by itself guarantee perfect reconstruction or a large listening area.

### AllRAD and AllRAD+

All-Round Ambisonic Decoding proceeds in two stages:

1. decoding to a dense, regular virtual spherical grid;
2. redistributing that grid to the actual loudspeakers, typically through a
   VBAP-derived matrix.

This separation adapts regular Ambisonic decoding to a non-uniform physical
array. Phantom loudspeakers can complete coverage at the array boundaries.
AllRAD+ and the Spat5 improvements,
[documented as additions in Spat 5.0.9](https://discussion.forum.ircam.fr/t/spat-5-0-9/2861),
aim for more robust behavior in these configurations.

The method still depends on the available geometrical coverage. Large gaps or
the absence of loudspeakers below the audience cannot be canceled by
computation.

### CSAD

The Constant Spread Ambisonic Decoder was introduced to equalize spatial spread
on irregular arrays. This addresses a direct SAD defect: on a non-uniform array,
the apparent width of a source may vary greatly with direction. This goal is
described in the
[IRCAM 2020 activity report](https://www.ircam.fr/media/uploads/uploads/Rapports%20activite/rapport-activite-2020-ircam.pdf),
and its integration into `spat5.hoa.decoder~` appears in the
[Spat 5.1.7 release notes](https://discussion.forum.ircam.fr/t/spat-5-1-7-released/22002).

### Other practical advantages

According to the
[Spat 5.1.7](https://discussion.forum.ircam.fr/t/spat-5-1-7-released/22002)
and
[Spat 5.0.9](https://discussion.forum.ircam.fr/t/spat-5-0-9/2861) release notes,
Spat5 also provides:

- orthonormality-error estimation;
- layout validity checks and diagnostic messages;
- phantom loudspeakers for some methods;
- automatic 3D-to-2D downscaling for a planar array;
- dual-band decoding variants;
- metric tools for comparing pressure, energy, and spatial vectors;
- separate alignment and calibration tools.

These features explain why Spat5 is a better decoder-design and validation
platform even when the final DSP must remain in Faust.

## What Spat5 does not fix automatically

### Distances

The Spat5 HOA decoder uses azimuth and elevation. Changing only a loudspeaker's
distance does not alter its decoding matrix, as
[confirmed by practical documentation from the Spat5 developer](https://discussion.forum.ircam.fr/t/problem-decoding-omnidirectional-b-format-file/142903).

For a non-spherical array, gains and delays must be handled separately by
`spat5.align~`, the calibration objects, the mixing desk, or the playback
system. The
[IRCAM-recommended workflow](https://discussion.forum.ircam.fr/t/other-set-up-and-directivity/2053)
places `spat5.align~` after the HOA decoder. A correction must not be applied
twice.

### Loudspeaker response and directivity

Spat5 assumes calibrated channels. Selecting an HOA decoder does not
automatically correct:

- frequency response;
- the actual directivity of loudspeaker models;
- maximum-level differences;
- amplifier or onboard-processing latency;
- bass management and the two subwoofers.

### Incomplete coverage

The studio is not a complete, homogeneous sphere. Most loudspeakers lie in the
upper hemisphere, with only four L channels below the proposed listening
height. No decoder can exactly reconstruct modes that are not sufficiently
observed by the physical array.

### Listening area

All the calculations described here remain centered on one reference point. A
more robust method improves the matrix at the sweet spot but does not
automatically create a wide, consistent listening area. This must be evaluated
through measurements and listening at several positions.

## Recommendation for the GRAME studio

### Immediate tests

1. Use a measured listening position, with `(0,0,1.24)` as a more realistic
   starting hypothesis than `(0,0,0)`.
2. Compare the 25- and 26-output layouts separately; do not assume that AtmoC
   improves every direction.
3. Retain the two Faust decoders as simple references:
   - abclib direct/basic;
   - Ambitools max-rE SAD.
4. In Spat5, compare at least EPAD, AllRAD+, CSAD, and RMMAD.
5. Avoid unregularized MMAD as the initial production choice because of the
   measured high condition number.
6. Perform gain/delay alignment only once, either in Spat5 or in the existing
   playback chain.

### Measurements to compare

For every matrix and listening position:

- pressure gain and energy gain by direction;
- magnitude and direction of velocity and energy vectors (`rV`, `rE`);
- apparent width and continuity during an azimuth/elevation sweep;
- maximum row gain and headroom before clipping;
- conditioning and singular values;
- W-only response, without making it the sole criterion;
- result with and without AtmoC;
- localization, timbre, and level at several physical positions in the studio.

### Toward a standalone Faust solution

Two approaches are possible:

1. compute a matrix offline with a suitable tool, then embed its constant
   coefficients in a Faust library;
2. add a regularized matrix generator or a precomputed AllRAD path to the
   library.

The first option is the simplest for a fixed installation. Spat5 or a scientific
script can be used as a design tool while retaining a standalone Faust DSP at
runtime.

An embedded matrix must be accompanied by:

- the listening position and layout version used for its calculation;
- the order, ACN/SN3D or ACN/N3D convention, and normalizations;
- the method and its regularization parameters;
- the exact routing of the 25 or 26 outputs;
- calibration gains/delays if they are applied elsewhere;
- the metrics and measurements that justified the choice.

## Conclusion

The abclib and Ambitools decoders in the repository are not incorrect. They are
useful, simple, compilable direct decoders, but they are not **layout-adaptive**.
Their principal shortcoming for the GRAME dome is that they use the actual
directions without solving the non-uniformity of their distribution.

Spat5 handles an irregular dome better because it provides methods that compute
or redistribute the matrix according to the actual array, with regularization,
virtual loudspeakers, and diagnostics. This advantage disappears when Spat5 is
used in SAD/direct-sampling mode.

For this studio, the most cautious combination is therefore:

- a realistic listening position;
- an EPAD/AllRAD+/CSAD/RMMAD comparison;
- separate gain and delay calibration;
- validation through metrics, acoustic measurements, and listening;
- final embedding of a validated matrix in Faust if standalone execution is
  required.

## Sources

### Local code

- [`dsp/libraries/grame_studio_hoa.lib`](dsp/libraries/grame_studio_hoa.lib);
- [`dsp/libraries/abclib/faustCodes/library/hoa2.lib`](dsp/libraries/abclib/faustCodes/library/hoa2.lib);
- [`dsp/libraries/ambitools/faust/sampling_decoder.dsp`](dsp/libraries/ambitools/faust/sampling_decoder.dsp);
- [`dsp/libraries/ambitools/faust/ylm.lib`](dsp/libraries/ambitools/faust/ylm.lib);
- [`GRAME-STUDIO-LAYOUT-COHERENCE-en.md`](GRAME-STUDIO-LAYOUT-COHERENCE-en.md).

### Spat5 and IRCAM

Detailed Spat5 technical documentation is distributed in the Max package as
reference pages and help-patcher tabs. The developer explains this organization
in
[“Panning types for area-based source spatialization”](https://discussion.forum.ircam.fr/t/panning-types-for-area-based-source-spatialization/2736).
The public documents consulted for this analysis are:

| Documentation | Information used |
|:---|:---|
| [Official Spat project page](https://forum.ircam.fr/projects/detail/spat/) | origin of and access to the IRCAM project |
| [Spat 5.3.7, February 2026](https://discussion.forum.ircam.fr/t/spat-5-3-7-panoramix-1-7-3-and-admix-0-5-7-released/170493) | public reference version for the analysis |
| [SAD, EPAD, and an irregular dome](https://discussion.forum.ircam.fr/t/problem-decoding-omnidirectional-b-format-file/142903) | default EPAD, SAD/direct sampling, and absence of decoder distance processing |
| [Spat 5.1.7](https://discussion.forum.ircam.fr/t/spat-5-1-7-released/22002) | RMMAD, CSAD, orthonormality error, layout checks, and 3D/2D downscaling |
| [Spat 5.0.9](https://discussion.forum.ircam.fr/t/spat-5-0-9/2861) | AllRAD+, MVLAD, and dual-band decoding |
| [Irregular 3D layout and reference outside the array](https://discussion.forum.ircam.fr/t/how-to-design-an-irregular-speaker-arrangement-in-spat5/54184) | origin validity and VBAP3D/HOA3D recommendations |
| [Nearly coincident loudspeaker directions](https://discussion.forum.ircam.fr/t/error-message-when-positioning-speakers-randomly/65504) | warnings, errors, and audible consequences of an invalid layout |
| [Angular decoding and `spat5.align~`](https://discussion.forum.ircam.fr/t/other-set-up-and-directivity/2053) | separation of decoding from gain/delay compensation |
| [IRCAM 2020 activity report](https://www.ircam.fr/media/uploads/uploads/Rapports%20activite/rapport-activite-2020-ircam.pdf) | CSAD's goal for irregular arrays |

### Theoretical references

- F. Zotter and M. Frank,
  [*Ambisonics: A Practical 3D Audio Theory for Recording, Studio Production,
  Sound Reinforcement, and Virtual Reality*](https://doi.org/10.1007/978-3-030-17207-7),
  Springer, 2019;
- P. Lecomte et al., *A Fifty-Node Lebedev Grid and Its Applications to
  Ambisonics*, Journal of the Audio Engineering Society, 64(11), 2016;
- P. Lecomte, *Ambitools: Tools for Sound Field Synthesis with Higher Order
  Ambisonics*, Faust Conference, 2018.
