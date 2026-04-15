---
id: STD-NORM-0002
title: Luphay Error Standard (LES) — Core Specification
status: draft
version: v0.1
steward: Platform Governance / Alpha Kamara
decision_basis: ADR-DECN-0010
related_artifacts:
  - STD-NORM-0001
  - STD-REFR-0007
  - STD-REFR-0008
  - STD-GUID-0003
  - STD-TEMP-XXXX
created_by: Alpha Kamara
created_at: 2026-04-12
---

# STD-NORM-0002 — Luphay Error Standard (LES)
## Core Specification v0.1

---

## Changelog

### v0.1 — 2026-04-12
- Initial specification. Grammar locked per ADR-DECN-0010 v0.2. Autonomy posture established per ADR-DECN-0010 v0.3. Taxonomy, assignment rules, and boundary rules derived from WBS-01.3 v0.2 (locked). Seed registry derived from WBS-01.4 v0.2. Consumer petition process derived from ADR-DECN-0010 §5.8.

---

## 0. Executive Summary

The **Luphay Error Standard (LES)** is the enterprise naming and semantic standard for governed error conditions, validation failures, invariant breaches, illegal transitions, integrity failures, and other formally diagnosable abnormal states across Luphay systems.

LES provides a common, grep-friendly, machine-readable, and human-legible language for error identification and classification. It is consumed by humans, agents, validators, pipelines, runtimes, and observability surfaces.

LES is a `STD-NORM` artifact — a normative definitional standard that is binding company-wide. It defines a grammar, a taxonomy, and a code registry. It does not define how individual systems handle errors; it defines how errors are named and classified when they occur.

**In the Luphay standards stack:**
- **LNS** names the artifact
- **LAMS** describes the artifact
- **LES** names what is wrong with the artifact or governed action

**LES is autonomous.** It is designed from the taxonomy up, independent of any consuming standard. Consuming standards adopt LES codes where they fit and petition for extension where they do not.

---

## 1. Purpose

This specification defines:

1. the locked LES grammar — the code structure that all LES codes must follow
2. the normative requirements (MUST rules) for code conformance
3. the controlled family taxonomy — 15 top-level families with definitions and boundaries
4. the code assignment rules — how authors choose the correct family, category, and object
5. the authoring rules — how conformant codes are constructed
6. the consumer petition process — how consuming standards request new codes or families
7. the normative code registry — the initial seed set of LES codes

---

## 2. Scope

### 2.1 Applies to
- All Luphay systems, agents, validators, pipelines, runtimes, and governance surfaces that emit, consume, or route error conditions
- All governed artifacts that declare error or failure states
- All consuming standards that reference LES codes in their failure semantics

### 2.2 Does not apply to
- Internal implementation-level error handling (stack traces, exception classes, debug logs)
- HTTP status codes used for API transport semantics
- Consumer-local error enums that have not been registered as LES codes

### 2.3 Relationship to consuming standards
Consuming standards — including LAMS — adopt LES codes. They do not define LES taxonomy. Where a consuming standard's failure mode maps to an existing LES code, it MUST use that code. Where no code exists, the consuming standard MUST petition the LES steward per §9 before defining its own error identifier.

---

## 3. Governing Principles

**P-01 — LES is autonomous.**
LES taxonomy and registry are designed independent of any consuming standard. Consumer needs inform petitions; they do not shape the taxonomy directly.

**P-02 — Semantic keys are stable once issued.**
A code entered into the registry MUST NOT be redefined or deleted. Deprecated codes MUST be marked deprecated with a successor code declared.

**P-03 — Family answers kind, category answers mode, object answers target.**
The three-block structure encodes three distinct questions. Conflating them produces non-conformant codes.

**P-04 — Narrowest correct family wins.**
When multiple families seem plausible, choose the most semantically specific family that cleanly describes the failure. Do not default to broad families.

**P-05 — LES is enterprise-scoped.**
Codes must express failure conditions general enough to be meaningful across Luphay systems. Consumer-specific constructs that cannot travel beyond one context do not belong in the registry.

**P-06 — Delimiters are deterministic.**
`__` separates blocks. `-` qualifies within a block. A parser and a human must arrive at the same parse result for every conformant code.

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

```
FAMILY   = what kind of thing is wrong?
CATEGORY = how is it wrong?
OBJECT   = what specific thing is affected?
```

Family encodes the semantic nature of the failure. Category encodes the failure mode. Object encodes the affected target. The taxonomy preserves this separation — family is never a dumping ground for emitting component names, and category never carries family semantics.

### 5.2 Controlled family set

The following 15 families constitute the initial LES v0.1 controlled family set. All are binding. New families require a taxonomy amendment ADR per LES-MUST-12.

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

5. **Construct and validate the code.** Apply the grammar (§4). Parse the code mentally to confirm three blocks, correct delimiters, uppercase characters, and no single underscores. Compare to existing codes to confirm non-duplication.

6. **Submit for steward review.** New codes are not self-approving. Complete a catalog entry using `STD-TEMP-XXXX` and submit to the LES steward.

---

## 9. Consumer Petition Process

When a consuming standard requires an error code that does not exist in the LES registry, the consuming standard MUST submit a petition to the LES steward. The standard MUST NOT define its own error identifier for a governed failure condition without LES registry approval.

### 9.1 Petition requirements

A petition must include:

1. **Proposed code** — a fully conformant LES code in the locked grammar
2. **Family/category/object assignment** — explicit declaration with rationale for each block choice
3. **Failure description** — plain-language description of the failure condition
4. **Cross-system applicability** — identification of at least one other Luphay system or context where the condition could plausibly occur
5. **Non-duplication check** — confirmation that no existing code covers the condition, including near-matches

### 9.2 Steward review criteria

The steward evaluates:
- Conformance to locked grammar
- Fit within existing family/category taxonomy
- Cross-system applicability
- Non-duplication

### 9.3 Family extension rule

A petition requiring a **new top-level FAMILY** MUST be accompanied by a taxonomy amendment ADR. Steward approval alone is not sufficient. A petition requiring only a new CATEGORY or OBJECT within an existing family may be approved by steward decision alone.

### 9.4 Petition outcomes

| Outcome | Meaning |
|---|---|
| **Accepted** | Code enters the registry; petitioning standard is noted as first consumer |
| **Redirected** | An existing code already covers the condition; petitioning standard maps to it |
| **Deferred** | Failure mode is consumer-specific or not yet demonstrably general; revisit when the consuming standard reaches ACTIVE status |
| **Rejected** | Proposed code does not conform to grammar or taxonomy; petitioner must revise and resubmit |

### 9.5 DRAFT consuming standard rule

A consuming standard in DRAFT status MAY submit petitions. The steward MAY defer acceptance until the consuming standard's failure semantics are confirmed stable at ACTIVE status, to avoid embedding superseded design decisions in the LES registry.

---

## 10. Normative Code Registry

The authoritative code catalog is maintained in `STD-REFR-0008__les-seed-catalog`. This section contains the current normative registry summary. All entries below are at **SEED** stage pending formal registry lock by the steward.

Severity values are `UNASSIGNED` pending approval of the LES severity framework.

### 10.1 Registry — Domain 1: Structural / Artifact

| Code | Family | Category | Object | Agent behavior | Entry stage |
|---|---|---|---|---|---|
| `LES__IDENTITY__MISMATCH__ARTIFACT-ID` | IDENTITY | MISMATCH | ARTIFACT-ID | REJECT | SEED |
| `LES__INPUT__MISSING__REQUIRED-INPUT` | INPUT | MISSING | REQUIRED-INPUT | REJECT | SEED |
| `LES__LIFECYCLE__STALE__ARTIFACT` | LIFECYCLE | STALE | ARTIFACT | Per declared freshness policy; default WARN | SEED |

### 10.2 Registry — Domain 2: Control / Governance

| Code | Family | Category | Object | Agent behavior | Entry stage |
|---|---|---|---|---|---|
| `LES__AUTHORIZATION__DENIED__REQUIRED-APPROVAL` | AUTHORIZATION | DENIED | REQUIRED-APPROVAL | REJECT | SEED |
| `LES__POLICY__VIOLATION__MANDATORY-RULE` | POLICY | VIOLATION | MANDATORY-RULE | REJECT | SEED |
| `LES__CONFIGURATION__MISSING__REQUIRED-PROFILE` | CONFIGURATION | MISSING | REQUIRED-PROFILE | REJECT | SEED |

### 10.3 Registry — Domain 3: Runtime / Operational

| Code | Family | Category | Object | Agent behavior | Entry stage |
|---|---|---|---|---|---|
| `LES__DEPENDENCY__UNRESOLVED__REQUIRED-ARTIFACT` | DEPENDENCY | UNRESOLVED | REQUIRED-ARTIFACT | Per declared dependency-handling rule; default REJECT | SEED |
| `LES__EXECUTION__FAILED__VALIDATION-STEP` | EXECUTION | FAILED | VALIDATION-STEP | REJECT | SEED |
| `LES__EXECUTION__TIMEOUT__WORKFLOW-STEP` | EXECUTION | TIMEOUT | WORKFLOW-STEP | WARN; apply retry policy if declared | SEED |

### 10.4 Registry — Domain 4: Trust / Assurance

| Code | Family | Category | Object | Agent behavior | Entry stage |
|---|---|---|---|---|---|
| `LES__INTEGRITY__MISMATCH__CONTENT-HASH` | INTEGRITY | MISMATCH | CONTENT-HASH | REJECT | SEED |
| `LES__SANITIZATION__FAILED__CONTENT-SCAN` | SANITIZATION | FAILED | CONTENT-SCAN | REJECT | SEED |
| `LES__PROVENANCE__MISSING__SOURCE-ATTESTATION` | PROVENANCE | MISSING | SOURCE-ATTESTATION | REJECT | SEED |

### 10.5 Families with no current registry entry

The following families are valid and active in the taxonomy but have no seed code. They are available for consuming standard petitions.

| Family | Domain |
|---|---|
| STATE | Structural/Artifact |
| INVARIANT | Structural/Artifact |
| TRACEABILITY | Structural/Artifact |
| SECURITY | Trust/Assurance |

---

## 11. Related Artifacts

| Artifact ID | Role |
|---|---|
| `ADR-DECN-0010` | Decision record authorizing LES — grammar, autonomy posture, petition process |
| `ADR-DECN-0011` | Decision record authorizing NORM class — LES as STD-NORM artifact |
| `STD-NORM-0001` | Luphay Naming Standard — governs LES artifact identity and file naming |
| `STD-REFR-0007` | LES family taxonomy reference — full family definitions for lookup |
| `STD-REFR-0008` | LES seed catalog — full code entries with descriptions, agent behaviors, human actions |
| `STD-GUID-0003` | LES authoring guideline — practical guidance for code authors |
| `STD-TEMP-XXXX` | LES catalog entry template — standard structure for petitioning new codes |

---

## 12. Stewardship

Platform Governance holds steward authority for LES and this governing artifact for v1.x. Alpha Kamara is the designated steward at initial publication.

**Steward responsibilities:**
- reviewing and approving new code petitions
- reviewing and approving new category proposals within existing families
- initiating taxonomy amendment ADRs for new family proposals
- marking codes as deprecated and declaring successor codes
- maintaining the registry summary in §10 as the normative record
- versioning this standard when normative changes are made
