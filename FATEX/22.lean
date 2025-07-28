import Mathlib

/--
Let $F$ be a field with $\mathbb{Q} \subseteq F \subseteq \mathbb{C}$, where $F/\mathbb{Q}$
is a finite \emph{abelian} Galois extension. Prove that $F$ contains only finitely many algebraic integers
(i.e. elements in $F$ whose minimal polynomial over $\mathbb{Q}$ have coefficients in $\mathbb{Z}$) having absolute value $1$,
and each of the algebraic integers is a root of unity.
-/
theorem finite_algebraic_integers_of_finite_module
    (F : IntermediateField ℚ ℂ) (h_fin : Module.Finite ℚ F) [IsGalois ℚ F]
    (h : IsMulCommutative (F ≃ₐ[ℚ] F)) : {x : F | IsIntegral ℤ x ∧ ‖(x : ℂ)‖ = 1}.Finite ∧
    (∀ x : F, IsIntegral ℤ x → ‖(x : ℂ)‖ = 1 → ∃ n,  x ^ n = 1) := by
  sorry
