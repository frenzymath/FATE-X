import Mathlib

open Polynomial

/--
Let $F$ be a field and let $f(x) \in F[x]$ be an irreducible polynomial.
Suppose that $K$ is a splitting field for $f(x)$ over $F$ and assume that there exists an element
$\alpha \in K$ such that both $\alpha$ and $\alpha+1$ are roots of $f(x)$.
Prove that there exists an intermediate field $E$ between $K$ and $F$ such that $[K:E]$
is equal to the characteristic of $F$. (In particular, the characteristic of $F$ is not zero)
-/
theorem intermediateField_rank_eq_ringChar (F : Type) [Field F] (f : Polynomial F) (hf : Irreducible f)
    (K : Type) [Field K] [Algebra F K] (hK : f.IsSplittingField F K) (α : K)
    (hα : f.aeval α = 0) (hα1 : f.aeval (α + 1) = 0) :
    ∃ (E : IntermediateField F K), Module.rank E K = ringChar F := by
  sorry
