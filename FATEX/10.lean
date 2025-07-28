import Mathlib

/--
Let \( A = \mathbb{R}[X, Y]/(X^2 + Y^2 + 1) \). Then it is a principal ideal domain. -/
theorem isPrincipalIdealRing_quot_X_pow_two_plus_Y_pow_two_plus_one :
    IsPrincipalIdealRing ((MvPolynomial (Fin 2) ℝ) ⧸
    Ideal.span {(.X 0 ^ 2 + .X 1 ^ 2 + .C 1 : (MvPolynomial (Fin 2) ℝ))}) := by
  sorry
