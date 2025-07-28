import Mathlib

/--
Let $A\subset B$ be commutative rings such that $B$ is finitely generated as a module over $A$.
If $B$ is a noetherian ring, show that $A$ is also a noetherian ring.
-/
theorem isNoetherianRing_of_fg_of_isNoetherianRing (B : Type) [CommRing B] [IsNoetherianRing B]
    (A : Subring B) (h : Module.Finite A B) : IsNoetherianRing A := by
  sorry
