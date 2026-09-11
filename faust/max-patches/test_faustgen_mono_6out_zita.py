#!/usr/bin/env python3
"""Structural regression test for the generated mono-to-six Zita Max patch."""

from __future__ import annotations

import json
from pathlib import Path
import subprocess
import sys


THIS_DIR = Path(__file__).resolve().parent
GENERATOR = THIS_DIR / "generate_faustgen_mono_6out_zita.py"
DSP_PATH = THIS_DIR / "faustgen-mono-6out-zita.dsp"
PATCH_PATH = THIS_DIR / "faustgen-mono-6out-zita.maxpat"


def boxes_by_id(document: dict) -> dict[str, dict]:
    return {
        box["box"]["id"]: box["box"]
        for box in document["patcher"]["boxes"]
        if "id" in box["box"]
    }


def main() -> None:
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

    generated_messages = {
        box.get("text") for box in boxes.values() if box.get("maxclass") == "message"
    }
    for name in ("azimuth", "reverb_mix", "zita_predelay", "zita_lf_x", "zita_low_rt60",
                 "zita_mid_rt60", "zita_hf_damping", "output_gain"):
        assert f"{name} $1" in generated_messages
    print("PASS: standalone DSP, generated MC patch, six outputs and Zita controls are consistent.")


if __name__ == "__main__":
    main()
