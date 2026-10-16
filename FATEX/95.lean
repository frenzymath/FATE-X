import Mathlib

namespace Problem95

open Polynomial Bivariate

/--
Let $f : \mathbb{C}[x, y] \to \mathbb{C}[x, y]$, $x \mapsto p(x) + ay, y \mapsto x$,
where $a \in \mathbb{C}$, $p(x) \in \mathbb{C}[x]$.
-/
noncomputable
def f (a : ℂ) (p : ℂ[X]): ℂ[X][Y] →+* ℂ[X][Y] :=
  eval₂RingHom (aeval (a • Y + C p)).toRingHom (C X)

/--
Let $f : \mathbb{C}[x, y] \to \mathbb{C}[x, y]$, $x \mapsto p(x) + ay, y \mapsto x$,
where $a \in \mathbb{C}$, $a \ne 0$, and $p(x) \in \mathbb{C}[x]$ has degree $>1$. Let $\mathfrak{p}
\subset \mathbb{C}[x, y]$ be a prime ideal. If $\mathrm{height}\ \mathfrak{p} = 1 $, then
$f(\mathfrak{p}) \ne \mathfrak{p}$.
-/
theorem p_map_ne_p (p : ℂ[X]) (h : p.natDegree > 1) {a : ℂ} (ha : a ≠ 0)
    (𝔭 : Ideal ℂ[X][Y]) (h𝔭 : 𝔭.IsPrime) (hheight : 𝔭.height = 1) :
    𝔭.map (f a p) ≠ 𝔭 := by
  sorry

end Problem95
