# Architecture Overview

This document describes the structural logic of `luphay-p3-governance` for a new agent or human contributor who needs to understand not just what the structure is, but why it was built that way. Navigation documents — `README.md`, `START_HERE.md`, and `AGENTS.md` — tell you where to go; this document explains the reasoning behind the design so that every structural choice is legible and every constraint is traceable to its purpose.

---

## The five zones

The repo root is organised into five conceptual zones, each carrying a distinct responsibility in the governance system.

| Zone | Root folders | Role |
|---|---|---|
| Governance | `01_governance/` | Defines the rules the system runs on |
| Execution instruments | `02_templates/`, `03_portfolios/` | Operationalises governance and houses live work |
| Reference and operations | `04_docs/` | Holds repo-level docs; home of the canonical path registry |
| Flow control | `05_hub/` | Controls intake, staging, and promotion of all new work |
| Machine layer | `06_state/`, `07_scripts/`, `08_command/`, `09_runs/` | Derived state, tooling, command surface, and ephemeral runtime |

The Governance zone (`01_governance/`) is the source of all rules. It contains the naming standard, the framework document that defines the P3 hierarchy, playbooks that encode repeatable operating procedures, and the decisions register. Nothing in this zone is operational — it defines; it does not act.

The Execution instruments zone bridges definition and work. `02_templates/` contains governed templates that operationalise the standards in `01_governance/` — every new portfolio, program, project, or task packet begins from a template, ensuring structural contracts are enforced at creation time rather than enforced after the fact. `03_portfolios/` houses all live governed work: the actual objects that agents and humans create, manage, and complete.

The Reference and operations zone (`04_docs/`) holds the documents that describe the repo itself — this architecture overview, the canonical path registry (`REPO_PROFILE.md`), and operating notes that are not governance rules. It is also the home of the machine-readable identity snapshot that every agent reads during cold-start to resolve navigable paths.

The Flow control zone (`05_hub/`) is the controlled entry point for all new work. Objects are proposed, staged, and reviewed here before being promoted into `03_portfolios/`. Nothing enters the governed hierarchy without passing through the hub, which enforces quality gates without polluting the live work zone with incomplete or unreviewed objects.

The Machine layer (`06_state/`, `07_scripts/`, `08_command/`, `09_runs/`) serves the operational mechanics of the system. `06_state/` holds both human-authored cross-cutting YAML and the derived JSON registers that agents query. `07_scripts/` provides validation and state rebuild tooling. `08_command/` is a deferred command surface not yet active — it requires an authorising ADR before use. `09_runs/` is gitignored ephemeral scratch space for agent runtime output.

The zones follow a conceptual flow: definition (governance) → operationalisation (templates) → execution (portfolios) → control (hub) → reflection (state). A new object always enters through the hub and exits into portfolios. State always reflects portfolios — it never defines them.

---

## The P3 hierarchy

The portfolio hierarchy is the structural backbone of all governed work. The model nests four levels: Portfolio → Program → Project → Task Packet. A Portfolio (`P3-PORT-NNNN`) is a strategic container — a persistent organisational objective that may span many programs over time. A Program (`P3-PROG-NNNN`) is a coordinated group of related projects working toward a shared goal within the portfolio. A Project (`P3-PROJ-NNNN`) is a bounded, time-limited effort that delivers a defined outcome. A Task Packet (`TASK-[CLASS]-NNNN`) is the unit of executable work: a single, well-scoped piece of work assigned to an agent or human operator.

The nesting implements inheritance of context: a task packet inherits the scope boundaries of its parent project, which inherits the goals of its parent program, which inherits the strategic objective of its parent portfolio. An agent working on a task packet can always trace upward to understand why the work exists and what constraints govern it.

Every governed object home carries two files: a primary Markdown file (the human-readable governing document) and a sibling `entity.yaml` or `packet.yaml` (the machine-readable source of truth). These files are not redundant — agents read YAML to extract structured identity data without parsing prose; humans read Markdown to understand intent, decisions, and context. Neither file is optional: an object home missing either file is structurally incomplete.

Scoped decisions follow the same nesting logic. Each portfolio, program, and project home contains a `decisions/` subfolder. Decision IDs use the `ADR-DECN-NNNN` sequence, and that sequence is globally sequential across all scopes. Scope is recorded in the decision's front matter (`scope_level`) rather than in the ID or path, so the decision register can be sorted and queried uniformly without needing to know where in the hierarchy a given ADR lives.

```
03_portfolios/
└─ P3-PORT-NNNN__slug/
   ├─ P3-PORT-NNNN__slug__vX.Y.md    — human governing file
   ├─ entity.yaml                     — machine-readable identity
   ├─ docs/
   ├─ decisions/
   └─ programs/
      └─ P3-PROG-NNNN__slug/
         ├─ P3-PROG-NNNN__slug__vX.Y.md
         ├─ entity.yaml
         ├─ docs/
         ├─ decisions/
         └─ projects/
            └─ P3-PROJ-NNNN__slug/
               ├─ P3-PROJ-NNNN__slug__vX.Y.md
               ├─ entity.yaml
               ├─ docs/
               ├─ decisions/
               ├─ artifacts/
               ├─ links/
               └─ task-packets/
                  └─ TASK-CLASS-NNNN__slug/
                     ├─ TASK-CLASS-NNNN__slug__vX.Y.md
                     ├─ packet.yaml
                     ├─ inputs/
                     ├─ outputs/
                     ├─ working/
                     └─ evidence/
```

---

## The state contract

The `06_state/` zone exists because agents need fast, structured access to entity data. Traversing `03_portfolios/` recursively on every query is slow and fragile — the registers in `06_state/registers/` provide pre-built JSON indexes that agents query directly, without walking the portfolio tree.

The zone operates on a two-layer model that distinguishes human-authored inputs from machine-written outputs. The `inputs/` layer contains human-authored YAML for cross-cutting concerns that cannot be derived from object-home entity files alone — risks, dependencies, benefits, and artifact registries that span multiple governed objects. Humans write these files; agents may propose changes but must surface them for human approval before writing.

The `registers/`, `graph/`, and `audit/` layer contains machine-written outputs only. `rebuild-state.ps1` regenerates them by scanning every `entity.yaml` and `packet.yaml` across `03_portfolios/` and joining them with the `inputs/` YAML. They are never edited directly. The audit log in `audit/` is append-only: agents write entries to it, and no entry is ever modified after it is written.

The governing invariant of this zone: if `registers/` and the actual `entity.yaml` files disagree, the `entity.yaml` files are truth. Registers are a cache, not a source. Running `rebuild-state.ps1` resolves any disagreement.

| Path | Type | Who writes | Edit directly? |
|---|---|---|---|
| `06_state/inputs/*.yaml` | Human-authored YAML | Human operator | YES |
| `06_state/registers/*.json` | Derived JSON | `07_scripts/rebuild-state.ps1` | NO |
| `06_state/graph/*.json` | Derived graph | `07_scripts/rebuild-state.ps1` | NO |
| `06_state/audit/` | Immutable log | Agent workers | NO |

---

## The agent path model

Agents in this repo navigate by declared paths, not by folder inference. This design decision — recorded in ADR-ARCH-0001 — isolates two navigation models that would otherwise interfere with each other.

Root folders carry a `NN_` numeric prefix designed for human visual orientation. If agents were allowed to infer paths from folder names or numbering, any structural change — adding a new root folder between `05_hub/` and `06_state/`, for example — would silently renumber downstream folders and break every path assumption held in agent memory. The failure would be silent until an agent tried to access a location that no longer existed at the expected address.

By requiring agents to derive all navigable paths from two declared sources — `AGENTS.md` and `04_docs/REPO_PROFILE.md` — the human visual model (T1) and the agent navigation model (T2) are fully isolated. Renumbering root folders requires updating those two files and nothing else. The two sources serve the same data in different formats: `AGENTS.md` is a human-readable declaration table that agents read on cold-start; `REPO_PROFILE.md` expresses the same declarations as structured YAML for programmatic use.

The cold-start protocol follows directly from this design. Every agent session begins by reading `AGENTS.md` in full, then `REPO_PROFILE.md`. Paths are never assumed from prior sessions. An agent that cannot find a required path by reading these two files should escalate to Alpha — not infer.

---

## The prefix convention

Every root folder carries a two-digit numeric prefix: `01_governance/`, `02_templates/`, through `09_runs/`. The prefix solves a specific human usability problem: file browsers and IDEs display folders in OS-default order, which is typically alphabetical or by creation date. Without prefixes, `governance/` would sort between `docs/` and `hub/`, breaking the conceptual reading sequence. The numeric prefix forces the display order to match the conceptual flow — from definition through operationalisation through execution through control to reflection.

The convention applies to root folders only. Internal subfolders, governed object homes (`P3-PORT-NNNN__slug/`), and LNS-named files do not carry numeric prefixes. Applying the convention internally would create noise without adding orientation value — internal navigation is driven by the LNS identity scheme, not by reading order.

The prefix is invisible to correct agent operation, since agents derive paths from declared registries rather than parsing folder names. If root folders are renumbered, `AGENTS.md` and `REPO_PROFILE.md` must be updated before the rename is committed — the control surfaces are always updated first.

---

## Structural invariants

The following invariants define the architectural commitments of this repository. They are not operational guidelines — those live in `AGENTS.md`. They are structural constraints that must not be violated without an authorising ADR.

1. The `NN_` numeric prefix applies to root folders only. Internal subfolders are not prefixed.
2. All agent-navigable paths are declared in `AGENTS.md` and `04_docs/REPO_PROFILE.md`. Agents derive paths from those sources — never from inference or memory.
3. `06_state/registers/`, `06_state/graph/`, and `06_state/audit/` are machine-written. They are never edited directly.
4. Every governed object home carries a primary `.md` file and a sibling `entity.yaml` (or `packet.yaml` for task packets). Neither file is optional.
5. `ADR-DECN` IDs are globally sequential across all scopes. Scope is recorded in front matter (`scope_level`), not in the ID or folder path.
6. Structural changes to the root hierarchy require an authorising ADR before implementation.
