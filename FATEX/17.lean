import Mathlib

namespace Problem17

/--
Let $K$ be a subfield of $\mathbb{C}$ maximal with respect to the property that $\sqrt 2 \notin K$.
Deduce that $[\mathbb{C} : K]$ is countable (and not finite).
-/
theorem countable_index_of_maximal_subfield_sqrt_2_nmem
    (K : Subfield ℂ) (h_nmem : (Real.sqrt 2 : ℂ) ∉ K)
    (h : ∀ (L : Subfield ℂ), K ≤ L → (Real.sqrt 2 : ℂ) ∉ L → K = L) :
    Module.rank K ℂ = Cardinal.aleph0 := by
  sorry

end Problem17
