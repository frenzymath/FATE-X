import Mathlib

namespace Problem7

/--
Prove that if $\#G = 1785$ then $G$ is not simple.
-/
theorem not_isSimpleGroup_of_card_eq_1785 (G : Type) [Group G]
    [Finite G] (h_card : Nat.card G = 1785) : ¬ IsSimpleGroup G := by
  sorry

end Problem7
