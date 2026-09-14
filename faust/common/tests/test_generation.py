"""Verify generation contracts shared by Max and PureData.

Run ``python -m pytest faust/common/tests`` with Faust, pytest, py2max, and py2pd
available. Native script directories are added to sys.path to import their
helpers. SIGNATURES follows exactly the insertion order of PROJECTS.

Tests generate only under tmp_path: they compare sources, ports, controls, and
initialization, then exercise --check and its preservation of reference files.
No native audio host is launched.
"""

import json
from pathlib import Path
import subprocess
import sys

import pytest

ROOT = Path(__file__).resolve().parents[2]
MAX = ROOT / "maxmsp/max-patches"
PD = ROOT / "puredata/pd-patches"
sys.path[:0] = [str(ROOT), str(MAX), str(PD)]

from common import faust  # noqa: E402
from max_helpers import control_address, generate as generate_max  # noqa: E402
from pd_helpers import generate as generate_pd, pd_name  # noqa: E402

SIGNATURES = [(0, 2), (1, 4), (2, 8), (1, 27), (8, 16), (8, 16), (8, 16), (1, 2), (1, 6), (1, 6)]


def document(path):
    """Read a .maxpat and return (objects by identifier, patchline list).

    Args:
        path: Path to generated Max JSON.

    Dictionaries are extracted without conversion. File, JSON, and structure errors
    are propagated to the test assertions.
    """
    patch = json.loads(path.read_text())["patcher"]
    boxes = {entry["box"]["id"]: entry["box"] for entry in patch["boxes"]}
    links = [entry["patchline"] for entry in patch["lines"]]
    return boxes, links


@pytest.mark.parametrize("stem,signature", zip(faust.PROJECTS, SIGNATURES))
def test_same_dsp_ports_controls_and_initialization_in_both_hosts(tmp_path, stem, signature):
    """Verify stem's expected signature and equivalent native interfaces.

    Args:
        tmp_path: Isolated pytest directory with separate Max and Pd export folders.
        stem: Identifier parametrized from PROJECTS.
        signature: Expected (inputs, outputs) pair at the corresponding SIGNATURES index.

    Check source UTF-8 size, Max cable indices, widget ranges, and the initialization
    path loadbang → value → widget → message → DSP. Mnemosphere sends only its
    preview to the DAC. The synth omits allocator-reserved controls and includes
    the required MIDI routing.
    """
    project = faust.load_project(stem)
    assert (project.inputs, project.outputs) == signature
    max_path, = generate_max(stem, tmp_path / "max")
    pd_path, _, dsp_path = generate_pd(stem, tmp_path / "pd")
    boxes, lines = document(max_path)
    dsp = boxes["faustgen_1"]
    assert dsp["text"] == "mc.faustgen~"
    assert dsp["sourcecode"] == dsp_path.read_text() == project.source
    assert dsp["sourcecode_size"] == len(project.source.encode("utf-8"))
    audio_outputs = 2 if stem == "faustgen-mnemosphere-hoa4" else project.outputs
    assert boxes["dac_1"]["text"] == "mc.dac~ " + " ".join(map(str, range(1, audio_outputs + 1)))
    assert f"faustgen2~ {stem}" in pd_path.read_text()
    assert "/Users/" not in project.source and "/private/" not in project.source
    for line in lines:
        source, outlet = line["source"]
        target, inlet = line["destination"]
        assert 0 <= outlet < boxes[source]["numoutlets"]
        assert 0 <= inlet < boxes[target]["numinlets"]
    for parameter in project.controls:
        widget = next(box for box in boxes.values() if box.get("varname") == f"{parameter.shortname}_value")
        assert (widget["minimum"], widget["maximum"]) == (parameter.minimum, parameter.maximum)
        message = next(box for box in boxes.values() if box.get("text") == f"{control_address(project, parameter)} $1")
        assert any(line["source"] == [widget["id"], 0] and line["destination"] == [message["id"], 0] for line in lines)
        # Initialization must travel through the widget to the DSP.
        initial = next(boxes[line["source"][0]] for line in lines if line["destination"] == [widget["id"], 0])
        assert float(initial["text"]) == parameter.initial
        assert any(line["source"] == ["loadbang_1", 0] and line["destination"] == [initial["id"], 0] for line in lines)
        assert f"{pd_name(parameter.label)} \\$1" in pd_path.read_text()
    if project.voices:
        assert project.voices == 16
        assert not {"freq", "gain", "gate"} & {item.label.strip("/") for item in project.controls}
        assert any(box.get("text") == "midiparse" and box["numoutlets"] == 8 for box in boxes.values())


def test_changes_to_common_dsp_drive_both_generators(tmp_path, monkeypatch):
    """Temporarily replace DSP_DIR and verify that both hosts follow the changed DSP.

    tmp_path receives a fixture with three control types and two outputs; monkeypatch
    restores DSP_DIR after the test. Bounds, units, initial values, and port changes
    must all come from that source. No reference DSP is modified.
    """
    stem = "faustgen-quad-panner"
    source = tmp_path / f"{stem}.dsp"
    source.write_text('''import("stdfaust.lib");
amount = vslider("amount [unit:dB]", -3, -12, 6, 0.5);
enabled = checkbox("enabled");
offset = nentry("offset", 0.2, -1, 1, 0.1);
process = *(amount + offset + enabled) <: _,_;
''')
    monkeypatch.setattr(faust, "DSP_DIR", tmp_path)
    project = faust.load_project(stem)
    assert (project.inputs, project.outputs) == (1, 2)
    amount = next(item for item in project.controls if item.label == "amount")
    assert (amount.initial, amount.minimum, amount.maximum, amount.step, amount.unit) == (-3, -12, 6, 0.5, "dB")
    max_path, = generate_max(stem, tmp_path / "max")
    pd_path, _, dsp_path = generate_pd(stem, tmp_path / "pd")
    boxes, _ = document(max_path)
    assert boxes["dac_1"]["text"] == "mc.dac~ 1 2"
    assert "dac~ 1 2;" in pd_path.read_text()
    assert boxes["faustgen_1"]["sourcecode"] == source.read_text() == dsp_path.read_text()
    assert len([box for box in boxes.values() if box.get("varname", "").endswith("_value")]) == 3


@pytest.mark.parametrize("directory,generate", [(MAX, generate_max), (PD, generate_pd)])
def test_check_detects_stale_assets_without_modifying_them(tmp_path, directory, generate):
    """Exercise --check with current and deliberately stale exports.

    Args:
        tmp_path: Destination for test files and the intentional stale-file edit.
        directory: Script directory of the parametrized backend's CLI.
        generate: Corresponding Max or Pd export function.

    Bytes and mtime_ns must be identical before and after each CLI call. Adding a
    line to the last export must produce a nonzero status with Regenerate, without
    the verification repairing or rewriting the file.
    """
    stem = "faustgen-quad-panner"
    paths = generate(stem, tmp_path)
    command = [sys.executable, str(directory / faust.GENERATORS[stem]), "--check", "--output-dir", str(tmp_path)]
    before = {path.name: (path.read_bytes(), path.stat().st_mtime_ns) for path in paths}
    result = subprocess.run(command, capture_output=True, text=True)
    assert result.returncode == 0, result.stdout + result.stderr
    assert before == {path.name: (path.read_bytes(), path.stat().st_mtime_ns) for path in paths}
    paths[-1].write_text(paths[-1].read_text() + "\n")
    stale = {path.name: (path.read_bytes(), path.stat().st_mtime_ns) for path in paths}
    result = subprocess.run(command, capture_output=True, text=True)
    assert result.returncode != 0 and "Regenerate" in result.stderr
    assert stale == {path.name: (path.read_bytes(), path.stat().st_mtime_ns) for path in paths}
