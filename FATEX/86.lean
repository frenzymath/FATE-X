import Mathlib

namespace Problem86

/--
For a one-dimensional commutative ring \( A \),
\( \dim A[x, y] + \dim A \le 2 \dim A[x]\).
-/
theorem dimension_concave (A : Type) [CommRing A] (h : ringKrullDim A = 1) :
    ringKrullDim (MvPolynomial (Fin 2) A) + ringKrullDim A ≤ 2 * ringKrullDim (Polynomial A) := by
  sorry

end Problem86
