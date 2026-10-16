# Statement corrections

This change addresses the twelve problems listed in [issue #1](https://github.com/frenzymath/FATE-X/issues/1)
and the grading defect in [issue #2](https://github.com/frenzymath/FATE-X/issues/2).
Together with the review findings in problems 70, 74, and 86, these make up the
initial sixteen-problem correction set. The later metadata/presentation review
and additional interface corrections are documented in [METADATA_REVIEW.md](METADATA_REVIEW.md).
The Lean and JSON statements are synchronized. Each benchmark task still has exactly
one intentional proof hole; the regression proofs are separate and do not use task theorems.

## Changes and review

| Problem | Correction | Semantic review |
|---|---|---|
| 2 | Take minimal elements among nontrivial normal subgroups. | The subtype excludes bottom before applying `IsMin`; it still admits the top subgroup of a simple group as a genuine minimal nontrivial normal subgroup. |
| 13 | Exclude division rings, retaining the noncommutative ring setting. | `¬ (Nontrivial R ∧ ∀ x, x ≠ 0 → IsUnit x)` excludes the quaternion counterexample. In a nontrivial ring it supplies a nonzero nonunit; the zero ring remains harmless. |
| 15 | Require strict maximal-normal steps, explicit bottom/top endpoints, additive cyclic factors, and three distinct primes. | A composition series is now a chain of proper maximal normal inclusions from bottom to top. `Multiplicative (ZMod p)` is the intended cyclic group. The regression constructs actual series for prime-order cyclic groups. |
| 22 | Require a positive root-of-unity exponent. | Exponent zero no longer discharges the conclusion. The formulation matches the positive witness supplied by Mathlib's number-field Kronecker theorem. |
| 23 | Require positive polynomial degree. | This excludes irreducible constants such as `C 2`, whose prime-root average is zero; positive-degree irreducible polynomials retain the intended scope. |
| 45 | Use base-field subspaces for homogeneous components while keeping differentials polynomial-ring-linear. | Scalar restriction is explicit. The regression admits the usual polynomial grading, the A-linear identity, and a nonzero variable action simultaneously. |
| 59 | State the finite value group explicitly. | The finite values on nonzero field elements are exactly `m + n * α`, with integer coefficients of either sign; `∞` is not a real value. This makes the requested value-group conclusion explicit rather than changing the valuation formula. |
| 60 | Use associated primes of `R/I` and prime height. | The unit ideal has no associated primes in its quotient module and remains invertible. The zero ideal over a field has an associated prime of height zero and is excluded. `dim(R/p)` is not used as a substitute for `height(p)`. |
| 63 | Require the map `S' → S` to be surjective. | Square-zero kernel and the universal lifting property are retained. The constant-map shortcut to a polynomial algebra is not surjective and no longer meets the conclusion. |
| 70 | Replace `NoZeroSMulDivisors R S` with injectivity of `algebraMap R S`. | An embedding need not make S torsion free as an R-module. The regression proves the intended minimal-prime contraction statement from injectivity alone using Mathlib. |
| 74 | Require the regular sequence to have length equal to `dim R`. | Without this hypothesis a length-two sequence in a three-dimensional regular local ring gives a colon quotient of type two. The corrected case reduces to an Artinian Gorenstein quotient. |
| 75 | Use the ordinary prime localization. | The degree-zero homogeneous localization does not test the affine-cone vertex. Ordinary localization retains it and gives the criterion discussed in issue #1; the informal statement is updated as well. |
| 81 | Parenthesize the existential only on the left of the equivalence. | The statement asserts both directions of the intended criterion. The existing proper-ideal hypothesis is retained and made explicit in the informal statement. |
| 86 | Restrict the dimension inequality to one-dimensional rings. | The unrestricted assertion is refuted by `tests/Problem86Counterexample.lean`. The dimension-one replacement is consistent with the cutoff sequences of problem 92. |
| 92 | Quantify over `ℕ∞` in the realization direction too. | Both directions now include the sequence for the infinite cutoff, namely `a_n = 2n+1` for every n. |
| 96 | Exclude actual poles instead of zero orbit values. | The denominator is nonzero at every iterate. A polynomial orbit starting at zero satisfies this guard, and the conclusion remains about the second iterate `f ∘ f`. |

For problem 63, the corrected statement also agrees directly with the universal
first-order thickening in [Stacks, Lemma 10.149.1](https://stacks.math.columbia.edu/tag/04EB).

## Details of the larger changes

### Problems 70, 74, and 86: subsequent review

Problem 70 only needs an embedding of R into S. Torsion freeness discards the
case in which nonzero elements of R become zero divisors in S. Even with this
corrected scope, the task is a short application of Mathlib's
`Ideal.exists_minimalPrimes_comap_eq`; the independent regression proves a stronger
statement without the local and Noetherian assumptions. The correction restores
the right scope, but does not make it a difficult benchmark task.

For problem 74, over the rationals take the regular local ring at `(a,b,c)` and
the regular sequence `(ab,(a+b)c)`, with `y=a+2b`. Gröbner elimination gives
`((ab,(a+b)c):y)=(ab,ac,bc)`. The quotient is one-dimensional Cohen--Macaulay;
reducing by the regular element `a+b+c` gives `Q[a,b]/(a²,ab,b²)`, with socle
spanned by a and b. Its type is two, so the original conclusion is false.
The socle computation was independently checked by multiplication matrices and
ideal quotients; this is not a Lean counterexample proof. Requiring `length = dim R`
makes the regular-sequence quotient Artinian Gorenstein. Its quotient by the
annihilator of a nonzero element is again Artinian Gorenstein, yielding the
intended corrected statement. The typo in “Prove” is fixed as well.

For problem 86, the reviewer-supplied standalone Lean file constructs
`A = D × Q[s,t]`, with `D = Q + t L[[t]]` and `L = Q(u,v)`. It proves the bounds
`dim A ≥ 2`, `dim A[X,Y] ≥ 5`, and `dim A[X] ≤ 3`, sufficient to force `7 ≤ 6`
from the original inequality. No further exact-dimension claims are needed.
The file was independently recompiled against the pinned toolchain;
`V86.problem86_false` depends only on `propext`, `Classical.choice`, and `Quot.sound`.

The new dimension-one condition in 86 is an explicit restriction of the task.
Two independent regressions prove concavity for every cutoff sequence in problem
92, including the infinite cutoff, and derive the ring-dimension inequality when
that sequence characterization is supplied as a hypothesis. They do not invoke
problem 92's unproved benchmark theorem.

### Problem 15

The old relation admitted equality, so any relation series could be lengthened by
repeating its last subgroup. Requiring a globally maximum length therefore made
the composition-series type empty.

The new definition instead records proper maximal-normal steps and the two
endpoints explicitly. Each successive quotient is nontrivial and simple, which
is the required composition-series notion; it does not require every subgroup
in the chain to be normal in the entire ambient group.

The six factor-group occurrences use `Multiplicative (ZMod p)` or
`Multiplicative (ZMod q)`, rather than the multiplicative monoid of `ZMod`.
The hypotheses `p ≠ q`, `p ≠ r`, and `q ≠ r` restore the distinctness stated in prose.

### Problem 45

For `A = k[x₁,…,xᵣ]`, an A-submodule in degree d is stable under every scalar.
The graded action simultaneously sends a positive-degree scalar times an element
in degree d into a different degree. Internal directness then forces that product
to be zero. With the other hypotheses and r > 0, every term of the original
complex is consequently zero.

The repaired homogeneous pieces are k-subspaces. Their k-action is obtained by
restricting the existing A-action along the coefficient inclusion. `IsGradedHom`
uses k for the components and A for its linear map, preserving the required
A-linearity of the chain-complex differentials.

### Problems 59, 75, and 96: scope

A mathematical check for problem 75 is the standard graded algebra
`A = k[x,y]/(x²,xy)`. Its nilradical is `(x)` and its reduction is `k[y]`, so
it has dimension one. The nonzero class x has annihilator `(x,y)` and remains
nonzero at that maximal ideal, where depth is zero. Thus A is not Cohen--Macaulay.
Its homogeneous primes are `(x)` and `(x,y)`. Their degree-zero homogeneous
localizations are both k: at `(x)` inverting y kills x, and at `(x,y)` the
homogeneous denominators outside the prime are nonzero constants. Consequently
the old right-hand side misses the failure at the cone vertex. The repaired
ordinary localization at `(x,y)` retains this failure. This paragraph is a
mathematical argument, not a claim of an additional Lean proof.

- Problem 59 describes the image of nonzero field elements among finite real
  values. The value of zero, `∞`, is deliberately outside that description.
- Problem 75 follows the ordinary-localization correction discussed in issue #1.
  This PR does not claim a Lean formalization of the old non-Cohen--Macaulay
  counterexample, or a completed proof of the corrected Cohen--Macaulay criterion.
- Problem 96 is the affine-orbit formulation with every iterate defined away
  from poles. It does not add a projective-line treatment of intermediate infinity
  points. The numerator/denominator degree hypothesis is unchanged.

## Follow-up: declarations, minor statement details and subject metadata

The subsequent [metadata review](METADATA_REVIEW.md) fixes the stale JSON helper
definitions for problems 15 and 45, missing helpers (including 76 and 94), and
the misplaced Stacks attribute in problem 79. Auxiliary declarations are now
extracted and checked against Lean source for all 100 problems.

It also addresses the additional presentation and scope observations, including
the missing `IsDomain` conjunct in 10, the explicit chain bound in 76, and the
positive variable-count witness in 90. Names, spelling and redundant hypotheses
are reviewed separately from the original sixteen mathematical corrections.
Problems 35 and 46 have independent library proofs in `tests/ReviewChecks.lean`;
the custom CM-module predicate in 72 now includes finite generation, with the
scope change and primary-source definition explicitly documented.

All 100 subject assignments are recorded in [TOPIC_INDEX.md](TOPIC_INDEX.md),
generated from the explicit mapping in `scripts/problem_tags.py`. They describe
primary mathematical subjects, not benchmark difficulty. The full per-problem
review and validation limits are in `METADATA_REVIEW.md`.

## Current validation

With Lean 4.28.0 and the dependencies pinned in `lake-manifest.json` available:

```sh
python3 tests/check_statements.py
```

The checker compares all 100 JSON formal statements with the Lean files, verifies
one benchmark proof hole per problem, elaborates all 100 modules and their
aggregate, then checks `tests/StatementCorrections.lean` and the standalone
`tests/Problem86Counterexample.lean` refutation, together with `tests/ReviewChecks.lean`.
It checks JSON auxiliary declarations, theorem docstrings and tags as well as
formal statements, and runs metadata mutation regressions. It uses at most three
concurrent module compilations and writes all logs under `.work/statement-checks/`.

The regression file checks the repaired interfaces with independent proofs and
prints their axiom dependencies. The checker rejects a `sorryAx` dependency in
those regression proofs. Importing a task module does not count as proving that task.

Compilation verifies that the statements are well formed. It does not certify
the full mathematical theorem in each benchmark problem.

The existing PDF is retained as the original edition; the corrected Lean and JSON
are the current statement sources for the changed problems.
