---
id: STD-SYS-0001
family: STD-SYS
version: 0.1
status: active
effective_on: 2026-03-29
---

# STD-SYS-0001 — Luphay Unified Naming Standard
This standard defines the baseline naming approach used throughout the scaffold.

## Core rules

- Root folders use `NN_` numeric prefixes for human visual orientation only.
- Internal subfolders do **not** use numeric prefixes.
- Governed object identifiers use LNS-aligned families such as `P3-PORT`, `P3-PROG`, `P3-PROJ`, `TASK`, `ADR-ARCH`, `ADR-DECN`, `STD-SYS`, `STD-REFR`, and `STD-TEMP`.
- Primary governing Markdown files use the formula `{ID}__{slug}__vX.Y.md`.
- Companion machine-readable files are named `entity.yaml` or `packet.yaml`.

## Guidance

Use human-friendly slugs, preserve ID stability, and increment versions when governed meaning changes.
