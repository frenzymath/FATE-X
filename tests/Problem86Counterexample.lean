import Mathlib

namespace V86

/-- Krull dimension of a disjoint sum of preorders is at most the max. -/
lemma krullDim_sum_le {α β : Type*} [Preorder α] [Preorder β] :
    Order.krullDim (α ⊕ β) ≤ max (Order.krullDim α) (Order.krullDim β) := by
  apply iSup_le
  intro l
  have hside : ∀ i, (l i).isLeft = (l 0).isLeft := by
    intro i
    have h0i : l 0 ≤ l i := l.monotone (Fin.zero_le i)
    rcases h0 : l 0 with a | b <;> rcases hi : l i with c | d <;> simp_all
  rcases h : l 0 with a | b
  · let l' : LTSeries α :=
      ⟨l.length, fun i => Sum.elim id (fun _ => a) (l i), fun i => by
        have hs := l.step i
        have h1 := hside i.castSucc
        have h2 := hside i.succ
        rw [h] at h1 h2
        change l i.castSucc < l i.succ at hs
        change Sum.elim id (fun _ => a) (l i.castSucc) < Sum.elim id (fun _ => a) (l i.succ)
        rcases hx : l i.castSucc with x | x <;> rcases hy : l i.succ with y | y <;>
          simp_all⟩
    have := Order.LTSeries.length_le_krullDim l'
    exact le_max_of_le_left this
  · let l' : LTSeries β :=
      ⟨l.length, fun i => Sum.elim (fun _ => b) id (l i), fun i => by
        have hs := l.step i
        have h1 := hside i.castSucc
        have h2 := hside i.succ
        rw [h] at h1 h2
        change l i.castSucc < l i.succ at hs
        change Sum.elim (fun _ => b) id (l i.castSucc) < Sum.elim (fun _ => b) id (l i.succ)
        rcases hx : l i.castSucc with x | x <;> rcases hy : l i.succ with y | y <;>
          simp_all⟩
    have := Order.LTSeries.length_le_krullDim l'
    exact le_max_of_le_right this

/-- A ring that "splits" via two surjections and orthogonal elements has dimension at most
the max of the two pieces. -/
lemma ringKrullDim_le_max_of {T R S : Type*} [CommRing T] [CommRing R] [CommRing S]
    (f : T →+* R) (g : T →+* S) (hf : Function.Surjective f) (hg : Function.Surjective g)
    (e e' : T) (hee' : e * e' = 0) (hfe : f e = 0) (hge' : g e' = 0)
    (hge : g e = 1) (hfe' : f e' = 1)
    (hkf : ∀ x, f x = 0 → x * e = x) (hkg : ∀ x, g x = 0 → x * e' = x) :
    ringKrullDim T ≤ max (ringKrullDim R) (ringKrullDim S) := by
  refine le_trans ?_ (krullDim_sum_le (α := PrimeSpectrum R) (β := PrimeSpectrum S))
  refine Order.krullDim_le_of_strictComono_and_surj
    (Sum.elim (PrimeSpectrum.comap f) (PrimeSpectrum.comap g)) ?_ ?_
  · intro u v huv
    rcases u with p | p <;> rcases v with q | q
    · simp only [Sum.elim_inl] at huv
      rw [Sum.inl_lt_inl_iff]
      rw [← PrimeSpectrum.asIdeal_lt_asIdeal] at huv ⊢
      rw [lt_iff_le_not_ge] at huv ⊢
      simp only [PrimeSpectrum.comap_asIdeal] at huv
      rwa [Ideal.comap_le_comap_iff_of_surjective f hf,
        Ideal.comap_le_comap_iff_of_surjective f hf] at huv
    · exfalso
      simp only [Sum.elim_inl, Sum.elim_inr] at huv
      have h1 : e ∈ (PrimeSpectrum.comap f p).asIdeal := by
        simp [hfe]
      have h2 := huv.le h1
      simp [hge] at h2
      exact q.isPrime.ne_top ((Ideal.eq_top_iff_one _).mpr h2)
    · exfalso
      simp only [Sum.elim_inl, Sum.elim_inr] at huv
      have h1 : e' ∈ (PrimeSpectrum.comap g p).asIdeal := by
        simp [hge']
      have h2 := huv.le h1
      simp [hfe'] at h2
      exact q.isPrime.ne_top ((Ideal.eq_top_iff_one _).mpr h2)
    · simp only [Sum.elim_inr] at huv
      rw [Sum.inr_lt_inr_iff]
      rw [← PrimeSpectrum.asIdeal_lt_asIdeal] at huv ⊢
      rw [lt_iff_le_not_ge] at huv ⊢
      simp only [PrimeSpectrum.comap_asIdeal] at huv
      rwa [Ideal.comap_le_comap_iff_of_surjective g hg,
        Ideal.comap_le_comap_iff_of_surjective g hg] at huv
  · intro P
    have h0 : e * e' ∈ P.asIdeal := by rw [hee']; exact P.asIdeal.zero_mem
    rcases P.isPrime.mem_or_mem h0 with he | he'
    · have hker : RingHom.ker f ≤ P.asIdeal := by
        intro x hx
        rw [RingHom.mem_ker] at hx
        rw [← hkf x hx]
        exact P.asIdeal.mul_mem_left x he
      have hp : (P.asIdeal.map f).IsPrime := Ideal.map_isPrime_of_surjective hf hker
      refine ⟨Sum.inl ⟨P.asIdeal.map f, hp⟩, ?_⟩
      ext1
      simp only [Sum.elim_inl, PrimeSpectrum.comap_asIdeal]
      rw [Ideal.comap_map_of_surjective' f hf]
      exact sup_eq_left.mpr hker
    · have hker : RingHom.ker g ≤ P.asIdeal := by
        intro x hx
        rw [RingHom.mem_ker] at hx
        rw [← hkg x hx]
        exact P.asIdeal.mul_mem_left x he'
      have hp : (P.asIdeal.map g).IsPrime := Ideal.map_isPrime_of_surjective hg hker
      refine ⟨Sum.inr ⟨P.asIdeal.map g, hp⟩, ?_⟩
      ext1
      simp only [Sum.elim_inr, PrimeSpectrum.comap_asIdeal]
      rw [Ideal.comap_map_of_surjective' g hg]
      exact sup_eq_left.mpr hker

/-- dim (R × S)[X] ≤ max (dim R[X]) (dim S[X]). -/
lemma ringKrullDim_polynomial_prod_le (R S : Type*) [CommRing R] [CommRing S] :
    ringKrullDim (Polynomial (R × S)) ≤
      max (ringKrullDim (Polynomial R)) (ringKrullDim (Polynomial S)) := by
  refine ringKrullDim_le_max_of (Polynomial.mapRingHom (RingHom.fst R S))
    (Polynomial.mapRingHom (RingHom.snd R S))
    (Polynomial.map_surjective _ Prod.fst_surjective)
    (Polynomial.map_surjective _ Prod.snd_surjective)
    (Polynomial.C (0, 1)) (Polynomial.C (1, 0)) ?_ ?_ ?_ ?_ ?_ ?_ ?_
  · rw [← Polynomial.C_mul]; show Polynomial.C ((0:R) * 1, (1:S) * 0) = 0; rw [zero_mul, mul_zero, Prod.mk_zero_zero, map_zero]
  · simp
  · simp
  · simp
  · simp
  · intro x hx
    ext n
    · have := congrArg (fun p => Polynomial.coeff p n) hx
      simp at this
      simp [Polynomial.coeff_mul_C, this]
    · simp [Polynomial.coeff_mul_C]
  · intro x hx
    ext n
    · simp [Polynomial.coeff_mul_C]
    · have := congrArg (fun p => Polynomial.coeff p n) hx
      simp at this
      simp [Polynomial.coeff_mul_C, this]

-- sanity check of junk values
example : (2 : WithBot ℕ∞) * ⊤ = ⊤ := by decide
example : (2 : WithBot ℕ∞) * ⊥ = ⊥ := by decide
example : (⊥ : WithBot ℕ∞) + ⊥ = ⊥ := by decide


open PowerSeries

noncomputable section

abbrev Pq : Type := MvPolynomial (Fin 2) ℚ
abbrev L : Type := FractionRing Pq

/-- the embedding ℚ → L -/
def φ : ℚ →+* L := (algebraMap Pq L).comp MvPolynomial.C

lemma φ_inj : Function.Injective φ := φ.injective

def fD : ℚ × PowerSeries L →+* L := φ.comp (RingHom.fst _ _)
def gD : ℚ × PowerSeries L →+* L := (PowerSeries.constantCoeff).comp (RingHom.snd _ _)

/-- D = { (q, f) : φ q = f(0) } ≅ ℚ + t L[[t]] -/
def DD : Subring (ℚ × PowerSeries L) := RingHom.eqLocus fD gD

abbrev D : Type := ↥DD

def c : D →+* ℚ := (RingHom.fst _ _).comp DD.subtype
def ψ : D →+* PowerSeries L := (RingHom.snd _ _).comp DD.subtype

lemma prop (x : D) : φ (c x) = constantCoeff (ψ x) := x.2

def mkD (q : ℚ) (f : PowerSeries L) (h : φ q = constantCoeff f) : D := ⟨(q, f), h⟩

@[simp] lemma c_mkD (q : ℚ) (f : PowerSeries L) (h) : c (mkD q f h) = q := rfl
@[simp] lemma ψ_mkD (q : ℚ) (f : PowerSeries L) (h) : ψ (mkD q f h) = f := rfl

lemma ψ_inj : Function.Injective ψ := by
  intro x y h
  have h1 : c x = c y := φ_inj (by rw [prop, prop, h])
  exact Subtype.ext (Prod.ext h1 h)

instance : IsDomain D := Function.Injective.isDomain ψ ψ_inj

lemma c_surj : Function.Surjective c := fun q => ⟨mkD q (C (φ q)) (by simp), rfl⟩

lemma ker_c_max : (RingHom.ker c).IsMaximal := RingHom.ker_isMaximal_of_surjective c c_surj

lemma unit_of_c_ne_zero (x : D) (hx : c x ≠ 0) : IsUnit x := by
  have hcc : constantCoeff (ψ x) ≠ 0 := by rw [← prop]; exact (map_ne_zero φ).mpr hx
  let y : D := mkD (c x)⁻¹ (ψ x)⁻¹ (by rw [PowerSeries.constantCoeff_inv, map_inv₀, prop])
  refine isUnit_iff_exists_inv.mpr ⟨y, ?_⟩
  apply ψ_inj
  rw [map_mul, map_one]
  exact PowerSeries.mul_inv_cancel _ hcc

instance dimD : Ring.KrullDimLE 1 D := by
  refine Ring.KrullDimLE.mk₁' fun I hI hprime => ?_
  obtain ⟨x, hxI, hx0⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hI
  have hcx : c x = 0 := by
    by_contra h
    exact hprime.ne_top (Ideal.eq_top_of_isUnit_mem I hxI (unit_of_c_ne_zero x h))
  have hψx : ψ x ≠ 0 := fun h => hx0 (ψ_inj (by rw [h, map_zero]))
  set k := (ψ x).order.toNat
  set w := divXPowOrder (ψ x)
  have hw : constantCoeff w ≠ 0 := by
    intro h; exact hψx (constantCoeff_divXPowOrder_eq_zero_iff.mp h)
  have hxw : X ^ k * w = ψ x := X_pow_order_mul_divXPowOrder
  have hle : RingHom.ker c ≤ I := by
    intro m hm
    rw [RingHom.mem_ker] at hm
    have hX : (X : PowerSeries L) ∣ ψ m := by
      rw [X_dvd_iff, ← prop, hm, map_zero]
    obtain ⟨g, hg⟩ := hX
    let z : D := mkD 0 (X * g ^ (k+1) * w⁻¹) (by simp)
    have hmz : m ^ (k+1) = x * z := by
      apply ψ_inj
      rw [map_pow, map_mul, hg]
      change (X * g) ^ (k+1) = ψ x * (X * g ^ (k+1) * w⁻¹)
      rw [← hxw]
      have := PowerSeries.mul_inv_cancel w hw
      calc (X * g) ^ (k+1) = X ^ k * X * g ^ (k+1) * (w * w⁻¹) := by rw [this]; ring
        _ = X ^ k * w * (X * g ^ (k+1) * w⁻¹) := by ring
    exact hprime.mem_of_pow_mem (k+1) (hmz ▸ I.mul_mem_right z hxI)
  exact (ker_c_max.eq_of_le hprime.ne_top hle) ▸ ker_c_max

lemma dimD_le : ringKrullDim D ≤ 1 := Ring.krullDimLE_iff.mp dimD

lemma dimDX_le : ringKrullDim (Polynomial D) ≤ 3 := by
  refine le_trans Polynomial.ringKrullDim_le ?_
  have h := dimD_le
  calc 2 * ringKrullDim D + 1 ≤ 2 * 1 + 1 := by gcongr
    _ = 3 := by norm_num

/-! ### A chain of primes of length 5 in D[X,Y] -/

abbrev DXY : Type := MvPolynomial (Fin 2) D

def u : L := algebraMap Pq L (MvPolynomial.X 0)
def v : L := algebraMap Pq L (MvPolynomial.X 1)

lemma u_ne : u ≠ 0 := by
  intro h
  have := (IsFractionRing.injective Pq L) (h.trans (map_zero _).symm)
  exact MvPolynomial.X_ne_zero _ this

lemma v_ne : v ≠ 0 := by
  intro h
  have := (IsFractionRing.injective Pq L) (h.trans (map_zero _).symm)
  exact MvPolynomial.X_ne_zero _ this

def E0 : DXY →+* MvPolynomial (Fin 2) (PowerSeries L) := MvPolynomial.map ψ
def F01 : MvPolynomial (Fin 2) (PowerSeries L) →+* Polynomial (PowerSeries L) :=
  MvPolynomial.eval₂Hom Polynomial.C ![Polynomial.C (PowerSeries.C u), Polynomial.X]
def E1 : DXY →+* Polynomial (PowerSeries L) := F01.comp E0
def E2 : DXY →+* PowerSeries L := (Polynomial.evalRingHom (PowerSeries.C v)).comp E1
def E3 : DXY →+* MvPolynomial (Fin 2) ℚ := MvPolynomial.map c
def G34 : MvPolynomial (Fin 2) ℚ →+* Polynomial ℚ :=
  MvPolynomial.eval₂Hom Polynomial.C ![0, Polynomial.X]
def E4 : DXY →+* Polynomial ℚ := G34.comp E3
def E5 : DXY →+* ℚ := (Polynomial.evalRingHom 0).comp E4

@[simp] lemma E1_C (d : D) : E1 (MvPolynomial.C d) = Polynomial.C (ψ d) := by
  simp [E1, F01, E0]
@[simp] lemma E1_X0 : E1 (MvPolynomial.X 0) = Polynomial.C (PowerSeries.C u) := by
  simp [E1, F01, E0]
@[simp] lemma E1_X1 : E1 (MvPolynomial.X 1) = Polynomial.X := by
  simp [E1, F01, E0]
@[simp] lemma E2_apply (p : DXY) : E2 p = Polynomial.eval (PowerSeries.C v) (E1 p) := rfl
@[simp] lemma E4_C (d : D) : E4 (MvPolynomial.C d) = Polynomial.C (c d) := by
  simp [E4, G34, E3]
@[simp] lemma E4_X0 : E4 (MvPolynomial.X 0) = 0 := by
  simp [E4, G34, E3]
@[simp] lemma E4_X1 : E4 (MvPolynomial.X 1) = Polynomial.X := by
  simp [E4, G34, E3]
@[simp] lemma E5_apply (p : DXY) : E5 p = Polynomial.eval 0 (E4 p) := rfl

lemma key : (PowerSeries.constantCoeff).comp E2 = (algebraMap Pq L).comp E3 := by
  apply MvPolynomial.ringHom_ext
  · intro d
    simp only [RingHom.comp_apply, E2_apply, E1_C, Polynomial.eval_C, E3, MvPolynomial.map_C]
    rw [← prop]
    rfl
  · intro i
    fin_cases i
    · simp [E3, u]
    · simp [E3, v]

lemma ker_le_of_comp {A B C' : Type*} [CommRing A] [CommRing B] [CommRing C']
    (f : A →+* B) (g : B →+* C') : RingHom.ker f ≤ RingHom.ker (g.comp f) := by
  intro x hx
  rw [RingHom.mem_ker] at hx ⊢
  rw [RingHom.comp_apply, hx, map_zero]

def tD : D := mkD 0 X (by simp)
def tuD : D := mkD 0 (C u * X) (by simp)
def tvD : D := mkD 0 (C v * X) (by simp)

lemma Cmul_ne (a : L) (ha : a ≠ 0) : (C a * X : PowerSeries L) ≠ 0 :=
  mul_ne_zero (fun h => ha (PowerSeries.C_injective (h.trans (map_zero _).symm)))
    PowerSeries.X_ne_zero

lemma lt01 : RingHom.ker E0 < RingHom.ker E1 := by
  rw [SetLike.lt_iff_le_and_exists]
  refine ⟨ker_le_of_comp E0 F01, MvPolynomial.C tD * MvPolynomial.X 0 - MvPolynomial.C tuD,
    ?_, ?_⟩
  · rw [RingHom.mem_ker]
    simp only [map_sub, map_mul, E1_C, E1_X0, tD, tuD, ψ_mkD]
    exact sub_eq_zero.mpr (mul_comm _ _)
  · intro h
    rw [RingHom.mem_ker] at h
    have h2 := congrArg (MvPolynomial.constantCoeff) h
    simp [E0, tD, tuD] at h2
    exact u_ne h2

lemma lt12 : RingHom.ker E1 < RingHom.ker E2 := by
  rw [SetLike.lt_iff_le_and_exists]
  refine ⟨ker_le_of_comp E1 _, MvPolynomial.C tD * MvPolynomial.X 1 - MvPolynomial.C tvD,
    ?_, ?_⟩
  · rw [RingHom.mem_ker]
    simp only [E2_apply, map_sub, map_mul, E1_C, E1_X1, tD, tvD, ψ_mkD, Polynomial.eval_sub,
      Polynomial.eval_mul, Polynomial.eval_C, Polynomial.eval_X]
    rw [mul_comm, sub_self]
  · intro h
    rw [RingHom.mem_ker] at h
    have h2 := congrArg (Polynomial.eval 0) h
    simp [tD, tvD] at h2
    exact v_ne h2

lemma lt23 : RingHom.ker E2 < RingHom.ker E3 := by
  rw [SetLike.lt_iff_le_and_exists]
  refine ⟨?_, MvPolynomial.C tD, ?_, ?_⟩
  · intro x hx
    rw [RingHom.mem_ker] at hx ⊢
    have h := congrArg (fun F => F x) key
    simp only [RingHom.comp_apply, hx, map_zero] at h
    exact IsFractionRing.injective Pq L (h.symm.trans (map_zero _).symm)
  · rw [RingHom.mem_ker]
    simp [E3, tD]
  · intro h
    rw [RingHom.mem_ker] at h
    simp [tD] at h

lemma lt34 : RingHom.ker E3 < RingHom.ker E4 := by
  rw [SetLike.lt_iff_le_and_exists]
  refine ⟨ker_le_of_comp E3 G34, MvPolynomial.X 0, ?_, ?_⟩
  · rw [RingHom.mem_ker]; exact E4_X0
  · intro h
    rw [RingHom.mem_ker] at h
    simp [E3] at h

lemma lt45 : RingHom.ker E4 < RingHom.ker E5 := by
  rw [SetLike.lt_iff_le_and_exists]
  refine ⟨ker_le_of_comp E4 _, MvPolynomial.X 1, ?_, ?_⟩
  · rw [RingHom.mem_ker]; simp
  · intro h
    rw [RingHom.mem_ker] at h
    simp at h

def P0 : PrimeSpectrum DXY := ⟨RingHom.ker E0, RingHom.ker_isPrime E0⟩
def P1 : PrimeSpectrum DXY := ⟨RingHom.ker E1, RingHom.ker_isPrime E1⟩
def P2 : PrimeSpectrum DXY := ⟨RingHom.ker E2, RingHom.ker_isPrime E2⟩
def P3 : PrimeSpectrum DXY := ⟨RingHom.ker E3, RingHom.ker_isPrime E3⟩
def P4 : PrimeSpectrum DXY := ⟨RingHom.ker E4, RingHom.ker_isPrime E4⟩
def P5 : PrimeSpectrum DXY := ⟨RingHom.ker E5, RingHom.ker_isPrime E5⟩

def chain : LTSeries (PrimeSpectrum DXY) :=
  LTSeries.mk 5 ![P0, P1, P2, P3, P4, P5] (by
    refine Fin.strictMono_iff_lt_succ.mpr fun i => ?_
    fin_cases i
    · exact lt01
    · exact lt12
    · exact lt23
    · exact lt34
    · exact lt45)

lemma dimDXY_ge : (5 : WithBot ℕ∞) ≤ ringKrullDim DXY :=
  Order.LTSeries.length_le_krullDim chain

end


open V86 in
/-- Problem 86 as stated is FALSE: its universal statement implies a contradiction. -/
theorem problem86_false :
    ¬ (∀ (A : Type) [CommRing A],
      ringKrullDim (MvPolynomial (Fin 2) A) + ringKrullDim A ≤
        2 * ringKrullDim (Polynomial A)) := by
  intro h
  have hA := h (D × Pq)
  have hPq : ringKrullDim Pq = 2 := by
    rw [MvPolynomial.ringKrullDim_of_isNoetherianRing, ringKrullDim_eq_zero_of_field]
    simp
  have h1 : (2 : WithBot ℕ∞) ≤ ringKrullDim (D × Pq) := by
    have := ringKrullDim_le_of_surjective (RingHom.snd D Pq) Prod.snd_surjective
    rwa [hPq] at this
  have h2 : (5 : WithBot ℕ∞) ≤ ringKrullDim (MvPolynomial (Fin 2) (D × Pq)) :=
    le_trans dimDXY_ge (ringKrullDim_le_of_surjective (MvPolynomial.map (RingHom.fst D Pq))
      (MvPolynomial.map_surjective _ Prod.fst_surjective))
  have h3 : ringKrullDim (Polynomial (D × Pq)) ≤ 3 := by
    refine le_trans (ringKrullDim_polynomial_prod_le D Pq) (max_le dimDX_le ?_)
    rw [Polynomial.ringKrullDim_of_isNoetherianRing, hPq]
    norm_num
  have h7 : (7 : WithBot ℕ∞) ≤ 6 := by
    calc (7 : WithBot ℕ∞) = 5 + 2 := by norm_num
      _ ≤ ringKrullDim (MvPolynomial (Fin 2) (D × Pq)) + ringKrullDim (D × Pq) :=
          add_le_add h2 h1
      _ ≤ 2 * ringKrullDim (Polynomial (D × Pq)) := hA
      _ ≤ 2 * 3 := by gcongr
      _ = 6 := by norm_num
  exact absurd h7 (by decide)

end V86

#print axioms V86.problem86_false
