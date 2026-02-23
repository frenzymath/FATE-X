import Mathlib

namespace Problem86

/--
For a commutative ring \( A \), \( dim A[x, y] + dim A \le 2 * dim A[x]\).
-/
theorem dimension_convex (A : Type) [CommRing A] :
    ringKrullDim (MvPolynomial (Fin 2) A) + ringKrullDim A ≤ 2 * ringKrullDim (Polynomial A) := by
  sorry

end Problem86
