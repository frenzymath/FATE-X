import Mathlib

open PowerSeries

/--
If \( R \) is a valuation ring of Krull dimension \( \geq 2 \),
then the formal power series ring \( R[[X]] \) is not integrally closed.-/
theorem powerSeries_not_integrallyClosed_of_two_lt_ringKrullDim (R : Type) [CommRing R]
    [IsDomain R] [ValuationRing R] (two_lt : 2 ≤ ringKrullDim R) :
    ¬ (IsIntegrallyClosed R⟦X⟧) := by
  sorry
