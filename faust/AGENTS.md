# Instructions for agents

Before creating or modifying a project, read the [general README](README.md),
then the guide for the relevant environment:

- [Max/MSP](maxmsp/README.md) for `maxmsp/max-patches/`;
- [PureData](puredata/README.md) for `puredata/pd-patches/`.

For Max, also read the [reference prompt](PROMPT.md).
Start from an existing generator when it matches the requested project.

The ten projects share the `.dsp` sources in `dsp/`. Modify these sources
to change the sound processing or the parameters. The `.dsp` files exported
in `puredata/pd-patches/` are generated copies; carry over any lasting
modification to `dsp/`.

Keep an explicit `build_patch(project)` in each project generator. Use
`common/faust.py` for the Faust catalog and metadata, `max_helpers.py` or
`pd_helpers.py` for the native blocks. Define parameter ranges and initial
values in Faust, then extract them from the JSON. Initialize widgets with
numeric messages that also pass the value to the DSP. Prefer MC objects in
Max; in Pd, port 0 of `faustgen2~` is used for control and audio ports
start at 1.

After a modification to the shared DSP or its analysis, regenerate the
patches for both environments. After a modification specific to one
interface, regenerate only the concerned patches. Keep the scripts and
their `.maxpat`, `.pd` and `.svg` outputs in their current locations. Use
`--check` to verify that the outputs of the project generators are up to
date, then run the checks appropriate to the modification.

The `py2max`, `py2pd`, `pd-faustgen` and abclib dependencies are submodules
declared in `../.gitmodules`. Use the original abclib libraries in
`dsp/libraries/abclib/faustCodes/library/`; the generators integrate their
functions into the exported DSP. Do not modify a submodule to adapt a
generator in the main repository.

The French and English READMEs must reference each other and describe the
same usage. Keep them focused on installation, generation and tool usage,
without a history of fixes or test results.
