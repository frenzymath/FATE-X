import Mathlib

/--
The field $K = \mathbb{Q}(\sqrt{p_1}, \dots, \sqrt{p_r})$
for a finite list of integers $p_1, \dots, p_r$.
-/
abbrev RatAdjoinSqrt {I : Type} (p : I → ℕ) : Type :=
  Algebra.adjoin ℚ (Set.range (fun i ↦ Real.sqrt (p i)))

/--
Let $p_1, \dots, p_r$ be $r$ different prime numbers.
Prove that the Galois group of $K =\mathbb{Q}(\sqrt{p_1}, \dots, \sqrt{p_r})$ over $\mathbb{Q}$
is $(\mathbb{Z}/2\mathbb{Z})^r$, here $\mathbb{Z}/2\mathbb{Z}$ is the cyclic group of order 2.
-/
theorem galoisGroup_iso_of_distinct_primes {I : Type} [Finite I] (p : I → ℕ)
    (hp : ∀ (i : I), (p i).Prime) (h_inj : p.Injective) :
    Nonempty ((RatAdjoinSqrt p ≃ₐ[ℚ] RatAdjoinSqrt p) ≃* (Multiplicative (I → (ZMod 2)))) := by
  sorry
