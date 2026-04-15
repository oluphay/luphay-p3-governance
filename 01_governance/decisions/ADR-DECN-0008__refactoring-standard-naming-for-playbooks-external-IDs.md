## ADR-DECN-0008: Refactoring Standard Naming for Playbooks and External IDs

**Date:** 2026-04-08  
**Status:** Decided  
**Proposer:** Alpha Kamara  

---

### 1. Context and Problem Statement

The previous naming standard for `STD` artifacts relied on a fixed 4-digit serial ID (`NNNN`). While this worked for internal sequential documents, it created two significant friction points for Luphay Technologies and the development of the **DRACO** compliance framework:

1.  **Missing Operational Layer:** There was no clear distinction between rigid, linear procedures (`PROC`) and situational, branching response patterns (`PLAY`).
2.  **ID Truncation Risk:** External regulatory and industry standards (e.g., ISO 27001, NIST 800-53, GDPR) often have IDs exceeding four digits. Truncating these to fit a fixed format compromised technical accuracy and slowed down automated cross-referencing in RegTech workflows.

---

### 2. Decision

We will update the naming formula for the `STD` family to support situational operational maneuvers and high-fidelity external identifiers.

**New Formula:**
```text
STD-[CLASS]-[ID]__[slug]__vX.Y.md
```

#### Key Changes:
* **Introduction of `PLAY` (Playbook):** A dedicated class for scenario-based response patterns, distinct from linear procedures (`PROC`).
* **Variable-Width IDs:** For `EXTR` (External) and `REGL` (Regulatory) classes, the full, original standard number must be used as the ID (e.g., `27001`, `2016679`).
* **Precedence Model Update:** The internal hierarchy is formally defined as:  
    `CONS (Constitution)` > `POLI (Policy)` > `PROC (Procedure) / PLAY (Playbook)` > `GUID (Guideline)`.

---

### 3. Rationale

* **Accuracy over Aesthetics:** In a compliance context, the technical accuracy of a regulatory ID (e.g., NIST `80053`) is more valuable for audit trails and machine-readability than a uniform 4-digit string.
* **Operational Agility:** By separating "The Tracks" (Procedures) from "The Strategy" (Playbooks), we allow teams to exercise expert judgment during incidents (e.g., Security Breach, Foster Care Complaint) without violating a rigid SOP.
* **Scalability for DRACO:** This naming convention allows the DRACO system to programmatically map internal `ADPT` (Adopted) standards directly to their `EXTR` counterparts using the source ID as a primary key.

---

### 4. Comparison of Class Boundaries

| Class | Trigger Type | Decision Points | Requirement |
| :--- | :--- | :--- | :--- |
| **PROC** | Routine / Scheduled | Zero (Linear path) | Mandatory Execution |
| **PLAY** | Event / Condition | Branching (If/Then) | Strategic Response |
| **GUID** | Continuous / General | Infinite (Judgment) | Advisory / Optional |

---

### 5. Consequences

* **Positive:** Enhanced clarity for documentation owners; easier integration with external regulatory databases; better alignment with SOC 2 and ISO requirements.
* **Neutral:** File lists will have "ragged" vertical alignment due to variable ID lengths.
* **Negative:** Requires a one-time migration/rename of existing external standard references to match the new full-ID logic.

---

### 6. Implementation Example

* **Internal:** `STD-PROC-0042__database-backup-procedure__v1.0.md`
* **External:** `STD-EXTR-27001__iso-infosec-management-standard__v2022.md`
* **Regulatory:** `STD-REGL-2016679__eu-general-data-protection-regulation__v1.0.md`