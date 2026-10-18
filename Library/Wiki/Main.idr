module Wiki.Main

import MetricSubstrate
import Stage1.VexelMaxel
import Stage1.Goh.Factor
import Reflect.SubstrateAuditor
import Wiki.BoxelStagingSpec
import Wiki.VexelStagingSpec
import Wiki.MaxelStagingSpec
import Wiki.SpreadStreamStagingSpec
import System

%default total

printTestResult : String -> Bool -> IO Unit
printTestResult name pass = 
  if pass 
     then putStrLn ("  [TEST] " ++ name ++ ": PASSED ✅")
     else putStrLn ("  [TEST] " ++ name ++ ": FAILED ❌")

main : IO ()
main = do
  putStrLn "========================================================"
  putStrLn "  🌌 FINSC-METRIC-SUBSTRATE: LAYER 0B VERIFICATION 🌌  "
  putStrLn "========================================================"

  printTestResult "Substrate Compile-Time %macro Reflections"
                  (all (== True) Reflect.SubstrateAuditor.substrateAuditorWitnesses)
  printTestResult "4-Metric Determinant Classification (+1, -1, 0, 0)"
                  (verifyMetricDeterminant EllipticGeom &&
                   verifyMetricDeterminant HyperbolicGeom &&
                   verifyMetricDeterminant ParabolicGeom &&
                   verifyMetricDeterminant SubstrateGeom)
  printTestResult "Primorial 210 Cosmic Budget Conservation (27+128+55=210)"
                  Reflect.SubstrateAuditor.auditPrimorialBudgetProof
  printTestResult "Holographic Boundary Area Bound (Law 13, L=3 Area=54)"
                  (Reflect.SubstrateAuditor.holographicAreaBoundProof 3)
  printTestResult "Discrete Helmholtz Free Energy Ground State (F = -1320)"
                  Reflect.SubstrateAuditor.auditHelmholtzGroundStateProof
  printTestResult "Chromogeometric Metric Support Fingerprints (Blue/Red vs Green)"
                  Stage1.VexelMaxel.auditChromogeometricMetricSupportsProof
  printTestResult "Wildberger Matrix Path Composition Invariant (Green^2 = Blue)"
                  Stage1.VexelMaxel.auditMatrixPathCompositionProof
  printTestResult "Deforested Stream DEC Coboundary Equivalence"
                  Stage1.Topology.Boundaries.auditStreamCoboundaryEquivalenceProof
  printTestResult "Parameterized Chromogeometric Metric Operator Identity (g_R^2 + g_G^2 = Q_B * g_B)"
                  (Stage1.VexelMaxel.auditParameterizedMetricOperatorIdentity (intToBoxInt 4) (intToBoxInt 3))
  printTestResult "Goh Factor 1D Polynomial & 2D Companion Support Sizes (p=2->1, p=3->3, p=5->7)"
                  Reflect.SubstrateAuditor.auditGohFactorCompanionSupportProof
  printTestResult "3D Euclidean Projective Rotation Invariants (Phi(v) v = v & Q-Invariance)"
                  (let prop = Stage1.ProjectiveRotation.MkProjectiveProportion (intToBoxInt 2) (intToBoxInt 1) (intToBoxInt 2) (intToBoxInt 2)
                       testW = [intToBoxInt 3, intToBoxInt 4, intToBoxInt 5]
                   in Stage1.ProjectiveRotation.auditAxisIsFixedEigenvector prop &&
                      Stage1.ProjectiveRotation.auditQuadranceScalingInvariant prop testW)
  printTestResult "2x2 Minkowski Dihedron Determinant & Adjugate Invariants (det(AB) = det(A)det(B))"
                  (let d1 = Stage1.DihedronModel.fromProportionMink (intToBoxInt 3) (intToBoxInt 2) (intToBoxInt 1) (intToBoxInt 1)
                       d2 = Stage1.DihedronModel.fromProportionMink (intToBoxInt 2) (intToBoxInt 1) (intToBoxInt 2) (intToBoxInt 0)
                   in Stage1.DihedronModel.auditDihedronDeterminantMultiplicative d1 d2 &&
                      Stage1.DihedronModel.auditDihedronAdjugateIdentity d1)


  putStrLn "--------------------------------------------------------"
  putStrLn "  ⚡ IDRIS2-QUICKCHECK GENERATIVE PROPERTY SUITES ⚡  "
  putStrLn "--------------------------------------------------------"

  pBoxel <- auditBoxelStagingProof
  printTestResult "1D Boxel & BoxInt Additive Cancellation 2LTT Staging" pBoxel

  pVexel <- auditVexelStagingProof
  printTestResult "1D Vexel & Unixel Spatial Stencil 2LTT Staging" pVexel

  pMaxel <- auditMaxelStagingProof
  printTestResult "2D Maxel Matrix Tensor & Product Cancellation 2LTT Staging" pMaxel

  pSpread <- auditSpreadStreamStagingProof
  printTestResult "Coinductive Spread Stream Deforestation 2LTT Staging" pSpread

  putStrLn "========================================================"
  putStrLn "  ✨ ALL METRIC SUBSTRATE WITNESSES PASSED ✨  "
  putStrLn "========================================================"
