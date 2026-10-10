# 🗂️ 2D Maxel Matrix Tensor & Product Cancellation 2LTT Staging Specification

Documents and verifies the formal application of **Two-Level Type Theory (2LTT) Staged Compilation** (Kovács 2022) to **2D Maxel Matrix Multisets** within the ground multiset kernel.

## 1. Mathematical Foundation

1. **2D Matrix Coordinate Cell (`Pixel`) & Tensor Multiset (`Maxel`)**:
   A `Pixel` $[i, j]$ represents a 2D coordinate cell or matrix entry. A `Maxel` represents a 2D matrix multiset $\sum a_{ij} \cdot [i, j]$ carrying signed `BoxInt` weights.

2. **Stage 1 ($\mathcal{U}_1$) Meta-Level / Compile-Time Stage**:
   Represented by `StrictLevel Maxel`. Meta-level operations evaluate matrix multiplication ($M_1 \times M_2$), composition ($T_2 \circ T_1$), Grassmann wedge products ($u \wedge v$), and commutator differences ($[T_1, T_2]$) at compile time under strict judgmental equality ($\equiv$).

3. **Stage 0 ($\mathcal{U}_0$) Object-Level / Runtime Stage**:
   Represented by `HomotopyLevel Maxel`. Object-level terms represent physical metric tensor fields ($g_{ij}$), 2-form electromagnetic curvature fields ($E, B$), and molecular covalent bond structures (`waterMoleculeBonds`).

4. **Dominant Cancellation Mechanism**:
   **Product & Tensor Cancellation**: Matrix multiplication $[i, j] \times [k, l]$ yields $[i, l]$ if $j = k$, and vanishes ($0$) if $j \neq k$. Non-aligned pixel channels collapse to zero during compile-time matrix staging.

> **Multiset Perspective**: 2D Maxel staging evaluates tensor products and matrix compositions at compile time (Stage 1). Unaligned coordinate channels cancel to zero naturally during multiplication, producing a minimal deforested metric field payload at runtime (Stage 0).

```idris
module Wiki.MaxelStagingSpec

import Stage1.TypeTheory.TwoLevel
import Stage1.VexelMaxel
import Stage0.BoxInt

%default total

||| Property 1: 2D Maxel 2LTT Stage 1 to Stage 0 Transfer
public export
prop_maxelStage1ToStage0Staging : Bool
prop_maxelStage1ToStage0Staging =
  let strictBonds = MkStrict waterMoleculeBonds
      homotopyBonds = MkHomotopy (unwrapStrict strictBonds)
  in (totalMaxelWeight (unwrapStrict strictBonds) == intToBoxInt 2) &&
     (totalMaxelWeight (unwrapHomotopy homotopyBonds) == intToBoxInt 2)

||| Property 2: 2D Maxel Product Cancellation ([1, 2] * [3, 4] == empty, [1, 2] * [2, 3] == [1, 3])
public export
prop_maxelProductCancellation : Bool
prop_maxelProductCancellation =
  let m1 = MkMaxel [(MkPixel 1 2, intToBoxInt 3)]
      m2 = MkMaxel [(MkPixel 3 4, intToBoxInt 5)]
      m3 = MkMaxel [(MkPixel 2 3, intToBoxInt 5)]
      unalignedProd = mulMaxel m1 m2
      alignedProd   = mulMaxel m1 m3
  in (unalignedProd == MkMaxel []) &&
     (alignedProd == MkMaxel [(MkPixel 1 3, intToBoxInt 15)])

||| Property 3: 2D Maxel Outer Product (Ket x Bra) & Row Vector Extraction
public export
prop_maxelOuterProductAndRowExtraction : Bool
prop_maxelOuterProductAndRowExtraction =
  let v1 = MkVexel [(MkUnixel 1, intToBoxInt 2), (MkUnixel 2, intToBoxInt 3)]
      v2 = MkVexel [(MkUnixel 1, intToBoxInt 1), (MkUnixel 2, intToBoxInt 4)]
      m = outerProductVexel v1 v2
      row1 = extractRowVexel 1 m
  in row1 == MkVexel [(MkUnixel 1, intToBoxInt 2), (MkUnixel 2, intToBoxInt 8)]

||| Property 4: Grassmann Exterior Wedge Product Nilpotency (v ^ v == 0)
public export
prop_maxelGrassmannWedgeNilpotency : Bool
prop_maxelGrassmannWedgeNilpotency =
  auditWedgeNilpotencyProof

||| Main Verification Suite for 2D Maxel 2LTT Staging
public export
auditMaxelStagingProof : IO Bool
auditMaxelStagingProof = do
  let p1 = prop_maxelStage1ToStage0Staging
  let p2 = prop_maxelProductCancellation
  let p3 = prop_maxelOuterProductAndRowExtraction
  let p4 = prop_maxelGrassmannWedgeNilpotency
  pure (p1 && p2 && p3 && p4)
```
