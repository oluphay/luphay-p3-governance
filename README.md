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

This repository is the canonical P3 governance platform for Luphay Technologies,
governing all portfolio, program, project, and task-packet work across the
organisation. Human operator Alpha and AI agents operating under LU-SDD execute
all work within this repo, each bound by the governing standards and operating
contracts that define their scope. The model is spec-driven: standards define
the rules, templates operationalise them, agents execute the work, and registers
reflect current state.

---

## Root folders

| Folder | Purpose |
|---|---|
| `01_governance/` | Governance library — standards, framework, playbooks, and all decisions |
| `02_templates/` | Bridge layer — operationalises governance for agents and humans creating new objects |
| `03_portfolios/` | Live work — all governed portfolios, programs, projects, and task packets |
| `04_docs/` | Repo-level reference — REPO_PROFILE, architecture, and operating docs |
| `05_hub/` | Controlled surface — intake, staging, and promotion of all new work |
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

---

## Repo status

Version v0.4. Scaffold is complete: governance library, control surfaces,
templates, and the example portfolio hierarchy are all in place. Current phase:
MVG tasks in progress — T01 through T19 are the active content tasks. Next
milestone: all MVG tasks complete and repo validated for production use.
