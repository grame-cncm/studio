#!/usr/bin/env python3
"""Validate the six-output abclib VBAP patch without launching Max.

Run ``python test_abclib_2d_vbap6.py`` directly with Faust and py2max available.
The generator first runs with --check, then the exported JSON is inspected.
No patch is rewritten and Max is not launched. This script uses assertions;
do not run it with Python -O, which disables them.
"""

from __future__ import annotations

import json
from pathlib import Path
import subprocess
import sys


THIS_DIR = Path(__file__).resolve().parent
GENERATOR = THIS_DIR / "generate_abclib_2d_vbap6.py"
PATCH = THIS_DIR / "faustgen-abclib-2d-vbap6.maxpat"


def main() -> None:
    """Check portable source, the MC object, six outputs, and seven VBAP addresses.

    Embedded source must match load_project and contain no /Users/ path. Messages
    for a0..a5/theta must use full UI addresses. Generator failures or assertions
    stop the script; success prints PASS.
    """
    subprocess.run([sys.executable, str(GENERATOR), "--check"], check=True)
    document = json.loads(PATCH.read_text(encoding="utf-8"))
    boxes = {entry["box"].get("id"): entry["box"] for entry in document["patcher"]["boxes"]}
    faustgen = boxes["faustgen_1"]
    assert faustgen["text"] == "mc.faustgen~"
    sys.path.insert(0, str(THIS_DIR.parents[1]))
    from common.faust import load_project
    project = load_project("faustgen-abclib-2d-vbap6")
    assert faustgen["sourcecode"] == project.source
    assert "/Users/" not in project.source
    assert boxes["dac_1"]["text"] == "mc.dac~ 1 2 3 4 5 6"
    messages = {box.get("text") for box in boxes.values() if box.get("maxclass") == "message"}
    for address in ("/vbap/a0", "/vbap/a1", "/vbap/a2", "/vbap/a3", "/vbap/a4", "/vbap/a5", "/vbap/theta"):
        assert f"{address} $1" in messages
    print("PASS: abclib VBAP6 source, JSON addresses and 1→6 MC routing are consistent.")


if __name__ == "__main__":
    main()
