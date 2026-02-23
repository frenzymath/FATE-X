import Mathlib

namespace Problem19

/--
Let $E$ denote the algebra $\mathbb{Q}(\sqrt{(2+\sqrt 2)(3+\sqrt 3)})
-/
abbrev E : Type := (Algebra.adjoin ℚ {Real.sqrt ((2 + Real.sqrt 2) * (3 + Real.sqrt 3))})

/--
Let $\alpha = \sqrt{(2+\sqrt 2)(3+\sqrt 3)}$ and consider the extension $E =\mathbb{Q}(\alpha)$.
Show that $\mathrm{Gal}(E/\mathbb{Q}) \cong Q_8$, the quaternion group of order $8$.
-/
theorem galoisGroup_iso_quaternion_group : Nonempty ((E ≃ₐ[ℚ] E) ≃* (QuaternionGroup 2)) := by
  sorry

end Problem19
