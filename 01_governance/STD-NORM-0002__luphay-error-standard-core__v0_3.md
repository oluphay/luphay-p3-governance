---
id: STD-NORM-0002
title: Luphay Error Standard (LES) — Core Specification
status: draft
version: v0.3
steward: Platform Governance / Alpha Kamara
decision_basis:
  - ADR-DECN-0010
  - ADR-DECN-0012
related_artifacts:
  - ADR-DECN-0011
  - STD-NORM-0001
  - STD-REFR-0007
  - STD-REFR-0008
  - STD-GUID-0003
  - STD-TEMP-XXXX
  - STD-SPEC-0006
  - TASK-CHNG-0001
petitions_accepted:
  - TASK-CHNG-0001
created_by: Alpha Kamara
created_at: 2026-04-12
updated_at: 2026-04-14
---

# STD-NORM-0002 — Luphay Error Standard (LES)
## Core Specification v0.3

---

## Changelog

### v0.3 — 2026-04-14
- Scope doctrinally expanded per `ADR-DECN-0012` from error naming/classification to governed failure semantics.
- `STD-NORM-0002` designated the authoritative LES reference.
- Executive summary, purpose, scope, governing principles, authoring rules, and petition process updated to reflect operational semantics.
- New §10 Operational Semantics Model added.
- New §11 Precedence and Consumer Override Rules added.
- New §12 Registry Entry Lifecycle added.
- Registry refactored from the narrow `Agent behavior` field to structured operational fields: `Baseline handling`, `Escalation handling`, `Escalation condition`, `Action profile`, and `Override posture`.
- `STD-REFR-0008` re-scoped as a derivative companion catalog rather than the authoritative LES source.
- No LES code grammar changes.
- No family taxonomy changes.
- No new LES codes added in v0.3.

### v0.2 — 2026-04-13
- Registry expansion: 12 new codes accepted via petition `TASK-CHNG-0001` (petitioning standard: `STD-SPEC-0006`, LAMS v2.0.0). Acceptance status: CONDITIONALLY ACCEPTED pending `STD-SPEC-0006` reaching ACTIVE.
- Domain 1 additions: `LES__IDENTITY__INVALID__ARTIFACT-ID`, `LES__IDENTITY__DUPLICATE__ARTIFACT-ID`, `LES__LIFECYCLE__PREMATURE__STATUS-TRANSITION`, `LES__LIFECYCLE__INVALID__STATUS-TRANSITION`.
- Domain 4 additions: `LES__INTEGRITY__MISSING__CONTENT-HASH`.
- First entries in INVARIANT family: `LES__INVARIANT__VIOLATION__HARD-CONSTRAINT`, `LES__INVARIANT__VIOLATION__DESIGN-INVARIANT`.
- First entries in TRACEABILITY family: `LES__TRACEABILITY__MISSING__CONSUMER-LINK`, `LES__TRACEABILITY__MISSING__OUTPUT-LINK`, `LES__TRACEABILITY__INCOMPLETE__CONFORMANCE-CLAIM`, `LES__TRACEABILITY__BROKEN__DEPENDENCY-LINK`, `LES__TRACEABILITY__UNLINKED__ARTIFACT`.
- `STD-SPEC-0006` added to Related Artifacts (§14).
- No grammar, taxonomy, or structural changes. No new families. No new categories outside preferred bands.

### v0.1 — 2026-04-12
- Initial specification. Grammar locked per `ADR-DECN-0010` v0.2. Autonomy posture established per `ADR-DECN-0010` v0.3. Taxonomy, assignment rules, and boundary rules derived from WBS-01.3 v0.2 (locked). Seed registry derived from WBS-01.4 v0.2. Consumer petition process derived from `ADR-DECN-0010` §5.8.

---

## 0. Executive Summary

The **Luphay Error Standard (LES)** is the authoritative Luphay standard for **governed failure semantics** across Luphay systems.

LES provides a common, grep-friendly, machine-readable, and human-legible language for formally diagnosable failure conditions. It defines:

- a locked code grammar
- a controlled family taxonomy
- a governed registry of issued LES codes
- default operational handling semantics for issued codes
- registry entry lifecycle semantics
- consumer adoption and override boundaries

LES is a `STD-NORM` artifact — a normative definitional standard that is binding company-wide. It governs both **what a failure condition is** and **the default operational consequence attached to that failure condition**.

**In the Luphay standards stack:**
- **LNS** names the artifact
- **LAMS** describes the artifact
- **LES** names what is wrong and governs the default consequence when it is wrong

**LES is autonomous and authoritative.** It is designed from the taxonomy up, independent of any consuming standard. Consuming standards adopt LES codes where they fit, petition for extension where they do not, and implement local behavior only within LES-defined boundaries.

---

## 1. Purpose

This specification defines:

1. the locked LES grammar — the code structure that all LES codes must follow
2. the normative requirements (MUST rules) for code conformance
3. the controlled family taxonomy — 15 top-level families with definitions and boundaries
4. the code assignment rules — how authors choose the correct family, category, and object
5. the authoring rules — how conformant codes and registry semantics are constructed
6. the consumer petition process — how consuming standards request new codes or families
7. the operational semantics model — how baseline and conditional handling consequences are represented
8. the precedence and override rules — how LES semantics govern downstream consumers
9. the registry entry lifecycle semantics — how issued LES codes move through governed states
10. the authoritative normative code registry — the current issued LES entries and their operational semantics

---

## 2. Scope

### 2.1 Applies to
- All Luphay systems, agents, validators, pipelines, runtimes, and governance surfaces that emit, consume, route, or interpret LES codes
- All governed artifacts that declare error or failure states
- All registry entries that carry LES naming and operational semantics
- All consuming standards that reference LES codes in their failure semantics or operational consequence rules

### 2.2 Does not apply to
- Internal implementation-level error handling details such as stack traces, exception classes, or debug logs
- HTTP status codes used for transport semantics
- Consumer-local recovery steps, retry loops, or UX copy that are not declared LES semantics
- Consumer-local error enums that have not been registered as LES codes

### 2.3 Relationship to consuming standards
Consuming standards — including LAMS — adopt LES codes. They do not define LES taxonomy. Where a consuming standard's failure mode maps to an existing LES code, it MUST use that code. Where no code exists, the consuming standard MUST petition the LES steward per §9 before defining its own governed error identifier.

Consuming standards MAY harden LES handling within the limits defined by §11. They SHALL NOT redefine LES meaning, outrank LES authority, or weaken LES semantics except where the registry entry posture and steward governance explicitly permit it.

---

## 3. Governing Principles

**P-01 — LES is autonomous and authoritative.**
LES taxonomy, registry, and operational semantics are designed independent of any consuming standard. Consumer needs inform petitions; they do not shape the taxonomy directly. `STD-NORM-0002` is the authoritative LES source.

**P-02 — Semantic keys are stable once issued.**
A code entered into the registry MUST NOT be redefined or deleted. Deprecated codes MUST be marked deprecated with a successor code declared where applicable.

**P-03 — Family answers kind, category answers mode, object answers target.**
The three-block structure encodes three distinct questions. Conflating them produces non-conformant codes.

**P-04 — Narrowest correct family wins.**
When multiple families seem plausible, choose the most semantically specific family that cleanly describes the failure. Do not default to broad families.

**P-05 — LES is enterprise-scoped.**
Codes must express failure conditions general enough to be meaningful across Luphay systems. Consumer-specific constructs that cannot travel beyond one context do not belong in the registry.

**P-06 — Delimiters are deterministic.**
`__` separates blocks. `-` qualifies within a block. A parser and a human must arrive at the same parse result for every conformant code.

**P-07 — Operational semantics are part of LES meaning.**
For issued LES codes, default operational handling posture is part of the governed meaning of the code, not merely commentary or local implementation detail.

**P-08 — The core standard owns final truth.**
Related artifacts may elaborate, mirror, or operationalize LES, but they SHALL NOT outrank or redefine the semantics established in this standard.

**P-09 — Consumers may implement, but not redefine.**
Consuming standards may bind LES to workflows and may harden behavior within authorized boundaries, but they SHALL NOT redefine family/category/object meaning or publish conflicting default semantics.

---

## 4. Locked Grammar

### 4.1 Grammar structure

The LES grammar is locked. Changes to the grammar shape require a new ADR. The locked structure is:

```text
LES__[FAMILY(-SUB-FAMILY)]__[CATEGORY(-SUB-CATEGORY)]__[OBJECT(-QUALIFIER...)]
```

### 4.2 Normative requirements (MUST rules)

**LES-MUST-01** Every LES code MUST begin with the prefix `LES`.

**LES-MUST-02** Every LES code MUST contain exactly three content blocks — FAMILY, CATEGORY, and OBJECT — separated by `__`. A code with fewer than three content blocks is non-conformant.

**LES-MUST-03** The `__` (double underscore) MUST be used exclusively as the block boundary delimiter. It MUST NOT appear within a block.

**LES-MUST-04** The `-` (hyphen) MUST be used exclusively as the qualifier delimiter within a block. It denotes a primary-qualifier relationship — the right side always narrows the left side.

**LES-MUST-05** The single underscore `_` MUST NOT appear anywhere in a conformant LES code.

**LES-MUST-06** All characters in a LES code MUST be uppercase.

**LES-MUST-07** FAMILY MUST be drawn from the controlled family set defined in §5. Codes using an unregistered family are non-conformant.

**LES-MUST-08** CATEGORY MUST be drawn from the preferred category bands for the declared family (§5.3) or formally approved as a new category by the steward.

**LES-MUST-09** OBJECT MUST identify the concrete object, condition, or detail affected by the failure. It MUST NOT be a narrative explanation or a human sentence.

**LES-MUST-10** FAMILY and CATEGORY MUST each begin with a single primary word. A sub-qualifier is optional and must narrow the primary.

**LES-MUST-11** Once issued, a code MUST NOT be redefined, repurposed, or deleted. Deprecated codes MUST carry a successor code reference in the registry.

**LES-MUST-12** New codes MUST be approved by the LES steward before entry into the registry. New top-level families MUST additionally be authorized by a taxonomy amendment ADR.

### 4.3 Formal grammar

```text
LES-CODE     ::= "LES" BLOCK-SEP FAMILY BLOCK-SEP CATEGORY BLOCK-SEP OBJECT
BLOCK-SEP    ::= "__"
FAMILY       ::= TOKEN (QUAL-SEP TOKEN)?
CATEGORY     ::= TOKEN (QUAL-SEP TOKEN)?
OBJECT       ::= TOKEN (QUAL-SEP TOKEN)*
TOKEN        ::= [A-Z]+
QUAL-SEP     ::= "-"
```

Interpretation:
- `FAMILY` and `CATEGORY` allow one optional qualifier (one `-TOKEN` suffix)
- `OBJECT` allows zero or more qualifiers (zero or more `-TOKEN` suffixes)
- All tokens consist of uppercase letters only

### 4.4 Parser specification

A conformant parser MUST:
1. Split the code on `__` to extract blocks
2. Assert exactly four elements: `["LES", FAMILY-BLOCK, CATEGORY-BLOCK, OBJECT-BLOCK]`
3. Split each block on `-` to extract primary token and qualifiers
4. Assert that FAMILY-BLOCK and CATEGORY-BLOCK each have at most two `-`-separated parts
5. Treat OBJECT-BLOCK as primary token plus zero or more qualifier tokens

### 4.5 Conformance examples

**Conformant codes:**

| Code | Parse result |
|---|---|
| `LES__INPUT__MISSING__REQUIRED-INPUT` | FAMILY=INPUT · CATEGORY=MISSING · OBJECT=REQUIRED-INPUT |
| `LES__INPUT-FILE__MISSING__REQUIRED-COLUMN` | FAMILY=INPUT(sub:FILE) · CATEGORY=MISSING · OBJECT=REQUIRED-COLUMN |
| `LES__LIFECYCLE__STALE__ARTIFACT` | FAMILY=LIFECYCLE · CATEGORY=STALE · OBJECT=ARTIFACT |
| `LES__INTEGRITY__MISMATCH__CONTENT-HASH` | FAMILY=INTEGRITY · CATEGORY=MISMATCH · OBJECT=CONTENT-HASH |

**Non-conformant codes with corrections:**

| Non-conformant | Problem | Corrected |
|---|---|---|
| `LES_INPUT_MISSING_REQUIRED` | Single underscores throughout — block boundaries ambiguous | `LES__INPUT__MISSING__REQUIRED-INPUT` |
| `LES__MISSING_INPUT__INVALID__FILE` | Category carries family meaning; single underscore in block | `LES__INPUT__MISSING__FILE` |
| `LES__INPUT__MISSING` | Only two content blocks — OBJECT missing | `LES__INPUT__MISSING__REQUIRED-INPUT` |
| `LES__input__missing__required` | Lowercase characters | `LES__INPUT__MISSING__REQUIRED-INPUT` |
| `LES__INPUT__MISSING__USER-LEFT-IT-OUT` | Object is a narrative explanation | `LES__INPUT__MISSING__REQUIRED-INPUT` |
| `LES__INPUT-FILE-CSV__MISSING__COLUMN` | FAMILY has two qualifiers — only one permitted | `LES__INPUT-FILE__MISSING__REQUIRED-COLUMN` |

---

## 5. Family Taxonomy

### 5.1 Taxonomy design principle

LES codes answer three questions in sequence:

```text
FAMILY   = what kind of thing is wrong?
CATEGORY = how is it wrong?
OBJECT   = what specific thing is affected?
```

Family encodes the semantic nature of the failure. Category encodes the failure mode. Object encodes the affected target. The taxonomy preserves this separation — family is never a dumping ground for emitting component names, and category never carries family semantics.

### 5.2 Controlled family set

The following 15 families constitute the controlled LES family set established in v0.1 and continued in v0.3. All are binding. New families require a taxonomy amendment ADR per LES-MUST-12.

---

#### Domain 1 — Structural / Artifact

**IDENTITY**
Use when the failure concerns identity, naming, UID resolution, alias resolution, identifier consistency, or identity-block agreement across declared representations.
*Do not use when* the core problem is a missing prerequisite input.

**INPUT**
Use when the failure concerns required supplied inputs, declared inputs, inbound dependencies, or provided artifact inputs.
*Do not use for* persistent settings or static system profiles — those belong in CONFIGURATION.

**STATE**
Use when the current condition of an object or system makes an action or condition invalid, blocked, or impossible, but the issue is not lifecycle progression.

Category disambiguation within STATE:
- `INVALID` — the state value itself is not a recognized or permitted value in the system's state model
- `ILLEGAL` — the state value is recognized, but the action attempted from it is not permitted

*Do not use for* stage, status, or maturity progression — those belong in LIFECYCLE.

**INVARIANT**
Use when a truth that must always hold has been broken — a structural or system truth, not a policy rule or linkage condition.
*Do not use for* missing/broken golden-thread links where the central issue is trace linkage — those belong in TRACEABILITY.

**LIFECYCLE**
Use when the failure concerns status, stage, version, freshness, expiry, activation state, retirement state, or valid progression through a lifecycle model.
*Do not use for* non-lifecycle runtime state conditions — those belong in STATE.

**TRACEABILITY**
Use when the failure concerns missing, broken, unresolved, or incomplete reference paths, evidence chains, parent-child mappings, lineage links, or golden-thread continuity.
*Do not use when* the broken condition is broader than trace linkage — that belongs in INVARIANT.

---

#### Domain 2 — Control / Governance

**AUTHORIZATION**
Use when the failure concerns permission to act, approval rights, allowed scope, delegation boundaries, or decision authority.
*Do not use for* broader security control failures such as threat detection or secret exposure — those belong in SECURITY.

**POLICY**
Use when the failure concerns a violated rule, prohibition, mandate, required control, or governance requirement.
*Do not use for* a structural truth that must hold irrespective of policy language — that belongs in INVARIANT.

**CONFIGURATION**
Use when the failure concerns configuration state, profiles, environment setup, mode settings, parameters, or static operational setup. Values persist across invocations and are managed outside the immediate execution context.
*Do not use for* runtime-supplied input data — that belongs in INPUT.

---

#### Domain 3 — Runtime / Operational

**DEPENDENCY**
Use when the failure concerns a prerequisite service, artifact, contract, system, or dependency that is missing, unavailable, unresolved, or incompatible before the real action can begin.
*Do not use when* the action itself has started and then fails — that belongs in EXECUTION.

**EXECUTION**
Use when the failure concerns a running process, workflow, command, validation step, or execution attempt that fails, aborts, times out, or is interrupted after it has begun.
*Do not use when* the operation could not begin because a prerequisite was absent — that belongs in DEPENDENCY.

---

#### Domain 4 — Trust / Assurance

**INTEGRITY**
Use when the failure concerns tamper evidence, content consistency, hash agreement, checksum agreement, immutability expectations, or signature-content agreement.
*Do not use when* the issue is source trust or lineage authenticity — that belongs in PROVENANCE.

**SANITIZATION**
Use when the failure concerns hygiene gates, redaction, content cleaning, allowlist/blocklist scans, secret removal, or output safety filtering — specifically when a dedicated sanitization step ran and failed.
*Do not use for* broader governance-rule violations unless the immediate failed mechanism is the sanitization gate itself.

**PROVENANCE**
Use when the failure concerns source origin, issuer legitimacy, authorship, attestation, lineage authenticity, or trusted-source verification.
*Do not use for* content tamper or hash mismatch — that belongs in INTEGRITY.

**SECURITY**
Use when the failure concerns security controls, authentication/session failures, exposure of secrets, threat detection, suspicious access, or protective enforcement.
*Do not use for* ordinary permission-to-act questions — those belong in AUTHORIZATION.

---

### 5.3 Preferred category bands

These constrain authoring. They are not an exhaustive frozen list. New categories within an existing family may be approved by steward decision alone (no ADR required).

| Family | Preferred category bands |
|---|---|
| IDENTITY | MISMATCH, INVALID, DUPLICATE, UNRESOLVED, AMBIGUOUS |
| INPUT | MISSING, UNRESOLVED, INVALID, INCOMPLETE, UNSUPPORTED |
| STATE | INVALID, ILLEGAL, CONFLICT, BLOCKED, IMPOSSIBLE |
| INVARIANT | VIOLATION, BROKEN, UNSATISFIED, MISMATCH |
| LIFECYCLE | INVALID, STALE, EXPIRED, RETIRED, PREMATURE |
| TRACEABILITY | MISSING, BROKEN, UNLINKED, INCOMPLETE, UNRESOLVED |
| AUTHORIZATION | DENIED, MISSING, FORBIDDEN, EXPIRED, OUT-OF-SCOPE |
| POLICY | VIOLATION, FORBIDDEN, REQUIRED, NONCOMPLIANT |
| CONFIGURATION | MISSING, INVALID, CONFLICT, INCOMPATIBLE, UNSUPPORTED |
| DEPENDENCY | MISSING, UNAVAILABLE, UNRESOLVED, TIMEOUT, INCOMPATIBLE |
| EXECUTION | FAILED, TIMEOUT, INTERRUPTED, ABORTED, BLOCKED |
| INTEGRITY | MISMATCH, MISSING, CORRUPT, TAMPERED, INVALID |
| SANITIZATION | FAILED, UNSAFE, FORBIDDEN, UNCLEAN, UNREDACTED |
| PROVENANCE | MISSING, UNVERIFIED, UNTRUSTED, MISMATCH, UNKNOWN |
| SECURITY | FAILED, DETECTED, EXPOSED, INVALID, BLOCKED |

---

## 6. Code Assignment Rules

**Rule 6.1 — Family by semantic locus, not emitting component.**
The code family is determined by the nature of the failure itself, not by where it appeared. A CI pipeline may emit INPUT. A runtime may emit POLICY. An agent may emit INTEGRITY. The emitter does not define the family.

**Rule 6.2 — Narrowest correct family.**
When multiple families seem plausible, choose the most semantically specific. Prefer LIFECYCLE over STATE for freshness/status issues; AUTHORIZATION over SECURITY for permission questions; TRACEABILITY over INVARIANT for broken link conditions; CONFIGURATION over INPUT for static setup issues.

**Rule 6.3 — Family is for kind, category is for mode, object is for target.**
Do not encode failure mode in family. Do not encode the target in category. Do not use the object position for narrative explanation.

**Rule 6.4 — Stable enterprise vocabulary.**
Use terms that travel across systems: `AGENT-CONTRACT`, `CONTENT-HASH`, `STATUS-TRANSITION`, `REQUIRED-INPUT`. Avoid short-lived field names, internal variable labels, or implementation-local jargon unless the variable itself is the governed object.

**Rule 6.5 — Sub-families are exceptional.**
A sub-family qualifier on FAMILY or CATEGORY may be introduced only when all four conditions hold:
1. the distinction is durable across system evolution
2. the distinction is reusable across more than one code
3. grep/aggregation value materially improves
4. the distinction cannot be handled more cleanly at object level

*Accepted sub-family:* `LES__INPUT-FILE__MISSING__REQUIRED-COLUMN` — if file-type inputs fail distinctly from other INPUT types across systems and the sub-family materially improves filtering.

*Rejected sub-family:* `LES__INPUT-ARTIFACT__MISSING__REQUIRED-INPUT` — if ARTIFACT is the only INPUT kind the system handles, the sub-qualifier adds no grep value. Use `LES__INPUT__MISSING__REQUIRED-ARTIFACT` instead — put the specificity in the object.

**Rule 6.6 — Codes are stable once issued.**
Once a code enters the registry it must remain stable. Formal deprecation with a declared successor is the only exit path.

**Rule 6.7 — Issued meaning includes operational posture.**
For a registry-issued LES code, the governed meaning includes not only family/category/object identity, but also the default operational semantics declared in the normative registry.

---

## 7. Boundary Rules

These rules resolve the most common family assignment ambiguities.

| Pair | Decision rule |
|---|---|
| IDENTITY vs INPUT | Use INPUT when something required was not supplied or resolved. Use IDENTITY when the thing exists but its identifier is wrong or inconsistent. |
| STATE vs LIFECYCLE | Use STATE for invalid current-condition problems. Use LIFECYCLE for status, stage, freshness, expiry, or progression problems. |
| INVARIANT vs TRACEABILITY | Use INVARIANT when a must-always-hold structural truth is broken regardless of reference chains. Use TRACEABILITY when the central problem is the absence or break of a declared reference relationship. |
| INVARIANT vs POLICY | Use INVARIANT for structural/system truth. Use POLICY for rule/mandate/prohibition failure. |
| AUTHORIZATION vs SECURITY | Use AUTHORIZATION for permission-to-act questions. Use SECURITY for protective controls, authn/session failures, exposure, or threat conditions. |
| INPUT vs CONFIGURATION | Use INPUT for values provided per-invocation or declared per-artifact. Use CONFIGURATION for values that persist across multiple invocations and are managed outside the immediate execution context. Agentic note: an agent reading a config file that persists across runs is consuming CONFIGURATION, not INPUT. |
| DEPENDENCY vs EXECUTION | Use DEPENDENCY when a prerequisite is absent before the action can begin. Use EXECUTION when the action itself runs and then fails. |
| INTEGRITY vs PROVENANCE | Use INTEGRITY when content agreement or tamper-evidence is broken. Use PROVENANCE when source legitimacy, issuer trust, or origin verification is broken. |
| SANITIZATION vs POLICY | Use SANITIZATION when a dedicated hygiene/redaction/filtering step explicitly ran and returned failure. Use POLICY when noncompliance is detected through policy evaluation alone with no sanitization step involved. |

---

## 8. Authoring Rules

Before authoring a new LES code, the author MUST:

1. **Confirm the failure condition is general.** The condition must be expressible across more than one Luphay system or context. Consumer-specific constructs must go through the petition process (§9).

2. **Select FAMILY.** Apply the three-question test: *what kind of thing is wrong?* Apply boundary rules (§7) if multiple families seem plausible. Choose the narrowest correct family.

3. **Select CATEGORY.** Apply the second question: *how is it wrong?* Select from the preferred category bands (§5.3). If no band fits, propose a new category through steward review.

4. **Select OBJECT.** Apply the third question: *what specific thing is affected?* Use stable enterprise vocabulary. If the object requires qualification, use `-` to narrow it. Do not use the object position for narrative.

5. **Determine the operational profile.** Propose `Baseline handling`, `Escalation handling`, `Escalation condition`, `Action profile`, and `Override posture` per §10. Operational semantics are part of the registry entry, not an afterthought.

6. **Construct and validate the code.** Apply the grammar (§4). Parse the code mentally to confirm three blocks, correct delimiters, uppercase characters, and no single underscores. Compare to existing codes to confirm non-duplication.

7. **Submit for steward review.** New codes are not self-approving. Complete a catalog entry using `STD-TEMP-XXXX` and submit to the LES steward.

---

## 9. Consumer Petition Process

When a consuming standard requires an error code that does not exist in the LES registry, the consuming standard MUST submit a petition to the LES steward. The standard MUST NOT define its own governed failure identifier without LES registry approval.

### 9.1 Petition requirements

A petition must include:

1. **Proposed code** — a fully conformant LES code in the locked grammar
2. **Family/category/object assignment** — explicit declaration with rationale for each block choice
3. **Failure description** — plain-language description of the failure condition
4. **Cross-system applicability** — identification of at least one other Luphay system or context where the condition could plausibly occur
5. **Non-duplication check** — confirmation that no existing code covers the condition, including near-matches
6. **Proposed operational profile** — proposed `Baseline handling`, `Escalation handling`, `Escalation condition`, `Action profile`, and `Override posture`
7. **Consumer binding note** — any consumer-specific hardening or special workflow binding requested, clearly marked as consumer-local rather than LES-core if applicable

### 9.2 Steward review criteria

The steward evaluates:
- conformance to locked grammar
- fit within existing family/category taxonomy
- cross-system applicability
- non-duplication
- operational fit within LES controlled semantics
- compatibility with existing precedence and override rules

### 9.3 Family extension rule

A petition requiring a **new top-level FAMILY** MUST be accompanied by a taxonomy amendment ADR. Steward approval alone is not sufficient. A petition requiring only a new CATEGORY or OBJECT within an existing family may be approved by steward decision alone.

### 9.4 Petition outcomes

| Outcome | Meaning |
|---|---|
| **Accepted** | Code enters the registry with no outstanding condition |
| **Conditionally accepted** | Code enters the registry pending a stated condition, such as the petitioning standard reaching ACTIVE status |
| **Redirected** | An existing code already covers the condition; petitioning standard maps to it |
| **Deferred** | Failure mode is consumer-specific or not yet demonstrably general; revisit later |
| **Rejected** | Proposed code does not conform to grammar, taxonomy, or operational model; petitioner must revise and resubmit |

### 9.5 DRAFT consuming standard rule

A consuming standard in DRAFT status MAY submit petitions. The steward MAY conditionally accept a code until the consuming standard's failure semantics are confirmed stable at ACTIVE status.

---

## 10. Operational Semantics Model

### 10.1 Role of operational semantics

Operational semantics are part of LES proper. For each issued LES code, the normative registry defines not only what the failure condition is, but also the default operational posture attached to that condition.

Operational semantics govern baseline handling. They do not replace consumer-local workflow design, but they do constrain it.

### 10.2 Registry operational fields

Every issued LES registry entry MUST declare the following fields:

- **Baseline handling** — the minimum default handling posture when no escalation condition is met
- **Escalation handling** — a stricter handling posture that applies when the declared escalation condition is met; `NONE` if no escalation exists
- **Escalation condition** — the controlled condition set that activates the escalation handling; `NONE` if no escalation exists
- **Action profile** — the default next-step recommendation associated with the code
- **Override posture** — the allowed consumer override posture for the code

A registry entry MAY also include:
- **Notes** — clarifying narrative that does not contradict the governed fields

### 10.3 Controlled values

#### 10.3.1 Handling values

`Baseline handling` MUST be one of:

- `ADVISORY`
- `WARN`
- `REJECT`
- `BLOCKING`

`Escalation handling` MUST be one of:

- `NONE`
- `WARN`
- `REJECT`
- `BLOCKING`

Handling strictness order is:

```text
ADVISORY < WARN < REJECT < BLOCKING
```

#### 10.3.2 Action profile values

`Action profile` MUST be one or more of:

- `NONE`
- `RETRY`
- `ESCALATE`
- `REVIEW`
- `QUARANTINE`

Where multiple actions apply, they are expressed as a comma-separated set.

#### 10.3.3 Override posture values

`Override posture` MUST be one of:

- `STANDARD`
- `STEWARD-OVERRIDABLE`
- `FIXED`

Interpretation:
- `STANDARD` — consumers may harden behavior but may not weaken it
- `STEWARD-OVERRIDABLE` — consumers may harden behavior; weakening requires explicit steward approval
- `FIXED` — consumers may neither harden nor weaken the declared LES posture

#### 10.3.4 Escalation condition tokens

`Escalation condition` MUST use controlled condition tokens. v0.3 authorizes the following set:

- `ACTIVE-OR-FROZEN`
- `ASSURED-MODE`
- `GRAPH-COMPILATION`
- `FULL-CONFORMANCE-CLAIM`
- `LIFECYCLE-PROMOTION`

Condition-set syntax:
- `+` means conjunctive scope (all tokens required)
- `,` means alternative condition sets
- `NONE` means no escalation condition exists

Example:

```text
ACTIVE-OR-FROZEN+ASSURED-MODE
```

means the escalation applies only when both conditions are true.

### 10.4 Interpretation rules

**Rule 10.4.1 — Baseline governs by default.**  
When no escalation condition is met, `Baseline handling` governs.

**Rule 10.4.2 — Escalation governs when triggered.**  
When an escalation condition is met, `Escalation handling` governs.

**Rule 10.4.3 — Strictest posture wins.**  
When multiple LES codes apply to the same action or evaluation context, the strictest resulting handling posture wins unless a higher-order deterministic aggregation rule is defined by a governing standard.

**Rule 10.4.4 — Handling meaning is fixed.**
- `ADVISORY` — issue must be recorded and surfaced; the current process may continue
- `WARN` — issue must be recorded and surfaced; the current process may continue under caution or retry/review policy
- `REJECT` — the current action or result must not be accepted as valid
- `BLOCKING` — the current action or declared progression scope must not proceed

**Rule 10.4.5 — Action profile guides next step.**
- `RETRY` — attempt recovery through controlled retry logic
- `ESCALATE` — route to an authority, approver, or supervising function
- `REVIEW` — route for deterministic or human review before continuation
- `QUARANTINE` — isolate the object, output, or artifact from normal flow

### 10.5 Operational conformance rules

**LES-MUST-13** Every issued LES registry entry MUST include `Baseline handling`, `Action profile`, and `Override posture`.

**LES-MUST-14** If `Escalation handling` is not `NONE`, `Escalation condition` MUST NOT be `NONE`.

**LES-MUST-15** `Escalation handling`, where present, MUST be stricter than `Baseline handling`.

**LES-MUST-16** Consumers MUST honor the `Override posture` declared for the LES code.

**LES-MUST-17** Related artifacts and consuming standards MUST NOT publish operational semantics that conflict with the normative registry entry.

---

## 11. Precedence and Consumer Override Rules

### 11.1 Precedence order

In the event of conflict, LES authority resolves in the following order:

1. the current approved version of `STD-NORM-0002`
2. derivative LES artifacts that faithfully mirror `STD-NORM-0002`
3. consuming standards that adopt LES
4. implementation-local runtime or workflow logic

A lower-precedence layer SHALL NOT contradict a higher-precedence layer.

### 11.2 Core override rule

Consumers may implement LES. They do not own LES.

Consumers SHALL NOT:
- redefine the semantic meaning of a LES code
- redefine family/category/object assignment
- publish alternative enterprise-default semantics for a LES code
- weaken LES semantics where the registry posture forbids weakening

### 11.3 Override posture interpretation

#### `STANDARD`
Consumers MAY harden handling or add stricter local actions. They SHALL NOT weaken the LES posture.

#### `STEWARD-OVERRIDABLE`
Consumers MAY harden handling. They MAY weaken handling only with explicit steward approval recorded in the consuming artifact.

#### `FIXED`
Consumers SHALL NOT harden, weaken, or otherwise alter the LES posture.

### 11.4 Derived artifact rule

`STD-REFR-0008` and other LES companion artifacts are derivative of `STD-NORM-0002`. They may provide expanded descriptions, lookup views, or operational guidance, but they SHALL NOT outrank this standard.

---

## 12. Registry Entry Lifecycle

### 12.1 Lifecycle states

LES registry entries move through governed lifecycle states.

| State | Meaning |
|---|---|
| `PROPOSED` | Petitioned or drafted, not yet issued into the authoritative registry |
| `SEED` | Issued into the authoritative registry as a steward-seeded or baseline code; usable, but not yet formally locked as ACTIVE |
| `CONDITIONAL` | Issued into the authoritative registry subject to a declared condition |
| `ACTIVE` | Fully locked registry entry with no outstanding condition |
| `DEPRECATED` | Entry remains valid for historical interpretation but SHOULD be replaced by a successor where declared |
| `RETIRED` | Entry is no longer for new use, but remains preserved for historical integrity |

### 12.2 Lifecycle transition rules

Allowed transitions are:

- `PROPOSED -> SEED`
- `PROPOSED -> CONDITIONAL`
- `SEED -> ACTIVE`
- `CONDITIONAL -> ACTIVE`
- `CONDITIONAL -> DEPRECATED`
- `ACTIVE -> DEPRECATED`
- `DEPRECATED -> RETIRED`

### 12.3 Transition authority

Only the LES steward may authorize registry lifecycle transitions.

### 12.4 Non-deletion rule

Once an entry reaches `SEED`, `CONDITIONAL`, or `ACTIVE`, it SHALL NOT be deleted from the historical LES record. It may only transition through governed lifecycle states.

---

## 13. Normative Code Registry

This section is the authoritative LES registry. `STD-REFR-0008__les-seed-catalog` is a derivative companion catalog that may elaborate the entries below, but it is not the normative source of truth.

### 13.1 Registry — Domain 1: Structural / Artifact

| Code | Family | Category | Object | Baseline handling | Escalation handling | Escalation condition | Action profile | Override posture | Entry stage | Petitioning standard | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `LES__IDENTITY__MISMATCH__ARTIFACT-ID` | IDENTITY | MISMATCH | ARTIFACT-ID | REJECT | NONE | NONE | REVIEW | STANDARD | SEED | — | Identifier mismatch invalidates acceptance of the object as declared |
| `LES__IDENTITY__INVALID__ARTIFACT-ID` | IDENTITY | INVALID | ARTIFACT-ID | REJECT | NONE | NONE | REVIEW | STANDARD | CONDITIONAL | STD-SPEC-0006 | Invalid identifier form or value |
| `LES__IDENTITY__DUPLICATE__ARTIFACT-ID` | IDENTITY | DUPLICATE | ARTIFACT-ID | REJECT | NONE | NONE | REVIEW | STANDARD | CONDITIONAL | STD-SPEC-0006 | Duplicate identifier breaks uniqueness expectation |
| `LES__INPUT__MISSING__REQUIRED-INPUT` | INPUT | MISSING | REQUIRED-INPUT | REJECT | NONE | NONE | REVIEW | STANDARD | SEED | — | Missing required input blocks valid evaluation |
| `LES__LIFECYCLE__STALE__ARTIFACT` | LIFECYCLE | STALE | ARTIFACT | WARN | NONE | NONE | REVIEW | STEWARD-OVERRIDABLE | SEED | — | Consumers commonly harden at freshness-sensitive gates |
| `LES__LIFECYCLE__PREMATURE__STATUS-TRANSITION` | LIFECYCLE | PREMATURE | STATUS-TRANSITION | REJECT | NONE | NONE | REVIEW | STANDARD | CONDITIONAL | STD-SPEC-0006 | Transition attempted before prerequisite state or stage |
| `LES__LIFECYCLE__INVALID__STATUS-TRANSITION` | LIFECYCLE | INVALID | STATUS-TRANSITION | REJECT | NONE | NONE | REVIEW | STANDARD | CONDITIONAL | STD-SPEC-0006 | Transition is not permitted by the lifecycle model |
| `LES__INVARIANT__VIOLATION__HARD-CONSTRAINT` | INVARIANT | VIOLATION | HARD-CONSTRAINT | REJECT | NONE | NONE | REVIEW | STANDARD | CONDITIONAL | STD-SPEC-0006 | Hard structural truth is broken |
| `LES__INVARIANT__VIOLATION__DESIGN-INVARIANT` | INVARIANT | VIOLATION | DESIGN-INVARIANT | REJECT | NONE | NONE | REVIEW | STANDARD | CONDITIONAL | STD-SPEC-0006 | Design-declared invariant is broken |
| `LES__TRACEABILITY__MISSING__CONSUMER-LINK` | TRACEABILITY | MISSING | CONSUMER-LINK | ADVISORY | BLOCKING | ACTIVE-OR-FROZEN+ASSURED-MODE | REVIEW | STANDARD | CONDITIONAL | STD-SPEC-0006 | Missing consumer linkage becomes blocking in governed assured states |
| `LES__TRACEABILITY__MISSING__OUTPUT-LINK` | TRACEABILITY | MISSING | OUTPUT-LINK | ADVISORY | BLOCKING | ACTIVE-OR-FROZEN+ASSURED-MODE | REVIEW | STANDARD | CONDITIONAL | STD-SPEC-0006 | Missing output linkage becomes blocking in governed assured states |
| `LES__TRACEABILITY__INCOMPLETE__CONFORMANCE-CLAIM` | TRACEABILITY | INCOMPLETE | CONFORMANCE-CLAIM | ADVISORY | REJECT | FULL-CONFORMANCE-CLAIM | REVIEW | STANDARD | CONDITIONAL | STD-SPEC-0006 | Partial claims may continue; full claims may not |
| `LES__TRACEABILITY__BROKEN__DEPENDENCY-LINK` | TRACEABILITY | BROKEN | DEPENDENCY-LINK | ADVISORY | BLOCKING | GRAPH-COMPILATION | REVIEW | STANDARD | CONDITIONAL | STD-SPEC-0006 | Broken dependency linkage blocks graph compilation flows |
| `LES__TRACEABILITY__UNLINKED__ARTIFACT` | TRACEABILITY | UNLINKED | ARTIFACT | ADVISORY | NONE | NONE | REVIEW | STANDARD | CONDITIONAL | STD-SPEC-0006 | Unlinked artifact is surfaced for remediation |

### 13.2 Registry — Domain 2: Control / Governance

| Code | Family | Category | Object | Baseline handling | Escalation handling | Escalation condition | Action profile | Override posture | Entry stage | Petitioning standard | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `LES__AUTHORIZATION__DENIED__REQUIRED-APPROVAL` | AUTHORIZATION | DENIED | REQUIRED-APPROVAL | REJECT | NONE | NONE | ESCALATE, REVIEW | STANDARD | SEED | — | Current action may not proceed without the required authority |
| `LES__POLICY__VIOLATION__MANDATORY-RULE` | POLICY | VIOLATION | MANDATORY-RULE | REJECT | NONE | NONE | REVIEW | FIXED | SEED | — | Mandatory rule violations are fixed at LES level |
| `LES__CONFIGURATION__MISSING__REQUIRED-PROFILE` | CONFIGURATION | MISSING | REQUIRED-PROFILE | REJECT | NONE | NONE | REVIEW | STANDARD | SEED | — | Required persistent profile or setup is absent |

### 13.3 Registry — Domain 3: Runtime / Operational

| Code | Family | Category | Object | Baseline handling | Escalation handling | Escalation condition | Action profile | Override posture | Entry stage | Petitioning standard | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `LES__DEPENDENCY__UNRESOLVED__REQUIRED-ARTIFACT` | DEPENDENCY | UNRESOLVED | REQUIRED-ARTIFACT | REJECT | NONE | NONE | REVIEW | STANDARD | SEED | — | Required dependency is absent or unresolved before execution begins |
| `LES__EXECUTION__FAILED__VALIDATION-STEP` | EXECUTION | FAILED | VALIDATION-STEP | REJECT | NONE | NONE | REVIEW | STANDARD | SEED | — | Running validation step failed after execution began |
| `LES__EXECUTION__TIMEOUT__WORKFLOW-STEP` | EXECUTION | TIMEOUT | WORKFLOW-STEP | WARN | NONE | NONE | RETRY, REVIEW | STANDARD | SEED | — | Retry policy may be bound by the consumer where allowed |

### 13.4 Registry — Domain 4: Trust / Assurance

| Code | Family | Category | Object | Baseline handling | Escalation handling | Escalation condition | Action profile | Override posture | Entry stage | Petitioning standard | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `LES__INTEGRITY__MISMATCH__CONTENT-HASH` | INTEGRITY | MISMATCH | CONTENT-HASH | REJECT | NONE | NONE | QUARANTINE, REVIEW | FIXED | SEED | — | Content mismatch indicates integrity failure |
| `LES__INTEGRITY__MISSING__CONTENT-HASH` | INTEGRITY | MISSING | CONTENT-HASH | ADVISORY | BLOCKING | LIFECYCLE-PROMOTION | REVIEW | STANDARD | CONDITIONAL | STD-SPEC-0006 | Missing hash blocks promotion-sensitive flows |
| `LES__SANITIZATION__FAILED__CONTENT-SCAN` | SANITIZATION | FAILED | CONTENT-SCAN | REJECT | NONE | NONE | QUARANTINE, REVIEW | STANDARD | SEED | — | Failed sanitization removes object from normal flow |
| `LES__PROVENANCE__MISSING__SOURCE-ATTESTATION` | PROVENANCE | MISSING | SOURCE-ATTESTATION | REJECT | NONE | NONE | REVIEW | STANDARD | SEED | — | Missing source attestation defeats trusted-origin claims |

### 13.5 Families with no current registry entry

The following families are valid and active in the taxonomy but have no current issued code. They are available for petition.

| Family | Domain |
|---|---|
| STATE | Structural / Artifact |
| SECURITY | Trust / Assurance |

---

## 14. Related Artifacts

| Artifact ID | Role |
|---|---|
| `ADR-DECN-0010` | Decision record authorizing LES — grammar, autonomy posture, petition process |
| `ADR-DECN-0011` | Decision record authorizing NORM class — LES as `STD-NORM` artifact |
| `ADR-DECN-0012` | Decision record expanding LES scope to governed failure semantics and establishing core authority |
| `STD-NORM-0001` | Luphay Naming Standard — governs LES artifact identity and file naming |
| `STD-SPEC-0006` | Luphay Artifact Metadata Standard (LAMS) v2.0.0 — petitioning standard for codes accepted in v0.2 |
| `STD-REFR-0007` | LES family taxonomy reference — full family definitions for lookup |
| `STD-REFR-0008` | LES companion catalog — derivative lookup and elaboration layer for the normative registry in this standard |
| `STD-GUID-0003` | LES authoring guideline — practical guidance for code authors |
| `STD-TEMP-XXXX` | LES catalog entry template — standard structure for petitioning new codes |
| `TASK-CHNG-0001` | LES petition — LAMS v2.0.0 error code registration |

---

## 15. Stewardship

Platform Governance holds steward authority for LES and this governing artifact for v1.x. Alpha Kamara is the designated steward at initial publication.

**Steward responsibilities:**
- reviewing and approving new code petitions
- reviewing and approving new category proposals within existing families
- initiating taxonomy amendment ADRs for new family proposals
- governing operational semantics attached to issued LES codes
- governing registry lifecycle transitions
- evaluating steward-override requests where permitted by `Override posture`
- marking codes as deprecated and declaring successor codes
- maintaining the authoritative normative registry in §13
- versioning this standard when normative changes are made

---

## 16. Decision Summary

LES is no longer only a naming layer.

LES is the authoritative Luphay standard for governed failure semantics. It defines the grammar, taxonomy, registry, default operational consequence, lifecycle state, and consumer-boundary rules for issued failure codes across Luphay systems.
