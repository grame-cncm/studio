"""Exercise the real Faust JIT in Pd: initialization, audio, and recompilation.

Run ``python -m pytest faust/puredata/tests/test_faustgen.py``. PD_BIN and
FAUSTGEN_EXTERNAL can override the binaries built inside the submodule.
requires_pd/requires_faust markers skip tests with unavailable prerequisites.
py2pd constructs probe patches under tmp_path.

JIT_SOURCE is a minimal stereo gain fixture independent of catalog projects.
Pd runs without preferences, a GUI, or audio devices, with the external preloaded.
Batch mode advances scheduled delays without real time; automatic compilation
uses real-time scheduling so Python can edit the source during the test.
"""

import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import threading

import pytest

from py2pd import Patcher

ROOT = Path(__file__).resolve().parents[1]
PATCHES = ROOT / "pd-patches"
sys.path.insert(0, str(PATCHES))
from pd_helpers import generate  # noqa: E402

PROJECT = "faustgen-quad-panner"
# Temporary DSP fixture isolates JIT recompilation from project generation.
JIT_STEM = "jit-test"
JIT_SOURCE = '''import("stdfaust.lib");
gain = hslider("gain", 0.1, 0, 1, 0.01);
process = _,_ : *(gain),*(gain);
'''

PD_BIN = Path(os.environ.get("PD_BIN", ROOT / "pd-faustgen/pure-data/src/pd"))
EXTERNAL = Path(os.environ.get(
    "FAUSTGEN_EXTERNAL", ROOT / "pd-faustgen/external/faustgen2~.pd_darwin",
))
requires_faust = pytest.mark.skipif(shutil.which("faust") is None, reason="faust not found")
requires_pd = pytest.mark.skipif(
    not PD_BIN.is_file() or not EXTERNAL.is_file(),
    reason="build pd-faustgen first, or set PD_BIN and FAUSTGEN_EXTERNAL",
)


def pd_command(*patches: Path, batch: bool = True) -> list[str]:
    """Build an isolated Pd command to open one or more patches.

    Args:
        *patches: Paths resolved before adding -open options.
        batch: Add -batch if True; False retains real-time scheduling.

    Returns:
        Arguments without a shell. -noaudio avoids devices, but patches may still
        enable DSP computation. Preferences and standard search paths are excluded.
    """
    command = [str(PD_BIN.resolve()), "-noprefs", "-nostdpath", "-nogui", "-noaudio",
               "-stderr", "-lib", str(EXTERNAL.resolve().with_suffix(""))]
    if batch:
        command.append("-batch")
    for patch in patches:
        command.extend(["-open", str(patch.resolve())])
    return command


def assert_clean(result: subprocess.CompletedProcess) -> str:
    """Return a CompletedProcess's combined console output after checking it.

    Require status zero and absence of ``error:`` (case-insensitive) and
    ``couldn't create``. stderr may be None when merged into stdout. Assertions
    include the complete console to make failures diagnosable.
    """
    console = result.stdout + (result.stderr or "")
    assert result.returncode == 0, console
    assert "error:" not in console.lower(), console
    assert "couldn't create" not in console, console
    return console


@requires_pd
@requires_faust
@pytest.mark.parametrize("clear_before_quit", [False, True])
def test_generated_patch_loads_initializes_and_exits(tmp_path, clear_before_quit):
    """Load a generated quad-panner and check level=0.8 before its destruction.

    tmp_path receives exports. clear_before_quit chooses between clearing the canvas
    before quit and normal destruction at shutdown. Pd must announce a 1/4 DSP,
    report the initialized control, and exit cleanly within 15 seconds.
    """
    pd_path, _, _ = generate(PROJECT, tmp_path)
    messages = [f"{PROJECT} level"]
    if clear_before_quit:
        messages.append(f"pd-{pd_path.name} clear")
    messages.append("pd quit")
    result = subprocess.run(pd_command(pd_path, batch=False) + ["-send", "; ".join(messages)],
                            capture_output=True, text=True, timeout=15)
    console = assert_clean(result)
    assert f"faustgen2~ {PROJECT} (1/4)" in console
    assert f"{PROJECT}: level 0.8" in console


def probe(tmp_path: Path, *, automatic: bool = False) -> tuple[Path, Path]:
    """Write a gain DSP and two Pd patches driving its measurements and shutdown.

    Args:
        tmp_path: Directory for the .dsp fixture and generated patches.
        automatic: Enable autocompile with 20 ms polling and delay measurements to
            allow external editing; otherwise send compile at 400 ms.

    Returns:
        Pair (probe.pd, driver.pd). The probe measures constant inputs 1 and 0.5
        before a change, after gain=0.5, and after recompilation. The independent
        driver closes Pd after 600 ms or 2500 ms.

    This writes disposable fixtures without launching Pd.
    """
    (tmp_path / f"{JIT_STEM}.dsp").write_text(JIT_SOURCE)
    p = Patcher()
    dsp = p.add(f"faustgen2~ {JIT_STEM}", num_inlets=3, num_outlets=3)
    p.link(p.add("sig~ 1"), dsp, inlet=1)
    p.link(p.add("sig~ 0.5"), dsp, inlet=2)
    load = p.add("loadbang")

    def delayed(milliseconds: int):
        """Add a delay in milliseconds triggered by the probe's loadbang.

        Return the delay object to connect a measurement or command at that Pd time.
        """
        delay = p.add(f"delay {milliseconds}")
        p.link(load, delay)
        return delay

    p.link(load, msg := p.add_msg("dsp 1"))
    p.link(msg, p.add("s pd"))
    for stage, time in (("INITIAL", 100), ("UPDATED", 1300 if automatic else 300),
                        ("RECOMPILED", 2300 if automatic else 500)):
        delay = delayed(time)
        for channel in (1, 2):
            snapshot = p.add("snapshot~")
            p.link(dsp, snapshot, outlet=channel)
            p.link(delay, snapshot)
            p.link(snapshot, p.add(f"print {stage}_{channel}"))
    p.link(delayed(200), msg := p.add_msg("gain 0.5"))
    p.link(msg, dsp)
    if automatic:
        p.link(load, msg := p.add_msg("autocompile 1 20"))
    else:
        p.link(delayed(400), msg := p.add_msg("compile"))
    p.link(msg, dsp)
    pd_path = tmp_path / "probe.pd"
    p.save(str(pd_path))
    driver = Patcher()
    driver.link(driver.add("loadbang"), delay := driver.add(
        f"delay {2500 if automatic else 600}",
    ))
    driver.link(delay, msg := driver.add_msg("quit"))
    driver.link(msg, driver.add("s pd"))
    driver_path = tmp_path / "driver.pd"
    driver.save(str(driver_path))
    return pd_path, driver_path


def assert_samples(console: str, *, automatic: bool = False):
    """Compare six printed measurements against expected gains within 1e-6.

    Args:
        console: Pd text output containing INITIAL/UPDATED/RECOMPILED per channel.
        automatic: Expect doubled gain from source editing after UPDATE; otherwise
            expect gain=0.5 to survive manual compilation.

    Missing or different samples raise AssertionError with the complete console.
    """
    expected = {"INITIAL_1": 0.1, "INITIAL_2": 0.05,
                "UPDATED_1": 0.5, "UPDATED_2": 0.25,
                "RECOMPILED_1": 1.0 if automatic else 0.5,
                "RECOMPILED_2": 0.5 if automatic else 0.25}
    for label, value in expected.items():
        match = re.search(rf"^{label}: ([-+\d.eE]+)$", console, re.M)
        assert match, console
        assert float(match[1]) == pytest.approx(value, abs=1e-6), console


@requires_pd
def test_audio_parameter_change_and_manual_recompile(tmp_path):
    """Measure stereo gain around a control change and its preservation through compile.

    The tmp_path probe runs in batch within 15 seconds. At least two 2/2 DSP
    announcements confirm that recompilation really occurred, rather than only a
    parameter update.
    """
    paths = probe(tmp_path)
    result = subprocess.run(pd_command(*paths), capture_output=True, text=True, timeout=15)
    console = assert_clean(result)
    assert_samples(console)
    assert console.count(f"faustgen2~ {JIT_STEM} (2/2)") >= 2


@requires_pd
def test_changed_faust_source_is_recompiled_automatically(tmp_path):
    """Edit the DSP after UPDATED_2 and verify that autocompilation doubles the gain.

    Pd runs in real time without audio devices. Python reads its console and rewrites
    only the tmp_path fixture. A Timer kills the process after 15 seconds if it
    hangs and is canceled in finally. Measurement timing exceeds the one-second
    granularity of the timestamp observed by the external. The source must actually
    be edited, Pd must exit cleanly, and new samples must reflect doubled gain with
    the previous control value preserved.
    """
    paths = probe(tmp_path, automatic=True)
    source = tmp_path / f"{JIT_STEM}.dsp"
    changed = False
    # Use Pd's real-time scheduler so the Python writer can edit the source
    # after the UPDATED measurements. No audio device is opened.
    with subprocess.Popen(pd_command(*paths, batch=False), stdout=subprocess.PIPE,
                          stderr=subprocess.STDOUT, text=True, bufsize=1) as process:
        timer = threading.Timer(15, process.kill)
        timer.start()
        lines = []
        try:
            for line in process.stdout:
                lines.append(line)
                if line.startswith("UPDATED_2:"):
                    # The external compares whole-second st_ctime values;
                    # UPDATED is delayed past the source's creation second.
                    source.write_text(source.read_text().replace(
                        "*(gain),*(gain)", "*(gain*2),*(gain*2)",
                    ))
                    changed = True
            process.wait(timeout=5)
        finally:
            timer.cancel()
    console = assert_clean(subprocess.CompletedProcess([], process.returncode, "".join(lines)))
    assert changed, console
    assert_samples(console, automatic=True)
