# luphay-p3-governance

| Field | Value |
|---|---|
| Repo ID | `luphay-p3-governance` |
| Operator | Alpha — Luphay Technologies |
| Framework | LuAOS / LU-SDD / P3 |
| Naming standard | LNS v0.4 |
| Governance model | ADR-ARCH-0001 |
| Version | v0.4 |
| Status | Active — scaffold complete; MVG tasks in progress |

---

## Purpose

This repository is the canonical governance layer and artifact-memory layer for
the P3 operating model at Luphay Technologies. It houses governance standards,
framework truth, reusable templates, repo-operating truth, and curated governed
artifacts for portfolio, program, project, and task-packet work.

It is not a product build environment. It does not house application source
code, deployment configurations, runtime artifacts, or DRACO kernel objects.

---

## Root folders

| Folder | Purpose |
|---|---|
| `01_governance/` | Governance library — standards, framework, playbooks, and all decisions |
| `02_templates/` | Bridge layer — operationalises governance for agents and humans creating new objects |
| `03_portfolios/` | Canonical governed object homes — currently a committed sample/template scaffold plus any future curated governed artifacts |
| `04_docs/` | Repo-level reference — REPO_PROFILE, architecture, and operating docs |
| `05_hub/` | Near-term local staging — tracked contract READMEs only; working intake/output materials remain local for now |
| `06_state/` | Machine-managed zone — derived registers, dependency graph, audit log; never edited manually |
| `07_scripts/` | Canonical scripts — validate.ps1 and rebuild-state.ps1 |
| `08_command/` | Deferred agentic command surface — not yet active; requires authorising ADR |
| `09_runs/` | Ephemeral runtime outputs — gitignored; agent scratch space |

---

## Quick start

**Human operator:** `START_HERE.md` — onboarding sequence and first-read navigation
order for any human entering the repository.

**Agent worker:** `AGENTS.md` — operating contract, cold-start checklist, and
canonical path declarations for all agent-side work.

**Repo profile:** `04_docs/REPO_PROFILE.md` — machine-readable identity snapshot
and authoritative path registry for this repository.

**Repo baseline:** `04_docs/REPO_BASELINE.md` — the current baseline memo for
sample, canonical-for-now, local-only, and archive-only repo zones.

**Live workflow:** `04_docs/operations/p3-live-workflow.md` — the minimum daily
operator and agent loop for creating, executing, reviewing, and closing work
inside the repo right now.

---

## Repo status

Version v0.4. Scaffold is complete: governance library, control surfaces,
templates, and the example portfolio hierarchy are all in place. The currently
committed portfolio tree is a sample/template scaffold rooted at
`03_portfolios/P3-PORT-0001__human-friendly-title/`.

## Current baseline

- `03_portfolios/P3-PORT-0001__human-friendly-title/` is a sample/template
  hierarchy, not a live production portfolio lane.
- `04_docs/operations/p3-live-workflow.md` is the canonical workflow document
  for now, without implying that a committed live portfolio lane currently
  exists in canon.
- `05_hub/` remains near-term local staging only; only the contract `README.md`
  files are tracked.
- `00_day_one/` is non-canonical incubation or archive-candidate material.
- `99_archive/` is archive-only and not live canon.
