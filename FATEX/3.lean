import Mathlib

namespace Problem3

/--
Let $H$ be a subgroup of finite index of a group $G$. Show that there exists a subset $S$ of $G$,
such that $S$ is both a set of representatives of the left and the right cosets of $H$ in $G$.
-/
theorem exists_leftCoset_rightCoset_representative
    (G : Type) [Group G] (H : Subgroup G) [H.FiniteIndex] :
    ∃ S : Set G, Subgroup.IsComplement S H ∧ Subgroup.IsComplement H S := by
  sorry

end Problem3
