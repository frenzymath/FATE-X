import Mathlib

namespace Problem52

/--
Let $R$ be a commutative ring, let \( \mathfrak{m} \) be an ideal contained in its Jacobson radical,
and \( G_{1}, G_{2} \in R[x] \) are polynomials such that $G_1$ is monic.
If the reductions of $G_1$ and $G_2$ generate the unit ideal of $(R/\mathfrak{m})[x]$,
then \( G_{1}, G_{2} \) together generate the unit ideal of \( R[x] \).
-/
theorem generate_unit_ideal_of_quotient (R : Type) [CommRing R] (m : Ideal R)
    (h_le_jac : m ≤ Ring.jacobson R) (G₁ G₂ : Polynomial R) (h_monic : G₁.Monic)
    (h_gen : Ideal.span {G₁.map (Ideal.Quotient.mk m), G₂.map (Ideal.Quotient.mk m)} = ⊤) :
    Ideal.span {G₁, G₂} = ⊤ := by
  sorry

end Problem52
