---
id: ADR-DECN-0004
title: Adopt LNS as Operational Naming Layer
class: Governance
status: accepted
version: v0.1
decision_type: Governance
scope_level: Enterprise
effective_date: 2026-03-27
related_artifacts:
  - LNS__luphay-naming-standard__v0.4.md
  - ADR-ARCH-0001__canonical-repo-hierarchy-and-navigation-model__v0.1.md
supersedes: DEC-0002
created_by: Alpha
created_at: 2026-03-27
---

# ADR-DECN-0004 — Adopt LNS as Operational Naming Layer

**Status:** Accepted
**Effective Date:** 2026-03-27
**Scope:** Enterprise

---

## 1. Context

Luphay Technologies operates with two distinct artifact populations:

- **Governance-tier artifacts** — policies, frozen standards, and audit-grade documents.
  These are already governed by STD-SYS-0001 (FROZEN, 2026-03-14).

- **Operational-tier artifacts** — task packets, research, media, records, decisions,
  architecture records, and P3 hierarchy documents. These are produced daily across
  all work contexts.

Prior to this decision, the operational tier had no single authoritative naming standard.
Naming was split across multiple legacy standards (TNS v1, SNS v1, SNS Extended v1,
IRNS v1, MANS v1, RNS v1) that were inconsistent in formula, separator conventions,
class code lengths, and ID formats. This created fragmentation, naming errors, and
increased cognitive load for both human operators and agentic toolchains.

A unified operational naming standard was drafted as LNS — the Luphay Naming Standard —
to consolidate all operational naming into a single document with one universal formula
and consistent rules across all artifact families.

---

## 2. Decision

**LNS (Luphay Naming Standard) is hereby adopted as the authoritative naming standard
for all operational-tier artifacts at Luphay Technologies.**

LNS governs the following artifact families:

| Prefix | Family |
|---|---|
| `TASK` | Task Packets |
| `STD` | Standards (operational subclasses) |
| `INTL` | Intelligence and Research |
| `MED` | Media and Assets |
| `ADR` | Records and Decisions |
| `P3` | Portfolio, Program, and Project hierarchy documents |

LNS does **not** govern STD-SYS-0001 or any artifact that falls under the
governance-tier naming layer. STD-SYS-0001 remains the authoritative standard
for frozen governance-tier artifacts. The two standards do not conflict.

The governing version at the time of this decision is **LNS v0.4**.

---

## 3. Rationale

### 3.1 Consolidation eliminates fragmentation

Six legacy standards (TNS, SNS, SNS Extended, IRNS, MANS, RNS) governed overlapping
artifact populations with inconsistent rules. LNS consolidates all of these into one
document with one formula. Any operator or agent needs to consult one source.

### 3.2 Universal formula reduces errors

The LNS universal formula — `[PREFIX]-[CLASS]-[ID]__[slug]__vX.Y.[ext]` — applies
uniformly across all families. Class codes are always 4 characters. IDs always use
sequence with leading zeros. Separators are always double underscore between the
identity block and slug. This uniformity reduces naming errors and makes validation
automatable.

### 3.3 Governance and operational tiers are cleanly separated

STD-SYS-0001 governs frozen, audit-grade artifacts. LNS governs everything produced
in daily operations. The separation is clear and the scope boundary is unambiguous.
When in doubt, use LNS.

### 3.4 Agentic toolchains benefit from a single reference

Claude Code and Codex both read naming standards to produce correctly named artifacts.
A single standard reduces the surface area for naming errors and makes agent output
more predictable.

---

## 4. Alternatives considered

**Alternative A — Extend STD-SYS-0001 to cover operational artifacts.**
Rejected. STD-SYS-0001 is FROZEN. Extending it would require a formal FROZEN document
change process for routine operational naming decisions. This would create governance
overhead disproportionate to the operational need.

**Alternative B — Maintain separate legacy standards.**
Rejected. Six inconsistent standards produced fragmented, error-prone naming. The
consolidation benefit of LNS outweighs the migration cost.

**Alternative C — Adopt LNS as a thin operational layer beneath STD-SYS-0001.**
Accepted. LNS operates as a second naming tier below the frozen governance standard.
The two layers are complementary, not competing.

---

## 5. Consequences

**Positive:**
- Single naming reference for all daily work
- Consistent formula across all artifact families
- Reduced naming errors and cleaner agent output
- Validation rules are uniform and automatable

**Negative:**
- Artifacts named under legacy standards (TNS, SNS, etc.) are not retroactively renamed
- Operators must learn LNS; the legacy standard names may cause confusion during transition

**Manageable:**
- LNS §10 Violation Reference provides a migration table mapping old patterns to new ones
- The decision register maps legacy IDs to current IDs where applicable

---

## 6. Effective scope and backcompat

All new artifacts produced after the effective date of this decision SHALL use LNS naming.

Artifacts produced before this decision under legacy naming standards are **not** renamed.
Their legacy IDs remain stable and are not invalidated. The decision register and artifact
register maintain the mapping between legacy IDs and current canonical IDs.

Exception: DEC-0001 through DEC-0003 (filed under the retired `DEC-DEC-[NNNN]` format)
are not renamed. All new decision records use `ADR-DECN-[NNNN]` per LNS v0.4 §8.2.

---

## 7. Related decisions

- **ADR-DECN-0005** — LNS formula wins for standards and task packets (companion decision)
- **ADR-ARCH-0001** — Canonical repo hierarchy and navigation model (structural context)

---

*luphay-p3-governance · decisions/ · ADR-DECN-0004*
