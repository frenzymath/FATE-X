"""Reviewed subject classification for every problem (a primary-topic index).

Tags describe mathematical content, not difficulty or whether Mathlib already
contains a short proof. The groups are explicit so their membership is reviewable.
"""

GROUPS = {
    ("Abstract Algebra", "Group Theory", "Finite Simple Groups and Sylow Theory"): [2, 4, 6, 7, 89],
    ("Abstract Algebra", "Group Theory", "Subgroups, Cosets and Normalizers"): [3, 9],
    ("Abstract Algebra", "Group Theory", "p-Groups and Abelian Subgroups"): [5],
    ("Abstract Algebra", "Group Theory", "Composition Series"): [15],
    ("Abstract Algebra", "Ring Theory", "PID, Euclidean Domains and UFD"): [1, 10, 11, 12, 14, 85, 88],
    ("Abstract Algebra", "Ring Theory", "Quaternion Algebras"): [8],
    ("Abstract Algebra", "Ring Theory", "Noncommutative Rings and Algebras"): [13, 93],
    ("Abstract Algebra", "Field Theory", "Galois Theory"): [16, 18, 19, 21, 24, 25, 27],
    ("Abstract Algebra", "Field Theory", "Infinite Galois Theory"): [17, 26, 28, 29],
    ("Abstract Algebra", "Field Theory", "Inseparable Extensions"): [20],
    ("Abstract Algebra", "Field Theory", "Algebraic Number Theory"): [22, 23],
    ("Commutative Algebra", "Ideal Theory", "Integral Dependence and Integral Closure"): [30, 39, 57],
    ("Commutative Algebra", "Ideal Theory", "Factorization, Dedekind Domains and Class Groups"): [31, 32, 37, 47, 60],
    ("Commutative Algebra", "Ideal Theory", "Noetherian Rings"): [33, 35, 41, 50],
    ("Commutative Algebra", "Ideal Theory", "Valuation Theory"): [34, 59],
    ("Commutative Algebra", "Ideal Theory", "Associated Primes and Support"): [36],
    ("Commutative Algebra", "Module Theory", "Free and Projective Modules"): [38, 40, 45, 55, 84, 100],
    ("Commutative Algebra", "Module Theory", "Flatness and Tensor Products"): [46, 48, 49, 56, 58],
    ("Commutative Algebra", "Local Algebra", "Completions and Power Series"): [42, 51, 62, 67, 82],
    ("Commutative Algebra", "Local Algebra", "Smoothness, Etaleness and Frobenius"): [43, 61, 63],
    ("Commutative Algebra", "Local Algebra", "Cohen-Macaulay and Gorenstein Rings"): [53, 64, 65, 71, 73, 75, 78, 80],
    ("Commutative Algebra", "Local Algebra", "Cohen-Macaulay Modules"): [72],
    ("Commutative Algebra", "Local Algebra", "Regular Sequences and Complete Intersections"): [44, 66, 74, 79, 81],
    ("Commutative Algebra", "Local Algebra", "Regular Local Rings"): [69, 83],
    ("Commutative Algebra", "Ideal Theory", "Jacobson Rings and Radicals"): [52, 68],
    ("Commutative Algebra", "Other Topics", "Derivations"): [54],
    ("Commutative Algebra", "Dimension Theory", "Prime Chains and Catenary Rings"): [70, 76, 77],
    ("Commutative Algebra", "Dimension Theory", "Polynomial Ring Dimensions"): [86, 92],
    ("Commutative Algebra", "Other Topics", "Polynomial Cancellation"): [87],
    ("Commutative Algebra", "Other Topics", "Hilbert's Fourteenth Problem"): [90],
    ("Commutative Algebra", "Other Topics", "Picard Groups"): [91],
    ("Commutative Algebra", "Other Topics", "Algebraic and Arithmetic Dynamics"): [94, 95, 96, 97, 98],
    ("Commutative Algebra", "Other Topics", "Automorphism Groups of Affine Algebras"): [99],
}


def problem_tags():
    result = {}
    for tags, numbers in GROUPS.items():
        for number in numbers:
            assert number not in result, f"Duplicate tag assignment: {number}"
            result[number] = list(tags)
    assert set(result) == set(range(1, 101)), "Tag assignments must cover all 100 problems"
    return result
