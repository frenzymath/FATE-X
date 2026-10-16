import Mathlib

namespace Problem90

/--
Given a field $k$, there exist $n > 0$ and an intermediate field
$k \subseteq K \subseteq k(x_1, \dots, x_n)$ such that
$K \cap k[x_1, \dots, x_n]$ is not a finitely generated $k$-algebra.
-/
theorem not_finiteType_inf_algebraMap_range (k : Type) [Field k] :
    ∃ (n : ℕ), 0 < n ∧ ∃ (K : IntermediateField k (FractionRing (MvPolynomial (Fin n) k))),
    ¬ Algebra.FiniteType k (K.toSubalgebra ⊓ (Algebra.algHom k (MvPolynomial (Fin n) k)
    (FractionRing (MvPolynomial (Fin n) k))).range :
    Subalgebra k (FractionRing (MvPolynomial (Fin n) k))) := by
  sorry

end Problem90
