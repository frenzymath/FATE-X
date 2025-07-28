import Mathlib

/--
Let $K/\mathbb{Q}$ be a finite extension.
Let $g$ be a nontrivial element of the absolute Galois group $G(K)$ of $K$.
Show that $g$ admits an infinite number of conjugates.
-/
theorem infinite_conj_of_ne_1_absoluteGaloisGroup (K : Type)
    [Field K] [Algebra ℚ K] [Module.Finite ℚ K] (g : Field.absoluteGaloisGroup K) (h : g ≠ 1) :
    {g' : Field.absoluteGaloisGroup K | IsConj g g'}.Infinite := by
  sorry
