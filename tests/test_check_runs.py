"""Regression coverage for the author-facing run vocabulary/link check."""
import contextlib
import io
import runpy
import shutil
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CHECK = runpy.run_path(str(ROOT / "bin/check-runs"))


class RunVocabularyTests(unittest.TestCase):
    def test_ordinary_work_is_not_a_named_execution(self):
        self.assertEqual([], CHECK["vocabulary_errors"](
            "JSON describing the job it did; reviewers do the same job on different models"))

    def test_obsolete_named_execution_cli_and_paths_are_rejected(self):
        for text in ('a job named "tetris"', 'the "tetris" job is running',
                     'factory/jobs/tetris/plan.md', 'bin/factory --job tetris',
                     'Jobs and targets'):
            with self.subTest(text=text):
                self.assertTrue(CHECK["vocabulary_errors"](text))

    def test_current_course_and_broken_link_regression(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            shutil.copytree(ROOT / "docs", root / "docs")
            main = CHECK["main"]
            globals_ = main.__globals__
            original_root, original_iterations = globals_["ROOT"], globals_["ITERATIONS"]
            try:
                globals_["ROOT"] = root
                globals_["ITERATIONS"] = root / "docs/iterations"
                with contextlib.redirect_stdout(io.StringIO()):
                    self.assertEqual(0, main())
                readme = root / "docs/iterations/README.md"
                readme.write_text(readme.read_text() + "\n[Missing spec](004-missing/README.md)\n")
                output = io.StringIO()
                with contextlib.redirect_stderr(output):
                    self.assertEqual(1, main())
                self.assertIn("broken link 004-missing/README.md", output.getvalue())
            finally:
                globals_["ROOT"], globals_["ITERATIONS"] = original_root, original_iterations


if __name__ == "__main__":
    unittest.main()
