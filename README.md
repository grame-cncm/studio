# GRAME Studio — Documentation

*September 2026*

## Overview and setup

The GRAME Studio is a dedicated space for creating, researching, and mixing
electroacoustic music and immersive audio productions.

- **Loudspeaker system:** 25.2 Neumann monitoring array connected via AES67.
- **Supported formats:** wideband stereo, octophony, quadraphony, heptaphony,
  Dolby Atmos, and up to fourth-order Ambisonics.
- **Calibration:** fully calibrated, equalized, and time-aligned using the
  Neumann MA 1 solution and Smaart.

> [!WARNING]
> **Internal hardware DSP equalization and delays**
>
> All EQs and delays are stored directly in the Neumann loudspeakers' internal
> DSP to form a perfect acoustic dome.
>
> **Do not add your own delays in your software.** Simply replicate the
> physical speaker coordinates provided in the Excel/CSV files.

### Default hardware access

- **Audio interface:** RME Digiface Dante + Neumann MT48.
- **Spatial routing:** pre-configured models (stereo, 4.1, 6.1, 8.1, 7.1.4,
  etc.).
- **“Thru” mode:** provides direct 1:1 access to every individual speaker from
  the RME audio outputs (see the Excel reference sheet).


## Repository contents

1. **FT STUDIO GRAME CNCM** — complete technical specification sheet covering
   loudspeakers, workstation computers, the software environment, microphones,
   and outboard gear.

2. **`grame-studio-layouts/`** — 2D and 3D architectural models of the studio,
   created in SketchUp and exported for cross-platform compatibility: `.skp`,
   `.3ds`, `.dae`, `.dwg`, `.mtl`, `.obj`, and `.pdf` (2D).

3. **`gramestudio-spat-base/`** — MaxMSP project featuring IRCAM Spat5
   integration with two ready-to-use models.

   - Install the IRCAM Spat5 library before opening the project.
   - The `code/` folder includes an HTML drag-and-drop utility: upload an
     Excel/CSV sheet to automatically generate Spat5-compatible positional
     lists or coordinates for a custom engine.

4. **`speaker description/`** — exact positions of the 28 loudspeakers in
   `.csv` and `.xlsx` formats:

   - Cartesian coordinates (`X`, `Y`, `Z`);
   - spherical coordinates (`A`, `D`, `E`: azimuth, distance, elevation).

5. **`technical information/`** — detailed technical documentation and studio
   hardware reference guides.
