import Mathlib

/--
A subgroup `H₁` is a maximal normal subgroup of `H₂` if it is contained in `H₂`,
and `H₁` is maximal normal in `H₂`.
-/
structure Subgroup.IsMaximalNormal {G : Type} [Group G] (H₁ H₂ : Subgroup G) : Prop where
  le : H₁ ≤ H₂
  subgroupOf_normal : (H₁.subgroupOf H₂).Normal
  is_maximal : ∀ H : Subgroup G, H₁ ≤ H → H ≤ H₂ → (H.subgroupOf H₂).Normal → (H = H₁ ∨ H = H₂)

/--
A normal subgroup composition series of a group `G` is a *maximal* finite chain of normal subgroups
\[
\{e\} = G_0 \triangleleft G_1 \triangleleft \cdots \triangleleft G_n = G
\]
such that each quotient `G_{i+1}/G_i` is a simple group.
-/
structure NormalSubgroupCompositionSeries (G : Type) [Group G] : Type where
  toRelSeries : RelSeries (Subgroup.IsMaximalNormal (G := G))
  maximal : ∀ s : RelSeries (Subgroup.IsMaximalNormal (G := G)), s.length ≤ toRelSeries.length

/--
The \(i\)-th factor of a normal subgroup composition series, which is the quotient of the \(i + 1\)-th
subgroup by the previous one.
-/
def StepwiseQuotient {G : Type} [Group G] (s : NormalSubgroupCompositionSeries G) (i : Fin s.toRelSeries.length) :
    Type :=
  s.toRelSeries i.succ ⧸ (s.toRelSeries i.castSucc).subgroupOf _

/--
The \(i\)-th factor of a normal subgroup composition series is a group.
-/
instance {G : Type} [Group G] (s : NormalSubgroupCompositionSeries G) (i : Fin s.toRelSeries.length) :
    Group (StepwiseQuotient s i) := QuotientGroup.Quotient.group _ (nN := (s.toRelSeries.step i).subgroupOf_normal)

/--
Let $p,q,r$ be three distinct prime numbers, $t$ a positive integer. Let $G$ be a finite group,
$H$ a normal subgroup of $G$ such that the cardinality of $G/H$ is $r^{t}$.
Suppose that there exists a composition series
\[
\{e\} = H_0 \triangleleft H_1 \triangleleft \cdots \triangleleft H_n = H,
\]
of $H$ that satisfies $n=2$, $H_1/H_0 = \mathbb{Z}/p\mathbb{Z}$,
$H_2/H_1 = \mathbb{Z}/q\mathbb{Z}$. Further suppose that there exists a composition series
\[
\{e\} = G_0 \triangleleft G_1 \triangleleft \cdots \triangleleft G_n = G,
\]
and positive integers $i < j\leq n$ such that $G_{i}/G_{i-1} = \mathbb{Z}/q\mathbb{Z}$,
$G_{j}/G_{j-1} = \mathbb{Z}/p\mathbb{Z}$. Show that there exists a composition series
\[
\{e\} = H_0 \triangleleft H_1 \triangleleft \cdots \triangleleft H_n = H,
\]
of $H$ that satisfies $n=2$, $H_1/H_0 = \mathbb{Z}/q\mathbb{Z}$,
$H_2/H_1 = \mathbb{Z}/p\mathbb{Z}$.
-/
theorem exists_swap_stepwiseQuotient {p q r t : ℕ} (hp : p.Prime) (hq : q.Prime) (hr : r.Prime)
    (ht : 0 < t) (G : Type) [Group G] [Fintype G] (H : Subgroup G) [H.Normal]
    (hH : Nat.card (G ⧸ H) = r ^ t) (Hs : NormalSubgroupCompositionSeries H)
    (hHs: Hs.toRelSeries.length = 2) (hHs0 : StepwiseQuotient Hs ⟨0, by omega⟩ ≃* ZMod p)
    (hHs1 : StepwiseQuotient Hs ⟨1, by omega⟩ ≃* ZMod q)
    (Gs : NormalSubgroupCompositionSeries G) (i j : Fin Gs.toRelSeries.length) (hij : i < j)
    (hGi : StepwiseQuotient Gs i ≃* ZMod q) (hGj : StepwiseQuotient Gs j ≃* ZMod p) :
    ∃ (Hs' : NormalSubgroupCompositionSeries H) (hlen : Hs'.toRelSeries.length = 2),
    Nonempty (StepwiseQuotient Hs' ⟨0, by omega⟩  ≃* ZMod q) ∧
    Nonempty (StepwiseQuotient Hs' ⟨1, by omega⟩  ≃* ZMod p) := by
  sorry
