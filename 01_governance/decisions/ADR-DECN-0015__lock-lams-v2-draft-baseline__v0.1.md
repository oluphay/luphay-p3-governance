---
id: ADR-DECN-0015
title: Lock LAMS v2 Draft Baseline
status: active
version: v0.1
decision_type: Governance
scope_level: Enterprise
effective_date: 2026-04-14
related_artifacts:
  - STD-PACK-0001
  - STD-SPEC-0006
  - STD-SPEC-0007
  - STD-NORM-0001
  - STD-NORM-0002
created_by: Alpha Kamara
created_at: 2026-04-14
---

# ADR-DECN-0015 — Lock LAMS v2 Draft Baseline
## v0.1

---

## 0. Decision

LAMS v2 is hereby closed for the current iteration at the posture:

**DRAFT baseline locked**

The governed package for this locked baseline is:

- `STD-PACK-0001__lams-v2-specification-package__v0.2.md`

The authoritative package members are:

- `STD-SPEC-0006__luphay-artifact-metadata-standard__v2.0.md`
- `STD-SPEC-0007__lams-graph-and-execution-semantics__v2.0.md`

This decision closes the current draft iteration without claiming implementation proof, production readiness, or ACTIVE promotion.

---

## 1. Context

LAMS v2 reached a coherent two-document specification shape:

- a canonical core specification for the metadata contract and authoring surface
- a companion infrastructure specification for graph compilation and execution semantics

During closure of the draft cycle, two additional governance realities became clear:

1. the prior working package file needed normalization into the new `STD-PACK` class
2. the package and member specifications required a harmonization pass against the current LNS and LES authorities

The current iteration goal is to establish a crisp end-state for the LAMS v2 draft baseline without pretending that implementation validation is complete.

---

## 2. Decision details

### 2.1 Package normalization

The previous working package artifact:

- `lams-v2-specification-package-r2.md`

is superseded by the governed package artifact:

- `STD-PACK-0001__lams-v2-specification-package__v0.2.md`

### 2.2 Locked member set

The current draft baseline is locked to the following authoritative members:

- `STD-SPEC-0006` — canonical LAMS core specification
- `STD-SPEC-0007` — canonical LAMS companion infrastructure specification

No additional LAMS primary specification documents are added in this iteration.

### 2.3 Harmonization scope

The closure pass includes:

- aligning member references to the current LNS authority
- aligning member references to the current LES authority (`STD-NORM-0002` v0.3)
- updating package framing and lock posture

This harmonization does **not** change the technical LAMS v2 baseline, document boundary, or core normative scope.

### 2.4 Explicit non-decision

This ADR does not:

- promote LAMS v2 to ACTIVE
- declare implementation conformance complete
- resolve deferred guidance artifacts
- activate optional execution-awareness surfaces as normative
- close the LES conditional-to-locked transition required at future ACTIVE promotion time

---

## 3. Consequences

### 3.1 Immediate consequences

- the LAMS v2 draft baseline is now considered closed for the current cycle
- future work against LAMS must be treated as follow-on guidance, implementation, or promotion work
- the package wrapper is now governed and properly named under LNS

### 3.2 Governance consequences

- `STD-PACK-0001` becomes the authoritative assembly artifact for the current LAMS v2 draft baseline
- `STD-SPEC-0006` and `STD-SPEC-0007` remain the native authorities for the actual LAMS technical content
- draft closure does not remove the need for future promotion evidence

### 3.3 Risk consequence

The system remains specification-complete for the draft cycle, but not yet implementation-proven. That distinction must remain explicit in future internal and external communication.

---

## 4. Deferred follow-on work

The following items are explicitly deferred beyond this ADR:

| Item | Type | Planned artifact or action |
|---|---|---|
| Graph compilation cadence guidance | Guidance | Future `STD-GUID` |
| LAMS-STUB auto-generation guidance | Guidance | Future `STD-GUID` |
| LES conditional-to-locked transition for LAMS-petitioned codes | Procedural promotion work | LES steward action when `STD-SPEC-0006` moves to ACTIVE |
| Promotion readiness evidence for `STD-SPEC-0006` and `STD-SPEC-0007` | Promotion work | Future validation / conformance package |

---

## 5. Decision rule going forward

Until superseded by a later ADR:

- the current LAMS v2 draft baseline is the locked reference state
- changes that alter package membership, scope, or lock posture require a new governance decision
- changes that only elaborate deferred guidance should land as separate follow-on artifacts and must not silently mutate the meaning of this locked draft baseline

---

## 6. Summary

This ADR closes the LAMS v2 draft iteration cleanly.

It does so by:

- normalizing the package into governed `STD-PACK` form
- locking the authoritative member set
- recording the harmonization pass
- explicitly separating draft closure from future ACTIVE promotion
