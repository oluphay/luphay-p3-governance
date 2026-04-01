# 01_governance/decisions/

## Purpose

This folder is the repo-wide decisions library. It holds Architecture Decision
Records (`ADR-ARCH`) and governance decision records (`ADR-DECN`) scoped at the
Enterprise level — decisions that apply across the entire `luphay-p3-governance`
repo and the P3 operating model.

It also holds the global decision register and the exception register, which
cover all decision scopes.

---

## Scope model

Decisions are scoped by where they apply, not by where they are filed.
`scope_level` in front matter is the authority — not the folder path.

| scope_level | Meaning | Filed in |
|---|---|---|
| `Enterprise` | Applies repo-wide or across all portfolios | `01_governance/decisions/` (this folder) |
| `Portfolio` | Applies to one portfolio and its children | `03_portfolios/P3-PORT-NNNN.../decisions/` |
| `Program` | Applies to one program and its children | `.../programs/P3-PROG-NNNN.../decisions/` |
| `Project` | Applies to one project and its task packets | `.../projects/P3-PROJ-NNNN.../decisions/` |

**Rule:** when in doubt about scope, file at the highest applicable level. A
decision that affects two portfolios is Enterprise-scoped, not Portfolio-scoped.

---

## ID model

### ADR-DECN

`ADR-DECN` IDs are **globally sequential across all scopes**. There is one
sequence — not one sequence per scope level.

- Determine the next ID from `decision-register.md` (column: ID).
- The next ID is the current maximum plus one, regardless of which folder the
  ADR is being filed in.
- Never reuse an ID. Never skip an ID.

Example: if the current maximum `ADR-DECN` ID in the register is `0004`, the
next decision filed anywhere — Enterprise, Portfolio, Program, or Project — is
`ADR-DECN-0005`.

### ADR-ARCH

`ADR-ARCH` IDs are a separate sequence, reserved for architectural decisions
about the repo structure itself (folder hierarchy, navigation model, prefix
conventions, zone contracts). They follow the same sequential rule within their
own sequence.

Current `ADR-ARCH` maximum: `0001` (this repo's founding architecture decision).

---

## Files in this folder

| File | Purpose |
|---|---|
| `README.md` | This file — scope rules, ID model, usage guide |
| `decision-register.md` | Master index of all ADRs across all scopes and families |
| `exception-register.md` | Approved deviations from LNS v0.4 naming rules or P3 structural rules |
| `ADR-ARCH-0001__canonical-repo-hierarchy-and-navigation-model__v0.1.md` | Founding architecture decision — governs v0.4 repo structure |
| `ADR-DECN-0001__...` | Example Enterprise-scoped governance decision (stub) |

---

## How to file a new decision

1. Determine scope level (`Enterprise`, `Portfolio`, `Program`, or `Project`).
2. Determine the correct folder (see scope model table above).
3. Read `decision-register.md` to find the current maximum `ADR-DECN` ID.
4. Increment by one to get the new ID.
5. Create the file using LNS formula:
   `ADR-DECN-[NNNN]__[slug]__v0.1.md`
6. Populate mandatory front matter:

```yaml
---
id: ADR-DECN-[NNNN]
title: ""
version: v0.1
status: draft
decision_type: Governance | Architecture | Operational
scope_level: Enterprise | Portfolio | Program | Project
effective_date: YYYY-MM-DD
related_artifacts: []
supersedes: ~
created_by:
created_at:
---
```

7. Update `decision-register.md` to include the new entry.
8. The register update and the file creation are a single atomic action —
   never create an ADR without updating the register in the same commit.

---

## Exception register

`exception-register.md` records approved deviations from LNS v0.4 naming rules
or P3 structural rules. An exception is not a workaround — it is a governed
deviation with an approval record. Unapproved deviations are naming violations,
not exceptions.

To file an exception: record it in `exception-register.md` with the approver,
date, and expiry (if applicable) before committing the deviant file.

---

*01_governance/decisions/README.md — luphay-p3-governance v0.4*
