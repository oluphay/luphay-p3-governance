# START_HERE

Use this file as the first navigation surface when entering the repository.

## Recommended read order

1. `README.md`
2. `AGENTS.md`
3. `04_docs/REPO_PROFILE.md`
4. `04_docs/REPO_BASELINE.md`
5. `04_docs/operations/p3-live-workflow.md`
6. `01_governance/standards/STD-SYS-0001__luphay-unified-naming-standard__v0.1.md`
7. `01_governance/framework/STD-REFR-0001__portfolio-program-project-governance-framework__v0.2.md`
8. `01_governance/decisions/ADR-ARCH-0001__canonical-repo-hierarchy-and-navigation-model__v0.1.md`

## First actions

- Read the path declarations in `AGENTS.md`.
- Review the repo profile snapshot in `04_docs/REPO_PROFILE.md`.
- Review `04_docs/REPO_BASELINE.md` before treating any example hierarchy or
  local staging area as live canon.
- Use `04_docs/operations/p3-live-workflow.md` as the default operating loop for
  current repo workflow truth. Its location may later be optimized or relocated.
- Use `02_templates/` when creating new portfolios, programs, projects, and task packets.
- Use `07_scripts/validate.ps1` before committing structural changes.
- Use `07_scripts/rebuild-state.ps1` after changing `entity.yaml`, `packet.yaml`, or `06_state/inputs/*.yaml`.

## High-value locations

| Path | Why it matters |
| --- | --- |
| `01_governance/` | Source governance library |
| `02_templates/` | Reusable controlled templates |
| `03_portfolios/` | Canonical governed object homes; the committed hierarchy is currently a sample/template scaffold |
| `04_docs/REPO_BASELINE.md` | Current baseline for sample, canonical-for-now, local-only, and archive-only zones |
| `05_hub/` | Near-term local staging and stable storage contract surfaces |
| `06_state/` | Inputs and derived machine state |
| `07_scripts/` | Validation and rebuild entrypoints |
| `03_portfolios/P3-PORT-0001__human-friendly-title/` | Sample/template portfolio hierarchy used as the structural pattern reference |
