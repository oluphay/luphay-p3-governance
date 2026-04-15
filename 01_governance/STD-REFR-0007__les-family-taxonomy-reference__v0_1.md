---
id: STD-REFR-0007
title: LES Family Taxonomy Reference
status: draft
version: v0.1
steward: Platform Governance / Alpha Kamara
governing_standard: STD-NORM-0002
related_artifacts:
  - id: STD-NORM-0002
    title: LES Core Specification
    relationship: governing-standard
    role: Normative authority — this reference extends §5 of STD-NORM-0002
      with full lookup detail; STD-NORM-0002 is authoritative on all
      binding rules
    direction: upstream

  - id: STD-GUID-0003
    title: LES Authoring Guideline
    relationship: companion-advisory
    role: Practical authoring guidance for practitioners using this reference
    direction: peer

  - id: STD-REFR-0008
    title: LES Seed Catalog
    relationship: companion-reference
    role: Code-level detail; this reference governs family selection;
      STD-REFR-0008 governs code entries
    direction: peer
created_by: Alpha Kamara
created_at: 2026-04-12
---

# STD-REFR-0007 — LES Family Taxonomy Reference
**Version:** v0.1 | **Status:** draft | **Governing standard:** STD-NORM-0002

---

## Changelog

### v0.1 — 2026-04-12
- Initial reference. Derived from WBS-01.3 v0.2 (locked). Restructured from working document to governed reference artifact.

---

## 1. Purpose

This reference provides full lookup detail for the LES family taxonomy. It extends the normative family definitions in STD-NORM-0002 §5 with expanded examples, disambiguation guidance, agentic context notes, and cross-family navigation.

**STD-NORM-0002 is authoritative** on all binding rules. This reference is informational. Where this document and STD-NORM-0002 conflict, STD-NORM-0002 governs.

---

## 2. How to use this reference

**When authoring a new LES code:** Start at §3 (taxonomy design principle), then use §4 (family definitions) to identify the correct family. Apply §6 (assignment rules) to confirm your choice. If two families seem equally valid, use §7 (boundary rules) to resolve the ambiguity.

**When reviewing a petition:** Use §4 and §7 to evaluate whether the proposed family assignment is correct. Use §8 (consumer-independence rule) to evaluate whether the proposed code belongs in the enterprise registry.

**When building a consuming system:** Use §4 to understand what kind of failure conditions belong in each family before mapping your system's failure modes to LES codes.

---

## 3. Taxonomy design principle

LES codes answer three different questions in sequence:

```
FAMILY   = what kind of thing is wrong?
CATEGORY = how is it wrong?
OBJECT   = what specific thing is affected?
```

The taxonomy preserves this separation. Three violations to avoid:

- **Family drift** — using the family position to name the emitting component (e.g., `AGENT`, `CI-PIPELINE`, `VALIDATOR`). The emitter never defines the family.
- **Category leakage** — encoding family semantics in the category position (e.g., `LES__STATE__MISSING-INPUT__FILE` — MISSING-INPUT is family work, not category work).
- **Object as narrative** — using the object position for explanation rather than target identification (e.g., `USER-DID-NOT-SUPPLY-IT`).

---

## 4. Controlled family set

The following 15 families are the initial LES v0.1 controlled set. All are governed by STD-NORM-0002. New families require a taxonomy amendment ADR.

---

### 4.1 Domain: Structural / Artifact

#### IDENTITY

**Use when** the failure concerns identity, naming, UID resolution, alias resolution, identifier consistency, or identity-block agreement across declared representations.

**Examples of valid use:**
- The canonical identifier disagrees across filename and front matter
- A registry ID does not match the embedded object ID
- An alias or mapped identifier conflicts with the canonical identifier
- A UID cannot be resolved or has a collision

**Do not use when** the core problem is a missing prerequisite input — that belongs in INPUT. The distinction: with IDENTITY, the thing exists but its identity is wrong. With INPUT, the thing itself is absent.

**Preferred categories:** MISMATCH, INVALID, DUPLICATE, UNRESOLVED, AMBIGUOUS

---

#### INPUT

**Use when** the failure concerns required supplied inputs, declared inputs, inbound dependencies, or provided artifact inputs that are absent, unresolved, invalid, or incomplete.

**Examples of valid use:**
- A required input declared by a process is absent
- A declared dependency cannot be resolved at its stated location
- An input value does not conform to the required type or schema
- A required set of inputs is only partially provided

**Do not use for** persistent settings or static system profiles — those belong in CONFIGURATION. The distinction: INPUT values are provided per-invocation or declared per-artifact. CONFIGURATION values persist across invocations.

**Preferred categories:** MISSING, UNRESOLVED, INVALID, INCOMPLETE, UNSUPPORTED

---

#### STATE

**Use when** the current condition of an object or system makes an action or condition invalid, blocked, or impossible — but the issue is not lifecycle stage or status progression.

**Category disambiguation — INVALID vs ILLEGAL (important):**
- `INVALID` — the state value itself is not a recognized or permitted value in the system's state model. The state should not exist at all.
- `ILLEGAL` — the state value is recognized and permitted, but the action being attempted from that state is not allowed. The state is valid; the action or transition from it is not.

*Example: an object with status `UNKNOWN` → `LES__STATE__INVALID__STATUS` (unrecognized value). An object with status `DRAFT` where a publish operation is attempted without approval → `LES__STATE__ILLEGAL__PUBLISH-ATTEMPT` (valid state, disallowed action).*

**Do not use for** stage, status, or maturity progression failures — those belong in LIFECYCLE.

**Preferred categories:** INVALID, ILLEGAL, CONFLICT, BLOCKED, IMPOSSIBLE

---

#### INVARIANT

**Use when** a truth that must always hold has been broken — a structural or system truth that is non-negotiable regardless of policy or context.

**Examples of valid use:**
- A required relationship between two objects has not been preserved
- A structural consistency rule is violated
- A mandatory condition that must always be true is unsatisfied
- An internal consistency invariant has been broken

**Do not use for** missing/broken golden-thread links where the central issue is trace linkage — those belong in TRACEABILITY. Use INVARIANT when the broken truth is broader than a reference chain. Use TRACEABILITY when the broken truth is specifically a declared link that should exist.

**Do not use for** policy-rule violations — those belong in POLICY. INVARIANT is for structural truth; POLICY is for behavioral mandate.

**Preferred categories:** VIOLATION, BROKEN, UNSATISFIED, MISMATCH

---

#### LIFECYCLE

**Use when** the failure concerns status, stage, version, freshness, expiry, activation state, retirement state, or valid progression through a declared lifecycle model.

**Examples of valid use:**
- An artifact has exceeded its declared freshness window
- A status transition is attempted that is not permitted from the current stage
- An approval has expired and is no longer valid
- A retired object is being referenced as if it were active

**Do not use for** non-lifecycle runtime state conditions — those belong in STATE. LIFECYCLE is specifically about stage/status/freshness/progression. STATE is for all other invalid current-condition problems.

**Preferred categories:** INVALID, STALE, EXPIRED, RETIRED, PREMATURE

---

#### TRACEABILITY

**Use when** the failure concerns missing, broken, unresolved, or incomplete reference paths, evidence chains, parent-child mappings, lineage links, or golden-thread continuity.

**Examples of valid use:**
- A required source link is missing from a governed artifact
- An obligation-to-control chain is broken
- A reference path cannot be resolved
- An evidence thread required for audit is incomplete

**Do not use when** the broken condition is broader than trace linkage — that belongs in INVARIANT. The key test: if the failure is specifically about a declared link or reference path that should exist, use TRACEABILITY. If the failure is about a structural truth that holds independently of any specific link, use INVARIANT.

**Preferred categories:** MISSING, BROKEN, UNLINKED, INCOMPLETE, UNRESOLVED

---

### 4.2 Domain: Control / Governance

#### AUTHORIZATION

**Use when** the failure concerns permission to act, approval rights, allowed scope, delegation boundaries, or decision authority.

**Examples of valid use:**
- An action requiring formal approval is attempted without the approval present
- An actor attempts to operate outside their authorized scope
- Authorization has expired and is no longer valid
- A delegation boundary is exceeded

**Do not use for** broader security control failures such as threat detection, secret exposure, or authentication failures — those belong in SECURITY. AUTHORIZATION is specifically about whether the actor has permission to perform the action. SECURITY is about protective controls and threat conditions.

**Preferred categories:** DENIED, MISSING, FORBIDDEN, EXPIRED, OUT-OF-SCOPE

---

#### POLICY

**Use when** the failure concerns a violated rule, prohibition, mandate, required control, or governance requirement — where the governing instrument is a formal policy.

**Examples of valid use:**
- A prohibited action has been attempted
- A mandatory governance rule has not been satisfied
- Behavior is noncompliant with a formal requirement
- A required approval under policy is missing

**Do not use for** structural truths that must hold irrespective of policy language — those belong in INVARIANT. If the condition would still be a failure even if no policy existed, it is INVARIANT. If the failure is specifically about violating a formally stated rule, it is POLICY.

**Preferred categories:** VIOLATION, FORBIDDEN, REQUIRED, NONCOMPLIANT

---

#### CONFIGURATION

**Use when** the failure concerns configuration state, profiles, environment setup, mode settings, parameters, or static operational setup where values persist across multiple invocations.

**Examples of valid use:**
- A required configuration profile is absent
- A configuration value is invalid or out of range
- Two configuration settings conflict
- An environment parameter is set to an unsupported value

**Do not use for** runtime-supplied input data that is provided per-invocation or per-artifact — those belong in INPUT.

**Agentic context:** An agent reading a configuration file that persists across runs is consuming CONFIGURATION, not INPUT. If the agent receives a parameter set as part of a task packet specific to the current run, that is INPUT.

**Preferred categories:** MISSING, INVALID, CONFLICT, INCOMPATIBLE, UNSUPPORTED

---

### 4.3 Domain: Runtime / Operational

#### DEPENDENCY

**Use when** the failure concerns a prerequisite service, artifact, contract, system, or dependency that is missing, unavailable, unresolved, or incompatible — and this prevents the real action from beginning.

**Examples of valid use:**
- An upstream service is unavailable
- A required contract artifact cannot be located
- A dependency resolution step fails
- A prerequisite component is incompatible with the required version

**Do not use when** the action itself has started and then fails during execution — that belongs in EXECUTION. The test: if the failure occurs before the main action can begin because a prerequisite is absent, use DEPENDENCY. If the main action runs and then fails, use EXECUTION.

**Preferred categories:** MISSING, UNAVAILABLE, UNRESOLVED, TIMEOUT, INCOMPATIBLE

---

#### EXECUTION

**Use when** the failure concerns a running process, workflow, command, validation step, or execution attempt that fails, aborts, times out, or is interrupted after it has begun.

**Examples of valid use:**
- A validation step runs to completion but the evaluated content does not pass
- A workflow step times out during execution
- A process is aborted mid-run
- A run is interrupted by an external condition

**Do not use when** the operation could not begin because a prerequisite was absent — that belongs in DEPENDENCY. The distinction is whether the main action ever started. If it started and failed, use EXECUTION. If it couldn't start, use DEPENDENCY.

**Preferred categories:** FAILED, TIMEOUT, INTERRUPTED, ABORTED, BLOCKED

---

### 4.4 Domain: Trust / Assurance

#### INTEGRITY

**Use when** the failure concerns tamper evidence, content consistency, hash agreement, checksum agreement, immutability expectations, or signature-content agreement.

**Examples of valid use:**
- The computed content hash does not match the declared hash
- A checksum is invalid
- An integrity proof is missing from a release-grade artifact
- Content has been corrupted

**Do not use when** the issue is source trust or lineage authenticity rather than content consistency — that belongs in PROVENANCE. The distinction: INTEGRITY is about whether the content is what it claims to be (tamper detection, hash agreement). PROVENANCE is about whether the source is who it claims to be (issuer trust, origin verification).

**Preferred categories:** MISMATCH, MISSING, CORRUPT, TAMPERED, INVALID

---

#### SANITIZATION

**Use when** the failure concerns hygiene gates, redaction, content cleaning, allowlist/blocklist scans, secret removal, or output safety filtering — specifically when a dedicated sanitization step ran and returned failure.

**Examples of valid use:**
- A sanitization gate detects an injection pattern in a freetext field
- A forbidden token pattern is found in a payload
- An unredacted sensitive field is present after a redaction step
- A content scan at an output filtering gate fails

**Do not use for** broader governance-rule violations unless the immediate failed mechanism is actually the sanitization gate. If a policy evaluation detects noncompliance without a hygiene step being involved, use POLICY. SANITIZATION requires that a dedicated cleaning/scanning/filtering step explicitly ran and returned failure.

**Preferred categories:** FAILED, UNSAFE, FORBIDDEN, UNCLEAN, UNREDACTED

---

#### PROVENANCE

**Use when** the failure concerns source origin, issuer legitimacy, authorship, attestation, lineage authenticity, or trusted-source verification.

**Examples of valid use:**
- Required origin attestation is absent from an artifact
- A source cannot be verified against a trusted issuer
- The issuer of a payload is unknown or unrecognized
- Authorship attestation is missing from a governed document

**Do not use for** content tamper or hash mismatch — that belongs in INTEGRITY. PROVENANCE is about *who* produced the content and whether that source is trusted. INTEGRITY is about *whether* the content has been altered.

**Preferred categories:** MISSING, UNVERIFIED, UNTRUSTED, MISMATCH, UNKNOWN

---

#### SECURITY

**Use when** the failure concerns security controls, authentication/session failures, exposure of secrets, threat detection, suspicious access patterns, or protective enforcement failures.

**Examples of valid use:**
- An authentication state is invalid or expired
- A secret value is detected in output or a log
- A threat is detected in access patterns
- A security control blocks an action due to a detected condition

**Do not use for** ordinary permission-to-act questions — those belong in AUTHORIZATION. SECURITY is for defensive controls, threat conditions, authn/session failures, and exposure events. AUTHORIZATION is for permission-scope decisions.

**Preferred categories:** FAILED, DETECTED, EXPOSED, INVALID, BLOCKED

---

## 5. Preferred category bands

These constrain authoring but do not freeze the registry. New categories within an existing family may be approved by steward decision alone (no ADR required).

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

## 6. Code assignment rules

**Rule 6.1 — Family by semantic locus, not emitting component.**
The code family is determined by the nature of the failure itself, not by where it appeared. A CI pipeline may emit INPUT. A runtime may emit POLICY. An agent may emit INTEGRITY.

**Rule 6.2 — Narrowest correct family.**
When multiple families seem plausible, choose the most semantically specific. Quick preferences:
- LIFECYCLE over STATE when the issue is stage/status/freshness
- AUTHORIZATION over SECURITY when the issue is permission scope
- TRACEABILITY over INVARIANT when the issue is a broken link chain
- CONFIGURATION over INPUT when the issue is static setup

**Rule 6.3 — Structural separation.**
Family = kind. Category = mode. Object = target. These are three distinct questions and must not collapse into each other.

**Rule 6.4 — Stable enterprise vocabulary.**
Prefer terms that travel across systems: `AGENT-CONTRACT`, `CONTENT-HASH`, `STATUS-TRANSITION`, `REQUIRED-INPUT`. Avoid implementation-local jargon.

**Rule 6.5 — Sub-families are exceptional.**
A sub-family qualifier is permitted only when: the distinction is durable, reusable across multiple codes, materially improves grep/aggregation value, and cannot be handled at object level.

*Accepted:* `LES__INPUT-FILE__MISSING__REQUIRED-COLUMN` — if FILE-type inputs fail distinctly from other INPUT types across systems.

*Rejected:* `LES__INPUT-ARTIFACT__MISSING__REQUIRED-INPUT` — if ARTIFACT is the only INPUT kind the system handles, the sub-qualifier adds no filtering value. Put specificity in the object: `LES__INPUT__MISSING__REQUIRED-ARTIFACT`.

**Rule 6.6 — Codes are stable once issued.**
Once a code enters the registry it must remain stable. Formal deprecation with a declared successor is the only exit path.

---

## 7. Boundary rules

| Family pair | Decision rule |
|---|---|
| IDENTITY vs INPUT | Use INPUT when something required was not supplied or resolved. Use IDENTITY when the thing exists but its identifier is wrong or inconsistent. |
| STATE vs LIFECYCLE | Use STATE for invalid current-condition problems. Use LIFECYCLE for status, stage, freshness, expiry, or progression problems. |
| INVARIANT vs TRACEABILITY | Use INVARIANT when a must-always-hold structural truth is broken regardless of reference chains. Use TRACEABILITY when the central problem is the absence or break of a declared reference relationship. |
| INVARIANT vs POLICY | Use INVARIANT for structural/system truth. Use POLICY for rule/mandate/prohibition failure. |
| AUTHORIZATION vs SECURITY | Use AUTHORIZATION for permission-to-act questions. Use SECURITY for protective controls, authn/session failures, exposure, or threat conditions. |
| INPUT vs CONFIGURATION | Use INPUT for values provided per-invocation or declared per-artifact. Use CONFIGURATION for values that persist across invocations and are managed outside the execution context. |
| DEPENDENCY vs EXECUTION | Use DEPENDENCY when a prerequisite is absent before the action can begin. Use EXECUTION when the action itself runs and then fails. |
| INTEGRITY vs PROVENANCE | Use INTEGRITY when content agreement or tamper-evidence is broken. Use PROVENANCE when source legitimacy, issuer trust, or origin verification is broken. |
| SANITIZATION vs POLICY | Use SANITIZATION when a dedicated hygiene/filtering step explicitly ran and returned failure. Use POLICY when noncompliance is detected through policy evaluation alone with no sanitization step involved. |

---

## 8. Consumer-independence rule

LES taxonomy is enterprise-scoped and consumer-independent.

- No consumer gets automatic authority to add a family.
- No draft consumer gets automatic authority to reshape boundaries.
- No consumer-specific convenience category is admitted unless it improves the enterprise language.
- Consumer-specific special cases must first attempt representation using the existing LES family/category/object model.
- When representation is genuinely inadequate, the consumer must propose a formal LES change through the petition process (STD-NORM-0002 §9).

**A proposed LES extension should pass all of the following tests:**
1. The condition is not already cleanly representable with existing LES structure.
2. The condition is semantically distinct from existing codes.
3. The condition is likely reusable beyond one narrow consumer context.
4. The condition is worth stabilizing at enterprise standard level.

If those tests fail, the consumer adapts to LES. LES does not adapt to the consumer.
