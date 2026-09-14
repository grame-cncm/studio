"""Load the common DSPs and run the same generation workflow for both hosts."""

from __future__ import annotations

import argparse
from dataclasses import dataclass
import importlib.util
import json
from pathlib import Path
import re
import shutil
import subprocess
import tempfile

DSP_DIR = Path(__file__).resolve().parents[1] / "dsp"
PROJECTS = {
    "faustgen-additive-poly-midi": "Additive MIDI / synthese additive MIDI - 16 voices",
    "faustgen-quad-panner": "Quadraphonic panner / panoramique quadriphonique",
    "faustgen-stereo-orbit": "Stereo Orbit / Orbite stereo - eight speakers / huit enceintes",
    "faustgen-mnemosphere-hoa4": "Mnemosphere HOA4 / Mnemosphere - 3D ACN SN3D + stereo preview",
    "faustgen-8x16-panner": "8 inputs to 16 speakers / 8 entrees vers 16 enceintes",
    "faustgen-8x16-per-input-panner": "Independent 8x16 VBAP / VBAP 8x16 independant",
    "faustgen-8x16-per-input-vbap-reverb": "Independent 8x16 VBAP + Freeverb",
    "faustgen-mono-stereo-spatial-reverb": "Mono to stereo / mono vers stereo - Zita Rev1",
    "faustgen-mono-6out-zita": "Mono to six outputs / mono vers six sorties - Zita Rev1",
    "faustgen-abclib-2d-vbap6": "abclib 2D VBAP - six speakers / six enceintes",
}
GENERATORS = {
    stem: "generate_" + stem.replace("faustgen-abclib", "abclib").replace(
        "mono-stereo-spatial-reverb", "mono-stereo-reverb"
    ).replace("-", "_") + ".py"
    for stem in PROJECTS
}


def include_options(dsp: Path) -> list[str]:
    """Resolve the DSP and the unchanged abclib submodule's local imports."""
    paths = [dsp.resolve().parent, DSP_DIR / "libraries/abclib/faustCodes/library"]
    return [argument for path in paths if path.is_dir() for argument in ("-I", str(path))]


def analyze_dsp(dsp: Path, faust: str = "faust") -> dict:
    """Ask Faust for its ports and UI without writing beside the source."""
    dsp = dsp.resolve()
    with tempfile.TemporaryDirectory(prefix="studio-faust-json-") as temporary:
        source = Path(temporary) / dsp.name
        shutil.copyfile(dsp, source)
        subprocess.run([faust, "-json", *include_options(dsp),
                        "-o", str(Path(temporary) / "dsp.cpp"), str(source)],
                       check=True, capture_output=True, text=True)
        return json.loads(source.with_suffix(source.suffix + ".json").read_text())


def parameters(items: list[dict]) -> list[dict]:
    """Flatten active controls; meters and soundfiles are not numeric controls."""
    result = []
    for item in items:
        if "items" in item:
            result.extend(parameters(item["items"]))
        elif item["type"] in {"hslider", "vslider", "nentry", "button", "checkbox"}:
            result.append(item)
    return result


@dataclass(frozen=True)
class Parameter:
    label: str
    address: str
    shortname: str
    initial: float
    minimum: float
    maximum: float
    step: float
    unit: str
    kind: str

    @classmethod
    def from_json(cls, item: dict) -> Parameter:
        meta = {key: value for entry in item.get("meta", []) for key, value in entry.items()}
        return cls(item["label"], item["address"], item.get("shortname", item["label"]),
                   float(item.get("init", 0)), float(item.get("min", 0)),
                   float(item.get("max", 1)), float(item.get("step", 1)),
                   meta.get("unit", ""), item["type"])


@dataclass(frozen=True)
class FaustProject:
    stem: str
    title: str
    source: str
    metadata: dict

    @property
    def inputs(self) -> int:
        return self.metadata["inputs"]

    @property
    def outputs(self) -> int:
        return self.metadata["outputs"]

    @property
    def voices(self) -> int:
        meta = {key: value for entry in self.metadata.get("meta", []) for key, value in entry.items()}
        return int(meta.get("nvoices", 0))

    @property
    def controls(self) -> list[Parameter]:
        controls = [Parameter.from_json(item) for item in parameters(self.metadata["ui"])]
        if self.voices:
            # freq/gain/gate belong to the MIDI voice allocator.
            controls = [item for item in controls if item.label.strip("/") not in {"freq", "gain", "gate"}]
        return controls


def load_project(stem: str, faust: str = "faust") -> FaustProject:
    path = DSP_DIR / f"{stem}.dsp"
    source = path.read_text()
    if 'library("libraries/abclib/' in source and not (
        DSP_DIR / "libraries/abclib/faustCodes/library/abc.lib"
    ).is_file():
        raise FileNotFoundError("Initialize abclib with: git submodule update --init -- faust/dsp/libraries/abclib")
    metadata = analyze_dsp(path, faust)
    if 'library("libraries/' in source:
        # Both hosts receive the same portable source, with local libs expanded.
        with tempfile.TemporaryDirectory(prefix="studio-faust-expand-") as temporary:
            expanded = Path(temporary) / "expanded.dsp"
            subprocess.run([faust, "-e", *include_options(path), "-o", str(expanded), str(path)],
                           check=True, capture_output=True, text=True)
            lines = [line for line in expanded.read_text().splitlines()
                     if not re.match(r"declare (?:compile_options|library_path\d+|filename) ", line)]
            if expanded.stat().st_size > 1_000_000:
                # Box expansion duplicates lambdas in complex HOA graphs.
                # Include the upstream source instead, retaining its licenses.
                source = bundle_local_libraries(source, path.parent)
            else:
                source = "\n".join(lines) + "\n"
            source = f"// Generated from faust/dsp/{path.name}; edit that source and regenerate.\n" + source
    return FaustProject(stem, PROJECTS[stem], source, metadata)


def bundle_local_libraries(source: str, directory: Path) -> str:
    """Embed local libraries, leaving standard Faust imports available to JIT."""
    def library(match):
        path = directory / match[1]
        aliases = {}
        imported = set()

        def include(path):
            def local_import(match):
                child = path.parent / match[1]
                if not child.is_file():
                    return match[0]
                child = child.resolve()
                if child in imported:
                    return ""
                imported.add(child)
                return include(child)

            return re.sub(r'import\("([^"]+)"\);', local_import, path.read_text())

        lines = []
        for line in include(path).splitlines():
            line = re.sub(r'^[ \t]+', lambda match: match[0].expandtabs(4), line).rstrip()
            alias = re.fullmatch(r'(\w+)\s*=\s*library\("([^"]+)"\);', line)
            if alias:
                name, target = alias.groups()
                if name in aliases:
                    if aliases[name] != target:
                        raise ValueError(f"Conflicting bundled library alias: {name}")
                    continue
                aliases[name] = target
            lines.append(line)
        return "environment {\n" + "\n".join(lines) + "\n}"

    return re.sub(r'library\("(libraries/[^"]+)"\)', library, source)


def project_builder(directory: Path, stem: str):
    """Load this backend's explicit build_patch without mixing backend modules."""
    path = directory / GENERATORS[stem]
    spec = importlib.util.spec_from_file_location(f"{directory.parent.name}_{stem}", path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.build_patch


def generation_cli(generate, directory: Path, stem: str | None = None):
    """Generate one/all projects, or compare every exported asset read-only."""
    parser = argparse.ArgumentParser(description="Generate Faust patches from the shared DSP sources.")
    parser.add_argument("--output-dir", type=Path, default=directory)
    parser.add_argument("--faust", default="faust")
    parser.add_argument("--check", action="store_true", help="Compare regenerated assets without modifying them.")
    args = parser.parse_args()
    projects = [stem] if stem else PROJECTS
    if args.check:
        with tempfile.TemporaryDirectory(prefix="studio-faust-check-") as temporary:
            for name in projects:
                for path in generate(name, Path(temporary), args.faust):
                    target = args.output_dir / path.relative_to(temporary)
                    if not target.is_file() or path.read_bytes() != target.read_bytes():
                        raise SystemExit(f"Regenerate {target}")
        print("Generated assets are up to date.")
    else:
        for name in projects:
            for path in generate(name, args.output_dir, args.faust):
                print(path)
