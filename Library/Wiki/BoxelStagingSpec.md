# 🗂️ 1D Boxel & BoxInt Additive Cancellation 2LTT Staging Specification

Documents and verifies the formal application of **Two-Level Type Theory (2LTT) Staged Compilation** (Kovács 2022) to **1D Boxel and BoxInt Multiset Scalars** within the ground multiset kernel.

## 1. Mathematical Foundation

1. **Stage 1 ($\mathcal{U}_1$) Meta-Level / Compile-Time Stage**:
   Represented by `StrictLevel (BoxInt)`. Meta-level operations evaluate symbolic multiset addition, scalar multiplication, and Dirac cancellations ($+a \oplus -a = 0$) at compile time under strict judgmental equality ($\equiv$).

2. **Stage 0 ($\mathcal{U}_0$) Object-Level / Runtime Stage**:
   Represented by `HomotopyLevel (BoxInt)`. Object-level terms represent physical capacity budgets, mass payloads, and dark energy boxels ($128$ DE Boxels, $27$ Baryon Maxels, $55$ Dark Matter Laws $\to 210$ Primorial Closure).

3. **Dominant Cancellation Mechanism**:
   **Additive Dirac Cancellation**: $+a + (-a) \to 0$ operates natively under normalization, erasing zero-multiplicity terms from the multiset payload.

> **Multiset Perspective**: 1D Boxel staging evaluates scalar multiset counts and eliminates canceling positive/negative pairs at compile time (Stage 1), leaving only the net physical mass payload at runtime (Stage 0).

```idris
module Wiki.BoxelStagingSpec

import Stage1.TypeTheory.TwoLevel
import Stage0.BoxInt
import Stage0.Multiset

%default total

||| Property 1: 1D Boxel Additive Dirac Cancellation (+137 + -137 == 0)
public export
prop_boxelAdditiveDiracCancellation : Bool
prop_boxelAdditiveDiracCancellation =
  let b1 = intToBoxInt 137
      b2 = intToBoxInt (-137)
      sumB = addBox b1 b2
  in sumB == intToBoxInt 0

||| Property 2: 1D Boxel 2LTT Stage 1 to Stage 0 Transfer
public export
prop_boxelStage1ToStage0Staging : Bool
prop_boxelStage1ToStage0Staging =
  let strictBoxel = MkStrict (intToBoxInt 210)
      homotopyBoxel = MkHomotopy (unwrapStrict strictBoxel)
  in (unwrapStrict strictBoxel == intToBoxInt 210) &&
     (unwrapHomotopy homotopyBoxel == intToBoxInt 210)

||| Property 3: 1D Boxel Monoid Identity and Associativity Laws
public export
prop_boxelMonoidLaws : Bool
prop_boxelMonoidLaws =
  let a = intToBoxInt 128
      b = intToBoxInt 27
      c = intToBoxInt 55
      leftAssoc = boxAdd (boxAdd a b) c
      rightAssoc = boxAdd a (boxAdd b c)
      idLeft = boxAdd (intToBoxInt 0) a
  in (leftAssoc == rightAssoc) && (idLeft == a)

||| Property 4: Primorial 210 Boxel Mass Capacity Closure (27 VM + 128 DE + 55 DM == 210)
public export
prop_boxelPrimorial210Closure : Bool
prop_boxelPrimorial210Closure =
  let vm = intToBoxInt 27
      de = intToBoxInt 128
      dm = intToBoxInt 55
      totalBudget = boxAdd (boxAdd vm de) dm
  in totalBudget == intToBoxInt 210

||| Main Verification Suite for 1D Boxel 2LTT Staging
public export
auditBoxelStagingProof : IO Bool
auditBoxelStagingProof = do
  let p1 = prop_boxelAdditiveDiracCancellation
  let p2 = prop_boxelStage1ToStage0Staging
  let p3 = prop_boxelMonoidLaws
  let p4 = prop_boxelPrimorial210Closure
  pure (p1 && p2 && p3 && p4)
```
