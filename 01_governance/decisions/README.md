# Decisions

This folder contains repo-wide and cross-cutting decisions.

## Scope rules

- `ADR-ARCH-*` records architecture decisions.
- `ADR-DECN-*` records durable governance decisions.
- `ADR-DECN` IDs are globally sequential across `Enterprise`, `Portfolio`, `Program`, and `Project` scope levels.
- Scope is recorded in document metadata, not encoded in the ID range.

## Registers

- `decision-register.md` is the human-readable authority index.
- `06_state/registers/decision-register.json` is the machine-facing derived register.
- `exception-register.md` records approved exceptions to naming or governance rules.
