import Mathlib

namespace Problem13

/--
Let $(R,+,\cdot)$ be a (not necessarily commutative) ring.
If we know that $R$ is not a field and $x^2=x$ for any $x\in R,$
where $x$ is not invertible. Prove that $x^2=x$ for any $x.$
-/
theorem sq_eq_self_of_not_unit {R : Type} [Ring R] (h : ¬ IsField R)
    (h2 : ∀ x : R, ¬ IsUnit x → x^2 = x) (x : R) : x^2 = x := by
  sorry

end Problem13
