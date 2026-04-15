---
id: ADR-DECN-0010
title: Introduce the Luphay Error Standard (LES)
decision_type: Governance
scope_level: Enterprise
status: draft
version: v0.2
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

### 4.6 LAMS is the correct first consumer
LAMS already contains explicit MUST rules, failure semantics, execution gates, freshness rules, invariant requirements, and sanitization requirements. That makes it the most natural proving ground for LES.

---

## 5. Decision Details

### 5.1 LES is established as an enterprise standard family
LES is now recognized as a formal Luphay standard family for error naming and diagnostic semantics. Its governing artifact is `STD-NORM-0002`.

### 5.2 Locked semantic code structure
The approved and locked LES semantic code structure is:

```text
LES__[FAMILY(-SUB-FAMILY)]__[CATEGORY(-SUB-CATEGORY)]__[OBJECT(-QUALIFIER...)]
```

This structure is locked as of v0.2. Changes to the grammar shape require a new ADR.

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

### 5.5 First consumer
**LAMS** (`LUP-LAMS-STD-0001`) is designated as the first formal consumer of LES. LAMS v1.2 will replace raw behavioral enums in `agent_contract.failure_semantics` and `relationships.inputs.missing_input_behavior` with LES semantic keys.

Initial LAMS-oriented LES conditions may include:
- filename and front matter identity mismatch
- unresolved required input
- invariant violation
- stale artifact
- executable artifact missing `agent_contract`
- release-grade artifact missing integrity hash
- sanitization scan failure

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

---

## 7. Consequences

### Positive consequences
- establishes a shared Luphay-wide language for errors
- improves readability in logs, CI output, and diagnostics
- improves consistency across human and agent workflows
- strengthens LAMS validation semantics
- prepares Luphay systems for better aggregation, analytics, and observability
- creates a foundation for future formal error catalogs and governance
- improves cross-system portability of diagnostics
- supports future audit and evidence-oriented workflows
- two-delimiter grammar enables deterministic parsing by both humans and agents

### Costs and tradeoffs
- requires upfront taxonomy design discipline
- requires governance to prevent duplicate or inconsistent semantic keys
- double-underscore codes are slightly longer to type than single-underscore equivalents
- some early LES keys may need refactoring as the ontology matures

### Risk
If LES grows without grammar rules, catalog review discipline, and family boundaries, it could become noisy or inconsistent. The stewardship designation in §5.7 is the primary mitigation.

---

## 8. Implementation Direction

The following follow-on work is authorized:

### 8.1 LES core specification
Create a formal standard (`STD-NORM-0002`) describing:
- purpose
- scope
- principles
- locked grammar (as defined in §5.2 and §5.3 of this ADR)
- family taxonomy
- authoring rules
- example usage

### 8.2 LES grammar guidance
The grammar is locked as of this ADR v0.2. The LES core specification (`STD-NORM-0002`) will formalize it with full definitions of:
- `__` block delimiter rules and parser specification
- `-` qualifier rules and primary-qualifier relationship definition
- block arity requirements
- conformance validation rules
- non-conformant code examples and corrections

### 8.3 LES starter catalog
Build an initial catalog (`STD-REFR-0008`) of LAMS-first LES codes using the locked grammar.

### 8.4 LAMS integration
Update LAMS to v1.2 so governed failure conditions in `agent_contract.failure_semantics` and `relationships.inputs.missing_input_behavior` emit LES semantic keys rather than raw behavioral enums.

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
- taxonomy in development
- first consumer identified as LAMS
- full standard specification pending

---

## 12. Follow-On Artifacts

| Artifact ID | Filename | Purpose |
|---|---|---|
| `STD-NORM-0002` | `STD-NORM-0002__luphay-error-standard-core__v0.1.md` | Core LES specification — locked grammar, principles, family taxonomy, authoring rules |
| `STD-REFR-0007` | `STD-REFR-0007__luphay-error-family-taxonomy__v0.1.md` | Full family taxonomy reference |
| `STD-GUID-0003` | `STD-GUID-0003__les-authoring-guideline__v0.1.md` | LES authoring guidance for code authors |
| `STD-REFR-0008` | `STD-REFR-0008__lams-les-starter-catalog__v0.1.md` | Seed catalog of LAMS-oriented LES codes |
| `STD-TEMP-XXXX` | `STD-TEMP-XXXX__les-catalog-entry-template__v0.1.md` | Reusable template for authoring new catalog entries |

> `STD-TEMP-XXXX` sequence number to be assigned from the STD-TEMP registry before the artifact is filed.

---

## 13. Decision Summary

Luphay adopts the **Luphay Error Standard (LES)** as the new enterprise error naming standard, governed under `STD-NORM-0002`.

The locked LES grammar is:

```text
LES__[FAMILY(-SUB-FAMILY)]__[CATEGORY(-SUB-CATEGORY)]__[OBJECT(-QUALIFIER...)]
```

Where `__` is the block delimiter and `-` is the qualifier delimiter. All three content blocks are required. LAMS will serve as the first formal consumer, and further standardization work will proceed through the dedicated LES specification artifacts listed in §12.
