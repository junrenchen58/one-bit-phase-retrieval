# MATLAB Codes for  
**One-Bit Phase Retrieval: Optimal Rates and Efficient Algorithms**

**Authors:** Junren Chen, Ming Yuan  
**Paper:** [arXiv:2405.04733](https://arxiv.org/pdf/2405.04733)

This repository contains MATLAB codes to reproduce the numerical experiments and figures in the paper  
*One-Bit Phase Retrieval: Optimal Rates and Efficient Algorithms*.

All scripts are organized by experiment type and figure number for easy reference.

---

## Requirements

- MATLAB R2021a or later (recommended)
- No additional toolboxes are required

---

## Reproducing Figures

### 1. Graphical illustrations for (phaseless) hyperplane tessellation

- `onebcs_embedding.m`  
  → Figure 1 (left)

- `onebpr_embedding.m`  
  → Figure 1 (right)

---

### 2. Phases are non-essential in solving 1-bit linear systems

- `inessential_unstructured.m`  
  → Figure 2 (left)

**Relevant functions:**
- `onebitlinear.m`, `onebitlinear_repe.m`  
  Solve 1-bit linear systems via linear programming
- `GD_albe.m`, `GD_albe_repe.m`  
  Solve 1-bit phase retrieval using Algorithms 1 & 3 in the paper

---

### 3. Phases are non-essential in solving 1-bit compressed sensing

- `inessential_sparse.m`  
  → Figure 2 (right)

**Relevant functions:**
- `onebcs_pgd.m`, `onebcs_pgd_repe.m`  
  NBIHT for 1-bit compressed sensing
- `SPGD_albe.m`, `SPGD_albe_repe.m`  
  Sparse 1-bit phase retrieval using Algorithms 2 & 4

---

### 4. Impact of the threshold parameter $\tau$

- `tau_unstructured.m`  
  → Figure 3 (left)

- `tau_sparse.m`  
  → Figure 3 (right)

---

### 5. Full signal reconstruction over an annulus

- `full_unstructured.m`  
  → Figure 4 (left)

- `full_sparse.m`  
  → Figure 4 (right)

---

### 6. Recovering natural images

- `Realimage_StanfordQuad.m`  
  → Figure 5

- `Realimage_galaxy.m`  
  → Figure 6

- `minverse_decay_stanford.m`  
  → Figure 7

---

## Contact

If you have any questions or encounter issues, please contact:

- **Junren Chen**  
  📧 jchen58@umd.edu  
  📧 chenjr58@connect.hku.hk


## Citation

If you use this code in your work, please cite:

```bibtex
@article{chen2024one,
  title={One-bit phase retrieval: Optimal rates and efficient algorithms},
  author={Chen, Junren and Yuan, Ming},
  journal={arXiv preprint arXiv:2405.04733},
  year={2024}
}











