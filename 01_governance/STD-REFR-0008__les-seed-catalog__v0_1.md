---
id: STD-REFR-0008
title: LES Seed Catalog
status: draft
version: v0.1
catalog_stage: seed
steward: Platform Governance / Alpha Kamara
governing_standard: STD-NORM-0002
related_artifacts:
  - id: STD-NORM-0002
    title: LES Core Specification
    relationship: split-record
    role: STD-NORM-0002 §10 contains the normative registry summary;
      this reference contains the full entry detail. STD-NORM-0002 is
      authoritative on code existence; this reference is authoritative
      on code detail. Both must remain in sync.
    direction: upstream
    sync-required: true

  - id: STD-REFR-0007
    title: LES Family Taxonomy Reference
    relationship: companion-reference
    role: Family selection and boundary guidance for codes in this catalog
    direction: peer

  - id: STD-TEMP-0015
    title: LES Catalog Entry Template
    relationship: operational-tool
    role: Template used to author new entries submitted for registry inclusion
    direction: peer
created_by: Alpha Kamara
created_at: 2026-04-12
---

# STD-REFR-0008 — LES Seed Catalog
**Version:** v0.1 | **Status:** draft | **Catalog stage:** seed | **Governing standard:** STD-NORM-0002

---

## Changelog

### v0.1 — 2026-04-12
- Initial catalog. 12 seed codes across 4 domains, 3 per domain. Derived from WBS-01.3 locked taxonomy (STD-REFR-0007). Consumer-independent. Restructured from WBS-01.4 working document to governed reference artifact.

---

## 1. Purpose

This reference contains the full detail record for every code in the LES seed registry. It is the authoritative source for code descriptions, agent behaviors, human actions, dashboard labels, and domain assignments.

**STD-NORM-0002 §10** contains the normative registry summary — the authoritative record of code existence. This reference extends that summary with full operational detail. These two documents must remain in sync. If they conflict, STD-NORM-0002 governs on code existence; this reference governs on code detail.

---

## 2. Catalog principles

All codes in this catalog are:

- derived from the LES taxonomy (STD-REFR-0007), not from any consuming standard's failure modes
- general enough to apply across multiple Luphay systems
- conformant with the locked LES grammar (STD-NORM-0002 §4)
- stable as seed entries — consuming standards map to these codes where they fit and petition for extension where they do not

Consuming standards — including LAMS — map their failure modes to these codes where applicable. Where no code exists, they petition per STD-NORM-0002 §9.

---

## 3. Code entry structure

| Field | Description |
|---|---|
| **Code** | Full LES semantic key in locked grammar |
| **Family / Category / Object** | Parsed block values |
| **Description** | Plain-language failure condition |
| **Agent behavior** | What a consuming agent does on receiving this code |
| **Human action** | What an operator does to triage and remediate |
| **Dashboard label** | Short aggregation label for observability surfaces |
| **Severity** | `UNASSIGNED` — pending LES severity framework approval |
| **Domain** | Structural/Artifact · Control/Governance · Runtime/Operational · Trust/Assurance |
| **Entry stage** | `SEED` — pending steward review and formal registry lock |

---

## 4. Domain 1 — Structural / Artifact

*Families: IDENTITY · INPUT · LIFECYCLE*

---

### LES__IDENTITY__MISMATCH__ARTIFACT-ID

| Field | Value |
|---|---|
| **Code** | `LES__IDENTITY__MISMATCH__ARTIFACT-ID` |
| **Family** | IDENTITY |
| **Category** | MISMATCH |
| **Object** | ARTIFACT-ID |
| **Description** | The canonical identifier for an artifact or governed object disagrees across declared representations. The object cannot be reliably addressed until the conflict is resolved. Example applications: filename ID does not match front matter ID; registry ID does not match embedded object ID; alias or mapped identifier conflicts with canonical identifier. |
| **Agent behavior** | REJECT — halt processing; do not proceed on inference about which ID is authoritative; surface both conflicting values |
| **Human action** | Determine which ID is authoritative; correct the non-authoritative instance; verify no downstream references point to the incorrect ID |
| **Dashboard label** | Identity mismatch — artifact ID |
| **Severity** | UNASSIGNED |
| **Domain** | Structural / Artifact |
| **Entry stage** | SEED |

---

### LES__INPUT__MISSING__REQUIRED-INPUT

| Field | Value |
|---|---|
| **Code** | `LES__INPUT__MISSING__REQUIRED-INPUT` |
| **Family** | INPUT |
| **Category** | MISSING |
| **Object** | REQUIRED-INPUT |
| **Description** | A required input declared by the consuming process, artifact, or system is absent. Processing cannot proceed without it. |
| **Agent behavior** | REJECT — halt; surface the missing input reference; do not substitute inference or a default value |
| **Human action** | Supply the missing input; or update the declaration if the input is no longer required and the standard permits removal |
| **Dashboard label** | Input missing — required input |
| **Severity** | UNASSIGNED |
| **Domain** | Structural / Artifact |
| **Entry stage** | SEED |

---

### LES__LIFECYCLE__STALE__ARTIFACT

| Field | Value |
|---|---|
| **Code** | `LES__LIFECYCLE__STALE__ARTIFACT` |
| **Family** | LIFECYCLE |
| **Category** | STALE |
| **Object** | ARTIFACT |
| **Description** | A governed artifact remains present but has exceeded its declared freshness window, review interval, or acceptable currency threshold. Its content may no longer reflect current governing conditions, dependency versions, or approval state. |
| **Agent behavior** | Apply the consuming system's declared freshness behavior — WARN, REJECT, or PROCEED. Default to WARN if no behavior is declared. |
| **Human action** | Review the artifact for currency; re-approve and update the review timestamp if still valid; retire and replace if superseded |
| **Dashboard label** | Lifecycle stale — artifact |
| **Severity** | UNASSIGNED |
| **Domain** | Structural / Artifact |
| **Entry stage** | SEED |

---

## 5. Domain 2 — Control / Governance

*Families: AUTHORIZATION · POLICY · CONFIGURATION*

---

### LES__AUTHORIZATION__DENIED__REQUIRED-APPROVAL

| Field | Value |
|---|---|
| **Code** | `LES__AUTHORIZATION__DENIED__REQUIRED-APPROVAL` |
| **Family** | AUTHORIZATION |
| **Category** | DENIED |
| **Object** | REQUIRED-APPROVAL |
| **Description** | An action requiring formal approval was attempted without the required approval being present, valid, or within scope. The actor does not have the authority to proceed without it. |
| **Agent behavior** | REJECT — halt the action; surface the approval requirement and the identity of the required approver role; do not proceed or escalate autonomously |
| **Human action** | Obtain the required approval through the designated approval process; verify approval scope and expiry before retrying the action |
| **Dashboard label** | Authorization denied — required approval |
| **Severity** | UNASSIGNED |
| **Domain** | Control / Governance |
| **Entry stage** | SEED |

---

### LES__POLICY__VIOLATION__MANDATORY-RULE

| Field | Value |
|---|---|
| **Code** | `LES__POLICY__VIOLATION__MANDATORY-RULE` |
| **Family** | POLICY |
| **Category** | VIOLATION |
| **Object** | MANDATORY-RULE |
| **Description** | A mandatory governing rule, prohibition, or policy requirement has been violated by the current state, action, artifact, or output. The condition is non-negotiable and cannot be bypassed. |
| **Agent behavior** | REJECT — halt; surface the identity of the violated rule and the policy artifact it belongs to; do not proceed |
| **Human action** | Identify the violated rule via the surfaced policy reference; remediate the state, action, or artifact to achieve compliance; re-evaluate before retrying |
| **Dashboard label** | Policy violation — mandatory rule |
| **Severity** | UNASSIGNED |
| **Domain** | Control / Governance |
| **Entry stage** | SEED |

---

### LES__CONFIGURATION__MISSING__REQUIRED-PROFILE

| Field | Value |
|---|---|
| **Code** | `LES__CONFIGURATION__MISSING__REQUIRED-PROFILE` |
| **Family** | CONFIGURATION |
| **Category** | MISSING |
| **Object** | REQUIRED-PROFILE |
| **Description** | A required configuration profile, environment setting block, or operational parameter set is absent. The system or process cannot initialize or operate in its expected mode without it. |
| **Agent behavior** | REJECT — halt; surface the missing profile reference; do not default to an undeclared or inferred configuration state |
| **Human action** | Supply or register the required configuration profile in the appropriate configuration store; verify the profile is accessible to the consuming system before retrying |
| **Dashboard label** | Configuration missing — required profile |
| **Severity** | UNASSIGNED |
| **Domain** | Control / Governance |
| **Entry stage** | SEED |

---

## 6. Domain 3 — Runtime / Operational

*Families: DEPENDENCY · EXECUTION*

---

### LES__DEPENDENCY__UNRESOLVED__REQUIRED-ARTIFACT

| Field | Value |
|---|---|
| **Code** | `LES__DEPENDENCY__UNRESOLVED__REQUIRED-ARTIFACT` |
| **Family** | DEPENDENCY |
| **Category** | UNRESOLVED |
| **Object** | REQUIRED-ARTIFACT |
| **Description** | A required artifact declared as a dependency could not be located, retrieved, or verified at the declared location or version. Processing that depends on this artifact cannot proceed. |
| **Agent behavior** | Apply the consuming system's declared dependency-handling rule where one exists. If no dependency-handling rule is declared, default to REJECT. Surface the unresolved dependency reference, declared location, and required version or selector where available. |
| **Human action** | Verify the artifact exists at the declared location and version; update the dependency declaration if the artifact has moved, been re-versioned, or been retired |
| **Dashboard label** | Dependency unresolved — required artifact |
| **Severity** | UNASSIGNED |
| **Domain** | Runtime / Operational |
| **Entry stage** | SEED |

---

### LES__EXECUTION__FAILED__VALIDATION-STEP

| Field | Value |
|---|---|
| **Code** | `LES__EXECUTION__FAILED__VALIDATION-STEP` |
| **Family** | EXECUTION |
| **Category** | FAILED |
| **Object** | VALIDATION-STEP |
| **Description** | A validation step within a process, workflow, or pipeline ran to completion but returned a failure result. The step executed successfully as a process; the content or condition it evaluated did not pass. |
| **Agent behavior** | REJECT — halt the workflow at the failing step; surface the step identity and failure result; do not advance to downstream steps |
| **Human action** | Review the validation failure output; remediate the failing condition in the evaluated content; re-run the validation step after remediation |
| **Dashboard label** | Execution failed — validation step |
| **Severity** | UNASSIGNED |
| **Domain** | Runtime / Operational |
| **Entry stage** | SEED |

---

### LES__EXECUTION__TIMEOUT__WORKFLOW-STEP

| Field | Value |
|---|---|
| **Code** | `LES__EXECUTION__TIMEOUT__WORKFLOW-STEP` |
| **Family** | EXECUTION |
| **Category** | TIMEOUT |
| **Object** | WORKFLOW-STEP |
| **Description** | A workflow or pipeline step did not complete within its declared or system-enforced time limit. The step was running; it did not fail on content — it ran out of time. |
| **Agent behavior** | WARN — surface the timeout event with step identity and elapsed time; apply retry policy if declared; escalate to human via declared escalation path if retry limit is reached |
| **Human action** | Investigate the cause of the timeout — resource contention, step complexity, or infrastructure limits; adjust time limits, step scope, or resource allocation as appropriate; retry after remediation |
| **Dashboard label** | Execution timeout — workflow step |
| **Severity** | UNASSIGNED |
| **Domain** | Runtime / Operational |
| **Entry stage** | SEED |

---

## 7. Domain 4 — Trust / Assurance

*Families: INTEGRITY · SANITIZATION · PROVENANCE*

---

### LES__INTEGRITY__MISMATCH__CONTENT-HASH

| Field | Value |
|---|---|
| **Code** | `LES__INTEGRITY__MISMATCH__CONTENT-HASH` |
| **Family** | INTEGRITY |
| **Category** | MISMATCH |
| **Object** | CONTENT-HASH |
| **Description** | The computed content hash for a governed object does not match the expected or declared hash value. Content consistency or tamper-evidence cannot be trusted until the mismatch is resolved. |
| **Agent behavior** | REJECT — halt immediately; do not use the object's content for any downstream purpose; surface the hash mismatch for human investigation |
| **Human action** | Determine whether the content was intentionally modified without a corresponding hash update, or whether unauthorized alteration has occurred; re-hash after confirmed remediation; treat as a security event if tampering is suspected |
| **Dashboard label** | Integrity mismatch — content hash |
| **Severity** | UNASSIGNED |
| **Domain** | Trust / Assurance |
| **Entry stage** | SEED |

---

### LES__SANITIZATION__FAILED__CONTENT-SCAN

| Field | Value |
|---|---|
| **Code** | `LES__SANITIZATION__FAILED__CONTENT-SCAN` |
| **Family** | SANITIZATION |
| **Category** | FAILED |
| **Object** | CONTENT-SCAN |
| **Description** | A sanitization gate scanning content for prohibited patterns — including injection patterns, unsafe tokens, forbidden payloads, or disallowed constructs — detected a violation. The gate ran and explicitly failed; this is not a policy check. Example applications: prompt injection detected in a freetext field; forbidden token pattern found in payload; unsafe content identified at output filtering gate. |
| **Agent behavior** | REJECT — halt; quarantine the affected field content; do not process or forward the field; surface the scan result and the flagged field reference |
| **Human action** | Review the flagged content; identify and remove the prohibited pattern; re-submit through the sanitization gate after remediation; if the pattern was introduced maliciously, treat as a security event |
| **Dashboard label** | Sanitization failed — content scan |
| **Severity** | UNASSIGNED |
| **Domain** | Trust / Assurance |
| **Entry stage** | SEED |

---

### LES__PROVENANCE__MISSING__SOURCE-ATTESTATION

| Field | Value |
|---|---|
| **Code** | `LES__PROVENANCE__MISSING__SOURCE-ATTESTATION` |
| **Family** | PROVENANCE |
| **Category** | MISSING |
| **Object** | SOURCE-ATTESTATION |
| **Description** | Required origin attestation, issuer declaration, or trusted-source verification material is absent. The source of the governed object cannot be verified against an authorized or trusted origin. |
| **Agent behavior** | REJECT — halt; do not treat the artifact or payload as authoritative without verified provenance; surface the missing attestation reference |
| **Human action** | Obtain and attach the required origin attestation through the designated attestation process; if the source cannot be verified, escalate for governance review before the object is used |
| **Dashboard label** | Provenance missing — source attestation |
| **Severity** | UNASSIGNED |
| **Domain** | Trust / Assurance |
| **Entry stage** | SEED |

---

## 8. Seed catalog summary

| # | Code | Domain | Family | Category | Object |
|---|---|---|---|---|---|
| 1 | `LES__IDENTITY__MISMATCH__ARTIFACT-ID` | Structural/Artifact | IDENTITY | MISMATCH | ARTIFACT-ID |
| 2 | `LES__INPUT__MISSING__REQUIRED-INPUT` | Structural/Artifact | INPUT | MISSING | REQUIRED-INPUT |
| 3 | `LES__LIFECYCLE__STALE__ARTIFACT` | Structural/Artifact | LIFECYCLE | STALE | ARTIFACT |
| 4 | `LES__AUTHORIZATION__DENIED__REQUIRED-APPROVAL` | Control/Governance | AUTHORIZATION | DENIED | REQUIRED-APPROVAL |
| 5 | `LES__POLICY__VIOLATION__MANDATORY-RULE` | Control/Governance | POLICY | VIOLATION | MANDATORY-RULE |
| 6 | `LES__CONFIGURATION__MISSING__REQUIRED-PROFILE` | Control/Governance | CONFIGURATION | MISSING | REQUIRED-PROFILE |
| 7 | `LES__DEPENDENCY__UNRESOLVED__REQUIRED-ARTIFACT` | Runtime/Operational | DEPENDENCY | UNRESOLVED | REQUIRED-ARTIFACT |
| 8 | `LES__EXECUTION__FAILED__VALIDATION-STEP` | Runtime/Operational | EXECUTION | FAILED | VALIDATION-STEP |
| 9 | `LES__EXECUTION__TIMEOUT__WORKFLOW-STEP` | Runtime/Operational | EXECUTION | TIMEOUT | WORKFLOW-STEP |
| 10 | `LES__INTEGRITY__MISMATCH__CONTENT-HASH` | Trust/Assurance | INTEGRITY | MISMATCH | CONTENT-HASH |
| 11 | `LES__SANITIZATION__FAILED__CONTENT-SCAN` | Trust/Assurance | SANITIZATION | FAILED | CONTENT-SCAN |
| 12 | `LES__PROVENANCE__MISSING__SOURCE-ATTESTATION` | Trust/Assurance | PROVENANCE | MISSING | SOURCE-ATTESTATION |

---

## 9. Families not represented in this catalog

These families are valid and active in the taxonomy (STD-REFR-0007) but have no seed code. They are available for consuming standard petitions per STD-NORM-0002 §9.

| Family | Domain | Reason not seeded |
|---|---|---|
| STATE | Structural/Artifact | Deferred to later LES expansion. Initial seed set prioritized broader cross-system anchors before state-model-specific failures. |
| INVARIANT | Structural/Artifact | Deferred until a first cross-system invariant-breach pattern is demonstrated and can be seeded without overfitting to one consumer. |
| TRACEABILITY | Structural/Artifact | Deferred pending broader cross-system golden-thread and linkage context. |
| SECURITY | Trust/Assurance | Deferred until a threat-model-independent seed anchor is selected that does not collapse into AUTHORIZATION or SANITIZATION. |
