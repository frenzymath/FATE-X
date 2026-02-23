import Mathlib

namespace Problem1

/--
Let $R$ be a UFD with two nonassociate prime elements $p$ and $q$ such that every prime
element is an associate of either $p$ or $q$. Prove that $R$ is a PID.
-/
theorem isPrincipalIdealRing_of_associated_or_associated {R : Type} [CommRing R] [IsDomain R]
    [UniqueFactorizationMonoid R] {p q : R} (hp : Prime p) (hq : Prime q) (hpq : ¬ Associated p q)
    (h : ∀ {x : R}, Prime x → Associated x p ∨ Associated x q) :
    IsPrincipalIdealRing R := by
  sorry

end Problem1
