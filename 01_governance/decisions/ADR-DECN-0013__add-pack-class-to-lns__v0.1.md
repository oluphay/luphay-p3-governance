---
id: ADR-DECN-0013
title: Add PACK class to the Luphay Naming Standard
status: active
version: v0.1
decision_type: Governance
scope_level: Enterprise
effective_date: 2026-04-14
related_artifacts:
  - STD-NORM-0001
  - STD-SPEC-0006
  - STD-SPEC-0007
supersedes: []
created_by: OpenAI ChatGPT
created_at: 2026-04-14
---

# ADR-DECN-0013 — Add PACK class to the Luphay Naming Standard

## 1. Decision

Luphay Naming Standard (LNS) SHALL introduce a new internal `STD` class:

- **`PACK` — Package**

`PACK` is the governed assembly class for artifacts whose primary purpose is to bundle, frame, version, and release a coherent set of related standards, specifications, or companion documents as one bounded package.

This decision adds `PACK` as a first-class internal `STD` class under LNS.

---

## 2. Status

**Accepted.**

This ADR authorizes the LNS update and serves as the decision basis for the follow-on pull request that will amend `STD-NORM-0001`.

---

## 3. Context

LNS currently provides internal `STD` classes for constitution, normative standard, policy, specification, procedure, playbook, guideline, template, and reference. These classes cover foundational governance, definitional systems, behavioral rules, technical blueprints, execution methods, scenario response, advisory guidance, reusable scaffolds, and passive lookup material.

A gap remains for a recurring artifact type that is neither a technical specification nor a passive reference: the **package-level wrapper** used to organize a bounded multi-document standard set.

This need surfaced directly in the LAMS v2 work, where the specification set now naturally separates into:

- `STD-SPEC-0006` — LAMS Core Specification
- `STD-SPEC-0007` — LAMS Graph and Execution Semantics
- a wrapper artifact that explains package composition, canonical members, boundary rationale, version alignment, and release packaging

That wrapper is not well-classified as:

- `SPEC`, because it is not itself the authoritative technical target-state definition
- `REFR`, because it does more than passive lookup or citation
- `TEMP`, because it is not primarily an instantiation scaffold
- `GUID`, because it is not advisory practice
- `POLI` or `NORM`, because it does not define behavioral obligations or a definitional grammar

A distinct class is warranted.

---

## 4. Decision Drivers

1. **Recurring pattern** — multi-document systems are expected to increase across Luphay.
2. **Classification clarity** — package wrappers should not be forced into misfit classes.
3. **Governance cleanliness** — canonical source documents should remain distinct from packaging artifacts.
4. **Operational scale** — solo and agentic workflows benefit from a clear package-level artifact type.
5. **Future-proofing** — standards families may increasingly ship as bounded document sets rather than single files.

---

## 5. Decision Outcome

### 5.1 New class

Add the following internal `STD` class to LNS:

| Class | Type |
| :--- | :--- |
| `PACK` | Package — a governed assembly artifact that bundles, frames, and releases a coherent set of related standards/specifications/documents as one bounded package |

### 5.2 Class definition

#### `PACK` — Package
**Definition:**  
A package is a governed assembly artifact whose primary function is to define, organize, version, and release a coherent set of related artifacts as one bounded package.

**Use when:**
- the artifact answers “What is the authoritative bounded package for this system, release, or standard set?”
- the artifact identifies package members and canonical documents
- the artifact explains package boundaries, composition rationale, and reading order
- the artifact provides package-level release framing, version alignment, or handoff structure
- the artifact exists because the authoritative source is intentionally distributed across multiple documents

**Boundary:**
- A package is **not** itself the primary technical blueprint unless explicitly stated.
- A package does **not** replace the canonical authority of member `SPEC`, `POLI`, `NORM`, `PROC`, or other artifacts.
- A package may summarize, map, and frame package members, but it should not silently absorb their full normative burden.
- A package is **not** passive lookup material; if the artifact only preserves facts for citation, it belongs in `REFR`.
- A package is **not** an arbitrary folder note or informal bundle; it is a governed artifact with defined membership and purpose.

**Ownership:**  
System owner, standards steward, architecture owner, or other permanently assigned package steward.

### 5.3 Versioning convention

Use standard Luphay versioning:

- `v0.x` — drafting / package assembly in progress
- `v1.0` — first formally recognized package release
- `v1.x+` — maintained package revisions

### 5.4 Canonical rule

Unless explicitly declared otherwise, a `STD-PACK` artifact is a **package authority**, not a **content authority**.

That means:
- it is authoritative about package composition, package boundaries, package version, and canonical member selection
- it is not automatically authoritative over the detailed technical or normative content of the member artifacts

---

## 6. Placement Within LNS

### 6.1 Internal class list

`PACK` SHALL be added to the LNS internal `STD` class list.

### 6.2 Precedence model

`PACK` SHOULD be treated as a **supporting assembly role**, similar to how `TEMP` and `REFR` are supporting roles rather than primary directive layers.

The main precedence chain remains:

```text
CONS > NORM > POLI > SPEC / PROC / PLAY > GUID
```

Supporting roles become:
- `PACK` — governed package assembly
- `TEMP` — reusable structural scaffold
- `REFR` — lookup/citation material

Rationale: `PACK` organizes authority; it does not outrank authority.

### 6.3 Decision rule insertion

LNS decision logic SHOULD include:

**Choose `PACK` if:**
- the artifact answers “What artifacts belong together as one governed package?”
- the artifact defines a bounded release or handoff set for a multi-document standard/system
- the artifact exists to frame, organize, and publish a coherent document package without replacing the canonical member documents

---

## 7. Initial Example

The motivating example is the LAMS v2 specification package:

- `STD-SPEC-0006__luphay-artifact-metadata-standard__v2.0.md`
- `STD-SPEC-0007__lams-graph-and-execution-semantics__v2.0.md`
- `STD-PACK-0001__lams-v2-specification-package__v0.2.md`

In this pattern:
- `0006` remains the canonical core specification
- `0007` remains the canonical companion specification
- `PACK-0001` becomes the governed wrapper that defines the package

---

## 8. Consequences

### Positive
- Eliminates repeated misclassification of package wrapper artifacts
- Preserves clean boundaries between canonical documents and bundle-level framing artifacts
- Creates a reusable naming class for future multi-document systems
- Improves machine interpretability for agents and registries
- Supports release-oriented documentation without distorting existing classes

### Trade-offs
- LNS gains another internal class and therefore slightly more complexity
- Operators must learn the distinction between `PACK` and `REFR`
- Some existing working files may later need reclassification into `STD-PACK`

### Risk if not adopted
- Package artifacts will continue to be misfiled as `REFR`, `SPEC`, or informal non-governed filenames
- Future multi-document standards will lack a clean packaging class
- Tooling and agents will have weaker semantics around bounded document sets

---

## 9. Implementation Direction for the LNS Update

The follow-on PR should update LNS in at least these sections:

1. **§5.1 Internal classes** — add `PACK`
2. **§5.2 Internal class definitions** — define `PACK`
3. **§5.3 Relationship and precedence model** — add `PACK` as a supporting role
4. **§5.4 Decision rules** — add `Choose PACK if...`
5. **§5.8 Examples** — add at least one `STD-PACK` filename example
6. **§10 Violation Reference** — add anti-pattern examples for misclassified package artifacts
7. **§11 Front Matter Minimum** — add any package-specific extension fields if desired

Suggested anti-pattern example:

- `STD-REFR-0009__lams-v2-specification-package__v0.2.md`  
  Problem: governed package assembly artifact misclassified as passive reference  
  Fix: `STD-PACK-0001__lams-v2-specification-package__v0.2.md`

---

## 10. Alternatives Considered

### A. Keep using `REFR`
Rejected. `REFR` is too passive and lookup-oriented for bounded package assembly.

### B. Keep using `SPEC`
Rejected. A package wrapper is not the same thing as a binding technical blueprint.

### C. Introduce `BUND`
Rejected. Clear enough semantically, but less elegant and less standard-feeling than `PACK`.

### D. Introduce `COMP`
Rejected. Too ambiguous; could mean component, compilation, or companion.

### E. Leave package files informal and outside LNS
Rejected. This would undermine governed multi-document systems.

---

## 11. Decision Summary

Luphay SHALL add `PACK` as a new internal `STD` class in LNS.

`PACK` is the correct governed class for assembly artifacts that bundle, frame, and release a coherent multi-document standard or specification set.

This ADR is the decision basis for the LNS amendment PR.

---

## 12. Naming Impact

This decision enables future filenames such as:

- `STD-PACK-0001__lams-v2-specification-package__v0.2.md`
- `STD-PACK-0002__draco-core-architecture-release-package__v1.0.md`
- `STD-PACK-0003__keystone-compliance-kernel-specification-package__v0.1.md`

