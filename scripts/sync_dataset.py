#!/usr/bin/env python3
"""Synchronize the corrected entries with Lean and render the complete benchmark."""
import argparse
from collections import Counter
import json
from pathlib import Path

from dataset_metadata import check_entry, declarations, informal_statement
from problem_tags import problem_tags

ROOT = Path(__file__).resolve().parents[1]
CORRECTED = (2, 10, 13, 15, 22, 23, 45, 59, 60, 63, 68, 70, 72, 74, 75, 76, 81, 86, 90, 92, 96)


def synchronize(check=False):
    data = json.loads((ROOT / "FATE-X.json").read_text())
    tags = problem_tags()
    for entry in data:
        source = (ROOT / "FATEX" / f"{entry['id']}.lean").read_text().rstrip()
        entry["formal_statement"] = source
        entry["informal_statement"] = informal_statement(source)
        entry["declaration"] = declarations(source)
        entry["tag"] = tags[entry["id"]]
    rendered = json.dumps(data, ensure_ascii=False, indent=2) + "\n"
    sections = [
        "# FATE-X corrected statements",
        "This corrected edition contains all 100 problems. "
        "See [STATEMENT_CORRECTIONS.md](STATEMENT_CORRECTIONS.md) and "
        "[METADATA_REVIEW.md](METADATA_REVIEW.md) for the corrections and validation scope. "
        "Proof holes are intentional benchmark tasks.",
    ]
    for entry in data:
        mark = " (corrected)" if entry["id"] in CORRECTED else ""
        sections.extend([
            f"## Problem {entry['id']}{mark}",
            entry["informal_statement"],
            f"[Lean source](FATEX/{entry['id']}.lean)",
            "```lean\n" + entry["formal_statement"] + "\n```",
        ])
    markdown = "\n\n".join(sections) + "\n"
    counts = Counter(tuple(tag[:2]) for tag in tags.values())
    topics = ["# Reviewed subject index", "", "These are primary mathematical subjects, not difficulty ratings.", "",
              "| Field | Area | Problems |", "|---|---|---:|"]
    topics.extend(f"| {field} | {area} | {count} |" for (field, area), count in sorted(counts.items()))
    topics.extend(["", "## All 100 assignments", "", "| Problem | Field | Area | Topic |", "|---:|---|---|---|"])
    topics.extend(f"| [{n}](FATEX/{n}.lean) | " + " | ".join(tags[n]) + " |" for n in range(1, 101))
    topic_index = "\n".join(topics) + "\n"
    for name, text in [("FATE-X.json", rendered), ("FATE-X.md", markdown), ("TOPIC_INDEX.md", topic_index)]:
        path = ROOT / name
        if check:
            assert path.read_text() == text, f"{name} is out of sync"
        else:
            path.write_text(text)
    assert [entry["id"] for entry in data] == list(range(1, 101))
    for entry in data:
        check_entry(entry, (ROOT / "FATEX" / f"{entry['id']}.lean").read_text())
    print("All 100 JSON formal statements, helper declarations, theorem docstrings and reviewed tags synchronized.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    synchronize(parser.parse_args().check)
