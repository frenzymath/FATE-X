import Mathlib

namespace Problem5

/--
Let \(p\) be a prime, let \(G\) be a finite p-group. Let A be a maximal normal abelian subgroup
of \(G\). Prove that A is also a maximal abelian subgroup of \(G\).
-/
theorem maximal_abelian_normal_subgroup_of_p_group_is_maximal_abelian_subgroup
    (p : ℕ) (hp : p.Prime) (G : Type) [Group G] [Finite G] (h_pgroup : IsPGroup p G)
    (H : Subgroup G) (h_normal : H.Normal) (h_comm : IsMulCommutative H)
    (h_maximal_normal_abelian : ∀ (K : Subgroup G), K.Normal → IsMulCommutative K → H ≤ K → H = K) :
    ∀ (K : Subgroup G), IsMulCommutative K → H ≤ K → H = K := by
  sorry

end Problem5
