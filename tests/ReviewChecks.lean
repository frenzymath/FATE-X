import Mathlib

namespace FatexReviewChecks

/-- Problem 35 is exactly Cohen's theorem already present in Mathlib. -/
theorem noetherian_of_prime_ideals_fg (R : Type) [CommRing R]
    (h : ∀ p : Ideal R, p.IsPrime → p.FG) : IsNoetherianRing R :=
  IsNoetherianRing.of_prime h

/-- Problem 46 is a library corollary; no benchmark theorem is used. -/
theorem flat_iff_finite_free_factorization (R M : Type) [CommRing R]
    [AddCommGroup M] [Module R M] :
    Module.Flat R M ↔
    ∀ P : Type, ∀ (_ : AddCommGroup P), ∀ (_ : Module R P), ∀ f : P →ₗ[R] M,
      Module.FinitePresentation R P →
      ∃ (F : Type) (_ : AddCommGroup F) (_ : Module R F),
        Module.Finite R F ∧ Module.Free R F ∧
        ∃ h : P →ₗ[R] F, ∃ g : F →ₗ[R] M, f = g.comp h := by
  constructor
  · intro hflat P _ _ f hP
    letI := hflat
    letI := hP
    obtain ⟨n, h, g, heq⟩ := Module.Flat.exists_factorization_of_isFinitelyPresented f
    exact ⟨Fin n →₀ R, inferInstance, inferInstance, inferInstance, inferInstance, h, g, heq⟩
  · intro H
    apply Module.Flat.of_forall_exists_factorization
    intro l f x hx
    let K : Submodule R (Fin l →₀ R) := Submodule.span R {f}
    have hK : K ≤ LinearMap.ker x := by
      apply Submodule.span_le.mpr
      simpa using hx
    let q := K.mkQ
    haveI : Module.FinitePresentation R ((Fin l →₀ R) ⧸ K) :=
      Module.finitePresentation_of_surjective q K.mkQ_surjective
        (by simpa [q] using Submodule.fg_span_singleton f)
    let z : ((Fin l →₀ R) ⧸ K) →ₗ[R] M := K.liftQ x hK
    obtain ⟨F, _, _, hfin, hfree, h, g, hz⟩ := H _ inferInstance inferInstance z inferInstance
    letI := hfin
    letI := hfree
    let e := ((Module.Free.chooseBasis R F).reindex (Fintype.equivFin _)).repr
    refine ⟨_, e.toLinearMap.comp (h.comp q), g.comp e.symm.toLinearMap, ?_, ?_⟩
    · apply LinearMap.ext
      intro v
      simpa [z, q] using LinearMap.congr_fun hz (q v)
    · have hf : q f = 0 := by
        exact (Submodule.Quotient.mk_eq_zero K).mpr (Submodule.subset_span (by simp))
      simp [hf]

/-- The compatibility premise in the old problem-63 helper is automatic. -/
theorem algebra_square_commutes {R S A : Type} [CommRing R] [CommRing S] [CommRing A]
    [Algebra R S] [Algebra R A] (I : Ideal A) (g : S →ₐ[R] A ⧸ I) :
    g.toRingHom.comp (algebraMap R S) = (Ideal.Quotient.mk I).comp (algebraMap R A) := by
  ext r
  exact g.commutes r

/-- The nilpotent case removed from problem 68 is harmless: the localization is zero. -/
theorem nilpotent_away_isJacobsonRing (R : Type) [CommRing R] (f : R)
    (hf : IsNilpotent f) : IsJacobsonRing (Localization.Away f) := by
  obtain ⟨n, hn⟩ := hf
  haveI : Subsingleton (Localization.Away f) :=
    IsLocalization.subsingleton (M := Submonoid.powers f) (S := Localization.Away f) ⟨n, hn⟩
  infer_instance

/-- The chain bound added to problem 76 is already forced by its dimension hypothesis. -/
theorem prime_chain_length_le_three (R : Type) [CommRing R]
    (hdim : ringKrullDim R ≤ 3) (chain : LTSeries (PrimeSpectrum R)) :
    chain.length ≤ 3 := by
  have h : (chain.length : WithBot ℕ∞) ≤ 3 :=
    le_trans (Order.LTSeries.length_le_krullDim chain) hdim
  exact_mod_cast h

#print axioms noetherian_of_prime_ideals_fg
#print axioms flat_iff_finite_free_factorization
#print axioms algebra_square_commutes
#print axioms nilpotent_away_isJacobsonRing
#print axioms prime_chain_length_le_three

end FatexReviewChecks
