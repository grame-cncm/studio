"""Build pd-faustgen and a Pd executable without audio/MIDI drivers on macOS.

Example from the repository root:
    python faust/puredata/scripts/build_faustgen.py --jobs 4

Options: --faust-library (LLVM-enabled Faust archive, default
/usr/local/lib/libfaustwithllvm.a), --llvm-config (LLVM executable), and --jobs
(parallelism, default 4). git, cmake, make, autoreconf, llvm-config, and a working
compiler toolchain are required. This recipe initializes submodules and writes
build artifacts inside pd-faustgen; it may require network access. It does not
run tests or install anything globally.
"""

import argparse
from pathlib import Path
import shlex
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "pd-faustgen"


def run(*args: str, cwd: Path | None = None) -> None:
    """Execute args without a shell, leaving stdout/stderr visible.

    Args:
        *args: Program and arguments, passed separately.
        cwd: Process working directory; None keeps Python's current directory.

    Raises:
        subprocess.CalledProcessError: The program exits with a nonzero status.
        OSError: The program or working directory is inaccessible.

    Return None after success. A failure stops the build recipe.
    """
    subprocess.run(args, cwd=cwd, check=True)


def output(*args: str, cwd: Path | None = None) -> str:
    """Execute args and return text stdout with surrounding whitespace stripped.

    Args:
        *args: Program and arguments, without shell interpolation.
        cwd: Optional process working directory.

    stderr remains visible. Execution errors are propagated as in run. This reads
    LLVM's library and CMake package directory paths.
    """
    return subprocess.check_output(args, cwd=cwd, text=True).strip()


def build(faust_library: Path, llvm_config: str, jobs: int) -> None:
    """Initialize dependencies and build the external followed by the test Pd.

    Args:
        faust_library: Existing Faust archive built with the LLVM backend.
        llvm_config: Executable providing --libdir and --cmakedir for compatible LLVM.
        jobs: Parallel task count passed to CMake and make.

    Raises:
        SystemExit: Platform is not macOS, a tool is missing, or the archive is absent.
        subprocess.CalledProcessError: Initialization, configuration, or build fails.

    CMake uses the installed Faust library, LLVM package, and a runtime search path
    to LLVM libraries. Pd is configured without PortAudio, PortMidi, JACK, ALSA,
    OSS, FFTW, or locales, then built in src. External and executable paths are
    printed. Submodule source files are not rewritten, but dependencies and build
    artifacts are created on disk.
    """
    if sys.platform != "darwin":
        raise SystemExit("This build recipe has only been validated on macOS.")
    for tool in ("git", "cmake", "make", "autoreconf", llvm_config):
        if shutil.which(tool) is None:
            raise SystemExit(f"Missing build tool: {tool}")
    faust_library = faust_library.resolve()
    if not faust_library.is_file():
        raise SystemExit(f"Missing LLVM-enabled Faust library: {faust_library}")
    run("git", "submodule", "update", "--init", "--", "pd-faustgen", cwd=ROOT)
    run("git", "submodule", "update", "--init", "--depth", "1", "pd.build", "pure-data",
        cwd=SOURCE)
    llvm_libdir = output(llvm_config, "--libdir")
    llvm_cmakedir = output(llvm_config, "--cmakedir")
    # The rpath lets the macOS loader find LLVM when Pd starts.
    # shlex.quote protects paths inside the option string processed by CMake.
    linker_flags = (
        f"-L{shlex.quote(llvm_libdir)} -Wl,-rpath,{shlex.quote(llvm_libdir)} -lc++"
    )
    run("cmake", "-S", str(SOURCE), "-B", str(SOURCE / "build"),
        "-DINSTALLED_FAUST=ON", f"-DFAUST_LIBRARY={faust_library}",
        f"-DLLVM_DIR={llvm_cmakedir}", f"-DCMAKE_SHARED_LINKER_FLAGS={linker_flags}")
    run("cmake", "--build", str(SOURCE / "build"), "--parallel", str(jobs))
    pd = SOURCE / "pure-data"
    # Test probes compute DSP output without depending on hardware drivers.
    run("./autogen.sh", cwd=pd)
    run("./configure", "--disable-portaudio", "--disable-portmidi", "--disable-jack",
        "--disable-alsa", "--disable-oss", "--disable-fftw", "--disable-locales", cwd=pd)
    run("make", "-C", "src", f"-j{jobs}", cwd=pd)
    print(f"\nExternal: {SOURCE / 'external' / 'faustgen2~.pd_darwin'}")
    print(f"Headless test Pd: {pd / 'src' / 'pd'}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--faust-library", type=Path,
                        default=Path("/usr/local/lib/libfaustwithllvm.a"))
    parser.add_argument("--llvm-config", default="llvm-config")
    parser.add_argument("--jobs", type=int, default=4)
    args = parser.parse_args()
    build(args.faust_library, args.llvm_config, args.jobs)
