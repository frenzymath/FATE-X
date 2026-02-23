import Mathlib

namespace Problem27

/--
Let $p$ be a prime number. Let $K/\mathbb{Q}$ be a finite extension, such that the $p^{2}$th
root of unity is contained in $K$. Let $L/K$ be a Galois extension of degree $p$, show that there
exists a Galois extension $L'/L$ of degree $p$, such that the extension $L'/K$ is Galois.
-/
theorem isGalois_and_rank_eq_of_isPrimitiveRoot_sq (p : ℕ) (hp : p.Prime) {K : Type} [Field K]
    [NumberField K] {ζ : K} (h : IsPrimitiveRoot ζ (p^2))
    {L : IntermediateField K (AlgebraicClosure K)} [IsGalois K L]
    (hdeg : Module.rank K L = p) :
    ∃ (L' : Type) (_ : Field L') (_ : Algebra K L')
    (_ : Algebra L L') (_ : IsScalarTower K L L'),
    IsGalois K L' ∧ IsGalois L L' ∧ Module.rank L L' = p := by
  sorry

end Problem27
