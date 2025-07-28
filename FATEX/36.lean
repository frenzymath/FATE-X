import Mathlib

/--
If \( R \) is Noetherian and \( M \) and \( N \) are finitely generated \( R \)-modules, show that
\[
\operatorname{Ass} \operatorname{Hom}_R(M, N) = \operatorname{Supp} M \cap \operatorname{Ass} N,
\]
where \( \operatorname{Supp} M \) is the set of all primes containing the annihilator of \( M \).-/
theorem associatedPrimes_hom_eq_support_inter_associatedPrimes (R : Type) [CommRing R]
    [IsNoetherianRing R] (M N : Type) [AddCommGroup M] [AddCommGroup N] [Module R M] [Module R N]
    [Module.Finite R M] [Module.Finite R N] : associatedPrimes R (M →ₗ[R] N) =
    {p | p ∈ associatedPrimes R N ∧ Module.annihilator R M ≤ p} := by
  sorry
