import Mathlib

namespace Problem16

/--
A Galois extension such that the degree of the extension is a power of a prime \( p \) is
called a p-extension.
-/
class IsPExtension (F E : Type) [Field F] [Field E] [Algebra F E]
    (p : ℕ) : Prop extends IsGalois F E where
    rank_eq_pow : ∃ (n : ℕ), Module.rank F E = p ^ n

/--
Let $p$ be a prime and let $F$ be a field.
Let $K$ be a finite Galois extension of $F$ whose Galois group is a $p$-group (i.e., the degree
$[K : F]$ is a power of $p$). Such an extension is called a \emph{$p$-extension} (note that
$p$-extensions are Galois by definition). Let $L$ be a $p$-extension of $K$. Prove that the
Galois closure of $L$ over $F$ is a $p$-extension of $F$.
-/
theorem normalClosure_isPExtension_of_isPExtension (F E : Type) [Field F] [Field E]
    [Algebra F E] (L : IntermediateField F E) (K : IntermediateField F L) (p : ℕ) (hp : p.Prime)
    [IsPExtension F K p] [IsGalois K L] [IsPExtension K L p]
    (h_normalClosure : IsNormalClosure F L E) : IsPExtension F E p := by
  sorry

end Problem16
