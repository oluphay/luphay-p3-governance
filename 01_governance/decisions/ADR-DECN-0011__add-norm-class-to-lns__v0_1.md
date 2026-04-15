---
id: ADR-DECN-0011
title: Add NORM Class to LNS for Normative Definitional Standards
decision_type: Governance
scope_level: Enterprise
status: draft
version: v0.1
effective_date:
related_artifacts:
  - LNS-0001
  - ADR-DECN-0010
supersedes:
created_by: Alpha Kamara
created_at: 2026-04-12
---

# ADR-DECN-0011 — Add `NORM` Class to LNS for Normative Definitional Standards

---

## 1. Decision

The Luphay Naming Standard (LNS) v0.9 `STD` family is missing a class for **normative definitional standards** — artifacts that establish a governed rule system, grammar, naming convention, taxonomy, or classification layer that is binding across the company, but whose function is neither a build specification nor a behavioral policy.

This ADR authorizes the addition of a new `STD` internal class:

```
NORM — Normative Standard
```

**`NORM` definition:**  
A normative standard establishes a governed definitional system — a grammar, naming convention, taxonomy, classification scheme, or semantic rule set — that is binding and company-wide but does not describe how to build a technical artifact (`SPEC`), define behavioral obligations and prohibitions (`POLI`), or constitute foundational governance authority (`CONS`).

The first artifacts to be classified as `STD-NORM` are:

- **LNS itself** (`STD-NORM-0001` retroactively, if re-registered) — the naming and classification grammar for all Luphay files
- **LES core** (`STD-NORM-XXXX`) — the error naming grammar and family taxonomy for all Luphay systems

---

## 2. Context

### 2.1 The triggering artifact

ADR-DECN-0010 authorized the Luphay Error Standard (LES) and designated the LES core specification as the first follow-on artifact. When assigning the LNS class for that artifact, no existing class fit accurately:

| Class considered | Why it fails for LES core |
|---|---|
| `SPEC` | SPEC is a binding technical build blueprint — schemas, APIs, ERDs, performance thresholds. LES defines a naming grammar, not a build target. |
| `CONS` | CONS is constitutional authority — the highest governance layer. LES is normative but not constitutional. Stretching CONS to absorb definitional standards erodes its meaning. |
| `POLI` | POLI defines behavioral obligations and prohibitions. LES defines a definitional system. Different function and authority mode. |
| `GUID` | GUID is advisory — judgment permitted. LES is normative and binding. Wrong authority level. |
| `REFR` | REFR is passive lookup material. LES is binding, not merely informational. |

### 2.2 The broader gap

The gap is not unique to LES. LNS itself is a normative definitional standard — it defines the naming grammar for all Luphay files. It was filed as `STD-CONS-0001` as a pragmatic bootstrapping choice, but `CONS` was already a stretch. LES makes the gap visible because it needs to be classified, and there is no principled home for it.

Any future Luphay standard that establishes a governed classification scheme — a tagging taxonomy, a severity framework, a data type registry, an event naming convention — will face the same ambiguity. Adding `NORM` closes the gap permanently.

### 2.3 Why `NORM`

The name is intentional:

- `NORM` reads immediately as **normative** — binding, not advisory
- It is distinct from `SPEC` (build target), `POLI` (behavioral rule), `CONS` (constitutional authority), and `GUID` (advisory)
- It is 4 characters — conformant with the LNS class length rule
- It is legible in filenames without expansion: `STD-NORM-0002` communicates its nature on sight

---

## 3. Problem Statement

Without `NORM`:

1. Normative definitional standards have no accurate LNS home
2. Authors must misclassify them as `CONS`, `SPEC`, or `POLI` — all of which carry the wrong semantic meaning
3. `CONS` gets overloaded beyond its intended constitutional function, eroding its governance signal
4. `SPEC` gets applied to non-build artifacts, blurring the class boundary that engineers rely on
5. Future definitional standards (tagging conventions, severity taxonomies, classification registries) will repeat the ambiguity
6. Agents and humans consuming `STD-CONS` or `STD-SPEC` artifacts cannot reliably infer what kind of artifact they are dealing with

---

## 4. Rationale

### 4.1 The class boundary is real and recurring
Normative definitional standards are a distinct artifact type. They share normative force with `POLI` and `CONS` but serve a definitional function that neither covers. The boundary will be crossed again — adding `NORM` now is lower cost than adjudicating each future case individually.

### 4.2 Precision in class codes protects agent consumption
LAMS establishes that agents use artifact metadata for orientation and execution. A misclassified artifact produces a wrong inference at the class level — before an agent even reads the content. `STD-NORM` communicates "this defines a rule system" accurately; `STD-CONS` or `STD-SPEC` do not.

### 4.3 LNS v0.9 → v1.0 is the right moment
LNS is already `status: Active`. It has been stable across nine versions. Adding a new class at this moment — triggered by a real operational need — is the right forcing function for a v1.0 promotion. The standard is mature enough to carry a new class cleanly.

---

## 5. Decision Details

### 5.1 New class approved

| Class | Name | Definition |
|---|---|---|
| `NORM` | Normative Standard | A governed definitional system — grammar, naming convention, taxonomy, classification scheme, or semantic rule set — that is binding company-wide but does not describe a build target, define behavioral obligations, or constitute foundational governance authority. |

### 5.2 Precedence position

`NORM` sits alongside `CONS` and `POLI` at the top of the STD authority hierarchy, below `CONS`:

```
CONS > NORM > POLI > SPEC / PROC / PLAY > GUID
```

`NORM` is normative and binding. It outranks `POLI` because it defines the semantic system that policies and specifications operate within — you cannot write a conformant policy without knowing the naming standard it must follow.

### 5.3 Ownership

`NORM` artifacts are owned by Platform Governance or the designated standards authority. A `NORM` artifact must have a named steward role responsible for versioning, review cadence, and long-term maintenance.

### 5.4 First registrations

| Artifact | Current classification | Correct classification under this ADR |
|---|---|---|
| LNS — Luphay Naming Standard | `STD-CONS-0001` (bootstrapped) | `STD-NORM-0001` (re-registration optional; see §7) |
| LES core specification | Unclassified (pending) | `STD-NORM-XXXX` (sequence TBD) |

### 5.5 LNS re-registration

Re-registering LNS from `STD-CONS-0001` to `STD-NORM-0001` is **optional** for now. LNS is widely referenced under its current ID. A re-registration would require an alias entry in the artifact registry and a redirect note in LNS itself. This is deferred to a future governance maintenance pass. LNS continues to operate under `STD-CONS-0001` until explicitly re-registered.

---

## 6. Alternatives Considered

### Alternative A — Extend `CONS` to cover foundational definitional standards
Rejected. `CONS` carries a specific meaning: constitutional governance authority. Absorbing definitional standards blurs that signal. Over time, `CONS` would accumulate artifacts with different functions, weakening its governance value.

### Alternative B — Extend `SPEC` to cover normative rule systems
Rejected. `SPEC` is specifically a build blueprint. Engineering and agent consumers rely on `STD-SPEC` meaning "here is what you must build." Applying it to a naming grammar produces a wrong inference at the class level.

### Alternative C — Classify LES core as `POLI`
Rejected. `POLI` defines behavioral obligations and prohibitions. LES defines a definitional and semantic system. The governance function is different. A policy tells you what you must do; a normative standard tells you what things are called and how they are structured.

### Alternative D — Leave the gap and adjudicate per case
Rejected. The gap will recur with every future definitional standard Luphay produces. Repeated case-by-case adjudication produces inconsistency. The cost of adding `NORM` now is low; the cost of misclassification accumulating across the artifact estate is high.

---

## 7. Consequences

### Immediate
- LNS must be updated to v1.0, adding `NORM` to §5 with full class definition, boundaries, ownership, and examples
- ADR-DECN-0010 §12 must be updated to replace `STD-CONS-0011` with `STD-NORM-XXXX` for the LES core artifact
- LNS v1.0 is the natural vehicle for this change; the version bump from v0.9 to v1.0 is authorized by this ADR

### Near-term
- LES core is filed as `STD-NORM-XXXX` once LNS v1.0 is published
- Any future definitional standard (tagging taxonomy, severity framework, event naming convention) uses `STD-NORM`

### Long-term
- Optional: re-register LNS as `STD-NORM-0001` in a future governance maintenance pass
- `NORM` becomes the stable home for Luphay's growing library of definitional rule systems

### Risks

| Risk | Likelihood | Mitigation |
|---|---|---|
| `NORM` boundary creep — authors use it for artifacts that should be `POLI` or `SPEC` | Low | Clear boundary definition in LNS §5.2; violation examples in §10 |
| LNS re-registration confusion — two IDs for the same artifact | Low | Deferred; alias entry in registry when executed; not required immediately |

---

## 8. Implementation Direction

1. Update LNS to v1.0 — add `NORM` class to §5.1 and §5.2 with definition, boundaries, ownership, examples, and precedence update; add violation anti-pattern to §10
2. Update ADR-DECN-0010 §12 — replace `STD-CONS-0011` with `STD-NORM-XXXX`
3. Assign `STD-NORM` sequence number for LES core and register in artifact registry
4. Proceed with LES artifact build using correct classification

---

## 9. Non-Goals

This ADR does not:
- Mandate immediate re-registration of LNS from `STD-CONS-0001`
- Define the full contents of LES core
- Change any existing `STD-CONS` or `STD-SPEC` artifact registrations other than LES core

---

## 10. Decision Summary

A new `STD` internal class `NORM` (Normative Standard) is added to LNS to provide an accurate, principled classification for governed definitional systems — grammars, naming conventions, taxonomies, and classification schemes — that are binding company-wide but are not build specifications, behavioral policies, or constitutional documents. LNS v1.0 will carry the change. LES core will be the first artifact formally registered as `STD-NORM`.

---

## 11. Changelog

- **v0.1** — Initial decision record.
