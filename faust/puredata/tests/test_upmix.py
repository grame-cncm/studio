"""Check the upmix patches in Pd with their own test scene.

Run ``python -m pytest faust/puredata/tests/test_upmix.py`` with py2pd, pytest,
Faust, and the built Pd/external (PD_BIN and FAUSTGEN_EXTERNAL override them, as
in test_projects.py). Each test instruments the generated patch itself, so the
scene selector, routing, and control names are those users get.

The scene's centered 440 Hz sine breathes with a 0.5 Hz cosine clipped to 0..1:
it plays around 0, 2, 4 s and is silent around 1 and 3 s. env~ uses Pd's
convention: 100 dB for RMS=1 and 0 for silence.
"""

import re

import pytest

from py2pd import Patcher  # noqa: F401 - project_builder returns py2pd patches
from test_projects import (
    PATCHES, command, load_project, pd_name, project_builder, requires_faust, requires_pd,
    run, scheduled,
)

UPMIX = ["faustgen-upmix-center-3ch", "faustgen-upmix-surround-5ch",
         "faustgen-upmix-surround-7ch", "faustgen-upmix-surround-7ch-multiband"]


def measure(p, load, dsp, outlet, stage, time, *, band=None):
    """Print env~ of a Faust outlet at time ms as ``stage: dB``.

    band selects a bp~ at that frequency (Q 20) before env~ 4096, to follow
    the scene's tone apart from its noise.
    """
    source = dsp
    energy = p.add("env~ 4096")
    if band:
        source = p.add(f"bp~ {band} 20")
        p.link(dsp, source, outlet=outlet)
        p.link(source, energy)
    else:
        p.link(dsp, energy, outlet=outlet)
    store = p.add("f")
    p.link(energy, store, inlet=1)
    p.link(scheduled(p, load, time), store)
    p.link(store, p.add(f"print {stage}"))


def value(console, stage):
    """Read the dB value printed for stage."""
    found = re.search(rf"^{stage}: ([-+\d.eE]+)$", console, re.M)
    assert found, console
    return float(found[1])


@requires_pd
@requires_faust
@pytest.mark.parametrize("stem", UPMIX)
def test_scene_tone_goes_to_center_and_ambience_to_surrounds(tmp_path, stem):
    """Tone to the center, noise to the surrounds, and both depth controls.

    With the scene: while the tone plays (2 s), the center carries it at least
    6 dB above the fronts; while it rests (1 s), the surrounds carry the noise
    at least 10 dB above the center. The margin on the tone is modest by design:
    the fourth-root center mask keeps part of a centered source in front as soon
    as a decorrelated background plays in the same band (measured: 7 dB with one
    band, 10.7 dB with four). Then center extraction 0 and surround
    relocation 0 (2.6 s) silence the center and the surrounds exactly and give
    the tone back to the fronts (4 s).
    """
    project = load_project(stem)
    p = project_builder(PATCHES, stem)(project)
    (tmp_path / f"{stem}.dsp").write_text(project.source)
    load = next(node for node in p.nodes if node.parameters.get("text") == "loadbang")
    dsp = next(node for node in p.nodes if node.parameters.get("text") == f"faustgen2~ {stem}")
    choice = next(node for node in p.nodes if node.parameters.get("label") == "test-scene")
    p.link(scheduled(p, load, 10), msg := p.add_msg("1"))
    p.link(msg, choice)
    p.link(load, msg := p.add_msg("dsp 1"))
    p.link(msg, p.add("s pd"))
    depth = next((item.label for item in project.controls if "relocation" in item.label), None)
    for label in ("center extraction", depth):
        if label:
            p.link(scheduled(p, load, 2600), msg := p.add_msg(f"{pd_name(label)} 0"))
            p.link(msg, dsp)
    surrounds = range(3, project.outputs)
    for outlet, name in ((1, "FL"), (3, "C")):
        measure(p, load, dsp, outlet, f"TONE_{name}", 2000, band=440)
        measure(p, load, dsp, outlet, f"BYPASS_{name}", 4000, band=440)
    measure(p, load, dsp, 3, "REST_C", 1000)
    measure(p, load, dsp, 3, "OFF_C", 3000)
    for channel in surrounds:
        measure(p, load, dsp, channel + 1, f"REST_S{channel}", 1000)
        measure(p, load, dsp, channel + 1, f"OFF_S{channel}", 3000)
    p.link(scheduled(p, load, 4100), msg := p.add_msg("quit"))
    p.link(msg, p.add("s pd"))
    path = tmp_path / "upmix-scene.pd"
    p.save(path)
    console = run(command(path) + ["-batch"])
    assert value(console, "TONE_C") > value(console, "TONE_FL") + 6, console
    assert value(console, "TONE_C") > 70, console
    for channel in surrounds:
        assert value(console, f"REST_S{channel}") > value(console, "REST_C") + 10, console
        assert value(console, f"OFF_S{channel}") == 0, console
    assert value(console, "OFF_C") == 0, console
    assert value(console, "BYPASS_FL") > value(console, "TONE_FL") + 6, console
