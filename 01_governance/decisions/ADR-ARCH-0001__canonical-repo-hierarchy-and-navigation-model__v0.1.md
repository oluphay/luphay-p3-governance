---
id: ADR-ARCH-0001
family: ADR-ARCH
version: 0.1
scope_level: Enterprise
status: accepted
decided_on: 2026-03-29
---

# ADR-ARCH-0001 — Canonical Repo Hierarchy and Navigation Model
## Context

The repository requires a stable, agent-friendly hierarchy that separates governance, execution, state, and operational control surfaces.

## Decision

Adopt the canonical root layout with:

- `01_governance/` as the governance library
- `02_templates/` as the bridge layer
- `03_portfolios/` as the top governed business container
- `06_state/` as the machine-managed state zone
- agent path isolation through `AGENTS.md` and `04_docs/REPO_PROFILE.md`

## Consequences

- Human navigation improves because root folders are numerically ordered.
- Agent navigation remains resilient because paths are declared rather than inferred.
- Derived state can be rebuilt deterministically from object-home YAML plus state inputs.
