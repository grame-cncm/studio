# GRAME studio layout consistency audit

[Version française](GRAME-STUDIO-LAYOUT-COHERENCE.md)

Audit date: September 16, 2026.

## Purpose

This analysis checks the consistency of the Faust studio description against
the tabular and graphical descriptions available in the repository:

- [`dsp/libraries/grame_studio_layout.lib`](dsp/libraries/grame_studio_layout.lib);
- [`dsp/libraries/grame_studio_hoa.lib`](dsp/libraries/grame_studio_hoa.lib);
- [`../speaker-description/gramestudio-speaker-setup.csv`](../speaker-description/gramestudio-speaker-setup.csv);
- [`../speaker-description/gramestudio-speaker-setup.xlsx`](../speaker-description/gramestudio-speaker-setup.xlsx);
- the drawings and models in [`../grame-studio-layouts/`](../grame-studio-layouts/).

The goal is to distinguish three aspects:

1. the exact reproduction of source data in the Faust library;
2. the internal geometrical consistency between Cartesian and spherical
   coordinates;
3. the correspondence with the 2D drawings and 3D model volumes.

## Overall conclusion

The Faust description is consistent with the reference files and reproduces
every CSV value exactly. Loudspeaker order, numbering, physical groups,
hardware outputs, and HOA selections are also consistent.

One caveat remains: the published spherical coordinates for **L** and **R** do
not exactly match their Cartesian coordinates. The Faust library does not
introduce this discrepancy; it faithfully reproduces both representations,
which are already identical in the CSV and XLSX files.

## CSV, XLSX, and Faust comparison

### CSV and XLSX

The CSV contains one header row and 28 loudspeaker rows, each with nine columns.
The XLSX workbook contains a single worksheet, `Feuil1`, covering `A1:I29`.

After normalizing the French decimal separator in the CSV:

- all 29 rows and 9 columns are identical;
- the 28 loudspeaker names are identical and in the same order;
- no numerical or textual difference was found.

The common order is:

```text
L, R,
C1, C2, C3, C4, C5, C6, C7, C8,
M1, M2, M3, M4, M5, M6,
L1, L2, L3, L4,
H1, H2, H3, H4, H5,
SW1+L, SW2+R,
AtmoC
```

The first CSV column contains the uninterrupted sequence `1..28`.

### Faust arrays

The six numerical arrays in `grame_studio_layout.lib` were compared value by
value with the corresponding CSV columns:

| Faust array | Source column | Values compared | Differences |
|:---|:---|---:|---:|
| `_speakerX` | X | 28 | 0 |
| `_speakerY` | Y | 28 | 0 |
| `_speakerZ` | Z | 28 | 0 |
| `_speakerAzimuth` | A | 28 | 0 |
| `_speakerDistance` | D | 28 | 0 |
| `_speakerElevation` | E | 28 | 0 |

All **168 X/Y/Z/A/D/E values** are therefore strictly identical between the
tabular source and the Faust library.

## Indices, groups, and outputs

Public Faust indices are zero-based, while the first CSV column and hardware
outputs are one-based. The function

```faust
hardwareOutput(I) = I + 1;
```

therefore follows the source description numbering.

The group codes match the CSV order:

| Code | Group | Faust indices | Loudspeakers | Hardware outputs |
|---:|:---|:---|:---|:---|
| 0 | stereo front pair | 0–1 | L, R | 1–2 |
| 1 | C ring | 2–9 | C1–C8 | 3–10 |
| 2 | M ring | 10–15 | M1–M6 | 11–16 |
| 3 | L ring | 16–19 | L1–L4 | 17–20 |
| 4 | H group | 20–24 | H1–H5 | 21–25 |
| 5 | subwoofers | 25–26 | SW1+L, SW2+R | 26–27 |
| 6 | Atmos center | 27 | AtmoC | 28 |

The multi-output presets select the intended groups:

| DSP outputs | Loudspeakers | Faust indices | Hardware outputs |
|---:|:---|:---|:---|
| 2 | L, R | 0–1 | 1–2 |
| 4 | L1–L4 | 16–19 | 17–20 |
| 6 | M1–M6 | 10–15 | 11–16 |
| 8 | C1–C8 | 2–9 | 3–10 |

This is the CSV hardware order, organized by pairs and groups. It is not a
circular azimuth order and must therefore not be interpreted as the internal
ordering of a panning algorithm.

In `grame_studio_hoa.lib`, HOA outputs 0 through 24 select physical
loudspeakers 0 through 24. HOA output 25 selects physical index 27, i.e. AtmoC.
The two subwoofers, physical indices 25 and 26, are intentionally excluded from
HOA decoding. This mapping is consistent with the documentation.

## Drawings and 3D model verification

### Room dimensions

The PDF gives the following room dimensions:

- 5.40 m wide;
- 10.40 m long;
- 3.97 m high.

The OBJ model floor also measures 5.40 × 10.40 m. The CSV positions fall within
the room boundaries:

- X ranges from -2.55 m to +2.55 m, with walls at approximately ±2.70 m;
- Y ranges from -4.10 m to +4.50 m, within a total length of 10.40 m;
- Z ranges from 0.38 m to 3.12 m, below the 3.97 m ceiling.

All four PDF pages were rendered and inspected. They show the same 28 labels
and overall organization as the CSV: stereo front pair, C/M/L rings, H group,
two subwoofers, and AtmoC.

### OBJ and 3DS

The OBJ file explicitly declares meter units. Its export uses Y as the vertical
axis; the conversion to the physical coordinate system documented by Faust is:

```text
Xphysical = Xobj
Yphysical = -Zobj
Zphysical = Yobj
```

The OBJ model contains 28 loudspeaker volumes. For each CSV name, the published
X/Y/Z point lies inside the corresponding volume. The coordinates therefore
describe an acoustic or placement reference point, not necessarily the
geometric center of the drawn box. This is particularly visible for L/R, the
tilted H loudspeakers, and the subwoofers.

The binary structure of the 3DS file was also parsed. It contains exactly 28
solid volumes with loudspeaker-compatible dimensions, and every one of the 28
CSV points lies inside its corresponding volume.

### DAE, SKP, DWG, and MTL

The DAE is a COLLADA export produced by SketchUp. It declares `Z_UP` and an
internal inch unit (`meter="0.0254000"`). The difference in units and axis
convention is an export property, not a layout difference. Its groups and their
placement match the OBJ.

The SKP file contains the following layers, consistent with the Faust groups:

```text
H (high), L (low), Stereo (foh), room, atmosC,
C (crown), Subs (subwoofers), M (middle)
```

Its embedded thumbnail shows the same overall placement as the PDF and the
OBJ/DAE/3DS exports.

The DWG contains the same layer and entity families, including `ATMOSC`,
`C__CROWN_`, `H__HIGH_`, `L__LOW_`, `M__MIDDLE_`, `STEREO__FOH_`, and
`SUBS__SUBWOOFERS_`. It could not be parsed numerically because no DWG reader
was available in the audit environment. Its entity inventory is consistent,
but it therefore does not have the same level of numerical verification as the
OBJ and 3DS files.

The MTL only describes materials and colors associated with the OBJ; it adds no
independent geometry.

## Cartesian and spherical consistency

The A/D/E columns were compared with values recomputed from X/Y/Z using the
documented coordinate system:

```text
azimuth   = atan2(X, Y)
distance  = sqrt(X² + Y² + Z²)
elevation = atan2(Z, sqrt(X² + Y²))
```

### General result

Excluding L and R, the largest differences between the published columns and
the recomputed values are:

| Quantity | Maximum difference | Loudspeaker |
|:---|---:|:---|
| azimuth | 0.0782° | M5/M6 |
| distance | 0.0176 m | C1/C2 |
| elevation | 0.3155° | H2/H3 |

These differences are compatible with rounding of the A/D/E columns and the
limited precision of the published Cartesian coordinates.

### Special case: L and R

For L:

| Representation | Azimuth | Distance | Elevation |
|:---|---:|---:|---:|
| published value | -26.2° | 4.88 m | 28.1° |
| recomputed from `(-1.80; 3.65; 2.30)` | -26.250° | 4.6747 m | 29.473° |
| published minus recomputed | +0.050° | +0.2053 m | -1.373° |

R has the same absolute differences, with a symmetrical azimuth.

The 20.53 cm distance difference and 1.373° elevation difference cannot be
attributed solely to rounding. They may result from a different reference
point, a separate measurement, or an earlier position, but the available files
do not make it possible to choose between these hypotheses.

## Consequence for the Faust API

The library intentionally preserves both representations:

- `speakerSpherical(I)` directly returns the published A/D/E values;
- `speakerSphericalAt(I,lx,ly,lz)` recomputes A/D/E from X/Y/Z and the supplied
  listening position.

For an origin at `(0,0,0)`, these functions therefore differ significantly for
L and R. This design avoids silently correcting the source and remains
functionally consistent. The current documentation, however, presents the
difference as a consequence of CSV rounding alone. That wording is insufficient
for L/R and should state that the two source representations are not strictly
equivalent.

Before correcting any value, the authoritative representation must be chosen:

1. retain A/D/E as published measurements and explicitly document the
   discrepancy;
2. treat X/Y/Z as authoritative and recompute A/D/E;
3. physically verify the position and acoustic reference point of L/R, then
   correct the upstream CSV and XLSX files.

The Faust library alone should not be changed because it is currently an exact
copy of both tabular files.

## Compilation validation

The example
[`dsp/libraries/examples/grame_studio_ring4_mapping.dsp`](dsp/libraries/examples/grame_studio_ring4_mapping.dsp)
was compiled with Faust 2.89.0 using `dsp/libraries` as its import path. The
compilation succeeds without errors. No source, patch, or DSP file was modified
during this audit.
