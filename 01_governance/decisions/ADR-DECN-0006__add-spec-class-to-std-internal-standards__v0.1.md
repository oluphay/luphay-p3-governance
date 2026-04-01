# Decision: Add SPEC Class to STD Internal Standards

```yaml
---
id: ADR-DECN-0006
title: Add SPEC (Specification) Class to STD Internal Standards
decision_type: Governance
scope_level: Enterprise
status: active
version: v0.1
effective_date: 2026-04-01
created_by: Alpha
created_at: 2026-04-01
related_artifacts:
  - STD-CONS-0001 (Luphay Naming Standard v0.5)
  - STD-CONS-0010 (Task Packet Standard v2.1)
  - STD-SPEC-0012 (Spec-Driven Development v0.3)
supersedes: null
---
```

---

## Decision

**Add `SPEC` as a new internal class code to §5.1 (STD — Standards) in the Luphay Naming Standard.**

`SPEC` is defined as: **Specification — formal system, methodology, or framework definitions with prescriptive structure but non-sequential organization.**

All new STD files of specification type shall use the `SPEC` class code. Existing files classified as `PROC`, `REFR`, or `GUID` are not retroactively reclassified.

---

## Rationale

### Problem

The current STD internal classes conflate distinct document types:

- **PROC** (Procedure) describes step-by-step sequential workflows — "do A, then B, then C."
- **SPEC** (Specification) describes system structure, methodology, or framework definitions — "the system is organized as X with properties Y and Z."
- **REFR** (Reference) provides static lookup data and glossaries — "look up the value of X in this table."
- **GUID** (Guideline) offers soft best-practice suggestions — "consider doing X."
- **CONS** (Constitution) defines foundational governance structure — "we have these governance layers and decision nodes."

Documents like "Spec-Driven Development" and "Task Packet Standard" are **specifications** — they define *how a system works*, not *how to perform a task sequentially*. They have internal structure and prescriptive rules, but are not procedural.

Current classification forces specification documents into adjacent classes:
- Forcing them into PROC overloads the procedure class and loses the specification intent.
- Forcing them into REFR misses that they are normative, not merely informational.

This creates ambiguity at filing time and makes the taxonomy harder to navigate operationally.

### Solution

Add `SPEC` as an explicit class in the STD internal standards hierarchy. This:

1. **Disambiguates specification documents** from procedures and reference material.
2. **Clarifies operational intent** — when someone files `STD-SPEC-[NNNN]`, it signals a system definition, not a sequential workflow or reference lookup.
3. **Maintains backward compatibility** — existing filings are unaffected; only new filings benefit from the clearer class.
4. **Aligns with domain practice** — "specification" is standard terminology in engineering and product development.

### Distinction Matrix

| Class | Purpose | Structure | Prescriptive? | Example |
| :--- | :--- | :--- | :--- | :--- |
| **CONS** | Define governance layers & authority | Meta-structural | Yes (foundational) | Org bylaws, naming standard |
| **SPEC** | Define system/methodology structure | System architecture | Yes (conformance required) | API spec, framework definition, methodology |
| **PROC** | Define sequential task execution | Step-by-step workflow | Yes (execution required) | Onboarding checklist, SOP |
| **REFR** | Provide static lookup data | Reference table | No (informational) | Glossary, lookup table, dataset |
| **GUID** | Suggest best practices | Flexible | No (advisory) | Code review guidelines, style guide |
| **POLI** | Define domain rules & constraints | Rule set | Yes (mandatory) | Data retention policy, security mandate |

---

## Alternatives Considered

### 1. Keep current system; force specifications into PROC

**Rejected.** Procedures are sequential; specifications are not. This conflates distinct concepts and increases filing ambiguity. Operational burden increases as filers must choose between related classes.

### 2. Expand REFR definition to explicitly cover specifications

**Rejected.** REFR is meant for informational/reference content (glossaries, lookup tables). Specifications are normative — they require conformance. Conflating reference data with normative system definitions diminishes the clarity of both.

### 3. Create a separate SPEC family (like TASK, STD, INTL)

**Rejected.** Specifications are a subtype of standards governance, not a separate governance family. They belong in the STD layer alongside policies, procedures, and guidelines. A separate family would fragment the standards layer unnecessarily.

### 4. Add SPEC and retire PROC entirely

**Rejected.** PROC remains essential for sequential operational workflows (checklists, SOPs, step-by-step guides). SPEC and PROC both serve governance; they are complementary, not competing.

---

## Follow-on Actions

### Immediate (This Release — LNS v0.6)

1. **Update LNS §5.1** — Insert SPEC into the internal classes table (position: between POLI and PROC).
2. **Update §10 Violation Reference** — Add anti-patterns for SPEC misclassification:
   - `STD-PROC-0012__spec-driven-development__v0.3.md` → use `STD-SPEC-0012`
   - `STD-REFR-0018__api-specification__v1.0.md` → use `STD-SPEC-0018` (if normative, not reference)
3. **Refile existing specification documents** with SPEC class:
   - `STD-SPEC-0012__spec-driven-development__v0.3.md` (was misclassified)
   - `STD-SPEC-0010__task-packet-standard__v2.1.md` (re-evaluate; may stay CONS if foundational)
4. **Bump LNS version** from v0.5 to v0.6 (minor version bump for new class).
5. **Update changelog** in LNS with v0.6 entry and decision basis.

### Medium Term

- Review existing STD-PROC and STD-REFR filings for SPEC mislabeling.
- Reissue any that should have been SPEC with correct class code.
- Update decision register to map both old and new filings.

### Governance

- This decision becomes effective 2026-04-01.
- LNS v0.5 is the last version using the old 6-class internal standards taxonomy.
- LNS v0.6 onwards uses the 7-class taxonomy (CONS, POLI, SPEC, PROC, TEMP, GUID, REFR).

---

## Impact Assessment

| Dimension | Impact | Severity |
| :--- | :--- | :--- |
| **Existing filings** | None (not retroactive) | Low |
| **New filings** | Clearer taxonomy; reduced ambiguity at classification time | Positive |
| **Governance layer** | STD-SYS-0001 unaffected; this is operational layer change | Low |
| **Training/onboarding** | Brief note added to LNS; no major retraining required | Low |
| **Interop with other systems** | None known | None |

---

## Decision Record Metadata

**Filed by:** Alpha  
**Consensus:** Single decision (design authority)  
**Reviewers:** —  
**Approved:** 2026-04-01  

This decision is **ACTIVE** as of 2026-04-01 and governs all LNS v0.6+ filings.

---

*ADR-DECN-0006 — Decision Record for STD Taxonomy Update*  
*Decision basis for LNS v0.6 release*
