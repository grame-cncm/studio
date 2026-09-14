#!/usr/bin/env python3
"""Validate the mono-to-six Zita patch without launching Max.

Run ``python test_faustgen_mono_6out_zita.py`` directly with Faust and py2max.
--check first compares exports without modifying them; assertions then inspect
the shared source and JSON. Max is not launched. Python -O disables assertions
and is unsuitable for this verification.
"""

from __future__ import annotations

import json
from pathlib import Path
import subprocess
import sys


THIS_DIR = Path(__file__).resolve().parent
GENERATOR = THIS_DIR / "generate_faustgen_mono_6out_zita.py"
DSP_PATH = THIS_DIR.parents[1] / "dsp/faustgen-mono-6out-zita.dsp"
PATCH_PATH = THIS_DIR / "faustgen-mono-6out-zita.maxpat"


def boxes_by_id(document: dict) -> dict[str, dict]:
    """Index objects from a Max JSON document by identifier.

    Args:
        document: Dictionary containing patcher/boxes.

    Returns:
        Mapping id → box, excluding objects without an id. The JSON structure is
        assumed valid; the objects themselves are not copied.
    """
    return {
        box["box"]["id"]: box["box"]
        for box in document["patcher"]["boxes"]
        if "id" in box["box"]
    }


def main() -> None:
    """Check current exports, 1→6 MC routing, and three stereo Zita instances.

    Embedded source must match the shared DSP. Every control address extracted by
    Faust must have a Max message. Subprocess errors or assertions stop the script;
    success prints PASS.
    """
    subprocess.run([sys.executable, str(GENERATOR), "--check"], check=True)
    document = json.loads(PATCH_PATH.read_text(encoding="utf-8"))
    boxes = boxes_by_id(document)
    faustgen = boxes["faustgen_1"]
    source = DSP_PATH.read_text(encoding="utf-8")

    assert faustgen["text"] == "mc.faustgen~"
    assert faustgen["numinlets"] == 1
    assert faustgen["outlettype"][0] == "multichannelsignal"
    assert faustgen["sourcecode"] == source
    assert boxes["dac_1"]["text"] == "mc.dac~ 1 2 3 4 5 6"
    assert "re.zita_rev1_stereo" in source
    assert source.count("zita01 =") == source.count("zita23 =") == source.count("zita45 =") == 1

    sys.path.insert(0, str(THIS_DIR.parents[1]))
    from common.faust import load_project
    project = load_project("faustgen-mono-6out-zita")
    generated_messages = {
        box.get("text") for box in boxes.values() if box.get("maxclass") == "message"
    }
    for parameter in project.controls:
        assert f"{parameter.address} $1" in generated_messages
    print("PASS: standalone DSP, generated MC patch, six outputs and Zita controls are consistent.")


if __name__ == "__main__":
    main()
