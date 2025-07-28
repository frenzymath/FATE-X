import Mathlib

open Quaternion

/--
Let $A, B \in \mathbb{Q}^\times$ be rational numbers. Consider the quaternion ring
$$
D_{A, B, \mathbb{R}} = \{a+b\boldsymbol{i} +c\boldsymbol{j}+d\boldsymbol{k}\;|\; a,b,c,d \in
\mathbb{R}\}$$
in which the multiplication satisfies relations: $\boldsymbol{i}^2 = A$, $\boldsymbol{j}^ 2 = B$,
and $\boldsymbol{i}\boldsymbol{j}= -\boldsymbol{j}\boldsymbol{i} = \boldsymbol{k}$.
Show that $D_{A, B, \mathbb{R}}$ is either isomorphic to $\mathbb{H}$ (Hamilton quaternion) or
isomorphic to $\mathrm{Mat}_{2\times 2}(\mathbb{R})$ as $\mathbb{R}$-algebras.
-/
theorem quaternionAlgebra_isomorphic_to_matrix_ring_or_quaternion_ring
    (A B : ℚ) (ha : A ≠ 0) (hb : B ≠ 0) :
    ((Nonempty (ℍ[ℝ, A, B] ≃ₐ[ℝ] ℍ[ℝ, -1, -1])) ∨ (Nonempty (ℍ[ℝ, A, B] ≃ₐ[ℝ] Matrix (Fin 2) (Fin 2) ℝ)))
    ∧ IsEmpty (Matrix (Fin 2) (Fin 2) ℝ ≃ₐ[ℝ] ℍ[ℝ, -1, -1]) := by
  sorry
