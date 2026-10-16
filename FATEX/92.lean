import Mathlib

namespace Problem92

/--
\(a_n = 2n+1\) if \(n \le k\), and \(a_n = n + k + 1\) otherwise,
for some \(k \in \mathbb{N} \cup \{+\infty\}\).
-/
def a (k : ℕ∞) (n : ℕ) :=
  if h : n ≤ k then 2 * n + 1
  else n + WithTop.untop k (by rintro rfl; exact h le_top) + 1

/--
Let $A$ be a commutative ring with identity, $\dim A = 1$.
Then all possible sequences \(a_n = \dim A[x_1, \ldots, x_n]\), for \(n \in \mathbb{N}\), are exactly
the sequences of the form: \(a_n = 2n+1\) if \(n \le k\) else \(a_n = n + k + 1\), for some
\(k \in \mathbb{N} \cup \{+\infty\}\).
-/
theorem dimension_sequences_of_one_dimensional_rings :
    (∀ (A : Type) [CommRing A] (h : ringKrullDim A = 1),
      ∃ (k : ℕ∞), (∀ (n : ℕ), ringKrullDim (MvPolynomial (Fin n) A) = a k n)) ∧
    (∀ (k : ℕ∞), ∃ (A : Type) (_ : CommRing A) (h : ringKrullDim A = 1),
      (∀ (n : ℕ), ringKrullDim (MvPolynomial (Fin n) A) = a k n)):= by
  sorry

end Problem92
