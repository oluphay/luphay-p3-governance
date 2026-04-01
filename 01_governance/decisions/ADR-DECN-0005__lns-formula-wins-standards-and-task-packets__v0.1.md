---
id: ADR-DECN-0005
title: LNS Formula Wins for Standards and Task Packets
class: Governance
status: accepted
version: v0.1
decision_type: Governance
scope_level: Enterprise
effective_date: 2026-03-27
related_artifacts:
  - LNS__luphay-naming-standard__v0.4.md
  - ADR-DECN-0004__adopt-lns-as-operational-naming-layer__v0.1.md
supersedes:
created_by: Alpha
created_at: 2026-03-27
---

# ADR-DECN-0005 — LNS Formula Wins for Standards and Task Packets

**Status:** Accepted
**Effective Date:** 2026-03-27
**Scope:** Enterprise

---

## 1. Context

Following the adoption of LNS as the operational naming layer (ADR-DECN-0004), a
secondary question arose about two specific artifact families where the LNS universal
formula produces names that differ from prior conventions:

**Standards (`STD` family):** Prior practice placed framework and template files under
names like `P3-GOV-0001__...` or `P3-TASK-PACKET__template__v0.1.md`. Under LNS,
these become `STD-REFR-0001__...` and `STD-TEMP-0001__...` respectively. The question
was whether to preserve the old `P3-GOV` and `P3-TASK-PACKET` naming for recognizability
or migrate fully to the LNS `STD-*` formula.

**Task packets (`TASK` family):** Prior practice used governing-question class codes
(`DISC`, `CHNG`, `ASSN`, `INCN`, `RELS`) derived from the TPS v2.0 `packet_class` field
as the filename class token. Under LNS, the filename carries a functional class code
(`FEAT`, `FIXE`, `RESR`, `ARCH`, `TEST`, etc.) that describes what the work is actually
doing. The `packet_class` governance field moves to front matter. The question was which
class code space the filename should carry.

---

## 2. Decision

**The LNS universal formula wins in both cases.**

### 2.1 Standards

All framework documents, templates, and reference files previously named under
`P3-GOV-*`, `P3-TASK-PACKET__`, `P3-PROJECT-CARD__`, `P3-PROGRAM-CARD__`, and
`P3-PORTFOLIO-CARD__` patterns SHALL be renamed to the `STD-*` family under LNS:

| Old pattern | New LNS pattern |
|---|---|
| `P3-GOV-0001__[slug]__vX.Y.md` | `STD-REFR-0001__[slug]__vX.Y.md` |
| `P3-TASK-PACKET__template__vX.Y.md` | `STD-TEMP-0001__[slug]__vX.Y.md` |
| `P3-PROJECT-CARD__template__vX.Y.md` | `STD-TEMP-0002__[slug]__vX.Y.md` |
| `P3-PROGRAM-CARD__template__vX.Y.md` | `STD-TEMP-0003__[slug]__vX.Y.md` |
| `P3-PORTFOLIO-CARD__template__vX.Y.md` | `STD-TEMP-0004__[slug]__vX.Y.md` |

Note: P3 hierarchy *identity* documents (`P3-PORT`, `P3-PROG`, `P3-PROJ`) are not
affected by this decision. The `P3` prefix in LNS §9 governs those. This decision
applies only to framework specs, templates, and reference materials.

### 2.2 Task packets

Task packet filenames SHALL carry the **LNS functional class code** (`FEAT`, `FIXE`,
`DEBT`, `RESR`, `ARCH`, `TEST`, `INFR`, `SECU`, `REVN`, `DOCS`, `ADMN`, `DATA`).

The TPS v2.0 `packet_class` field (`Discovery`, `Change`, `Assurance`, `Incident`,
`Release`) SHALL remain in front matter only. It is governance state, not filename
identity.

Both coexist: the filename carries the functional class the operator reasons with
daily; front matter carries the formal governance classification for routing and
compliance purposes.

---

## 3. Rationale

### 3.1 One formula — no exceptions

If LNS is adopted as the operational naming layer (ADR-DECN-0004), carving out
exceptions for specific artifact families immediately creates two naming systems again.
The consolidation benefit of LNS depends on its universal application.

### 3.2 STD-* is more expressive than P3-GOV-*

`P3-GOV-0001` conflates the family prefix with the content subject. `STD-REFR-0001`
correctly identifies the artifact family (Standards) and the class (Reference). This
makes the filename more informative and the family membership more legible to both
operators and agents.

### 3.3 Functional class codes in task filenames improve daily reasoning

Governing-question class codes (`DISC`, `CHNG`) describe how a task is routed through
governance. Functional class codes (`RESR`, `FEAT`, `ARCH`) describe what the work is.
Operators and agents scanning a task list reason from work type first, governance
classification second. The filename should carry the more operationally useful signal.

### 3.4 Front matter is the right home for governance fields

`packet_class`, `governance_mode`, `proof_burden`, and `packet_weight` are routing and
compliance fields consumed by governance tooling. They belong in machine-readable front
matter, not in the filename. Filenames are stable identity tokens; front matter fields
can evolve without renaming files.

---

## 4. Alternatives considered

**Alternative A — Preserve `P3-GOV-*` naming for framework files.**
Rejected. Preserving a separate naming pattern for framework files creates a naming
exception that must be learned and maintained separately. The `STD-*` family covers
the semantic need more precisely.

**Alternative B — Use governing-question class codes in task filenames.**
Rejected. Governing-question codes are governance routing signals, not work-type
identifiers. They belong in front matter where governance tooling can read them.
Functional codes in filenames are more useful to daily operators and scanning agents.

**Alternative C — Allow both class code spaces with operator discretion.**
Rejected. Operator discretion on class code space reintroduces the fragmentation LNS
was designed to eliminate.

---

## 5. Consequences

**Positive:**
- Single naming formula with no family-level exceptions
- Framework files are correctly classified under `STD-*`
- Task filenames are immediately meaningful to operators and agents
- Governance fields are cleanly separated into front matter

**Negative:**
- Existing framework files with `P3-GOV-*` and `P3-TASK-PACKET__` names must be
  renamed — this is a one-time migration cost
- Control surface files (`README.md`, `AGENTS.md`, `START_HERE.md`) that reference
  old framework filenames must be updated in sequence before the rename is executed

**Sequencing constraint:**
The `framework/` rename (`P3-GOV-0001` → `STD-REFR-0001`) MUST be deferred until
control surface files (`README.md`, `AGENTS.md`, `START_HERE.md`) have been updated
to reference the new filename. Executing the rename before updating control surfaces
will produce dead references in agent cold-start paths.

---

## 6. Related decisions

- **ADR-DECN-0004** — Adopt LNS as operational naming layer (parent decision)
- **ADR-ARCH-0001** — Canonical repo hierarchy and navigation model (structural context)

---

*luphay-p3-governance · decisions/ · ADR-DECN-0005*
