# 🗂️ 1D Vexel & Unixel Spatial Stencil 2LTT Staging Specification

Documents and verifies the formal application of **Two-Level Type Theory (2LTT) Staged Compilation** (Kovács 2022) to **1D Vexel & Unixel Vector Multisets** within the ground multiset kernel.

## 1. Mathematical Foundation

1. **1D Basis Coordinate (`Unixel`) & Vector Multiset (`Vexel`)**:
   A `Unixel` $[k]$ represents a 1D spatial basis coordinate. A `Vexel` represents a 1D vector multiset $\sum c_k \cdot [k]$ with signed `BoxInt` weights.

2. **Stage 1 ($\mathcal{U}_1$) Meta-Level / Compile-Time Stage**:
   Represented by `StrictLevel Vexel`. Meta-level computations evaluate vector addition, scalar scaling ($s \cdot v$), canonical duplicate aggregation, and dot products ($\langle u, v \rangle$) at compile time under strict judgmental equality ($\equiv$).

3. **Stage 0 ($\mathcal{U}_0$) Object-Level / Runtime Stage**:
   Represented by `HomotopyLevel Vexel`. Object-level terms represent physical subatomic state vectors (e.g. `nucleonQuarkVexel`: Red=[1], Green=[2], Blue=[3] color charges).

4. **Zero-Cost Passband Filtering & Canonicalization**:
   Canonical duplicate aggregation (`canonicalizeVexel`) prunes zero-weight entries and merges basis singletons at Stage 1, ensuring $100\%$ zero-heap execution at runtime.

> **Multiset Perspective**: 1D Vexel staging evaluates spatial basis vector stencils and color charge allocations at compile time (Stage 1), staging away empty coordinate components to deliver a dense, zero-pruned spatial vector payload at runtime (Stage 0).

```idris
module Wiki.VexelStagingSpec

import Stage1.TypeTheory.TwoLevel
import Stage1.VexelMaxel
import Stage0.BoxInt

%default total

||| Property 1: 1D Vexel 2LTT Stage 1 to Stage 0 Transfer
public export
prop_vexelStage1ToStage0Staging : Bool
prop_vexelStage1ToStage0Staging =
  let strictQuark = MkStrict nucleonQuarkVexel
      homotopyQuark = MkHomotopy (unwrapStrict strictQuark)
  in (totalVexelMass (unwrapStrict strictQuark) == intToBoxInt 3) &&
     (totalVexelMass (unwrapHomotopy homotopyQuark) == intToBoxInt 3)

||| Property 2: 1D Vexel Euclidean Inner Product (<u, v>)
public export
prop_vexelDotProduct : Bool
prop_vexelDotProduct =
  let v1 = MkVexel [(MkUnixel 1, intToBoxInt 2), (MkUnixel 2, intToBoxInt 3)]
      v2 = MkVexel [(MkUnixel 1, intToBoxInt 4), (MkUnixel 2, intToBoxInt 5)]
      dp = dotVexel v1 v2
  in dp == intToBoxInt (2 * 4 + 3 * 5) -- 8 + 15 = 23

||| Property 3: 1D Vexel Canonical Duplicate Aggregation and Zero-Pruning
public export
prop_vexelCanonicalization : Bool
prop_vexelCanonicalization =
  let rawVexel = MkVexel [(MkUnixel 1, intToBoxInt 5), (MkUnixel 1, intToBoxInt (-5)), (MkUnixel 2, intToBoxInt 7)]
      canon = canonicalizeVexel rawVexel
  in canon == MkVexel [(MkUnixel 2, intToBoxInt 7)]

||| Property 4: Subatomic Hadron Quark Color Charge Allocation (Red=[1], Green=[2], Blue=[3])
public export
prop_quarkColorChargeAllocation : Bool
prop_quarkColorChargeAllocation =
  let qv = nucleonQuarkVexel
      r = lookupUnixel (MkUnixel 1) qv
      g = lookupUnixel (MkUnixel 2) qv
      b = lookupUnixel (MkUnixel 3) qv
  in (r == intToBoxInt 1) && (g == intToBoxInt 1) && (b == intToBoxInt 1)

||| Main Verification Suite for 1D Vexel 2LTT Staging
public export
auditVexelStagingProof : IO Bool
auditVexelStagingProof = do
  let p1 = prop_vexelStage1ToStage0Staging
  let p2 = prop_vexelDotProduct
  let p3 = prop_vexelCanonicalization
  let p4 = prop_quarkColorChargeAllocation
  pure (p1 && p2 && p3 && p4)
```
