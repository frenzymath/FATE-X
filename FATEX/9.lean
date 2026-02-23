import Mathlib

namespace Problem9

/--
Let $G$ be a finite group and let $\mathrm{Syl}_p(G)$ denote its set of Sylow $p$-subgroups.
Suppose that $S$ and $T$ are distinct members of
$\mathrm{Syl}_p(G)$ chosen so that $\#(S \cap T)$ is maximal
among all such intersections. Prove that the normalizer $N_G(S \cap  T)$ does not admit normal
Sylow $p$-subgroup.
-/
theorem sylow_subgroup_not_normal_of_maximal_intersection (G : Type) [Finite G] [Group G]
    (p : ℕ) [Fact (Nat.Prime p)] (S T : Sylow p G) (h_ne : S ≠ T)
    (h_maximal : ∀ (S' T' : Sylow p G), S' ≠ T' →
    ((S' : Set G) ⊓ T').ncard ≤ ((S : Set G) ⊓ T).ncard) :
    ∀ (P : Sylow p ((S : Subgroup G) ⊓ T).normalizer), ¬ P.Normal := by
  sorry

end Problem9
