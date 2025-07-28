import Mathlib

/--
Let $G$ be a finite group and $L$ a maximal subgroup of $G$. Suppose $L$ is non-Abelian and simple.
Then there exist at most two minimal normal subgroups in $G$.
-/
theorem card_minimal_normal_subgroup_le_2 (G : Type) [Group G] [Finite G]
    (L : Subgroup G) (h_ne_top : L ≠ ⊤) (h_maximal : IsMax (⟨L, h_ne_top⟩ : {H : Subgroup G // H ≠ ⊤}))
    (h_simple : IsSimpleGroup L) (h_non_comm : ∃ (x y : L), x * y ≠ y * x) :
    {H : {H : Subgroup G // H.Normal} | IsMin H}.ncard ≤ 2 := by
  sorry
