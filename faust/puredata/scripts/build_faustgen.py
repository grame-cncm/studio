"""Build the pd-faustgen submodule and a headless Pd on macOS."""

import argparse
from pathlib import Path
import shlex
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "pd-faustgen"


def run(*args: str, cwd: Path | None = None) -> None:
    subprocess.run(args, cwd=cwd, check=True)


def output(*args: str, cwd: Path | None = None) -> str:
    return subprocess.check_output(args, cwd=cwd, text=True).strip()


def build(faust_library: Path, llvm_config: str, jobs: int) -> None:
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
    linker_flags = (
        f"-L{shlex.quote(llvm_libdir)} -Wl,-rpath,{shlex.quote(llvm_libdir)} -lc++"
    )
    run("cmake", "-S", str(SOURCE), "-B", str(SOURCE / "build"),
        "-DINSTALLED_FAUST=ON", f"-DFAUST_LIBRARY={faust_library}",
        f"-DLLVM_DIR={llvm_cmakedir}", f"-DCMAKE_SHARED_LINKER_FLAGS={linker_flags}")
    run("cmake", "--build", str(SOURCE / "build"), "--parallel", str(jobs))
    pd = SOURCE / "pure-data"
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
