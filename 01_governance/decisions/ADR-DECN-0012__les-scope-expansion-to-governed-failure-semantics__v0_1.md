---
id: ADR-DECN-0012
title: LES Scope Expansion to Governed Failure Semantics
status: draft
version: v0.1
decision_type: scope-expansion
steward: Platform Governance / Alpha Kamara
authors:
  - Alpha Kamara
created_at: 2026-04-14
related_artifacts:
  - ADR-DECN-0010
  - ADR-DECN-0011
  - STD-NORM-0002
  - STD-REFR-0008
  - STD-GUID-0003
  - STD-SPEC-0006
  - TASK-CHNG-0001
---

# ADR-DECN-0012 — LES Scope Expansion to Governed Failure Semantics

## 1. Status

**Draft**

This ADR is proposed to authorize the next doctrinal evolution of LES before `STD-NORM-0002` reaches ACTIVE status.

---

## 2. Decision

Luphay Error Standard (LES) is hereby expanded from a narrow error naming and classification standard into the **authoritative Luphay standard for governed failure semantics**.

Effective with the next revision of `STD-NORM-0002`, LES SHALL govern:

1. **error naming**
2. **error classification**
3. **default operational handling semantics**
4. **registry authority and entry lifecycle semantics**
5. **consumer adoption and override boundaries**

`STD-NORM-0002` SHALL become the **authoritative reference** for LES. Related artifacts may elaborate, mirror, or operationalize LES, but they SHALL NOT outrank or redefine the semantics established in `STD-NORM-0002`.

---

## 3. Context

LES was initially framed as the enterprise naming and semantic standard for formally diagnosable abnormal states. That framing was correct for the earliest phase of the work, when the main design objective was to establish a deterministic grammar, controlled taxonomy, and governed code registry.

As LES matured, the standard began to carry not only naming and classification, but also meaningful operational consequence. This is visible in the registry model and in the accepted petition-driven expansion for consuming standards. The v0.2 shape of LES already demonstrates that Luphay systems need more than a static error language; they need a governed language that can also communicate the default handling consequence of a failure.

Maintaining the older, narrower framing would now create structural ambiguity:

- the standard would claim to define only naming and classification while already carrying operational consequence
- the authority boundary between the core standard and related reference artifacts would remain unclear
- consuming standards would be encouraged to interpret, soften, or duplicate failure handling semantics locally
- LES would under-describe the role it is already beginning to play in Luphay's governed systems

This ADR resolves that ambiguity by explicitly recognizing what LES is becoming and authorizing the standard to evolve accordingly.

---

## 4. Problem Statement

Without a formal scope expansion, LES faces five risks:

### 4.1 Scope mismatch
The prose of the standard would describe LES as narrower than its actual use.

### 4.2 Authority ambiguity
The enterprise would lack a clear answer to which artifact owns the final truth for issued LES codes and their handling semantics.

### 4.3 Semantic drift
Consumers could begin treating operational consequence as local implementation detail rather than governed semantics.

### 4.4 Registry fragmentation
Reference artifacts or consuming standards could start behaving like unofficial authorities.

### 4.5 Weak governance posture
LES would name failures but stop short of governing their default consequence, leaving a critical enterprise control surface under-specified.

---

## 5. Rationale

The decision to expand LES is based on the following reasoning.

### 5.1 Naming alone is insufficient
In governed systems, the enterprise does not merely need to know **what failed**. It must also know the **default consequence of that failure** in a way that is stable, communicable, and governable.

### 5.2 Operational semantics are already emerging inside LES
The registry form of LES has already begun to express handling consequence. The correct response is not to suppress that evolution, but to formalize and discipline it.

### 5.3 The core standard should own the truth
If LES semantics are split between a naming standard and a separate, higher-authority operational layer, the system becomes harder to govern and easier to fragment. The core standard should remain the canonical source.

### 5.4 Draft status is the right time to expand
`STD-NORM-0002` is still in draft. This is the appropriate point to widen scope deliberately before the standard reaches ACTIVE status and downstream adoption hardens around an incomplete doctrinal framing.

### 5.5 Luphay needs a governed failure language
Luphay systems are increasingly deterministic, auditable, agentic, and compliance-oriented. Those systems benefit from a shared language that governs both error identity and default operational consequence.

---

## 6. Decision Details

### 6.1 New doctrinal definition of LES
LES SHALL be defined as:

> **The authoritative Luphay standard for governed failure semantics, defining the grammar, taxonomy, registry, and default operational consequences of formally diagnosable failure conditions across Luphay systems.**

### 6.2 Authority rule
`STD-NORM-0002` SHALL be the authoritative LES source.

If any related artifact conflicts with `STD-NORM-0002`, the core standard wins.

### 6.3 Registry rule
The LES registry contained in or governed by `STD-NORM-0002` SHALL be authoritative for:

- issued code identity
- semantic meaning
- registry entry stage
- default handling posture
- deprecation and successor relationships

Related registry artifacts may provide expanded descriptions, examples, or operational lookup views, but they SHALL be derivative.

### 6.4 Scope expansion rule
LES scope now includes:

- naming semantics
- classification semantics
- default handling semantics
- registry lifecycle semantics
- consumer adoption constraints

### 6.5 Consumer constraint rule
Consuming standards MAY adopt LES codes and MAY refine implementation behavior within the boundaries later defined by LES.

Consuming standards SHALL NOT:
- redefine the meaning of a LES code
- declare an alternative enterprise authority for LES semantics
- weaken LES semantics if such weakening is later prohibited by the core standard

### 6.6 Future structural requirement
The next revision of `STD-NORM-0002` SHALL formalize operational semantics through governed fields and rules, rather than leaving them as informal prose alone.

---

## 7. What This ADR Authorizes

This ADR authorizes the following changes in the next LES revision:

1. updating the executive summary, purpose, scope, and principles of `STD-NORM-0002`
2. making `STD-NORM-0002` the authoritative LES reference
3. formalizing default operational handling semantics as part of LES proper
4. formalizing registry entry lifecycle states and transition rules
5. defining precedence and consumer override boundaries
6. aligning related artifacts to the new authority model

---

## 8. What This ADR Does Not Yet Decide

This ADR deliberately does **not** decide the final detailed shape of the following items:

### 8.1 Severity framework
A formal LES severity framework remains deferred.

### 8.2 Event model / execution anchoring
This ADR does not convert LES into an event envelope or ControlRun-bound runtime specification.

### 8.3 Final operational field schema
This ADR authorizes operational semantics but does not yet lock the final field model for representing them.

### 8.4 Consumer override policy detail
This ADR authorizes the need for consumer-boundary rules, but the exact tighten/weaken policy will be defined in the next revision of `STD-NORM-0002`.

### 8.5 Grammar change
No change is authorized to the LES code grammar by this ADR.

---

## 9. Consequences

### 9.1 Positive consequences

- LES becomes doctrinally aligned with how it is actually being used
- the enterprise gets a single authoritative source for failure semantics
- consuming standards are less likely to fork behavior interpretation
- the registry becomes more governable and more operationally useful
- LES becomes a stronger fit for Luphay's compliance, assurance, and agentic systems posture

### 9.2 Costs and responsibilities

- `STD-NORM-0002` must be revised more substantially than a normal minor update
- related artifacts must be reviewed and realigned to the new authority model
- the steward must define clearer rules for lifecycle state, precedence, and override boundaries
- operational semantics must be normalized into governed fields over time

### 9.3 Risk if poorly implemented

If the scope expansion is adopted in doctrine but not translated into formal structure, LES could become bloated, ambiguous, or prose-heavy. The next revision must therefore convert this expansion into disciplined normative structure.

---

## 10. Alternatives Considered

### 10.1 Keep LES as naming/classification only
Rejected.

This would leave the standard misaligned with its emerging registry semantics and push operational consequence into ad hoc downstream interpretation.

### 10.2 Move operational handling semantics into a separate companion standard
Rejected for now.

This would split authority too early and weaken LES as a unified enterprise control surface.

### 10.3 Treat registry handling semantics as merely informative
Rejected.

The current trajectory of LES indicates that handling consequence is part of the governed meaning of failure, not just commentary.

---

## 11. Required Follow-On Work

The following work SHALL follow this ADR:

### 11.1 `STD-NORM-0002` v0.3 revision
Revise the core LES standard to reflect the doctrinal expansion authorized here.

### 11.2 Registry model refactor
Replace informal handling prose with a more structured operational semantics model.

### 11.3 Authority alignment
Update `STD-REFR-0008` and related artifacts so they are clearly derivative of `STD-NORM-0002`.

### 11.4 Petition template update
Update the LES petition template to include any new operational fields required by the expanded scope.

### 11.5 Stewardship update
Expand steward responsibilities to include governance of operational semantics and registry lifecycle transitions.

---

## 12. Acceptance Criteria

This ADR should be considered implemented when all of the following are true:

1. `STD-NORM-0002` explicitly defines LES as a governed failure semantics standard
2. `STD-NORM-0002` is explicitly designated as the authoritative LES reference
3. LES operational handling semantics are formally recognized inside the standard
4. registry authority ambiguity is removed
5. related artifacts are aligned to the new authority model

---

## 13. Decision Summary

LES is no longer treated as only a naming layer.

LES is now authorized to become Luphay's **authoritative governed failure semantics standard**, with `STD-NORM-0002` as its canonical source of truth.

That expansion is deliberate, authorized, and required for the next phase of LES maturation.
