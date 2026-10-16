import Mathlib

namespace Problem68

/--
Let $A$ be a Noetherian local ring with maximal ideal $\mathfrak{m}$.
For any $f\in \mathfrak{m}$, the localization $A_f$ is Jacobson.
If $f$ is nilpotent, this localization is the zero ring, which is also Jacobson.
-/
theorem localization_away_isJacobsonRing_of_mem_maximalIdeal (R : Type) [CommRing R] [IsLocalRing R]
    [IsNoetherianRing R] (f : R) (hf : f ∈ IsLocalRing.maximalIdeal R) :
    IsJacobsonRing (Localization.Away f) := by
  sorry

end Problem68
