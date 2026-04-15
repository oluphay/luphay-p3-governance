---
id: STD-TEMP-0015
title: LES Catalog Entry Template
status: draft
version: v0.1
steward: Platform Governance / Alpha Kamara
governing_standard: STD-NORM-0002
related_artifacts:
  - id: STD-NORM-0002
    title: LES Core Specification
    relationship: governing-standard
    role: Defines the petition process (§9) this template supports and
      the grammar and naming rules entries must conform to
    direction: upstream

  - id: STD-REFR-0007
    title: LES Family Taxonomy Reference
    relationship: companion-reference
    role: Family selection and boundary guidance for completing the
      Family, Category, and Object fields
    direction: peer

  - id: STD-REFR-0008
    title: LES Seed Catalog
    relationship: companion-reference
    role: Existing entries — consult before submitting a new code to
      confirm non-duplication
    direction: peer

  - id: STD-GUID-0003
    title: LES Authoring Guideline
    relationship: companion-advisory
    role: Practical guidance for completing each field in this template
    direction: peer
created_by: Alpha Kamara
created_at: 2026-04-12
---

# STD-TEMP-0015 — LES Catalog Entry Template
**Version:** v0.1 | **Status:** draft | **Governing standard:** STD-NORM-0002

---

## Changelog

### v0.1 — 2026-04-12
- Initial template. Covers all required fields for a LES catalog entry petition. Aligned with STD-NORM-0002 §9 petition process.

---

## 1. Purpose

This template is the standard structure for authoring a new LES code petition. Complete one copy of this template per proposed code. Submit the completed entry to the LES steward (Platform Governance) for review per STD-NORM-0002 §9.

**Before starting:**
1. Read STD-REFR-0007 to confirm your family selection
2. Check STD-REFR-0008 to confirm no existing code already covers the condition
3. Read STD-GUID-0003 for practical authoring guidance on each field
4. Read STD-NORM-0002 §9.1 for the full petition requirements checklist

A completed template that does not satisfy STD-NORM-0002 §9.1 will be returned without review.

---

## 2. Petition checklist

Before submitting, confirm all of the following:

- [ ] Proposed code is fully conformant with the locked LES grammar
- [ ] Family is drawn from the STD-REFR-0007 controlled family set
- [ ] Category is within the preferred band for the selected family
- [ ] Object identifies the affected thing — not a narrative explanation
- [ ] Non-duplication check complete — no existing code in STD-REFR-0008 covers this condition
- [ ] Cross-system applicability confirmed — at least one other Luphay system or context where this condition could plausibly occur is identified
- [ ] Consuming standard noted — the petitioning standard is named as first consumer
- [ ] All required fields below are populated

---

## 3. Entry template

Copy this block. Complete every field. Do not leave required fields blank.

---

### [PROPOSED CODE — replace with full LES code]

```
LES__[FAMILY]__[CATEGORY]__[OBJECT]
```

| Field | Value |
|---|---|
| **Code** | `LES__[FAMILY]__[CATEGORY]__[OBJECT]` |
| **Family** | [PRIMARY-TOKEN or PRIMARY-TOKEN-SUB-QUALIFIER] |
| **Category** | [PRIMARY-TOKEN or PRIMARY-TOKEN-SUB-QUALIFIER] |
| **Object** | [PRIMARY-TOKEN or PRIMARY-TOKEN-QUALIFIER or PRIMARY-TOKEN-QUALIFIER-QUALIFIER] |
| **Description** | [Plain-language description of the failure condition. Must be enterprise-scoped — not specific to one consuming standard. 1–3 sentences. Do not use narrative or explanation in this field — state the condition.] |
| **Agent behavior** | [What a consuming agent does when it receives this code. Choose from: REJECT / WARN / PROCEED. Add behavioral detail: what to halt, what to surface, what not to do. If behavior varies by system configuration, state the default and the variable.] |
| **Human action** | [What an operator does to triage and remediate. Start with investigation; follow with remediation; follow with retry condition. Be specific about sequence.] |
| **Dashboard label** | [Short label for log aggregation and observability dashboards. Format: `[Family concept] [mode] — [object]`. Maximum 8 words. All lowercase except proper nouns.] |
| **Severity** | UNASSIGNED |
| **Domain** | [One of: Structural/Artifact · Control/Governance · Runtime/Operational · Trust/Assurance] |
| **Entry stage** | PETITION |

---

### Petition metadata

| Field | Value |
|---|---|
| **Petitioning standard** | [Artifact ID of the consuming standard submitting this petition — e.g., LUP-LAMS-STD-0001] |
| **Petitioning standard status** | [DRAFT / ACTIVE / FROZEN] |
| **Failure condition source** | [Where this failure condition originates in the petitioning standard — e.g., `agent_contract.failure_semantics.on_stale_artifact`] |
| **Cross-system applicability** | [Name at least one other Luphay system or context where this condition could plausibly occur. If none can be identified, the petition will be deferred.] |
| **Non-duplication check** | [State which existing STD-REFR-0008 codes were reviewed and why they do not cover this condition.] |
| **Proposed family rationale** | [Why this family was chosen. Apply the boundary rules from STD-REFR-0007 §7 if two families were considered.] |
| **Proposed category rationale** | [Why this category was chosen from the preferred band for the selected family.] |
| **Proposed object rationale** | [Why this object token was chosen. If compound, explain each qualifier.] |
| **Family extension required** | [YES / NO. If YES, a taxonomy amendment ADR must accompany this petition per STD-NORM-0002 §9.3.] |
| **Submitted by** | [Name or role] |
| **Submitted at** | [ISO 8601 date] |

---

## 4. Field guidance summary

| Field | Common mistake | Correct approach |
|---|---|---|
| **Code** | Single underscores throughout | Use `__` between blocks, `-` within blocks |
| **Code** | Mixed case | All uppercase |
| **Code** | Two content blocks | All three (FAMILY, CATEGORY, OBJECT) are required |
| **Family** | Named after the emitting system | Named after the nature of the failure |
| **Category** | Carries family semantics | States only the failure mode |
| **Object** | Narrative explanation | Identifies the affected thing |
| **Description** | Consumer-specific framing | Enterprise-scoped condition |
| **Description** | Explanation of why it matters | Statement of what is wrong |
| **Agent behavior** | Generic "handle appropriately" | Explicit action with default and variable stated |
| **Human action** | One-word instruction | Investigate → remediate → retry sequence |
| **Dashboard label** | Too long or too abstract | Short, scannable, matches the code semantics |
| **Cross-system applicability** | "Other systems might use this" | Specific system or context named |

---

## 5. Steward review outcomes

After submission, the LES steward will return one of four outcomes per STD-NORM-0002 §9.4:

| Outcome | Meaning | Next action |
|---|---|---|
| **Accepted** | Code enters the registry | STD-REFR-0008 and STD-NORM-0002 §10 updated; petitioning standard may reference the code |
| **Redirected** | An existing code already covers this condition | Petitioning standard maps to the existing code |
| **Deferred** | Condition is consumer-specific or not yet demonstrably general | Resubmit when the consuming standard reaches ACTIVE status |
| **Rejected** | Code does not conform to grammar or taxonomy | Revise and resubmit; steward feedback will identify the specific issue |
