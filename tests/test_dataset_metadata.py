"""Regression checks for stale, missing and misplaced JSON helper declarations."""
import copy
import json
from pathlib import Path
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from scripts.dataset_metadata import check_entry, declarations
from scripts.problem_tags import problem_tags


class MetadataRegressionTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.entries = json.loads((ROOT / "FATE-X.json").read_text())

    def assert_rejected(self, number, mutate):
        entry = copy.deepcopy(self.entries[number - 1])
        mutate(entry)
        source = (ROOT / "FATEX" / f"{number}.lean").read_text()
        with self.assertRaisesRegex(AssertionError, "declaration mismatch"):
            check_entry(entry, source)

    def test_100_entries_match_sources(self):
        tags = problem_tags()
        for entry in self.entries:
            with self.subTest(problem=entry["id"]):
                check_entry(entry, (ROOT / "FATEX" / f"{entry['id']}.lean").read_text())
                self.assertEqual(entry["tag"], tags[entry["id"]])

    def test_old_non_strict_composition_step_is_rejected(self):
        def stale(entry):
            entry["declaration"][0] = entry["declaration"][0].replace("lt : H₁ < H₂", "le : H₁ ≤ H₂")
        self.assert_rejected(15, stale)

    def test_old_grading_interface_is_rejected(self):
        self.assert_rejected(45, lambda e: e.update(declaration=[
            "def IsGradedHom {R M N ι : Type} := True"]))

    def test_missing_helpers_are_rejected(self):
        for number in [76, 94]:
            with self.subTest(problem=number):
                self.assert_rejected(number, lambda e: e.update(declaration=[]))

    def test_misplaced_stacks_attribute_is_rejected(self):
        def misplaced(entry):
            attribute = "@[stacks 09Q3]\n"
            entry["declaration"][-1] = entry["declaration"][-1].removeprefix(attribute)
            entry["declaration"][-2] += "\n" + attribute.rstrip()
        self.assert_rejected(79, misplaced)

    def test_comments_do_not_create_commands_or_detach_attributes(self):
        source = '''import Mathlib
/- nested /- comment -/
def fake := 0
-/
@[stacks 09Q3]
/-- A docstring with a command-looking line:
class Fake where
-/
class Real where
  field : Nat
/-- Task. -/
theorem task : True := by
  trivial
'''
        self.assertEqual(declarations(source), [
            "@[stacks 09Q3]\n/-- A docstring with a command-looking line:\n"
            "class Fake where\n-/\nclass Real where\n  field : Nat"])

    def test_inductive_and_split_modifiers_are_preserved(self):
        source = '''import Mathlib
inductive Tower where
  | step : Tower
noncomputable
def f : Nat := 0
'''
        self.assertEqual(declarations(source), [
            "inductive Tower where\n  | step : Tower", "noncomputable\ndef f : Nat := 0"])


if __name__ == "__main__":
    unittest.main()
