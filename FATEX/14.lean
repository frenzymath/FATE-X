import Mathlib

/--
Show that if $R$ is a unique factorization domain such that the quotient field of $R$ is isomorphic
to $\mathbb{R}$, then R is isomorphic to $\mathbb{R}$.
-/
theorem isomorphic_real_of_fractionRing_isomorphic_real_of_UFD (R : Type) [CommRing R] [IsDomain R]
    [UniqueFactorizationMonoid R] (h : Nonempty ((FractionRing R) ≃+* ℝ)) :
    Nonempty (R ≃+* ℝ) := by
  sorry
