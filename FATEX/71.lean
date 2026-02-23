import Mathlib

namespace Problem71

section

variable (A B : Type) [CommRing A] [CommRing B] [Algebra A B]
variable (G : Type) [Monoid G] [MulSemiringAction G B] [SMulCommClass G A B]

/--
The set of fixed points under a group action, as a subring.
-/
def FixedPoints.subring : Subring B where
  __ := FixedPoints.addSubgroup G B
  __ := FixedPoints.submonoid G B

/--
The set of fixed points under a group action, as a subalgebra.
-/
def FixedPoints.subalgebra : Subalgebra A B where
  __ := FixedPoints.addSubgroup G B
  __ := FixedPoints.submonoid G B
  algebraMap_mem' r := by simp

end

section

open CategoryTheory Abelian Problem71

variable {R : Type} [CommRing R]

instance : CategoryTheory.HasExt.{0} (ModuleCat.{0} R) :=
  CategoryTheory.hasExt_of_enoughProjectives (ModuleCat R)

noncomputable def moduleDepth (N M : ModuleCat.{0} R) : ℕ∞ :=
  sSup {n : ℕ∞ | ∀ i : ℕ, i < n → Subsingleton (CategoryTheory.Abelian.Ext.{0} N M i)}

noncomputable def Ideal.depth (I : Ideal R) (M : ModuleCat.{0} R) : ℕ∞ :=
  moduleDepth (ModuleCat.of R (R ⧸ I)) M

noncomputable def IsLocalRing.depth [IsLocalRing R] (M : ModuleCat.{0} R) : ℕ∞ :=
  (IsLocalRing.maximalIdeal R).depth M

variable (R)

class IsCohenMacaulayLocalRing : Prop extends IsLocalRing R where
  depth_eq_dim : ringKrullDim R = IsLocalRing.depth (ModuleCat.of R R)

class IsCohenMacaulayRing : Prop where
  CM_localize : ∀ p : Ideal R, ∀ (_ : p.IsPrime), IsCohenMacaulayLocalRing (Localization.AtPrime p)

end

/--
Let \( G \) be a finite group acting as automorphisms of an algebra \( R \) over a field of
characteristic \( 0 \). Show that if \( R \) is Cohen-Macaulay, then the ring of invariants
\( R^G \) is Cohen-Macaulay.
-/
theorem fixedPoints_isCohenMacaulayRing {R : Type} [CommRing R] (k : Type) [Field k]
    [CharZero k] [Algebra k R] [IsNoetherianRing R] [IsCohenMacaulayRing R]
    (G : Subgroup (R ≃ₐ[k] R)) [Finite G] :
    IsCohenMacaulayRing (FixedPoints.subalgebra k R G) := by
  sorry

end Problem71
