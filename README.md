# FATE-X  
The **FATE-X (Formal Algebra Theorem Evaluation - Extra Hard)** benchmark.  

## Statement and metadata corrections

The initial sixteen statement corrections are documented in [STATEMENT_CORRECTIONS.md](STATEMENT_CORRECTIONS.md).
The follow-up [metadata review](METADATA_REVIEW.md) fixes stale/missing JSON helper declarations,
minor statement details, names and documentation, with checks covering all 100 problems.
Current statements are available in [FATE-X.md](FATE-X.md), Lean and JSON;
the existing PDF contains the original statements.

## Overview  
This benchmark contains 100 extremely challenging abstract algebra and commutative algebra exercises collected from:  
- Undergraduate and graduate textbooks,  
- Final exams and PhD qualifying exams,  
- Research literature.  

All exercises are formalized in Lean. The current natural-language and Lean statements
are collected in **[FATE-X.md](FATE-X.md)**. The original PDF is retained for provenance.

For users' convenience, we provide a JSON file (**FATE-X.json**) where each entry represents a problem and includes the following information:  
- Problem ID,  
- Formal statement (Lean code),  
- Natural language statement,  
- Benchmark source (FATE-X),  
- Tags indicating its mathematical field. 

## Benchmark Structure  
Each Lean file consists of a single exercise, containing:  
- One fully formalized statement,  
- A single `sorry`,  
- Appropriate open namespaces at the beginning, 
- Minimal dependent definitions formalized before the statement,  
- Natural language annotations preceding the statement. 

## Problem Distribution

The [reviewed subject index](TOPIC_INDEX.md) records all 100 assignments and
current counts. The original sunburst asset predates the metadata review.

## Lean Toolchain
The initial version of this benchmark uses `leanprover/lean4:v4.19.0`. For each supported minor version of Lean, a corresponding and updated iteration of the benchmark is available via the repository's tags.

This revision uses the locked Lean 4.28.0 toolchain. With its dependencies available:

```sh
python3 scripts/sync_dataset.py --check
python3 tests/check_statements.py
```

The checker verifies JSON statements, auxiliary declarations, theorem docstrings
and tags, runs metadata regressions, elaborates all 100 tasks and their aggregate,
and checks independent proofs. Logs remain in `.work/statement-checks/`.
Use `python3 tests/check_statements.py --dataset-only` for the metadata checks
without a Lean executable. Benchmark proof holes remain intentional.
