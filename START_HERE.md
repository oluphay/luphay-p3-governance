# START_HERE

Use this file as the first navigation surface when entering the repository.

## Recommended read order

1. `README.md`
2. `AGENTS.md`
3. `04_docs/REPO_PROFILE.md`
4. `01_governance/standards/STD-SYS-0001__luphay-unified-naming-standard__v0.1.md`
5. `01_governance/framework/STD-REFR-0001__portfolio-program-project-governance-framework__v0.2.md`
6. `01_governance/decisions/ADR-ARCH-0001__canonical-repo-hierarchy-and-navigation-model__v0.1.md`

## First actions

- Read the path declarations in `AGENTS.md`.
- Review the repo profile snapshot in `04_docs/REPO_PROFILE.md`.
- Use `02_templates/` when creating new portfolios, programs, projects, and task packets.
- Use `07_scripts/validate.ps1` before committing structural changes.
- Use `07_scripts/rebuild-state.ps1` after changing `entity.yaml`, `packet.yaml`, or `06_state/inputs/*.yaml`.

## High-value locations

| Path | Why it matters |
| --- | --- |
| `01_governance/` | Source governance library |
| `02_templates/` | Reusable controlled templates |
| `03_portfolios/` | Canonical governed object homes |
| `05_hub/` | Intake, staging, and stable storage |
| `06_state/` | Inputs and derived machine state |
| `07_scripts/` | Validation and rebuild entrypoints |
