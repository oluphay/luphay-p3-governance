# CLAUDE

| Field | Value |
|---|---|
| Repo | luphay-p3-governance |
| Applies to | Claude (claude.ai, Claude Code when acting as advisor) |
| Operator | Alpha — Luphay Technologies |
| Framework | LuAOS / LU-SDD / P3 |
| Last updated | 2026-04-15 |

`AGENTS.md` is the primary shared operating contract for this repo. This file is
the Claude-specific adapter: it should stay thin, point back to shared truth,
and add only the minimum Claude-oriented clarification needed for safe work.

## Claude posture

- Default role: governance advisor, spec producer, and review partner.
- When Claude is asked to write repo artifacts directly, shared repo truth still
  lives in `AGENTS.md`, `04_docs/REPO_PROFILE.md`, and `04_docs/REPO_BASELINE.md`.
- Claude should not duplicate repo law here. If a rule belongs in shared repo
  docs, point to it instead of restating it.

## Repo posture

- This repo is the canonical governance layer and artifact-memory layer for P3.
- It houses governance standards, framework truth, templates, repo-operating
  docs, and curated governed artifacts.
- It is not a product build repo. No application source code, deployment
  configuration, runtime artifacts, or DRACO kernel objects belong here.
- `03_portfolios/P3-PORT-0001__human-friendly-title/` is a sample/template
  hierarchy only.
- `04_docs/operations/p3-live-workflow.md` is canonical for now as the workflow
  reference. Its location may later be optimized or relocated.
- `05_hub/` is near-term local staging only; only the contract `README.md`
  files are tracked.
- `00_day_one/` is non-canonical. `99_archive/` is archive-only.

## Claude-specific working rules

- Read `AGENTS.md` first, then `04_docs/REPO_PROFILE.md`, then
  `04_docs/REPO_BASELINE.md`.
- Escalate structural ambiguity instead of inventing repo truth.
- Keep feedback direct and governance-grounded, but let the shared repo docs
  remain the authority for paths, permissions, and write rules.

## Key references

| File | Path | What it provides |
|---|---|---|
| Shared agent contract | `AGENTS.md` | Operational rules, cold-start sequence, write boundaries |
| Repo profile | `04_docs/REPO_PROFILE.md` | Canonical path registry and machine-oriented snapshot |
| Repo baseline | `04_docs/REPO_BASELINE.md` | Current posture for sample, canonical-for-now, local-only, and archive-only zones |
| Workflow reference | `04_docs/operations/p3-live-workflow.md` | Canonical-for-now workflow guidance |
| Architecture overview | `04_docs/architecture/overview.md` | Structural logic and zone model |
| P3 framework | `01_governance/framework/STD-REFR-0001__portfolio-program-project-governance-framework__v0.2.md` | P3 operating model |
