#!/usr/bin/env python3
"""Check JSON/Lean consistency, elaborate all 100 tasks, and run regression proofs.

Requires the repository's Lean toolchain and cached Lake dependencies. Proof holes
in benchmark tasks are intentional; the separate regression proofs must be closed.
All generated files are kept under .lake/ and .work/ in this checkout.
"""
import concurrent.futures
import argparse
import datetime
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from scripts.dataset_metadata import check_entry
from scripts.problem_tags import problem_tags
WORK = ROOT / ".work" / "statement-checks"
LIB = ROOT / ".lake" / "build" / "lib" / "lean"


def check_dataset():
    entries = json.loads((ROOT / "FATE-X.json").read_text())
    assert [entry["id"] for entry in entries] == list(range(1, 101))
    tags = problem_tags()
    for entry in entries:
        source = (ROOT / "FATEX" / f"{entry['id']}.lean").read_text()
        check_entry(entry, source)
        assert entry["tag"] == tags[entry["id"]], f"tag mismatch: {entry['id']}"
    print("All 100 JSON formal statements, declarations, theorem docstrings and tags checked; one task proof hole each.", flush=True)


def check_file(relative, output=None):
    command = ["lean"]
    if output:
        output.parent.mkdir(parents=True, exist_ok=True)
        command += ["-o", str(output)]
    command.append(relative)
    log = WORK / (relative.replace("/", "_") + ".log")
    start = time.monotonic()
    with log.open("w") as stream:
        try:
            result = subprocess.run(command, cwd=ROOT, env=ENV, stdout=stream,
                                    stderr=subprocess.STDOUT, timeout=600)
            code = result.returncode
        except subprocess.TimeoutExpired:
            code = 124
    record = {"source": relative, "returncode": code,
              "elapsed_seconds": round(time.monotonic() - start, 3),
              "sha256": hashlib.sha256((ROOT / relative).read_bytes()).hexdigest(),
              "log": str(log.relative_to(ROOT))}
    print(json.dumps({"source": relative, "returncode": code}), flush=True)
    return record


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dataset-only", action="store_true", help="Check all JSON fields and metadata regressions without running Lean")
    args = parser.parse_args()
    for directory in [WORK, WORK / "tmp", WORK / "cache", LIB / "FATEX"]:
        directory.mkdir(parents=True, exist_ok=True)
    ENV = dict(os.environ)
    ENV.update({"TMPDIR": str(WORK / "tmp"), "TMP": str(WORK / "tmp"),
                "TEMP": str(WORK / "tmp"), "XDG_CACHE_HOME": str(WORK / "cache")})
    check_dataset()
    subprocess.run([sys.executable, "tests/test_dataset_metadata.py"], cwd=ROOT, env=ENV, check=True)
    if args.dataset_only:
        sys.exit(0)
    ENV["LEAN_PATH"] = subprocess.check_output(
        ["lake", "env", "printenv", "LEAN_PATH"], cwd=ROOT, env=ENV, text=True).strip()
    with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:
        results = list(pool.map(lambda n: check_file(f"FATEX/{n}.lean", LIB / "FATEX" / f"{n}.olean"),
                                range(1, 101)))
    report = {"at_utc": datetime.datetime.now(datetime.timezone.utc).isoformat(),
              "lean_version": subprocess.check_output(["lean", "--version"], env=ENV, text=True).strip(),
              "benchmark_tasks": results, "benchmark_proofs_completed": False}
    passed = all(r["returncode"] == 0 for r in results)
    if passed:
        report["aggregate"] = check_file("FATEX.lean", LIB / "FATEX.olean")
        report["regressions"] = check_file("tests/StatementCorrections.lean")
        report["review_checks"] = check_file("tests/ReviewChecks.lean")
        report["original86_refutation"] = check_file("tests/Problem86Counterexample.lean")
        passed = (report["aggregate"]["returncode"] == 0 and report["regressions"]["returncode"] == 0
                  and report["review_checks"]["returncode"] == 0
                  and report["original86_refutation"]["returncode"] == 0)
        if passed:
            output = (ROOT / report["regressions"]["log"]).read_text()
            refutation = (ROOT / report["original86_refutation"]["log"]).read_text()
            review = (ROOT / report["review_checks"]["log"]).read_text()
            passed = "sorryAx" not in output and "sorryAx" not in refutation and "sorryAx" not in review
            report["regression_proofs_closed"] = passed
            report["regression_axiom_reports"] = output.count("depends on axioms:")
            report["review_axiom_reports"] = review.count("depends on axioms:")
            report["original86_refutation_closed"] = "sorryAx" not in refutation
    (WORK / "results.json").write_text(json.dumps(report, indent=2) + "\n")
    sys.exit(0 if passed else 1)
