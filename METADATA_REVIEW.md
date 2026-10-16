# Follow-up review: auxiliary declarations, subjects and statement presentation

Reviewed against upstream `a6fb49ee85fd05bb8ce9fc66e1c66797b5a0592d`, using
Lean 4.28.0 and pinned mathlib `8f9d9cff6bd728b17a24e163c9402775d9e6a365`.
This supplements the sixteen corrections described in `STATEMENT_CORRECTIONS.md`.
Problem IDs, dataset source and toolchain version metadata are preserved.

## JSON auxiliary declarations: confirmed synchronization defect

The previous correction updated `formal_statement` but did not regenerate
`declaration`. In particular, problem 15 still carried the non-strict normal-step
and global chain-maximality definitions, and problem 45 still carried the old
single-scalar-ring `IsGradedHom`. Consumers using this field could therefore see
different definitions from consumers using the corrected Lean file. Neither the
old synchronizer nor the checker detected this discrepancy.

Both fields now come from the same Lean source for **all 100 problems**:

- Problem 15 contains all five current helper commands: strict normal step,
  `setRel`, composition series with endpoints, quotient and group instance.
- Problem 45 contains the two-scalar-ring grading predicate and the local
  coefficient-module instance.
- Problems 76 and 94 now include `IsCatenary` and `zeroSet`, respectively.
- Problem 79's `@[stacks 09Q3]` belongs to `IsLocalCompleteIntersectionRing`,
  rather than the preceding Gorenstein definition.
- The same complete-source extraction fixes missing or grouped helpers in
  18, 23, 41, 57, 71 and 72. The inductive radical-tower declaration and local
  instances are included, not only `def` and `class` commands.
- Renamed helper fields and the simplified problem-63 predicate are synchronized
  wherever they occur.

`scripts/dataset_metadata.py` reads this repository's source layout (commands in
column zero), preserving declaration order, multiline modifiers and attributes,
and handling nested comments. It is not a general Lean parser. The `declaration`
list contains helper commands; namespace, `open`, section-variable and import
context remain in `formal_statement`, so a list item is not necessarily a
standalone Lean file. The complete files are the compilation targets.

`scripts/sync_dataset.py` now generates all formal statements, helper lists and
theorem docstrings, together with the reviewed tags. `tests/check_statements.py`
checks all four fields. `tests/test_dataset_metadata.py` has seven regression
tests, including mutations that reintroduce stale #15/#45 helpers, remove the
#76/#94 helpers, or move the #79 attribute to the wrong declaration. Each mutation
is rejected. The tests also cover nested comments, inductive declarations and
split `noncomputable` modifiers.

The existing GitHub Actions workflow runs the synchronization and metadata-only
checks before its Lean build, so future JSON/source mismatches fail CI.

## Additional statement details

| Problem | Finding | Action and scope |
|---:|---|---|
| 8 | The Lean task additionally asks that the two target algebras are nonisomorphic. | Make that extra conclusion explicit in the informal statement. Classification and nonisomorphism are separate parts of the existing task. |
| 10 | `IsPrincipalIdealRing` alone does not express the word **domain**. | Add `IsDomain` as a conjunct for the fixed conic quotient; the PID claim now includes both properties. No full proof of this conic theorem is claimed. |
| 16 | `IsPExtension K L p` already extends `IsGalois K L`. | Remove the duplicate typeclass assumption. |
| 35 | The statement is already present verbatim as `IsNoetherianRing.of_prime`. | Keep the benchmark statement; provide an independent closed one-line library proof in `tests/ReviewChecks.lean`. This is a difficulty observation, not a false statement. |
| 38 | The dual-number presentation looks cubic, but its leading coefficient is nilpotent. | No false-statement defect found: `p = (εx-1)(x²+x)`, and `εx-1` is a unit because `(εx)²=0`. Hence the quotient is the monic-quadratic quotient and is free of rank two. This is a mathematical check, not a claimed full Lean proof. |
| 46 | The equivalence is accessible through existing flatness criteria. | Keep the task statement; add a complete independent proof using `Module.Flat.exists_factorization_of_isFinitelyPresented` and `Module.Flat.of_forall_exists_factorization`. The reverse implication uses the finitely presented quotient of a finite free module by one relation. |
| 55 | The formal theorem is an iff while the informal task only requested one implication. | State the iff and include the definition of stably free in the task docstring. The extra direction, free implies stably free, is elementary; the substantive non-finitely-generated direction is unchanged. |
| 63 | The compatibility equality in the helper follows from `g` being an `R`-algebra map. | Remove the redundant premise; independently prove the automatic equality in `tests/ReviewChecks.lean`. Keep formal unramifiedness and the previously added surjectivity condition. |
| 68 | The name refers to an absent dimension hypothesis, and nonnilpotence is unnecessary. | Rename to `localization_away_isJacobsonRing_of_mem_maximalIdeal`; include the nilpotent case in both versions. The new case has zero localization and is Jacobson; an independent Lean check covers it. |
| 72 | Tensor factors are reversed between the two presentations, and the custom CM-module classes omit finite generation. | Tensor symmetry explains the order difference. Restore finite generation in both CM-module classes and state it explicitly in the informal task, matching the standard finite-module convention in the source below. This explicitly restricts the earlier generalized predicate; it does not claim that the earlier infinite-module extension theorem was refuted. |
| 73 | The informal statement lists `n+1` variables, while Lean uses `Fin n`. | Use `x₁,…,xₙ` and explicitly say the homogeneous ideal is proper, as required to make the displayed homogeneous maximal ideal prime. |
| 76 | The helper omits the chain-length bound promised by its own docstring and counts vertices rather than edges. | Include a bound for every finite chain and use `LTSeries.length` consistently for the common maximal-chain length. Under the task's `dim A ≤ 3` hypothesis, the bound is automatic; a separate Lean lemma checks this. The full catenarity theorem remains a benchmark task. |
| 90 | `n > 0` is absent and the informal text calls `K` a subfield rather than explicitly an intermediate field over `k`. | Include the positive-`n` conjunct and state `k ⊆ K`. The no-variable case cannot provide a non-finitely-generated intersection, so this restores the advertised witness interface. No full Hilbert-fourteenth counterexample construction is claimed. |

The observations about 35 and 46 concern the amount of library work already
available in the pinned version. They do not establish a difficulty ranking for
the other reviewed problems or invalidate their mathematics.

The relevant pinned Mathlib sources are
[Cohen's theorem](https://github.com/leanprover-community/mathlib4/blob/8f9d9cff6bd728b17a24e163c9402775d9e6a365/Mathlib/RingTheory/Noetherian/OfPrime.lean)
and [the equational flatness criteria](https://github.com/leanprover-community/mathlib4/blob/8f9d9cff6bd728b17a24e163c9402775d9e6a365/Mathlib/RingTheory/Flat/EquationalCriterion.lean).

Problem 72 matches [Stacks Lemma 10.103.13](https://stacks.math.columbia.edu/tag/0AAI).
The preceding [local and global definitions](https://stacks.math.columbia.edu/tag/00N2)
require the module to be finite. The earlier custom predicates admitted, for
example, infinite-dimensional vector spaces over a field: their nonzero local
support has dimension zero and their depth is zero. The new `Module.Finite`
parents restore the finite-module scope. No claim that the earlier generalized
extension theorem is false, or that the corrected full theorem is Lean-proved,
is needed for this interface correction.

## Names, wording and helper-field spelling

| Problem(s) | Correction |
|---|---|
| 15 | Separate the length-two series of `H` from the length-`n` series of `G`; use primed symbols for the new series. |
| 19 | Close the missing mathematical delimiter in the helper docstring. |
| 34 | Rename `two_lt`/`...two_lt_ringKrullDim` to `two_le`/`...two_le_ringKrullDim`, matching `2 ≤ dim R`. |
| 47 | Rename to `quotient_isDedekindDomain_and_nontrivial_classGroup`. |
| 52 | Fix “gnerate” and clarify that the reductions generate the unit ideal in `(R/m)[x]`. |
| 53, 65, 74, 78, 79 | Replace every occurrence of the misspelled `injDim_le_infity` by `injDim_finite`; the finite-injective-dimension condition is unchanged. |
| 60 | Remove “it is it not” in the helper docstring. |
| 65 | Fix “Neotherian”. |
| 69 | Remove the unused `A` from the informal statement. |
| 72 | Capitalize Krull and repair the helper sentence. |
| 79 | Repair the local-complete-intersection definition's English; preserve its mathematical quantifiers and Stacks attribute. |
| 80 | Define the ambient `R = k[x₁,…,x₆]` in the informal statement. |
| 82 | Complete the mixed-characteristic condition: characteristic zero in the ring, positive characteristic in the residue field. |
| 86 | Rename `dimension_convex` to `dimension_concave`; correct the displayed `dim` notation. |
| 87 | Replace “There exists two” by “There exist two”. |
| 88 | Rename `quotient_not_UFD` to `quotient_isDomain_and_UFD`, matching its positive conclusion. |
| 92 | Restore the missing union symbol in the helper description and improve dimension notation. |
| 94 | Correct articles, “étale endomorphism” and the zero-set delimiters; explicitly identify the algebra maps; rename `contain` to `contains`. |
| 95 | Repair the sentence and rename the duplicate height-hypothesis binder to `hheight`. |
| 97 | Replace “polyminal” by “polynomial” and repair the degree clause. |
| 98 | Replace “If K be” with “Let K be” and identify the endomorphism as a `K`-algebra map. |

These renames change source-level theorem/field names; downstream code referring
to the old names must use the new ones. Task IDs remain stable.

## Subject tags

All 100 tag assignments have been reviewed by mathematical content. For example,
79 belongs to regular sequences/complete intersections, 89 to finite simple
groups, 86 and 92 to polynomial-ring dimensions, and 94–98 to algebraic/arithmetic
dynamics. Problem 93 is explicitly noncommutative algebra, not localization.

The complete explicit mapping is in `scripts/problem_tags.py`, with one primary
three-level path per problem. It is a reviewed editorial classification, not a
unique canonical taxonomy or a difficulty label. Both the synchronizer and the
checker require all 100 assignments, with no missing or duplicate IDs. Generated
`TOPIC_INDEX.md` records every assignment and aggregate counts. The README links
this index instead of the old sunburst, which predates the review.

## Validation and limitations

Quick check (does not require a Lean executable):

```sh
python3 scripts/sync_dataset.py --check
python3 tests/check_statements.py --dataset-only
```

Complete check with locked Lean/mathlib dependencies:

```sh
python3 tests/check_statements.py
```

The complete check elaborates all 100 task files and `FATEX.lean`, then compiles
the original regression suite, `tests/ReviewChecks.lean`, and the standalone
problem-86 refutation. Independent proofs must have no `sorryAx` dependency.
Every benchmark file retains exactly one intentional task proof hole.
Compiling a statement does not prove its mathematical conclusion; the explicit
limits in the per-problem table above apply.
