---
id: STD-REFR-0001
family: STD-REFR
version: 0.2
status: active
effective_on: 2026-03-29
---

# STD-REFR-0001 — Portfolio / Program / Project Governance Framework
This framework specifies the canonical business hierarchy and the object-home contract.

## Hierarchy

`Portfolio -> Program -> Project -> Task Packet`

## Home contract

Each governed object home contains:

- one primary human-readable Markdown governing file
- one sibling machine-readable YAML file
- one or more supporting documentation folders or scoped control surfaces

## State contract

- `06_state/inputs/` is human-authored for cross-cutting items not derivable from object homes
- `06_state/registers/`, `06_state/graph/`, and `06_state/audit/` are machine-written
- derived state is rebuilt through `07_scripts/rebuild-state.ps1`

## Decision policy

- `ADR-ARCH-*` captures architecture decisions
- `ADR-DECN-*` captures durable governance decisions
- `ADR-DECN` IDs are globally sequential across scopes
