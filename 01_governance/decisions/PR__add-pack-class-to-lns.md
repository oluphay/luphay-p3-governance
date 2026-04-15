# PR: Add `PACK` as a new internal `STD` class in LNS

## PR Title
Add `PACK` as a new internal `STD` class in the Luphay Naming Standard

## Proposed LNS Version
`STD-NORM-0001` — bump from **v1.0** to **v1.1**

## Change Type
- Standards taxonomy extension
- Naming/classification update
- Non-breaking additive change

## Decision Basis
- `ADR-DECN-0013` — Add `PACK` class to the Luphay Naming Standard
- Motivating package pattern:
  - `STD-SPEC-0006` — Luphay Artifact Metadata Standard (LAMS) — Core Specification
  - `STD-SPEC-0007` — LAMS Graph and Execution Semantics
  - package wrapper artifact for the bounded LAMS v2 document set

---

## Summary
This PR adds **`PACK`** as a new internal `STD` class in LNS.

`PACK` is the governed class for **package assembly artifacts** whose primary purpose is to bundle, frame, version, and release a coherent set of related standards, specifications, or companion documents as one bounded package.

This closes a real classification gap in LNS. Multi-document systems such as LAMS v2 already require a governed wrapper artifact that is neither:
- a technical blueprint (`SPEC`)
- a passive lookup artifact (`REFR`)
- a reusable scaffold (`TEMP`)
- nor an advisory artifact (`GUID`)

The new class gives Luphay a clean, repeatable home for package-level artifacts.

---

## Why this change is needed
LNS currently covers constitutions, normative standards, policies, specifications, procedures, playbooks, guidelines, templates, and references.

What it does **not** currently cover well is the recurring artifact type that:
- defines the authoritative membership of a bounded document set
- explains package boundaries and composition rationale
- identifies canonical member documents
- provides package-level release framing and version alignment
- acts as the governed wrapper for a system intentionally distributed across multiple files

Without `PACK`, these artifacts are likely to be:
- misclassified as `REFR`
- misclassified as `SPEC`
- or left as informal filenames outside the governed naming system

This PR formalizes that class.

---

## Scope of change
This PR updates `STD-NORM-0001` in the following places:

1. Change log
2. `§5.1 Internal classes`
3. `§5.2 Internal class definitions, boundaries, and ownership`
4. `§5.3 Internal relationship and precedence model`
5. `§5.4 Decision rules for class selection`
6. `§5.8 Examples`
7. `§10 Violation Reference`
8. `§11 Front Matter Minimum`

---

## Proposed edits

## 1) Change log — add v1.1 entry
Insert a new top entry above `v1.0`:

```markdown
### v1.1 — 2026-04-14
- Added `PACK` to §5 under STD internal classes as the dedicated class for governed package assembly artifacts that bundle, frame, and release coherent multi-document standard/specification sets.
- Added `PACK` class definition, boundaries, ownership expectations, and decision rules to §5.2 and §5.4.
- Updated §5.3 to recognize `PACK` as a supporting assembly role alongside `TEMP` and `REFR`, without changing the main precedence chain.
- Added `STD-PACK` examples to §5.8.
- Added `PACK` misclassification anti-patterns to §10.
- Added optional `STD-PACK` front matter extension to §11.
- Version bumped from v1.0 to v1.1. This is an additive, non-breaking extension to the internal STD class taxonomy.
- Decision basis: ADR-DECN-0013.
```

### Versioning rationale
This should be a **minor** version bump (`v1.0` → `v1.1`) because:
- the change is additive
- no existing filename family is invalidated
- no precedence tier is broken
- no existing class semantics are removed

---

## 2) §5.1 Internal classes — add `PACK`
Update the table to:

```markdown
| Class | Type |
| :--- | :--- |
| `CONS` | Constitution — foundational governance principles, structural authority, and system-defining rules |
| `NORM` | Normative Standard — a governed rule system, grammar, naming convention, taxonomy, or classification scheme that is binding company-wide but is not a build specification, behavioral policy, or constitutional document |
| `POLI` | Policy — binding rules, mandatory requirements, assigned authority, and non-optional constraints |
| `SPEC` | Specification — binding technical blueprints, schemas, models, interfaces, thresholds, and build constraints for a defined system or component |
| `PROC` | Procedure — the canonical step-by-step method for carrying out a defined routine process |
| `PLAY` | Playbook — a scenario-based response pattern for handling recurring operational conditions, incidents, or coordinated actions |
| `GUID` | Guideline — recommended practices, heuristics, and quality-oriented advice where judgment is permitted |
| `PACK` | Package — a governed assembly artifact that bundles, frames, and releases a coherent set of related standards/specifications/documents as one bounded package |
| `TEMP` | Template — a reusable master document intended to be copied, filled in, or instantiated |
| `REFR` | Reference — stable factual, definitional, taxonomic, or technical material used for lookup or citation |
```

**Placement note:** `PACK` should sit with the supporting/document-structuring classes, not as a new directive tier above or below `SPEC`.

---

## 3) §5.2 Internal class definitions — insert `PACK`
Insert the following new subsection **after `GUID` and before `TEMP`**:

```markdown
#### `PACK` — Package
**Definition:**  
A package is a governed assembly artifact whose primary function is to define, organize, version, and release a coherent set of related artifacts as one bounded package.

**Use when:**  
- the artifact answers "What is the authoritative bounded package for this system, release, or standard set?"
- the artifact identifies package members and canonical documents
- the artifact explains package boundaries, composition rationale, and reading order
- the artifact provides package-level release framing, version alignment, or handoff structure
- the artifact exists because the authoritative source is intentionally distributed across multiple documents

**Boundary:**  
- A package is **not** itself the primary technical blueprint unless explicitly stated.
- A package does **not** replace the canonical authority of member `SPEC`, `POLI`, `NORM`, `PROC`, `PLAY`, or other artifacts.
- A package may summarize, map, and frame package members, but it should not silently absorb their full normative burden.
- A package is **not** passive lookup material; if the artifact only preserves facts for citation, it belongs in `REFR`.
- A package is **not** an arbitrary folder note or informal bundle; it is a governed artifact with defined membership and purpose.

**Ownership:**  
System owner, standards steward, architecture owner, or other permanently assigned package steward.
```

---

## 4) §5.3 Internal relationship and precedence model — add `PACK` as a supporting role
Keep the main precedence chain unchanged:

```text
CONS > NORM > POLI > SPEC / PROC / PLAY > GUID
```

Update the supporting roles list to:

```markdown
Supporting roles:
- `PACK` standardizes governed package assembly for bounded multi-document systems
- `TEMP` standardizes reusable artifact structure
- `REFR` preserves stable lookup and citation material
```

Add this clarification paragraph:

```markdown
`PACK` organizes authority; it does not outrank authority. A `PACK` artifact may be authoritative about package composition, package boundaries, package version, and canonical member selection, but it is not automatically authoritative over the detailed normative or technical content of its member artifacts.
```

---

## 5) §5.4 Decision rules — add `Choose PACK if:`
Insert the following block after `Choose GUID if:` and before `Choose TEMP if:`:

```markdown
#### Choose `PACK` if:
- the artifact answers "What artifacts belong together as one governed package?"
- the artifact defines a bounded release or handoff set for a multi-document standard, architecture, or system
- the artifact exists to frame, organize, and publish a coherent document package without replacing the canonical member documents
- the artifact is authoritative about package composition and canonical membership, not the detailed technical target state of every member
```

---

## 6) §5.8 Examples — add `STD-PACK` examples
Add the following examples:

```text
STD-PACK-0001__lams-v2-specification-package__v0.2.md
STD-PACK-0002__draco-core-architecture-release-package__v1.0.md
STD-PACK-0003__keystone-compliance-kernel-specification-package__v0.1.md
```

---

## 7) §10 Violation Reference — add `PACK` anti-patterns
Add at least these rows:

```markdown
| `STD-REFR-0009__lams-v2-specification-package__v0.2.md` | Governed package assembly artifact misclassified as passive reference | Use `STD-PACK-0001__lams-v2-specification-package__v0.2.md` |
| `STD-SPEC-0008__draco-core-architecture-release-package__v1.0.md` | Package wrapper misclassified as a technical specification | Use `STD-PACK-0002__draco-core-architecture-release-package__v1.0.md` |
```

---

## 8) §11 Front Matter Minimum — add optional `STD-PACK` extension
Add the following package-specific extension:

```markdown
Package files (`STD-PACK`) should additionally carry:

```yaml
package_steward:
package_scope: [e.g. specification_set, release_bundle, standards_bundle]
canonical_members:
  - [Artifact ID]
member_artifacts:
  - [Artifact ID]
package_version_alignment: [e.g. lockstep, mixed, release-bound]
```
```

### Field intent
- `package_steward` — standing owner of the package artifact
- `package_scope` — what kind of package this is
- `canonical_members` — authoritative core members of the package
- `member_artifacts` — all package members, including supporting artifacts where applicable
- `package_version_alignment` — whether package members are versioned in lockstep or by another scheme

**Note:** this extension should remain **lightweight**. `PACK` should not become a hidden substitute for richer portfolio or graph metadata.

---

## Proposed example after merge
The motivating LAMS example would become:

```text
STD-SPEC-0006__luphay-artifact-metadata-standard__v2.0.md
STD-SPEC-0007__lams-graph-and-execution-semantics__v2.0.md
STD-PACK-0001__lams-v2-specification-package__v0.2.md
```

Interpretation:
- `STD-SPEC-0006` remains the canonical core specification
- `STD-SPEC-0007` remains the canonical companion specification
- `STD-PACK-0001` becomes the governed package wrapper for the LAMS v2 set

---

## Reviewer notes
### Why not keep using `REFR`?
Because a governed package artifact does more than preserve facts for lookup. It frames package authority, composition, release structure, and canonical membership.

### Why not keep using `SPEC`?
Because the package wrapper is not the same thing as the technical source-of-truth specification itself.

### Why not create a new precedence tier?
Because `PACK` is an organizing/supporting role, not a new directive authority layer.

### Why `PACK` rather than `BUND` or `COMP`?
- `PACK` is clearer and more natural
- `BUND` feels less standard
- `COMP` is ambiguous (component, compilation, companion)

---

## Acceptance criteria
- [ ] LNS change log includes a new `v1.1` entry for `PACK`
- [ ] `PACK` appears in `§5.1 Internal classes`
- [ ] `PACK` definition, boundaries, and ownership are added to `§5.2`
- [ ] `§5.3` recognizes `PACK` as a supporting role without changing the main precedence chain
- [ ] `§5.4` includes decision logic for selecting `PACK`
- [ ] `§5.8` includes at least one `STD-PACK` example
- [ ] `§10` includes `PACK` anti-patterns
- [ ] `§11` includes optional `STD-PACK` front matter guidance
- [ ] version is bumped from `v1.0` to `v1.1`
- [ ] decision basis cites `ADR-DECN-0013`

---

## Test plan
1. Verify the new class still satisfies the 4-character class rule.
2. Confirm the `STD` filename formula remains unchanged.
3. Validate that no existing LNS class definitions are invalidated.
4. Confirm no precedence conflict is introduced in `§5.3`.
5. Review example filenames for consistency with LNS universal formatting.
6. Confirm the LAMS package use case is correctly classified as `STD-PACK` rather than `STD-SPEC` or `STD-REFR`.

---

## Migration / impact
This is an additive taxonomy change. No forced migration is required.

Potential follow-up work:
- reclassify current or future governed package wrappers into `STD-PACK`
- register the LAMS v2 package as the first `STD-PACK` artifact
- evaluate whether other multi-document systems now warrant package wrappers

---

## Suggested merge commit message
`Add PACK as internal STD class in LNS`

---

## Ready-to-use PR body (short form)
```markdown
## Summary
Add `PACK` as a new internal `STD` class in LNS for governed package assembly artifacts that bundle, frame, and release coherent multi-document standard/specification sets.

## Why
LNS currently lacks a clean class for bounded package wrappers such as the LAMS v2 specification package. These artifacts are neither technical specifications nor passive references.

## What changed
- Added `PACK` to `§5.1 Internal classes`
- Added full `PACK` definition and boundaries to `§5.2`
- Added `PACK` as a supporting role in `§5.3`
- Added decision logic for `PACK` in `§5.4`
- Added `STD-PACK` examples in `§5.8`
- Added anti-patterns in `§10`
- Added optional `STD-PACK` front matter extension in `§11`
- Bumped LNS from `v1.0` to `v1.1`

## Decision basis
`ADR-DECN-0013`
```

