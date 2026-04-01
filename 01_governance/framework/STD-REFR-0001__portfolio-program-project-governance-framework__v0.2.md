---
id: STD-REFR-0001
title: Portfolio–Program–Project Governance Framework
version: v0.2
status: active
family: STD-REFR
supersedes: P3-GOV-0001 v0.1
created_by: Alpha
created_at: 2026-03-27
last_updated: 2026-03-29
---

# STD-REFR-0001 — Portfolio–Program–Project Governance Framework v0.2

**Applies to:** all governed work at Luphay Technologies
**Naming standard:** LNS v0.4 (STD-SYS-0001)
**Repo:** luphay-p3-governance

---

## Change log

### v0.2 — 2026-03-29
- File renamed from `P3-GOV-0001` to `STD-REFR-0001` to align with LNS v0.4 STD family.
- Expanded lifecycle, gate model, and governance mode sections.
- Added agent operating notes throughout.

### v0.1 — 2026-03-27
- Initial release.

---

## 1. Purpose

The Portfolio–Program–Project (P3) framework is the operating model for all governed
work at Luphay Technologies. It provides a hierarchy of containers — Portfolio, Program,
Project, and Task Packet — that structure work from strategic objective down to discrete
executable unit. Every piece of governed work at Luphay belongs to a node in this
hierarchy.

P3 serves two readers simultaneously: human operators who need to plan, prioritise,
and decide; and AI agents who need to navigate, read state, and execute. The framework
is designed so both readers can operate from the same canonical structure without
separate interfaces.

---

## 2. Hierarchy model

The P3 hierarchy has four levels. Each level is governed, named, and tracked
independently. Each level inherits context from the level above it.

```
Portfolio
└─ Program
   └─ Project
      └─ Task Packet
```

### 2.1 Portfolio

A Portfolio is a collection of Programs aligned to a single strategic objective.
It is the highest-level governed container. A Portfolio defines the strategic
horizon (Now / Next / Later), the business outcome being pursued, and the
governance boundary within which its Programs operate.

Portfolios do not execute work. They own Programs. Every Program belongs to
exactly one Portfolio.

**Identity formula:** `P3-PORT-NNNN__slug__vX.Y.md`
**Home location:** `03_portfolios/P3-PORT-NNNN__slug/`

### 2.2 Program

A Program is a set of related Projects managed together to achieve a combined
outcome that could not be achieved by any single Project. Programs translate
Portfolio strategy into coordinated delivery. A Program owns its Projects and
is responsible for cross-project dependencies, shared risks, and milestone
sequencing.

**Identity formula:** `P3-PROG-NNNN__slug__vX.Y.md`
**Home location:** `03_portfolios/P3-PORT-NNNN.../programs/P3-PROG-NNNN__slug/`

### 2.3 Project

A Project is a temporary endeavor to create a unique product, capability, or
result. Projects have defined scope, start conditions, end conditions, and
acceptance criteria. A Project owns its Task Packets and is responsible for
delivering governed outputs within its Program's scope.

**Identity formula:** `P3-PROJ-NNNN__slug__vX.Y.md`
**Home location:** `.../programs/P3-PROG-NNNN.../projects/P3-PROJ-NNNN__slug/`

### 2.4 Task Packet

A Task Packet is the atomic unit of governed execution. It is the smallest unit
that carries its own scope, inputs, outputs, acceptance criteria, and evidence
trail. Task Packets are the interface between human governance and agent
execution — they are what agents pick up and execute.

**Identity formula:** `TASK-[CLASS]-NNNN__slug__vX.Y.md`
**Home location:** `.../projects/P3-PROJ-NNNN.../task-packets/TASK-CLASS-NNNN__slug/`

---

## 3. Companion file model (CP1)

Every governed object home carries two files that serve different readers:

| File | Reader | Purpose |
|---|---|---|
| `P3-PORT-NNNN__slug__vX.Y.md` | Human + agent context | Narrative, scope, rationale, governance notes |
| `entity.yaml` | Agent (structured query) | Machine-readable identity, status, dates, dependencies |
| `packet.yaml` (task packets only) | Agent (structured query) | Machine-readable task status, assignees, dependencies |

The `.md` file and the `entity.yaml` are not redundant. They serve different
purposes and different readers. Neither is optional.

**Source of truth rule:** for structured fields (status, dates, assignees,
dependencies), `entity.yaml` is the source of truth. If `entity.yaml` and
the `.md` file disagree on a structured field, the `entity.yaml` wins.

---

## 4. Lifecycle

Every governed object moves through a defined lifecycle. Status is recorded in
`entity.yaml` (or `packet.yaml`) — never in the filename.

### 4.1 Portfolio and Program lifecycle

```
draft → active → closing → closed | archived
```

| Status | Meaning |
|---|---|
| `draft` | Being scoped; not yet formally chartered |
| `active` | Chartered and in delivery |
| `closing` | Delivering final outputs; no new work entering |
| `closed` | Delivery complete; outcomes accepted |
| `archived` | Retired from active governance; read-only |

### 4.2 Project lifecycle

```
draft → scoped → active → review → closed | archived
```

| Status | Meaning |
|---|---|
| `draft` | Concept under development; not yet scoped |
| `scoped` | Scope confirmed; charter pending |
| `active` | Chartered and executing |
| `review` | Outputs under acceptance review |
| `closed` | Accepted; project complete |
| `archived` | Retired from active governance |

### 4.3 Task Packet lifecycle

```
draft → ready → active → blocked | in-review → done | returned
```

| Status | Meaning |
|---|---|
| `draft` | Being specified; not yet ready for execution |
| `ready` | Spec complete; ready to be picked up |
| `active` | Being executed by an agent or human |
| `blocked` | Execution paused; dependency or decision required |
| `in-review` | Outputs under review |
| `done` | Accepted; outputs promoted |
| `returned` | Returned to draft for rework |

---

## 5. Governance modes

Each Task Packet operates under one of three governance modes. The mode is
declared in front matter (`governance_mode`) at packet creation and governs
the level of review, evidence, and gate scrutiny applied.

| Mode | When to use | Evidence required | Gate |
|---|---|---|---|
| `Lean` | Low-risk, well-understood work; minimal review needed | Output present | Self-assessed |
| `Standard` | Most governed work; normal review cycle | Output + brief log | Human review |
| `Assured` | High-risk, high-consequence, or compliance-relevant work | Full evidence trail | Human sign-off |

Default mode for new Task Packets is `Standard` unless Alpha specifies otherwise.

---

## 6. Decision model

Decisions are formal records of choices that affect the governed system. Every
structural decision — a new portfolio, a change to repo architecture, a naming
exception — is recorded as an ADR.

### 6.1 Decision scopes

| Scope | Where filed | front matter `scope_level` |
|---|---|---|
| Enterprise / repo-wide | `01_governance/decisions/` | `Enterprise` |
| Portfolio | `03_portfolios/P3-PORT-NNNN.../decisions/` | `Portfolio` |
| Program | `.../programs/P3-PROG-NNNN.../decisions/` | `Program` |
| Project | `.../projects/P3-PROJ-NNNN.../decisions/` | `Project` |

### 6.2 ID model

`ADR-DECN` IDs are globally sequential across all scopes. The ID does not
encode the scope — scope is in front matter. The global decision register
(`01_governance/decisions/decision-register.md`) is the authority for the
current sequence.

Architecture decisions (`ADR-ARCH`) are a separate ID sequence reserved for
decisions about the repo structure itself.

### 6.3 When a decision record is required

- Any structural change to the root repo hierarchy
- Any deviation from LNS v0.4 naming rules (exception-register.md also updated)
- Any change to the governance model, lifecycle, or gate rules
- Any change that affects agent operating behaviour
- Any decision Alpha explicitly instructs to be recorded

---

## 7. Hub and promotion model

New work enters the system through `05_hub/`. It does not go directly into
`03_portfolios/`. The hub provides controlled intake, staging, and promotion.

### 7.1 Intake stages

```
raw_drop → triage → candidate_[type] → pending_admission → promoted
                                                          → rejected_or_returned
```

| Stage | What happens |
|---|---|
| `raw_drop/` | Item received; unreviewed |
| `triage/` | Classification review: what type of object is this? |
| `candidate_*/` | Classified by type; gate checks in progress |
| `pending_admission/` | All gate checks passed; awaiting final Alpha approval |
| `promoted_log/` | Record of promoted items; item moves to `03_portfolios/` |
| `rejected_or_returned/` | Failed gate or returned for rework |

### 7.2 Promotion gate criteria

An item passes from `pending_admission` to promotion when:
1. Object type is confirmed (portfolio / program / project / task packet)
2. LNS-compliant name is determined
3. Parent entity exists and is `active`
4. `entity.yaml` or `packet.yaml` is complete with no empty mandatory fields
5. Alpha has approved

Agents do not self-promote items. Promotion requires Alpha approval at the
final gate.

---

## 8. State model

`06_state/` holds derived and cross-cutting governance state. It is a
machine-managed zone — agents read it; humans manage `inputs/`; scripts
write `registers/` and `graph/`.

### 8.1 State inputs

`06_state/inputs/` holds human-authored YAML for concerns that cannot be derived
from entity files alone:

| File | Purpose |
|---|---|
| `risk-register.yaml` | Cross-cutting risks across the portfolio |
| `dependency-register.yaml` | Cross-object dependencies |
| `benefit-register.yaml` | Tracked benefits |
| `artifact-register.yaml` | Governed artifacts not in entity files |

### 8.2 Derived outputs

`06_state/registers/` holds JSON registers generated by `07_scripts/rebuild-state.ps1`
by scanning all `entity.yaml` and `packet.yaml` files in `03_portfolios/`.

Agents query JSON registers for fast structured access to entity state. They
do not traverse `03_portfolios/` for state queries.

**Invariant:** if a JSON register conflicts with an `entity.yaml`, the
`entity.yaml` is truth. Registers are a derived cache, not a source.

---

## 9. Agent operating notes

P3 is designed for agent-first execution. The following conventions exist
specifically to make agent operation reliable:

**Path isolation.** All agent-navigable paths are declared in `AGENTS.md` and
`04_docs/REPO_PROFILE.md`. Agents read paths from those sources — never from
folder name inference. This isolates human visual conventions (folder prefixes)
from agent navigation.

**YAML as query layer.** Agents read `entity.yaml` and `packet.yaml` for
structured data. They read `.md` files for context and narrative. They never
attempt to parse structured data from Markdown.

**Spec before build.** No agent builds a governed object without a spec —
either a task contract (TASK-DOCS/FEAT/etc.) or an explicit Alpha instruction
that functions as one. Building without a spec is a protocol violation under
LU-SDD.

**Escalation over inference.** When structural or governance ambiguity arises,
agents surface it to Alpha. They do not resolve it through inference and encode
that inference in the repo.

---

*STD-REFR-0001 v0.2 — Luphay Technologies*
*Naming standard: LNS v0.4 (STD-SYS-0001)*
*Founding ADR: ADR-ARCH-0001*
