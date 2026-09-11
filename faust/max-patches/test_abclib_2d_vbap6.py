#!/usr/bin/env python3
"""Validate the generated abclib 2D VBAP6 Max patch before opening Max."""

from __future__ import annotations

import json
from pathlib import Path
import subprocess
import sys


THIS_DIR = Path(__file__).resolve().parent
GENERATOR = THIS_DIR / "generate_abclib_2d_vbap6.py"
PATCH = THIS_DIR / "faustgen-abclib-2d-vbap6.maxpat"
SOURCE = Path("/Users/letz/Developpements/abclib/faustCodes/abc_2d_vbaps/abc_2d_vbap6.dsp")
LIBRARY = "/Users/letz/Developpements/abclib/faustCodes/library/"


def main() -> None:
    subprocess.run([sys.executable, str(GENERATOR), "--check"], check=True)
    document = json.loads(PATCH.read_text(encoding="utf-8"))
    boxes = {entry["box"].get("id"): entry["box"] for entry in document["patcher"]["boxes"]}
    faustgen = boxes["faustgen_1"]
    assert faustgen["text"] == "mc.faustgen~"
    assert faustgen["sourcecode"] == SOURCE.read_text(encoding="utf-8")
    assert faustgen["library_path0"] == LIBRARY
    assert boxes["dac_1"]["text"] == "mc.dac~ 1 2 3 4 5 6"
    messages = {box.get("text") for box in boxes.values() if box.get("maxclass") == "message"}
    for address in ("/vbap/a0", "/vbap/a1", "/vbap/a2", "/vbap/a3", "/vbap/a4", "/vbap/a5", "/vbap/theta"):
        assert f"{address} $1" in messages
    print("PASS: abclib VBAP6 source, JSON addresses and 1→6 MC routing are consistent.")


if __name__ == "__main__":
    main()
