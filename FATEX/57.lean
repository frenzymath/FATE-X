import Mathlib

/--
Let \( A \) be a domain and \( K \) its field of fractions.
\( x \in K \) is called almost integral if there exists an element \( r\in A, r \ne 0 \) such that \( rx^n \in A \) for all \( n \ge 0 \).
-/
def IsAlmostIntegral {A : Type} [CommRing A] [IsDomain A] (x : FractionRing A) : Prop :=
  ∃ r : A, r ≠ 0 ∧ ∀ n : ℕ, ∃ y : A, r • (x ^ n) = algebraMap A (FractionRing A) y

/--
\( A \) is called \textit{completely integrally closed} if every almost integral element of \( K \) is contained in \( A \).
-/
def IsCompletelyIntegrallyClosed (A : Type) [CommRing A] [IsDomain A] : Prop :=
  ∀ x : FractionRing A, IsAlmostIntegral x → ∃ y : A, x = algebraMap A (FractionRing A) y

/--
Let \( A \) be a domain. Show that if \( A \) is completely integrally closed, so is \( A[X] \). -/
theorem completely_integrally_closed_polynomial_ring {A : Type} [CommRing A] [IsDomain A]
    (h : IsCompletelyIntegrallyClosed A) : IsCompletelyIntegrallyClosed (Polynomial A) := by
  sorry
