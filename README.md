# FATE-X  
The **FATE-X (Formal Algebra Theorem Evaluation - Extra Hard)** benchmark.  

## Overview  
This benchmark contains 100 extremely challenging abstract algebra and commutative algebra exercises collected from:  
- Undergraduate and graduate textbooks,  
- Final exams and PhD qualifying exams,  
- Research literature.  

All exercises are formalized in Lean. For a complete list of exercises in both natural language and Lean code, please refer to the file **FATE-X.pdf**.

For users' convenience, we provide a JSON file (**FATE-X.json**) where each entry represents a problem and includes the following information:  
- Problem ID,  
- Formal statement (Lean code),  
- Natural language statement,  
- Benchmark source (FATE-X),  
- Tags indicating its mathematical field. 

## Benchmark Structure  
Each Lean file consists of a single exercise, containing:  
- One fully formalized statement,  
- A single `sorry`,  
- Appropriate open namespaces at the beginning, 
- Minimal dependent definitions formalized before the statement,  
- Natural language annotations preceding the statement. 

## Problem Distribution

<figure>
  <img src="https://raw.githubusercontent.com/frenzymath/FATE-X/main/assets/FATE-X-sunburst.svg" width="600" alt="Mathematical Categorical Distribution of FATE-X">
  <figcaption>
    Figure 1. Mathematical Categorical Distribution of FATE-X
  </figcaption>
</figure>

## Lean Toolchain
The initial version of this benchmark uses `leanprover/lean4:v4.19.0`. For each supported minor version of Lean, a corresponding and updated iteration of the benchmark is available via the repository's tags.