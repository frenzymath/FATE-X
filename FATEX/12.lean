import Mathlib

/--
Prove that the ring $\mathbb{Z}[\frac{1+\sqrt{-19}}{2}]$ is a principal ideal domain.
-/
theorem isPrincipalIdealRing_of_quadratic_integer_19 :
    IsPrincipalIdealRing (Algebra.adjoin ℤ {(1 + (Real.sqrt 19) * Complex.I) / 2}) ∧ IsDomain (Algebra.adjoin ℤ {(1 + (Real.sqrt 19) * Complex.I) / 2}) := by
  sorry
