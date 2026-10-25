# FinSc‑Metric‑Substrate Wiki

This repository contains the **verification suite** (wiki) for the `FinSc‑Metric‑Substrate` library. It provides Idris 2 code that checks the mathematical invariants, geometry definitions, and physical laws implemented in the core package.

## Directory layout

- `Library/` – Idris source files that encode the theorems, auditors, and supporting algebra used by the wiki. These are compiled and executed during the *wiki verification phase* of `build‑all.sh`.
- `build/` – Temporary build artefacts produced by the Idris compiler when the wiki is compiled. It is listed in `.gitignore` and can be safely removed.
- `.gitignore` – Prevents generated artefacts (`build/`, `*.ttc`, `*.ttm`, etc.) from being committed.
- `FinSc-Metric-Substrate-Wiki.ipkg` – Idris package descriptor for the wiki.

## Building & verifying

The wiki is verified as part of the overall ecosystem build:
```bash
toolbox run -c fedora-toolbox-44 ./build-all.sh   # Phase 2 runs each "*‑Wiki" package
```
Alternatively, you can build this wiki alone:
```bash
toolbox run -c fedora-toolbox-44 /var/home/justin/.local/bin/idris2 \
  --build FinSc-Metric-Substrate-Wiki/FinSc-Metric-Substrate-Wiki.ipkg
```
If the package contains an executable, the script will automatically run the verification suite after compilation.

## Purpose of the wiki

- **Theorem export** – Generates Lean 4 and Coq artefacts that are used by downstream packages.
- **Invariant auditing** – Uses `%macro` elaborator macros (see `Library/Reflect/SubstrateAuditor.idr`) to enforce compile‑time physical invariants.
- **Regression testing** – Guarantees that changes to the core library do not break established properties.

## Contributing

1. Add new Idris modules under `Library/` for additional theorems or auditors.
2. Ensure any new files are covered by the automated verification step.
3. Run the full build (`build-all.sh`) to confirm the wiki still passes.

---
*This README was generated automatically to give a quick overview of the FinSc‑Metric‑Substrate Wiki.*
