---
title: "Task Packet Standard"
short_name: "Task Packet Standard"
version: "2.1"
status: "Draft"
origin_context: "LuDRACO Agentic Operating System (LuAOS) v0.2"
standalone_intent: "This document is designed to stand on its own and remain fully reusable outside the originating system."
supersedes: "Task Packet Standard v2.0"
amendment_summary: "v2.1 adds icp_mode governance field, augmented_spec_ref and augmented_spec_status attachment fields, ICP mode mapping table, G1 Readiness gate update for Change packets, and the VMO-ICP invocation model declaration."
last_updated: "2026-03-25"
owner_role: "Platform Governance / Operating System Design"
---

# Task Packet Standard — v2.1

---

## 1. Purpose and role

The **Task Packet** is the first-class governed work object used to carry a unit of work across governance, classification, capability, runtime, execution, and proof boundaries.

It exists because a governed system needs more than a request or a ticket. It needs a **portable, structured, controlled work object** that can:

- preserve intent,
- declare classification and routing,
- carry required governance controls,
- bind the required capability path,
- define runtime expectations,
- and identify the proof required for completion.

The Task Packet answers two inseparable questions:

> **What is this work, what kind is it, what are its boundaries, and what path must it follow?**
> **What must be true before it is considered complete?**

This standard defines both the **object model** (what a Task Packet is and how it is structured) and the **classification model** (how packets are typed, governed, and routed). The two are inseparable and should not be developed independently.

This standard is **reusable outside its originating system**. Any environment that needs a governed unit of work can adopt it, even if it renames individual constructs.

---

## 2. Core definition

**Definition:**
A Task Packet is a structured, governed representation of a unit of work that carries classification, objective, scope, governance metadata, dependency references, required capability path, runtime bindings, and proof expectations from intake through closure.

**Distinctive characteristic:**
The Task Packet is not merely a task description. It is a **control-bearing, classification-bearing work object**.

It is distinct from:

- a **demand signal**, which may be too early or incomplete,
- a **capability contract**, which defines what a capability is,
- a **runtime session**, which is the live instantiation of the work,
- an **execution assignment**, which is a lower-level instruction to one actor,
- a **proof pack**, which is the evidence assembled after or during execution.

A Task Packet is what binds those adjacent stacks together.

---

## 3. Classification model

Classification is not separate from the packet — it is part of it. A packet without a class is unroutable and ungovernable.

### 3.1 Design rule

Task Packet classification must answer **two different questions separately**:

1. **What kind of work is this?** → `packet_class` and `packet_subtype`
2. **How much rigor, proof, and control does it require?** → `governance_mode`, `packet_weight`, and `proof_burden`

These must not be collapsed into one field. A low-risk documentation fix and a regulated decision-engine update may both be `Change` packets while requiring very different governance treatment.

### 3.2 Governing question rule

A packet is classified by its **governing question** — not by:

- the product,
- the team,
- the system name,
- the tool being used,
- or the artifact type being touched.

Product, team, domain, and system specifics are expressed as **context overlay fields**, not as new packet classes.

### 3.3 Canonical top-level packet classes

Exactly five top-level classes form the default constitutional set.

| `packet_class` | Governing question | Default tendency |
|---|---|---|
| `Discovery` | What is true, what do we need to learn, or what should we do? | Learn before commitment |
| `Change` | What should change? | Bounded implementation |
| `Assurance` | Is the state sufficient, compliant, defensible, or proven? | Prove / assess / validate |
| `Incident` | How do we triage, contain, recover, or stabilize harm? | Urgent containment and recovery |
| `Release` | May this advance, merge, deploy, publish, or be adopted? | Promotion under authority |

These classes are intentionally broad and durable. They are not status values. They are not product labels. They are the governing question the packet is designed to answer.

---

## 4. Class definitions

### 4.1 Discovery

**Purpose:** Reduce ambiguity, retrieve canon, compare options, examine feasibility, or produce a recommendation before commitment.

**Use when:**
- the problem is not yet well-bounded,
- learning is the primary outcome,
- architectural or operational options must be compared,
- research or retrieval is the governing activity.

**Typical subtypes:** `research`, `spike`, `option_analysis`, `architecture_probe`, `canon_retrieval`, `precedent_review`

**Typical outputs:** findings memo, option comparison, recommendation, draft ADR, risk notes, follow-on packet recommendation

**Default VCC chain tendency:** `Retrieval/Research → Spec/Design → Document`

**ICP applicability:** Not applicable. ICP governs implementation work. Discovery packets do not invoke ICP.

---

### 4.2 Change

**Purpose:** Make a bounded change to code, configuration, schema, policy text, documentation, workflows, prompts, or supporting artifacts.

**Use when:**
- something existing must be modified,
- implementation is central,
- the expected result is a changed artifact set.

**Typical subtypes:** `feature`, `bugfix`, `refactor`, `docs_update`, `config_change`, `schema_change`, `policy_update`, `migration`

**Typical outputs:** changed artifacts, tests and validations, change notes, updated docs, decision record when material

**Default VCC chain tendency:** `Spec/Design → Build → Verify → Document`

**ICP applicability:** ICP is invoked by VMO during pre-issuance planning for all Change packets. `icp_mode` is set at intake based on governance mode (see §6.4).

**Rule:** This is the default class for most product and engineering execution.

---

### 4.3 Assurance

**Purpose:** Prove, validate, audit, trace, certify, or assess whether a state, action, evidence set, or result satisfies required expectations.

**Use when:**
- the primary goal is checking or proving,
- evidence sufficiency matters more than new implementation,
- auditability, traceability, conformance, or defensibility is the governing concern.

**Typical subtypes:** `compliance_review`, `audit_response`, `traceability_check`, `proof_pack_assembly`, `readiness_assessment`, `control_validation`, `replay_verification`

**Typical outputs:** gate report, findings report, proof pack, waiver or exception record, conformance decision, remediation recommendations

**Default VCC chain tendency:** `Retrieval/Research → Verify → Compliance/Assurance → Document`

**ICP applicability:** Not applicable. Assurance packets do not invoke ICP.

---

### 4.4 Incident

**Purpose:** Triage, contain, recover, roll back, stabilize, or document operational failure, security events, data issues, or severe service defects.

**Use when:**
- the governing concern is harm reduction or service stability,
- there is an outage, failure, breach, or urgent rollback need,
- normal change flow is no longer sufficient by itself.

**Typical subtypes:** `triage`, `hotfix`, `rollback`, `containment`, `break_glass_response`, `failure_investigation`, `post_incident_evidence_capture`

**Typical outputs:** incident timeline, containment log, rollback or fix record, operator notes, root-cause draft, follow-on packets

**Default VCC chain tendency:** `Ops/Incident → Verify → Compliance/Assurance → Document`

**ICP applicability:** ICP-Emergency applies. VMO invokes abbreviated ICP at intake. Full reconciliation required within 48 hours per STD-ICP-0001 §3.4.

---

### 4.5 Release

**Purpose:** Promote a result into an adopted, merged, deployed, published, or otherwise authorized state.

**Use when:**
- the core question is whether something may advance,
- packaging, promotion, signoff, or adoption is the governing activity,
- release evidence and final authority are the primary concerns.

**Typical subtypes:** `merge_approval`, `deployment_approval`, `publication_approval`, `release_readiness`, `cutover_authorization`, `package_promotion`

**Typical outputs:** release decision, release manifest, approval record, promotion evidence, rollback plan, post-release verification plan

**Default VCC chain tendency:** `Verify → Compliance/Assurance → Release → Document`

**ICP applicability:** Not applicable. Release packets do not invoke ICP.

**Rule:** Release is not just another change. It is a governance event.

---

## 5. Anti-sprawl law

Do **not** create new top-level classes for common labels such as: bug, feature, refactor, docs, migration, remediation, audit prep, experiment, hotfix, policy update, backfill, customer request, platform request, security work, compliance work.

These are usually subtypes, originating demands, or context overlays — not distinct governing questions.

**New-class creation test.** A new top-level class should be created only if all of the following are true:

1. it has a genuinely different governing question,
2. it requires a materially different default VCC chain,
3. it changes default gate logic,
4. it changes required proof objects,
5. it is expected to remain common and durable over time.

If those tests are not met, add a subtype instead.

---

## 6. Governance model

### 6.1 Governance is separate from class

`packet_class` does not determine rigor by itself. A `Change` packet may be trivial or critical. Classification names the kind of work; governance fields name the intensity.

### 6.2 Governance mode

- `Lean` — low-risk, reversible, well-bounded work. Fewer gates, lighter proof, faster throughput. Human review may be sampled.
- `Standard` — default operating mode. Normal gates, required verification, standard proof pack, routine human review where specified.
- `Assured` — high-risk, regulated, release-affecting, security-sensitive, or irreversible work. Stronger proof, stricter approvals, expanded gate set, tighter runtime permissions, explicit compliance involvement.

### 6.3 Packet weight

- `MVPP` — Minimum Viable Packet Pack
- `SPP` — Standard Packet Pack
- `HAPP` — High-Assurance Packet Pack

### 6.4 ICP mode

`icp_mode` is set by VMO at intake, before packet issuance. It declares the depth of ICP planning that was applied and that the Augmented Spec must satisfy.

Applies to `Change` packets and `Incident` packets only. All other packet classes declare `icp_mode: N/A`.

**ICP mode mapping table:**

| `governance_mode` | `packet_class` | `icp_mode` |
|---|---|---|
| `Lean` | `Change` | `Lite` |
| `Standard` | `Change` | `Standard` |
| `Assured` | `Change` | `Full` |
| Any | `Incident` | `Emergency` |
| Any | `Discovery` | `N/A` |
| Any | `Assurance` | `N/A` |
| Any | `Release` | `N/A` |

If the correct ICP mode is ambiguous, apply the higher mode. Over-planning is recoverable; under-planning is not.

### 6.5 Proof burden

- `light`
- `standard`
- `high`

### 6.6 Example

A `Change` packet may be: `Lean + MVPP + light + ICP-Lite` for a copy fix, or `Assured + HAPP + high + ICP-Full` for a regulated schema migration. The class is the same. The governance intensity is not.

---

## 7. VMO-ICP invocation model

ICP is a **VMO pre-issuance planning protocol**. It does not live in the VCC chain.

**Responsibility split:**
- **VMO** — governs ICP invocation, selects `icp_mode`, reviews and approves the Augmented Spec, and finalizes packet fields before issuance.
- **RTE** — hosts the ICP execution session as a bounded runtime operation.
- **AEU** — executes the ICP lens analysis and produces the Augmented Spec artifact.
- **Proof Layer** — stores the Augmented Spec and all ICP artifacts, anchored to the packet ID.

**Invocation sequence:**

```
Demand enters VMO
  → VMO classifies, admits, sets governance_mode and icp_mode
  → VMO invokes ICP (RTE hosts session, AEU executes analysis)
      → Augmented Spec produced
      → Open Decisions resolved or flagged
      → Unresolved high-stakes Open Decisions block packet issuance
  → VMO reviews and approves Augmented Spec
  → VMO finalizes Task Packet
      → augmented_spec_ref and augmented_spec_status populated
  → VMO routes packet to VCC chain
      → RTE instantiates session
      → AEUs execute
      → Proof Layer captures records
  → VMO evaluates gates and closes
```

**VCCs consume the packet. They do not redo ICP.** The Spec/Design VCC is an architecture and design refinement capability (ADR production, interface design, structural design work) — not the primary owner of prompt-gap closure. Build VCC and all downstream VCCs treat the Augmented Spec reference as a required input, not a discovery artifact.

---

## 8. Functional responsibilities

The Task Packet owns the following responsibilities as a work object.

**8.1 Identity and traceability** — provide a stable ID; enable linkage to demand, runtime sessions, execution actors, artifacts, and proof.

**8.2 Classification and routing** — carry `packet_class`, `packet_subtype`, and `selected_vcc_chain` so any downstream actor can route without re-evaluating the governing question.

**8.3 Objective and scope preservation** — preserve why the work exists; define what is in scope and out of scope; prevent uncontrolled drift.

**8.4 Governance binding** — carry governance mode, ICP mode, gate requirements, approvals, and escalation conditions so downstream stacks know what control intensity applies.

**8.5 Capability binding** — identify the required VCC chain or path; provide enough structure for routing and handoffs.

**8.6 Runtime binding** — carry the runtime-relevant constraints and instructions needed for session instantiation; define targets such as project, repo, path, dataset, or workspace scope.

**8.7 Proof binding** — carry `augmented_spec_ref` and `augmented_spec_status`; declare what additional evidence is expected; define what completion means from a proof perspective.

**8.8 State-bearing coordination** — move through a lifecycle without losing control metadata; preserve disposition, waiting states, retries, and closure.

---

## 9. Internal structure

A Task Packet is a modular object with stable sections.

### 9.1 Header / identity block

Minimum fields: `packet_id`, `title`, `status`, `version`, `packet_class`, `packet_subtype`, `originating_demand`, `created_timestamp`, `owner`

### 9.2 Objective block

Minimum fields: problem or objective statement, expected outcome, value rationale, acceptance or completion statement (`done_definition`)

### 9.3 Scope block

Minimum fields: `in_scope_assets`, `out_of_scope_assets`, `scope_boundaries`, constraints, non-negotiable invariants, dependencies and blockers

### 9.4 Governance block

Minimum fields: `governance_mode`, `packet_weight`, `proof_burden`, `icp_mode`, `required_approvals`, `active_gates`, `escalation_triggers`, `human_checkpoint_required`, risk classification, sensitivity classification, exception policy reference if any

### 9.5 Capability block

Minimum fields: `selected_vcc_chain`, capability IDs, key handoff expectations, path selection rationale if relevant

### 9.6 Runtime block

Minimum fields: project/repo/workspace target, local path scope if relevant, instruction references, permission profile reference, runtime mode hints, environment assumptions

### 9.7 Proof block

Minimum fields: `augmented_spec_ref`, `augmented_spec_status`, `expected_outputs`, required proof objects, `proof_burden`, gate evidence references, completion proof expectations

### 9.8 State and transition block

Minimum fields: current state, prior state, transition history, blocking reason if any, active assignee or active session reference

### 9.9 Context overlay block

Minimum fields: `portfolio`, `program`, `parent_project`, `product_context`, `domain_context`, `capability_area`, `regulated_or_sensitive_assets`, `release_affecting`, `change_authority`

### 9.10 Attachment and reference block

Minimum fields: linked artifacts, linked decisions, linked sessions, linked approvals, linked proof packs or manifests, `canon_sources`, `decision_link`, `risk_issue_link`

---

## 10. Constitutional field inventory

These fields carry company-wide meaning and must mean the same thing everywhere.

**Required fields (every packet):**

- `packet_id`
- `title`
- `packet_class`
- `packet_subtype`
- `objective`
- `done_definition`
- `owner`
- `status`
- `dependencies_blockers`
- `originating_demand`
- `scope_boundaries`
- `in_scope_assets`
- `governance_mode`
- `packet_weight`
- `icp_mode`
- `selected_vcc_chain`
- `proof_burden`
- `required_approvals`
- `active_gates`
- `expected_outputs`
- `escalation_triggers`
- `augmented_spec_ref`
- `augmented_spec_status`

**Recommended additional fields:**

- `portfolio`
- `program`
- `parent_project`
- `product_context`
- `domain_context`
- `capability_area`
- `regulated_or_sensitive_assets`
- `release_affecting`
- `reversibility`
- `change_authority`
- `human_checkpoint_required`
- `canon_sources`
- `proof_pack_required`
- `decision_link`
- `risk_issue_link`

**Field notes:**
- `augmented_spec_ref` — the path or stable reference to the Augmented Spec artifact produced by the ICP run. Format: `specs/icp/[artifact-id].md` or equivalent repo-native path per STD-ICP-0001 §6.1. Set to `N/A` for packet classes where ICP does not apply.
- `augmented_spec_status` — the lifecycle state of the referenced Augmented Spec. Allowed values: `Draft`, `Approved`, `Approved-with-ODs`, `Amended`, `Closed`, `Waived`, `N/A`. Build VCC activation requires status `Approved` or `Approved-with-ODs`.

---

## 11. Packet granularity

A Task Packet should represent one governable unit of work. It should be:

- larger than a single command,
- smaller than an undifferentiated project,
- coherent enough to govern,
- and small enough to reason about.

A packet may be split into child packets, bundled with sibling packets, or linked to a parent packet for portfolio visibility. Granularity checks should be part of the intake process.

---

## 12. Packet lifecycle

### 12.1 States

A Task Packet moves through an explicit lifecycle.

| State | Meaning |
|---|---|
| `Draft` | Being formed; not yet admitted |
| `Admitted` | Accepted into governed flow |
| `Ready` | Sufficiently defined for execution planning |
| `Issued` | Formally released to runtime / execution path |
| `Active` | Undergoing execution |
| `Blocked` | Unable to proceed |
| `Awaiting Approval` | Paused for authority decision |
| `Verified` | Required technical or operational checks satisfied |
| `Released / Closed` | Governance allowed terminal advancement |
| `Archived` | Retained as historical record |

### 12.2 Transition rules

- A packet should not enter `Admitted` while unresolved high-stakes Open Decisions from the ICP run remain open for Change and Incident packets.
- A packet should not enter `Issued` without minimum governance, classification, ICP mode, and scope data populated, and `augmented_spec_status` at `Approved` or `Approved-with-ODs` for Change packets in Standard or Assured mode.
- A packet should not enter `Active` unless runtime prerequisites are met.
- A packet should not enter `Released / Closed` without required proof.
- Material scope changes should create a version change or explicit amendment record.
- Blocked or escalated packets should preserve reason and owning authority.

### 12.3 State and gate relationship

Packet state and active gates are related but distinct. State describes where the packet is in its lifecycle. Gates are explicit governance checkpoints the packet must pass to advance. A packet in `Active` state may be simultaneously blocked at `G3 Verification`. Both conditions must be tracked and visible.

---

## 13. Gate model

Gates are explicit governance checkpoints. Not every packet needs every gate, but the active gate set must be declared in the packet at intake.

| Gate | Governing question |
|---|---|
| `G0 Intake` | Should this work enter the governed system? |
| `G1 Readiness` | Is the packet sufficiently defined for execution? |
| `G2 Execution` | May runtime execution begin? |
| `G3 Verification` | Do results meet required technical checks? |
| `G4 Assurance` | Is proof sufficient and policy satisfied? |
| `G5 Release` | May the result be merged, released, or adopted? |
| `G6 Learning` | What should be retained for future work? |

### 13.1 G1 Readiness gate — updated rule for Change packets

For `Change` packets in `Standard` or `Assured` governance mode, G1 Readiness requires:
- all constitutional fields populated,
- `icp_mode` declared,
- `augmented_spec_status` at `Approved` or `Approved-with-ODs`.

For `Change` packets in `Lean` governance mode, G1 Readiness requires:
- all constitutional fields populated,
- `icp_mode: Lite` declared,
- an inline ICP note attached per STD-ICP-0001 §3.1 (in lieu of a standalone Augmented Spec document).

For `Incident` packets, G1 is replaced by emergency intake. Full Augmented Spec reconciliation occurs post-execution per STD-ICP-0001 §3.4.

### 13.2 Gate defaults by class

These are defaults, not rigid law. Governance mode may expand or contract the active gate set.

**Discovery:** G0, G1, G3 (when findings need checking), G6
**Change:** G0, G1, G2, G3, G6. Add G4 if policy, evidence, or sensitive assets are involved. Add G5 if promotion or deployment is in scope.
**Assurance:** G0, G1, G3, G4, G6
**Incident:** G0, G2, G3, G6. Add G4 if regulated or security-sensitive. Add G5 if the packet directly authorizes restored production state.
**Release:** G0, G1, G3, G4, G5, G6

---

## 14. Human checkpoint model

Human review is an explicit architectural concern, not an ad hoc afterthought.

Human checkpoints should be strongly considered when any of the following are true: ambiguous scope, policy conflict, failing verification, regulated or sensitive asset involvement, material architectural change, security or privacy impact, low confidence, release promotion, or unresolved Open Decisions from an ICP run.

**Practical defaults by class:**
- `Discovery` — optional unless strategic or high-risk
- `Change` — conditional; required for `Assured` mode
- `Assurance` — usually required for material findings or waivers
- `Incident` — required for major containment, break-glass action, or restoration authority
- `Release` — usually required

---

## 15. Intake decision process

Use this at intake to classify and govern an incoming packet.

**Step 1 — What is the governing question?**
- "What is true / what should we do?" → `Discovery`
- "What should change?" → `Change`
- "Is this sufficient / compliant / defensible?" → `Assurance`
- "How do we contain or recover?" → `Incident`
- "May this advance / release / publish?" → `Release`

**Step 2 — Is the granularity right?**
- Is this larger than a command? Is it smaller than a project? Is it coherent enough to govern independently?

**Step 3 — How much rigor is required?**
Declare: `governance_mode`, `packet_weight`, `proof_burden`

**Step 4 — Set ICP mode.**
Declare: `icp_mode` per the mapping table in §6.4. VMO invokes ICP at the declared mode before packet issuance.

**Step 5 — Which VCC chain and gates apply?**
Declare: `selected_vcc_chain`, `active_gates`, `required_approvals`, `human_checkpoint_required`

**Step 6 — What local context matters?**
Declare: `product_context`, `domain_context`, `capability_area`, `in_scope_assets`, `scope_boundaries`

**Step 7 — What proves completion?**
Declare: `done_definition`, `expected_outputs`, `proof_burden`, `escalation_triggers`

---

## 16. Context overlay rules

Product, team, and domain specificity must be expressed as overlays, not as new packet classes. The overlay fields (§9.9) exist precisely to carry this context without polluting the constitutional classification.

**Examples:**
- A schema change for one product and a schema change for another are both `Change / schema_change` with different `product_context` values.
- An audit response for one regulatory domain and another are both `Assurance / audit_response` with different `domain_context` values.
- A release approval for a customer portal and for an internal compliance engine are both `Release`, with different `product_context` and `change_authority` values.

**Prohibited pattern.** Do not encode the product or domain into the class itself. Avoid constructs like `SecurityPacket`, `CustomerPacket`, or `PlatformChangePacket`. Those are overlays, not classes.

---

## 17. Naming and identity rules

### 17.1 Identity

The durable identity field is `packet_id`. It must remain stable even if the title changes, the packet is reclassified, or the packet moves within the system.

### 17.2 Filename rule

```
TASK-PACKET-[ID]__[slug]__vX.Y.md
```

Example: `TASK-PACKET-0042__fix-validation-rule-for-control-ingest__v0.1.md`

### 17.3 Identity encoding rule

Do **not** encode volatile semantics — such as class, subtype, or product name — into the durable identity field.

---

## 18. Change management

- explicit versioning on every packet,
- amendment records for scope changes,
- state transition logging,
- ownership or authority change logging,
- reopening rules for closed packets.

Material changes to the work object should not be silent. A version change or an explicit amendment record is required.

---

## 19. Inputs and outputs

### 19.1 Inputs to packet creation or update

| Input | Purpose | Minimum expectation |
|---|---|---|
| Originating demand | Establishes why the packet exists | Must define a problem, request, or signal |
| Governance decision | Determines mode, gates, and approvals | Must be explicit enough to bind controls |
| Classification decision | Determines packet class and subtype | Must answer the governing question |
| ICP output (Augmented Spec) | Closes prompt gaps before issuance | Must be in Approved status for Change/Standard+; inline note for Change/Lite |
| Capability routing | Determines required VCC chain | Must identify capability chain or equivalent |
| Runtime-relevant context | Enables instantiation later | Must identify target environment scope |
| Proof expectations | Determines completion requirements | Must state required evidence level |

### 19.2 Outputs and downstream uses

| Output / use | Purpose | Common consumer |
|---|---|---|
| Governed work object | Carries the unit of work through the system | Runtime, execution, governance |
| Classification signal | Enables routing without re-evaluation | VMO, VCC chain, gate logic |
| Augmented Spec reference | Delivers planning completeness to downstream VCCs | Build VCC, Verify VCC |
| Execution source | Basis for lower-level assignments | Runtime, execution stack |
| State reference | Tells the system where the work currently stands | Governance, operations, reporting |
| Control carrier | Tells downstream actors what boundaries apply | Runtime, approvers |
| Evidence anchor | Gives proof records a stable identity to attach to | Proof layer |

---

## 20. Operational constraints

The Task Packet does **not**:

- decide whether work should be admitted (governance function),
- define what a capability means (VCC function),
- instantiate runtime sessions (RTE function),
- perform execution (AEU function),
- replace proof storage,
- replace approvals,
- replace portfolio planning,
- execute ICP analysis (VMO-owned, RTE-hosted, AEU-executed).

---

## 21. Design principles

1. **Work must be packetized.** Governed work needs a stable object, not scattered metadata.
2. **Classification before routing.** A packet without a class is unroutable.
3. **Separate class from governance rigor.** What kind of work and how rigorously to govern it are different questions requiring different fields.
4. **Identity first.** Traceability begins with a stable, durable packet ID.
5. **Scope is a control surface.** In-scope and out-of-scope definitions are operational safeguards.
6. **Carry controls with the work.** Governance metadata should travel with the packet, not be reconstructed at each handoff.
7. **Packets are born governance-complete.** ICP runs before issuance. Gaps are closed in governance, not discovered in execution.
8. **Reference, don't duplicate.** The packet points to adjacent stack contracts and artifacts rather than absorbing their content.
9. **State must be explicit.** Hidden work states create control failures.
10. **Granularity must be enforced at intake.** A packet too large or too small to govern undermines the model.
11. **Overlays, not classes.** Product, team, and domain specificity belongs in overlay fields.
12. **Version changes must be visible.** Material changes to the work object must not be silent.
13. **Usable by humans and machines.** The packet should support both operator comprehension and automation.
14. **Portable by design.** The packet should survive changes in host system, runtime, and vendor tooling.

---

## 22. Integration model

The Task Packet is designed for independent development and later reintegration into any broader governed work system.

### 22.1 Minimal integration contract

A host system must be able to: create packet IDs, store and update packet state, attach governance and classification metadata, invoke ICP at the declared mode and attach the resulting Augmented Spec reference, attach references to capabilities and runtime, and retrieve packets by ID.

### 22.2 Independence rule

The Task Packet schema can be designed, tested, versioned, and evolved independently from governance, runtime, execution, and proof implementations.

### 22.3 Reintegration rule

If evolved separately, reintegration occurs by mapping: packet ID, status/state model, classification fields, governance fields (including `icp_mode`), Augmented Spec reference fields, capability references, runtime references, proof links, and attachment/link semantics.

---

## 23. Migration from v2.0

### 23.1 New fields added in v2.1

| Field | Block | Notes |
|---|---|---|
| `icp_mode` | Governance block | Required for all packets. Use `N/A` for non-Change/Incident classes. |
| `augmented_spec_ref` | Proof block / Attachment block | Required. Use `N/A` where ICP does not apply. |
| `augmented_spec_status` | Proof block / Attachment block | Required. Allowed values: `Draft`, `Approved`, `Approved-with-ODs`, `Amended`, `Closed`, `Waived`, `N/A`. |

### 23.2 Updated rules in v2.1

- G1 Readiness gate now has explicit requirements for Change packets tied to `augmented_spec_status`.
- Class definitions now include ICP applicability statements.
- Section 7 (VMO-ICP invocation model) is new in v2.1.

### 23.3 Vocabulary continuity

All canonical field names from v2.0 are preserved unchanged. No renames.

---

## 24. Migration from v1.x vocabulary

The canonical field names are:

- `packet_id` — supersedes `task_id`
- `packet_class` — supersedes `task_type`
- `packet_subtype` — supersedes `task_subtype`

If a legacy packet contains `task_id`, `task_type`, or `task_subtype`, interpret them as `packet_id`, `packet_class`, and `packet_subtype` respectively, provided the meaning is compatible.

---

## 25. Artifacts and records

**Core packet artifacts:**
- Task Packet
- Packet Amendment Record
- Packet Transition Record
- Packet Split / Merge Record
- Packet Attachment Manifest
- Packet Closure Record

**ICP artifacts (produced by VMO-invoked ICP run, stored in Proof Layer, referenced by packet):**
- Augmented Spec (`augmented_spec_ref`)
- Coverage Matrix
- Gap Inventory
- Open Decision records
- Viability Findings

**Core proof artifacts (produced by the execution stack, anchored to the packet):**
- Run Record
- Test Record
- Decision Record
- Change Record
- Gate Record
- Approval Record
- Proof Pack Manifest

---

## 26. Starter subtype registry

This is an open starter registry, not a closed list.

**Discovery:** `research`, `spike`, `option_analysis`, `architecture_probe`, `canon_retrieval`, `precedent_review`

**Change:** `feature`, `bugfix`, `refactor`, `docs_update`, `config_change`, `schema_change`, `policy_update`, `migration`

**Assurance:** `compliance_review`, `audit_response`, `traceability_check`, `proof_pack_assembly`, `readiness_assessment`, `control_validation`, `replay_verification`

**Incident:** `triage`, `hotfix`, `rollback`, `containment`, `break_glass_response`, `failure_investigation`, `post_incident_evidence_capture`

**Release:** `merge_approval`, `deployment_approval`, `publication_approval`, `release_readiness`, `cutover_authorization`, `package_promotion`

---

## 27. Adoption guidance

### 27.1 Standardize immediately

- top-level packet classes,
- constitutional and governance fields including `icp_mode`,
- `augmented_spec_ref` and `augmented_spec_status` fields,
- naming and identity rules,
- intake decision process,
- ICP mode mapping table.

### 27.2 Allow controlled extension

- `packet_subtype` registry,
- `product_context` and `domain_context` values,
- `capability_area` values,
- approval routing detail.

### 27.3 Never do

- create product-specific top-level packet classes,
- mix governance rigor into the class name,
- use class and subtype as status values,
- treat packet titles as durable identity,
- invent classification synonyms without registry control,
- issue a Change packet without a valid Augmented Spec reference.

---

## Appendix A — Key terms

These definitions are scoped to this document. The authoritative, system-wide definitions for all LuAOS terminology are maintained in the LuDRACO Atlas (STD-0003).

- **Amendment record** — the record of a material change to a packet after it has been admitted.
- **AEU (Autonomous Execution Unit)** — the concrete worker that executes ICP analysis and other implementation functions inside a runtime session.
- **Augmented Spec** — the full implementation specification produced by an ICP run, incorporating the original prompt plus all surfaced and resolved gaps. Stored as a governed, repo-native artifact. Referenced by the packet via `augmented_spec_ref`.
- **Canon** — the authoritative reference sources governing a packet's execution context.
- **Context overlay fields** — fields that add local product, domain, or team specificity without changing the governing class.
- **Governing question** — the primary question that determines a packet's top-level class.
- **Governance mode** — the control intensity applied to a packet: Lean, Standard, or Assured.
- **ICP (Implementation Completeness Protocol)** — the standard (STD-ICP-0001) that governs the pre-issuance planning phase for Change and Incident packets. Invoked by VMO before packet issuance.
- **ICP mode** — the depth of ICP analysis applied: Lite, Standard, Full, or Emergency. Declared in the packet governance block as `icp_mode`.
- **Open Decision** — a gap item surfaced during an ICP run that requires resolution before or during implementation. High-stakes Open Decisions block packet admission.
- **Originating demand** — the request, signal, incident, or opportunity from which the packet was created.
- **Packet** — shorthand for Task Packet.
- **Packet class** — the top-level classification of a packet by its governing question.
- **Packet state** — the packet's current lifecycle position.
- **Packet subtype** — a more specific label within a top-level class.
- **Packet weight** — the proof and documentation burden tier: MVPP, SPP, or HAPP.
- **Proof burden** — the declared evidence intensity: light, standard, or high.
- **Proof pack** — the assembled evidence bundle anchored to a packet, gate, or release.
- **RTE (Runtime Execution Environment)** — the execution substrate that hosts ICP runs and instantiates task packets into live execution sessions.
- **Selected VCC chain** — the ordered capability chain through which the work is expected to move.
- **Task Packet** — the first-class governed work object defined by this standard.
- **VCC (Value Capability Contract)** — a formal, reusable capability contract defining purpose, boundaries, inputs, outputs, proof requirements, and autonomy limits.
- **VMO (Value Management Orchestrator)** — the governance control plane that owns ICP invocation, Augmented Spec approval, and packet issuance.

---

## Appendix B — Canonical packet events

| Event | Meaning |
|---|---|
| `PacketDrafted` | Initial work object created |
| `PacketAdmitted` | Packet accepted into governed flow (ICP complete, Open Decisions resolved or flagged) |
| `PacketReady` | Packet sufficiently defined for issue |
| `PacketIssued` | Packet formally released to downstream stacks (Augmented Spec in Approved status) |
| `PacketActivated` | Execution work began |
| `PacketBlocked` | Progress halted |
| `PacketEscalated` | Packet requires higher authority or review |
| `PacketVerified` | Required checks satisfied |
| `PacketClosed` | Terminal governed state reached |
| `PacketArchived` | Historical retention state entered |

---

## Appendix C — Minimal standalone schema

A minimal Task Packet schema must define at least:

- `packet_id` and version,
- `packet_class` and `packet_subtype`,
- `objective` and `done_definition`,
- `in_scope_assets` and `scope_boundaries`,
- current state,
- `governance_mode`, `packet_weight`, `proof_burden`, `icp_mode`,
- `active_gates` and `required_approvals`,
- `selected_vcc_chain`,
- `augmented_spec_ref` and `augmented_spec_status`,
- runtime target / scope,
- `expected_outputs`,
- timestamps and owner/sponsor.

If those fields exist, the Task Packet can be independently developed and later reintegrated into any broader governed work system with minimal rewriting.
