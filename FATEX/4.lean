import Mathlib

/--
Let $p$ be an odd prime number, and let $G$ be a finite group of order $p(p + 1)$. Assume that $G$
does not have a normal Sylow $p$-subgroup. Prove that $p + 1$ is a power of $2$.
-/
theorem add_one_eq_two_pow_of_sylow_subgroup_not_normal (p : ℕ) (h_odd : Odd p) (G : Type)
    (hp : p.Prime) [Finite G] [Group G] (h_card : Nat.card G = p * (p + 1))
    (h_sylow : ∀ (H : Sylow p G), ¬ H.Normal) : ∃ (n : ℕ), p + 1 = 2 ^ n := by
  sorry
