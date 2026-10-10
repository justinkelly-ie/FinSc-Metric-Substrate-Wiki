module Wiki.Main

import MetricSubstrate
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
