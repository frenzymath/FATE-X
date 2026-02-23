import Mathlib

namespace Problem25

/--
Prove that the automorphism group of $\mathbb{F}_2(t)$ is isomorphic to $S_3$, and its fixed field is
$\mathbb{F}_2(u)$ with $$u = \frac{(t^4-t)^3}{(t^2-t)^5} = \frac{(t^2+t+1)^3}{(t^2-t)^2}$$.
-/
theorem fixedField_eq_algebra_adjoin :
    Nonempty ((RatFunc (ZMod 2) ≃+* RatFunc (ZMod 2)) ≃* (Equiv.Perm (Fin 3))) ∧
    IntermediateField.fixedField (F := ZMod 2) (E := RatFunc (ZMod 2)) ⊤ =
    IntermediateField.adjoin (ZMod 2) {((.X ^ 4 - .X) ^ 3 / (.X ^ 2 - .X) ^ 5 : (RatFunc (ZMod 2)))} := by
  sorry

end Problem25
