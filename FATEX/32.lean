import Mathlib

open IsLocalRing

/--
Let \( A \) be a Noetherian local ring such that its completion \( \widehat{A} \) is a unique factorization domain.
Then \( A \) is a unique factorization domain.-/
theorem UFD_of_adicCompletion_UFD (R : Type) [CommRing R] [IsLocalRing R] [IsNoetherianRing R]
    [IsDomain (AdicCompletion (maximalIdeal R) R)]
    [UniqueFactorizationMonoid (AdicCompletion (maximalIdeal R) R)] :
    ∃ (h : IsDomain R), UniqueFactorizationMonoid R := by
  sorry
