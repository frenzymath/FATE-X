import Mathlib

/--
Let $R=\mathbb{C}[x_{11},x_{12},\dots,x_{1n},x_{21},x_{22},\dots,
x_{2n},\dots,x_{n1},x_{n2},\dots,x_{nn}]/(\det(x_{ij})-1)$.
-/
abbrev QuotDetSubOne (n : ℕ) : Type := MvPolynomial ((Fin n) × (Fin n)) ℂ ⧸ Ideal.span {
      Matrix.det (fun (i : Fin n) ↦ (fun (j : Fin n) ↦ (.X ⟨i, j⟩ : (MvPolynomial ((Fin n) × (Fin n)) ℂ)))) - .C 1}

/--
Let $R=\mathbb{C}[x_{11},x_{12},\dots,x_{1n},x_{21},x_{22},\dots,
x_{2n},\dots,x_{n1},x_{n2},\dots,x_{nn}]/(\det(x_{ij})-1)$,
show that $R$ is a unique factorization domain.
-/
theorem ufd_quotDetSubOne (n : ℕ) (h : n ≥ 1) : ∃ (h : IsDomain (QuotDetSubOne n)),
    UniqueFactorizationMonoid (QuotDetSubOne n) := by
  sorry
