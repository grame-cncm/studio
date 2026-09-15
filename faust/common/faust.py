"""Analyze shared Faust sources and coordinate their export to both hosts.

``DSP_DIR`` locates the reference sources independently of the working directory.
``PROJECTS`` maps file identifiers to bilingual titles; its insertion order also
defines generation order. ``GENERATORS`` maps each identifier to its script name,
including the two historical naming exceptions.

The Faust compiler supplies audio ports and controls through JSON. The resulting
``FaustProject`` feeds either native patch builder. Local imports are embedded
in exported sources to avoid dependencies on this machine's paths. Compiler
outputs are written in temporary directories. The abclib submodule and standard
Faust libraries remain the reference implementations of the audio processing.
"""

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
    "faustgen-mnemosphere-hoa4": "Mnemosphere HOA4 / Mnemosphere - studio decoder / decodeur studio - 26 speakers",
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
    """Build the ``-I`` arguments required to compile ``dsp``.

    Args:
        dsp: Relative or absolute path to a Faust source file.

    Returns:
        Flat list alternating ``-I`` and directory paths: the DSP directory followed
        by the abclib library directory. Only existing directories are included.

    This function neither checks that the DSP file exists nor launches a compiler.
    """
    paths = [dsp.resolve().parent, DSP_DIR / "libraries",
             DSP_DIR / "libraries/abclib/faustCodes/library"]
    return [argument for path in paths if path.is_dir() for argument in ("-I", str(path))]


def analyze_dsp(dsp: Path, faust: str = "faust") -> dict:
    """Compile a temporary copy of the DSP and read its JSON metadata.

    Args:
        dsp: Faust file to analyze; imports are resolved using its original directory.
        faust: Compiler executable name or path, looked up through PATH if necessary.

    Returns:
        Faust JSON document, including ``inputs``, ``outputs``, ``ui``, and global
        metadata. Its structure is the compiler's own schema.

    Raises:
        OSError: Source or compiler is inaccessible, or the JSON output is missing.
        subprocess.CalledProcessError: Compilation failed; captured stdout/stderr
            are available on the exception.
        json.JSONDecodeError: The generated JSON cannot be decoded.

    The generated C++ and JSON are removed when the temporary context exits,
    including on failure. No output is written next to the original source.
    """
    dsp = dsp.resolve()
    with tempfile.TemporaryDirectory(prefix="studio-faust-json-") as temporary:
        # Faust names its JSON after the input file, not the -o destination.
        source = Path(temporary) / dsp.name
        shutil.copyfile(dsp, source)
        subprocess.run([faust, "-json", *include_options(dsp),
                        "-o", str(Path(temporary) / "dsp.cpp"), str(source)],
                       check=True, capture_output=True, text=True)
        return json.loads(source.with_suffix(source.suffix + ".json").read_text())


def parameters(items: list[dict]) -> list[dict]:
    """Extract numeric controls from a Faust UI tree in their original order.

    Args:
        items: JSON list of widgets or nested groups containing an ``items`` key.

    Returns:
        Original dictionaries for sliders, numeric entries, buttons, and checkboxes.
        Groups are visited recursively; bargraphs and soundfiles are excluded.
        Widgets are neither copied nor modified.

    Entries must follow the Faust JSON schema. A leaf without ``type`` raises
    KeyError rather than being silently ignored.
    """
    result = []
    for item in items:
        if "items" in item:
            # A group organizes the UI but is not itself a parameter.
            result.extend(parameters(item["items"]))
        elif item["type"] in {"hslider", "vslider", "nentry", "button", "checkbox"}:
            result.append(item)
    return result


@dataclass(frozen=True)
class Parameter:
    """Immutable description of a numeric control from the Faust UI.

    Attributes:
        label: Faust widget label, used as a selector by some host configurations.
        address: Full UI path, used by monophonic Max patches.
        shortname: Short identifier used to name generated widgets.
        initial: Value to send when the patch loads.
        minimum: Lower bound defined in the DSP.
        maximum: Upper bound defined in the DSP.
        step: Faust step size, retained even when the native widget does not expose it.
        unit: Unit from widget metadata, or an empty string.
        kind: Faust JSON type, such as ``hslider`` or ``checkbox``.

    Numeric fields are floats. The bounds describe the interface; this model does
    not validate or clamp values sent to the DSP.
    """
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
        """Convert an active JSON widget into a parameter description.

        Args:
            item: Dictionary requiring ``label``, ``address``, and ``type``. Optional
                ``meta`` is a list of small dictionaries merged in their original order.

        Returns:
            An instance of ``cls``. Missing init/min default to 0, max/step to 1,
            shortname to label, and unit to an empty string.

        Raises:
            KeyError: A required field is missing.
            ValueError: A numeric value cannot be converted to float.

        Repeated metadata keys use their last value; ``item`` is not modified.
        """
        meta = {key: value for entry in item.get("meta", []) for key, value in entry.items()}
        return cls(item["label"], item["address"], item.get("shortname", item["label"]),
                   float(item.get("init", 0)), float(item.get("min", 0)),
                   float(item.get("max", 1)), float(item.get("step", 1)),
                   meta.get("unit", ""), item["type"])


@dataclass(frozen=True)
class FaustProject:
    """Portable source and metadata for a project shared by both hosts.

    Attributes:
        stem: Catalog identifier and basename of all exported files.
        title: Bilingual title displayed in the patches.
        source: Faust code to embed in Max or write next to the Pd patch.
        metadata: JSON compiled from the reference source before library embedding.

    The dataclass is frozen, but metadata is not deeply immutable. Patch builders
    treat that dictionary as read-only data.
    """
    stem: str
    title: str
    source: str
    metadata: dict

    @property
    def inputs(self) -> int:
        """Return the compiled DSP's audio input count, excluding the control port."""
        return self.metadata["inputs"]

    @property
    def outputs(self) -> int:
        """Return the Faust audio output count reported by the compiler."""
        return self.metadata["outputs"]

    @property
    def voices(self) -> int:
        """Read ``nvoices`` from global metadata and convert it to an integer.

        Return 0 when the declaration is absent, meaning that no polyphonic allocator
        is requested. A nonnumeric declaration raises ValueError.
        """
        meta = {key: value for entry in self.metadata.get("meta", []) for key, value in entry.items()}
        return int(meta.get("nvoices", 0))

    @property
    def controls(self) -> list[Parameter]:
        """Build the ordered list of parameters to expose in the host patch.

        For a polyphonic DSP, ``freq``, ``gain``, and ``gate`` belong to the MIDI voice
        allocator and are removed after stripping surrounding slashes from their labels.
        Each access rebuilds the list; the underlying metadata remains unchanged.
        """
        controls = [Parameter.from_json(item) for item in parameters(self.metadata["ui"])]
        if self.voices:
            # freq/gain/gate belong to the MIDI voice allocator.
            controls = [item for item in controls if item.label.strip("/") not in {"freq", "gain", "gate"}]
        return controls


def load_project(stem: str, faust: str = "faust") -> FaustProject:
    """Load, analyze, and prepare a portable source for a catalog project.

    Args:
        stem: Key in ``PROJECTS``; the source is ``DSP_DIR / (stem + '.dsp')``.
        faust: Compiler used for JSON analysis and optional source expansion.

    Returns:
        Project whose controls and ports come from the shared DSP. Sources without
        local libraries are preserved verbatim. Otherwise, ``faust -e`` expands the
        imports and machine-specific compilation declarations are removed. Above
        1 MB, textual library embedding retains a smaller source and library notices
        instead of using the expanded Faust graph.

    Raises:
        FileNotFoundError: Source is missing or the abclib submodule is uninitialized.
        KeyError: The identifier is not in the catalog.
        subprocess.CalledProcessError: Faust analysis or expansion failed.
        ValueError: Textual embedding encounters incompatible library aliases.

    Sources embedding local imports receive a provenance comment. Reference files
    and submodule sources are never modified.
    """
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
                # Apply the size threshold to raw output, before removing path declarations.
                # Box expansion duplicates lambdas in complex HOA graphs.
                # Include the upstream source instead, retaining its licenses.
                source = bundle_local_libraries(source, path.parent)
            else:
                source = "\n".join(lines) + "\n"
            source = f"// Generated from faust/dsp/{path.name}; edit that source and regenerate.\n" + source
    return FaustProject(stem, PROJECTS[stem], source, metadata)


def bundle_local_libraries(source: str, directory: Path) -> str:
    """Replace ``library("libraries/...")`` expressions with Faust environments.

    Args:
        source: Faust text containing local libraries to embed.
        directory: Base directory used to resolve the ``libraries/...`` paths.

    Returns:
        Source independent of those local library files. Existing local imports are
        included recursively, once per environment. Standard imports not found on
        disk remain available for the JIT compiler to resolve. Comments and license
        notices are retained. Leading indentation tabs become spaces, and trailing
        whitespace is removed.

    Raises:
        OSError: A local library cannot be read.
        ValueError: The same alias refers to two different libraries.

    This performs textual substitutions on the expected syntax, not general Faust
    parsing. Alias deduplication recognizes simple declarations occupying a whole
    line, as matched by the regular expression.
    """
    embedding = set()

    def environment(path):
        """Embed path and recursively turn its local libraries into environments."""
        path = path.resolve()
        if path in embedding:
            raise ValueError(f"Recursive local library dependency: {path}")
        embedding.add(path)
        aliases = {}
        imported = set()

        def include(path):
            """Read path and expand local imports and library environments.

            Return the expanded text to the caller. Imports absent from disk remain intact
            so that the compiler can still resolve standard Faust libraries. A local
            ``library`` expression remains namespaced in its own embedded environment.
            """
            def local_import(match):
                """Resolve an import relative to the file containing the directive.

                Return the original directive if the file does not exist, an empty string if
                its resolved path was already included, or its recursively expanded contents.
                """
                child = path.parent / match[1]
                if not child.is_file():
                    return match[0]
                child = child.resolve()
                # Absolute paths detect repeated inclusions despite different relative paths
                # and stop recursive import cycles.
                if child in imported:
                    return ""
                imported.add(child)
                return include(child)

            def local_library(match):
                """Embed a library path relative to the file that refers to it."""
                child = path.parent / match[1]
                if not child.is_file() or child.resolve() == path:
                    # Self references occur in faust2md documentation examples.
                    return match[0]
                return environment(child)

            text = re.sub(r'import\("([^"]+)"\);', local_import, path.read_text())
            return re.sub(r'library\("([^"]+)"\)', local_library, text)

        try:
            lines = []
            depth = 0
            for line in include(path).splitlines():
                line = re.sub(r'^[ \t]+', lambda match: match[0].expandtabs(4), line).rstrip()
                # Nested local libraries are already isolated environments; only
                # deduplicate aliases in the current environment's top level.
                alias = (re.fullmatch(r'(\w+)\s*=\s*library\("([^"]+)"\);', line)
                         if depth == 0 else None)
                if alias:
                    # Included files may declare the same standard library aliases;
                    # only identical declarations can be shared without ambiguity.
                    name, target = alias.groups()
                    if name in aliases:
                        if aliases[name] != target:
                            raise ValueError(f"Conflicting bundled library alias: {name}")
                        continue
                    aliases[name] = target
                lines.append(line)
                code = line.split("//", 1)[0]
                depth += code.count("{") - code.count("}")
            return "environment {\n" + "\n".join(lines) + "\n}"
        finally:
            embedding.remove(path)

    def library(match):
        """Embed a top-level ``libraries/...`` expression."""
        return environment(directory / match[1])

    return re.sub(r'library\("(libraries/[^"]+)"\)', library, source)


def project_builder(directory: Path, stem: str):
    """Import a native generator and return its ``build_patch`` function.

    Args:
        directory: Generator directory for the selected backend, Max or Pd.
        stem: Key in both the project catalog and ``GENERATORS``.

    Returns:
        Function accepting a FaustProject and returning an in-memory native Patcher.

    The module name includes the host to distinguish scripts with identical names.
    Their helper imports must already be available through sys.path. Import executes
    the module body but not its CLI block guarded by ``__main__``. Catalog, import,
    and missing-API errors are propagated.
    """
    path = directory / GENERATORS[stem]
    spec = importlib.util.spec_from_file_location(f"{directory.parent.name}_{stem}", path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module.build_patch


def generation_cli(generate, directory: Path, stem: str | None = None):
    """Parse the shared CLI and generate or verify a backend's output files.

    Args:
        generate: Callable ``(stem, output_dir, faust)`` returning paths it writes.
        directory: Default output directory for this backend.
        stem: Single project identifier, or None for all projects in catalog order.

    Options:
        --output-dir: Export destination, or reference directory for verification.
        --faust: Compiler name/path; defaults to ``faust``.
        --check: Generate in a temporary directory and compare bytes without changing
            reference files. The first missing or different file exits with
            ``Regenerate ...`` and a nonzero status.

    Normal generation prints exported paths; successful verification prints a single
    confirmation. Backend errors are propagated. This reads sys.argv and is not an
    API for constructing patches in memory.
    """
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
                    # Preserve any subdirectories when matching temporary exports
                    # to their reference files.
                    target = args.output_dir / path.relative_to(temporary)
                    if not target.is_file() or path.read_bytes() != target.read_bytes():
                        raise SystemExit(f"Regenerate {target}")
        print("Generated assets are up to date.")
    else:
        for name in projects:
            for path in generate(name, args.output_dir, args.faust):
                print(path)
