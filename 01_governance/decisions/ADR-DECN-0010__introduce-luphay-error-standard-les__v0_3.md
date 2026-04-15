---
id: ADR-DECN-0010
title: Introduce the Luphay Error Standard (LES)
decision_type: Governance
scope_level: Enterprise
status: draft
version: v0.3
effective_date: 2026-04-12
related_artifacts:
  - STD-NORM-0001
  - LUP-LAMS-STD-0001
supersedes:
created_by: Alpha Kamara
created_at: 2026-04-12
---

# ADR-DECN-0010 — Introduce the Luphay Error Standard (LES)

---

## Changelog

### v0.3 — 2026-04-12
- Established LES autonomy principle: LES is designed independently of any consuming standard. Consuming standards adopt LES codes; they do not drive LES design.
- Updated §4.6 to reflect LES autonomy rationale.
- Updated §5.5 to reframe LAMS as a consumer that adopts LES codes and petitions for new ones — not a design driver.
- Added §5.8: Consumer Petition Process — the minimum bar for a consuming standard to request a new LES code or family.
- Updated §8.3: seed registry scope is now a representative cross-domain spread (2–3 codes per domain, 8–12 total), not LAMS-coverage-first.
- Updated §8.4: LAMS adopts LES autonomously; LAMS-specific failure modes not covered by the seed registry require a petition.
- Updated §12: renamed `STD-REFR-0008` slug from `lams-les-starter-catalog` to `les-seed-catalog`.
- Updated §13 decision summary to reflect autonomy posture.

### v0.2 — 2026-04-12
- Locked LES grammar: replaced single-underscore delimiter scheme with a two-delimiter grammar.
- `__` (double underscore) is now the block boundary delimiter separating FAMILY, CATEGORY, and OBJECT.
- `-` (hyphen) is now the qualifier delimiter within a block — right side always narrows left side (primary-qualifier relationship).
- All three content blocks (FAMILY, CATEGORY, OBJECT) are mandatory in v0.1 — no optional blocks.
- Updated §1, §4.3, §5.2, §5.3, §8.2, and §13 to reflect locked grammar.
- Updated all examples to use `LES__FAMILY__CATEGORY__OBJECT` form.

### v0.1 — 2026-04-12
- Initial decision record. Decision: approved for introduction.

---

## 1. Decision

Luphay Technologies hereby introduces the **Luphay Error Standard (LES)** as the enterprise naming and semantic standard for governed error conditions, validation failures, invariant breaches, illegal transitions, integrity failures, and other formally diagnosable abnormal states across Luphay systems.

LES is established as the canonical error naming layer for both:
- human operators, and
- machine consumers, including agents, validators, pipelines, runtimes, and future audit or governance systems.

LES shall provide a common, grep-friendly, machine-readable, and human-legible language for error identification and classification.

The locked LES grammar is:

```text
LES__[FAMILY(-SUB-FAMILY)]__[CATEGORY(-SUB-CATEGORY)]__[OBJECT(-QUALIFIER...)]
```

Where:
- `LES` = Luphay Error Standard prefix — fixed, always first
- `FAMILY` = the broad semantic family of the failure
- `CATEGORY` = the failure mode or error type within that family
- `OBJECT` = the affected object, condition, or concrete detail

**Delimiter rules:**
- `__` (double underscore) = block boundary — separates `LES` from FAMILY, FAMILY from CATEGORY, and CATEGORY from OBJECT. A parser splits on `__` to extract blocks.
- `-` (hyphen) = qualifier boundary — separates a primary token from its narrowing sub-qualifier within a single block. The right side of a `-` always narrows the left side. This is a primary-qualifier relationship, not free-form compounding.

**Block rules:**
- All three content blocks — FAMILY, CATEGORY, OBJECT — are REQUIRED. A code without all three blocks is non-conformant.
- FAMILY and CATEGORY MUST begin with a single primary word. A sub-qualifier is optional and must narrow the primary.
- OBJECT MUST begin with a single primary word. One or more qualifiers are permitted; each narrows the preceding token.
- All characters MUST be uppercase.
- Codes MUST remain grep-friendly and MUST NOT be redefined once issued.

**Grammar expressed formally:**

```text
LES__FAMILY__CATEGORY__OBJECT

  FAMILY   = PRIMARY-TOKEN[-SUB-QUALIFIER]
  CATEGORY = PRIMARY-TOKEN[-SUB-QUALIFIER]
  OBJECT   = PRIMARY-TOKEN[-QUALIFIER[-QUALIFIER...]]
```

**Examples:**

| Code | FAMILY | CATEGORY | OBJECT |
|---|---|---|---|
| `LES__INPUT__MISSING__REQUIRED-COLUMN` | INPUT | MISSING | REQUIRED-COLUMN |
| `LES__INPUT-FILE__MISSING__REQUIRED-COLUMN` | INPUT-FILE | MISSING | REQUIRED-COLUMN |
| `LES__STATE__INVALID__TRANSITION` | STATE | INVALID | TRANSITION |
| `LES__INVARIANT__VIOLATION__REQUIRED-LINK` | INVARIANT | VIOLATION | REQUIRED-LINK |
| `LES__INTEGRITY__MISMATCH__CONTENT-HASH` | INTEGRITY | MISMATCH | CONTENT-HASH |
| `LES__LIFECYCLE__INVALID__STATUS-TRANSITION` | LIFECYCLE | INVALID | STATUS-TRANSITION |

**Grep examples:**

```bash
grep "LES__INPUT"            errors.log   # all INPUT family errors
grep "LES__INPUT__MISSING"   errors.log   # all INPUT/MISSING errors
grep "LES__INPUT-FILE"       errors.log   # INPUT sub-family FILE only
```

This ADR authorizes formal development of the LES standard family, including:
- a core LES specification
- LES grammar rules
- LES family taxonomy
- LES catalog entries
- LES payload guidance
- LES usage guidance for systems that emit or consume LES codes

---

## 2. Context

Luphay has now formalized important foundational standards that govern:
- artifact identity and naming through the **Luphay Naming Standard (LNS)** (`STD-NORM-0001`), and
- machine-readable artifact context and execution governance through the **Luphay Artifact Metadata Standard (LAMS)** (`LUP-LAMS-STD-0001`).

As Luphay moves from exploratory system-building into more formal specification and governed execution, the absence of a standard diagnostic language creates increasing friction.

At present, systems may detect failures, but without a unified naming convention those failures risk being expressed inconsistently across:
- validators
- agents
- runtime systems
- workflows
- logs
- test harnesses
- CI pipelines
- governance checks
- future audit and compliance layers

This problem became concrete during the evolution of **LAMS**, where the standard already contains many governed failure conditions, including:
- UID resolution failure
- missing or unresolved inputs
- invariant violations
- stale artifacts
- absence of required `agent_contract`
- sanitization rule violations
- release-grade integrity failures

LAMS therefore created the immediate operational need for a formal error naming standard.

At the same time, LNS already defines a disciplined naming culture for artifacts and governed files across Luphay. The next natural step is to establish a corresponding naming discipline for **failure states and error semantics**.

In effect:

- **LNS names the artifact**
- **LAMS describes the artifact**
- **LES names what is wrong with the artifact or governed action**

LES is therefore introduced as the missing diagnostic layer in the emerging Luphay standards stack.

---

## 3. Problem Statement

Without a formal error standard:

1. the same failure can be named differently in different systems
2. agents may interpret similar failures inconsistently
3. logs become harder to grep, aggregate, and analyze
4. CI and validators lose semantic precision
5. operator triage becomes slower
6. dashboards and metrics fragment around ad hoc phrasing
7. governance and audit trails lose consistency
8. future cross-system observability becomes weaker
9. future machine reasoning over error conditions becomes harder
10. Luphay loses the opportunity to build a shared internal failure ontology

A governed company needs not only standards for what should exist, but also standards for how deviations, failures, and invalid states are represented.

---

## 4. Rationale

The decision to introduce LES is based on the following rationale.

### 4.1 A universal error language is now necessary
Luphay systems are becoming increasingly structured, interdependent, and machine-consumable. As these systems mature, governed failure representation becomes necessary rather than optional.

### 4.2 LES complements LNS and LAMS
LNS establishes naming discipline for files and artifacts. LAMS establishes machine-readable execution and governance context. LES complements both by standardizing the language of abnormal conditions and failed expectations.

### 4.3 LES supports both humans and agents
The two-delimiter grammar `LES__[FAMILY]__[CATEGORY]__[OBJECT]` is unambiguous to parsers (split on `__` for blocks; split on `-` for qualifiers within a block) and readable on sight to humans. Block boundaries are visually distinct from internal qualification. This design deliberately follows the same two-delimiter logic already established in LNS filenames.

### 4.4 Full semantic families are preferred over abbreviated families
Luphay has chosen to prefer explicit family names such as:
- `IDENTITY`
- `INPUT`
- `STATE`
- `INVARIANT`
- `AUTHORIZATION`
- `DEPENDENCY`
- `POLICY`
- `INTEGRITY`
- `SANITIZATION`
- `EXECUTION`

rather than compressed forms such as:
- `IDEN`
- `INPT`
- `INVT`

This improves on-the-fly readability and reduces ambiguity.

### 4.5 LES should begin with semantic keys before full catalog maturity
At this stage of development, highly readable semantic codes are preferable to opaque numeric-only identifiers. They will help shape Luphay's internal language and allow rapid operational use.

### 4.6 LES must be autonomous — consuming standards adopt, not drive
LES is a company-wide infrastructure standard. Its taxonomy and registry must be designed to serve all Luphay systems, not shaped by the current state of any single consuming standard. A consuming standard in early development — such as LAMS, which is currently DRAFT — may change its internal failure semantics before it reaches ACTIVE status. If LES is seeded by a DRAFT consuming standard's failure modes, two failure modes emerge:

- LES codes that reflect superseded design decisions in the consuming standard
- forced LES revision cycles tied to a consuming standard's instability

The correct posture is: LES is designed from the taxonomy up, independent of any consumer. Consuming standards identify which LES codes map to their failure modes. Where no code exists, they petition the LES steward. This keeps LES stable and cross-system, and keeps each consuming standard responsible for its own mapping work.

---

## 5. Decision Details

### 5.1 LES is established as an enterprise standard family
LES is now recognized as a formal Luphay standard family for error naming and diagnostic semantics. Its governing artifact is `STD-NORM-0002`.

### 5.2 Locked semantic code structure
The approved and locked LES semantic code structure is:

```text
LES__[FAMILY(-SUB-FAMILY)]__[CATEGORY(-SUB-CATEGORY)]__[OBJECT(-QUALIFIER...)]
```

This structure is locked as of ADR-DECN-0010 v0.2. Changes to the grammar shape require a new ADR.

### 5.3 Naming rules

**Delimiter rules:**
- `__` (double underscore) MUST be used as the block boundary delimiter between all blocks
- `-` (hyphen) MUST be used as the qualifier delimiter within a block
- single underscore `_` MUST NOT appear anywhere in a conformant LES code
- all characters MUST be uppercase

**Block rules:**
- token order MUST be `LES`, then `FAMILY`, then `CATEGORY`, then `OBJECT` — separated by `__`
- all three content blocks MUST be present — a code missing any block is non-conformant
- `FAMILY` MUST represent the broad semantic failure family; MUST be a single primary word; MAY include one sub-qualifier that narrows it
- `CATEGORY` MUST represent the error mode within the family; MUST be a single primary word; MAY include one sub-qualifier that narrows it
- `OBJECT` MUST identify the concrete object, condition, or detail; MUST begin with a single primary word; MAY include one or more qualifiers each narrowing the preceding token

**Qualifier rules:**
- the `-` qualifier relationship is always primary-qualifier: the right side narrows the left side
- qualifiers MUST NOT be used to form free compound words unrelated to the primary token
- `FAMILY` and `CATEGORY` SHOULD be expressible as a single primary word without a sub-qualifier wherever possible — qualifiers at these positions are for genuine sub-family or sub-category precision only

**Stability rules:**
- semantic keys MUST remain stable once issued — a code MUST NOT be redefined or deleted
- deprecated codes MUST be marked deprecated with a successor code declared
- new codes require steward approval before catalog entry

### 5.4 Initial example families
The following candidate families are accepted as valid starting points for LES exploration:

- `IDENTITY`
- `INPUT`
- `STATE`
- `INVARIANT`
- `AUTHORIZATION`
- `DEPENDENCY`
- `POLICY`
- `INTEGRITY`
- `SANITIZATION`
- `EXECUTION`
- `LIFECYCLE`
- `CONFIGURATION`
- `PROVENANCE`
- `SECURITY`
- `TRACEABILITY`

These are approved as initial working families, not yet a frozen final taxonomy.

### 5.5 First consumer — adoption model
**LAMS** (`LUP-LAMS-STD-0001`) is designated as the first formal consumer of LES.

The adoption model is:
- LAMS examines its failure modes and maps each to an existing LES code where one exists
- where no LES code covers a LAMS failure mode, LAMS petitions the LES steward per §5.8
- LAMS does not drive LES design — LAMS makes the case for inclusion; LES steward decides

LAMS is currently in DRAFT status. Its internal failure semantics may change before it reaches ACTIVE. LES codes adopted by LAMS must meet the general LES standard — they are not LAMS-specific constructs. Any LAMS failure mode that cannot be expressed within the existing LES taxonomy without compromising cross-system applicability will be deferred until LAMS reaches ACTIVE status and the failure mode is confirmed stable.

### 5.6 LES scope
LES is intended to eventually apply across:
- standards validation
- artifact validation
- agent execution
- CI/CD pipelines
- runtime services
- workflow engines
- governance checks
- integrity verification
- future DRACO-oriented systems
- audit and observability surfaces

### 5.7 Stewardship
Platform Governance holds steward authority for LES and the `STD-NORM-0002` governing artifact for v1.x. All code addition, deprecation, and family extension requests route through Platform Governance. Alpha Kamara is the designated steward at initial publication.

### 5.8 Consumer petition process
When a consuming standard requires an error code that does not exist in the LES registry, the consuming standard MUST submit a petition to the LES steward. The minimum bar for a petition to be accepted is:

**Petition requirements:**
1. **Proposed code** — a fully conformant LES code in the locked grammar
2. **Family/category/object assignment** — explicit declaration of which family, category, and object the proposed code occupies, with rationale for each choice
3. **Failure description** — a plain-language description of the failure condition the code represents
4. **Cross-system applicability** — demonstration that the failure condition is not unique to the petitioning standard; at least one other Luphay system or context where the condition could plausibly occur must be identified
5. **Non-duplication check** — confirmation that no existing LES code covers the condition, including near-matches with different OBJECT tokens

**Steward review criteria:**
- Conformance to locked grammar
- Fit within existing family/category taxonomy — does the proposed code sit naturally within declared families and preferred category bands?
- Cross-system applicability — is this a general condition or a consuming-standard-specific construct?
- Non-duplication — does an existing code already cover this condition?

**Family extension rule:**
- A petition that requires a new top-level FAMILY that does not exist in the authorized family set MUST be accompanied by a taxonomy amendment ADR. A steward decision alone is not sufficient to add a new family.
- A petition that requires only a new CATEGORY or OBJECT within an existing family may be approved by steward decision alone.

**Petition outcome:**
- **Accepted** — code enters the registry; petitioning standard is noted as first consumer
- **Redirected** — an existing code already covers the condition; petitioning standard maps to it
- **Deferred** — failure mode is consuming-standard-specific and not yet general; revisit when the consuming standard reaches ACTIVE status
- **Rejected** — proposed code does not conform to grammar or taxonomy; petitioning standard must revise and resubmit

---

## 6. Alternatives Considered

### Alternative A — Continue using ad hoc free-text error messages
Rejected.

Reason:
This would preserve inconsistency, reduce grep-ability, weaken aggregation, and block the emergence of a shared diagnostic language.

### Alternative B — Use short abbreviated family tokens
Rejected for primary use.

Reason:
Abbreviations reduce immediate readability and introduce ambiguity. Full family names are more usable in live triage and standards work.

### Alternative C — Use numeric-only error identifiers from the start
Deferred.

Reason:
Numeric identifiers may later be useful for long-term stability and governance references, but semantic keys are more useful during initial adoption and language formation.

### Alternative D — Create separate error vocabularies per system
Rejected.

Reason:
This would fragment Luphay's operating language and reduce cross-system interoperability.

### Alternative E — Single-underscore delimiter throughout
Rejected.

Reason:
A single delimiter between all tokens — blocks and qualifiers alike — creates structural ambiguity. A parser and a human reader cannot determine reliably where one block ends and another begins when compound tokens are permitted. The two-delimiter grammar (`__` for blocks, `-` for qualifiers) resolves this unambiguously and aligns with LNS filename conventions already in use.

### Alternative F — Seed the LES registry from LAMS failure modes
Rejected.

Reason:
LAMS is currently in DRAFT status and its internal failure semantics may change before it reaches ACTIVE. Seeding LES from a DRAFT consuming standard risks embedding superseded design decisions into a company-wide infrastructure standard. LES must be designed from the taxonomy up, independent of any consumer. Consuming standards — including LAMS — adopt LES codes and petition for new ones. The standard does not absorb a consumer's current implementation state.

---

## 7. Consequences

### Positive consequences
- establishes a shared Luphay-wide language for errors
- improves readability in logs, CI output, and diagnostics
- improves consistency across human and agent workflows
- LES autonomy insulates the standard from consuming-standard churn
- prepares Luphay systems for better aggregation, analytics, and observability
- creates a foundation for future formal error catalogs and governance
- improves cross-system portability of diagnostics
- supports future audit and evidence-oriented workflows
- two-delimiter grammar enables deterministic parsing by both humans and agents
- petition process ensures LES grows through governed cross-system demand, not local convenience

### Costs and tradeoffs
- requires upfront taxonomy design discipline
- requires governance to prevent duplicate or inconsistent semantic keys
- double-underscore codes are slightly longer to type than single-underscore equivalents
- consuming standards must invest in mapping their failure modes to LES rather than receiving a pre-seeded list
- some early LES keys may need refactoring as the ontology matures

### Risk
If LES grows without grammar rules, catalog review discipline, and family boundaries, it could become noisy or inconsistent. The stewardship designation in §5.7 and the petition process in §5.8 are the primary mitigations.

---

## 8. Implementation Direction

The following follow-on work is authorized:

### 8.1 LES core specification
Create a formal standard (`STD-NORM-0002`) describing:
- purpose
- scope
- principles including the autonomy posture (§4.6)
- locked grammar (as defined in §5.2 and §5.3 of this ADR)
- family taxonomy
- authoring rules
- consumer petition process (as defined in §5.8 of this ADR)
- example usage

### 8.2 LES grammar guidance
The grammar is locked as of ADR-DECN-0010 v0.2. The LES core specification (`STD-NORM-0002`) will formalize it with full definitions of:
- `__` block delimiter rules and parser specification
- `-` qualifier rules and primary-qualifier relationship definition
- block arity requirements
- conformance validation rules
- non-conformant code examples and corrections

### 8.3 LES seed catalog
Build an initial catalog (`STD-REFR-0008`) as a representative cross-domain spread — 2–3 codes per domain (Structural/Artifact, Control/Governance, Runtime/Operational, Trust/Assurance), targeting 8–12 seed codes total. The seed catalog is derived from the LES taxonomy, not from any consuming standard's failure modes. LAMS-relevant codes will appear naturally where they represent general conditions. LAMS-specific constructs will not appear unless they demonstrate cross-system applicability and pass the petition process.

### 8.4 LAMS integration
LAMS v1.2 will examine its failure modes and map each to an existing LES code. Where no LES code exists, LAMS will submit petitions per §5.8. Any LAMS failure mode deferred by the steward will remain as a raw behavioral enum in LAMS until the condition is stable and a petition is accepted. LAMS does not unblock itself from v1.2 by driving LES design — it maps to what LES provides.

### 8.5 Future expansion
Evaluate whether LES should later support:
- stable numeric IDs
- payload schemas
- severity levels (acceleration candidate — likely needed before DRACO cOS dashboard build)
- retryability semantics
- agent action guidance
- operator remediation guidance

---

## 9. Non-Goals

This ADR does not yet:
- freeze the final LES taxonomy
- define every LES family boundary
- define severity levels
- define payload structure
- define numeric identifiers
- define a complete catalog
- mandate LES adoption in every Luphay system immediately

Those items are deferred to the LES core specification and follow-on implementation artifacts.

---

## 10. Initial One-Line Framing

**The Luphay Error Standard (LES) is the governed naming and semantic layer for errors, failures, invalid states, and breached expectations across Luphay systems.**

---

## 11. Status

Approved for introduction as a new Luphay standard family.

Initial maturity state:
- concept approved
- grammar locked (v0.2)
- autonomy posture established (v0.3)
- consumer petition process defined (v0.3)
- taxonomy in development
- first consumer identified as LAMS (adoption model, not design driver)
- full standard specification pending

---

## 12. Follow-On Artifacts

| Artifact ID | Filename | Purpose |
|---|---|---|
| `STD-NORM-0002` | `STD-NORM-0002__luphay-error-standard-core__v0.1.md` | Core LES specification — locked grammar, autonomy posture, petition process, family taxonomy, authoring rules |
| `STD-REFR-0007` | `STD-REFR-0007__luphay-error-family-taxonomy__v0.1.md` | Full family taxonomy reference |
| `STD-GUID-0003` | `STD-GUID-0003__les-authoring-guideline__v0.1.md` | LES authoring guidance for code authors |
| `STD-REFR-0008` | `STD-REFR-0008__les-seed-catalog__v0.1.md` | Cross-domain seed catalog — 8–12 codes derived from taxonomy |
| `STD-TEMP-XXXX` | `STD-TEMP-XXXX__les-catalog-entry-template__v0.1.md` | Reusable template for authoring new catalog entries |

> `STD-TEMP-XXXX` sequence number to be assigned from the STD-TEMP registry before the artifact is filed.

---

## 13. Decision Summary

Luphay adopts the **Luphay Error Standard (LES)** as the new enterprise error naming standard, governed under `STD-NORM-0002`.

The locked LES grammar is:

```text
LES__[FAMILY(-SUB-FAMILY)]__[CATEGORY(-SUB-CATEGORY)]__[OBJECT(-QUALIFIER...)]
```

Where `__` is the block delimiter and `-` is the qualifier delimiter. All three content blocks are required.

LES is designed autonomously — from the taxonomy up, independent of any consuming standard. Consuming standards adopt LES codes and petition for new ones through the process defined in §5.8. LAMS is the first designated consumer and operates under the adoption model, not as a design driver.
