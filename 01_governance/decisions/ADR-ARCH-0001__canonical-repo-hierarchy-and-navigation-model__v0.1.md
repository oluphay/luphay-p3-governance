---
id: ADR-ARCH-0001
title: Canonical Repo Hierarchy and Navigation Model
version: v0.1
status: active
decision_type: Architecture
scope_level: Enterprise
effective_date: 2026-03-29
related_artifacts:
  - luphay-p3-governance__canonical-repo-tree__v0_4.md
  - STD-SYS-0001__luphay-unified-naming-standard__v0.4.md
  - STD-REFR-0001__portfolio-program-project-governance-framework__v0.2.md
supersedes: ~
created_by: Alpha
created_at: 2026-03-29
---

# ADR-ARCH-0001 — Canonical Repo Hierarchy and Navigation Model v0.1

---

## Status

**Active.** This ADR governs the structure of `luphay-p3-governance` at v0.4.
Structural changes to the root hierarchy require a new ADR or a version increment
to this document before implementation.

---

## Context

`luphay-p3-governance` is the canonical governance platform for Luphay Technologies'
Portfolio–Program–Project (P3) operating model. As a solo-founder operation directing
AI agents as the primary execution layer, the repo must serve two distinct navigation
needs simultaneously:

**T1 — Human visual navigation.** Alpha needs to scan and orient within the repo
quickly using an IDE sidebar or file browser. Humans parse ordered, labelled
structures faster than alphabetical or creation-order listings.

**T2 — Agent navigation.** AI agents (Claude Code, Codex, Claude Cowork) navigate
the repo programmatically. They must reach any zone reliably without inferring
paths from folder names or numbering. Any convention that requires agents to
reconstruct paths from visual cues is fragile.

The tension: if T1 changes folder names (through prefixing or reordering), and
agents depend on those names to navigate, T1 changes break T2. The architecture
must resolve this tension with a structural decision, not an operational workaround.

Additional concerns addressed in this ADR:

- **Governance consolidation.** Prior structure had `standards/`, `framework/`,
  and `decisions/` as separate root folders. As standalone roots they were
  operationally disconnected despite being logically unified as governance artifacts.
- **Register maintenance burden.** Manual Markdown registers (portfolio-register.md,
  program-register.md, etc.) create a three-write problem: every entity change
  requires updating the entity file, the Markdown register, and the derived JSON.
  This is a drift vector at solo-operator scale.
- **Agent-readable state.** Agents querying entity state by traversing a deeply
  nested folder tree is slow and fragile. A structured query layer is needed.
- **Machine vs. human authoring zones.** No prior explicit boundary existed between
  what humans maintain and what agents write. This creates ambiguity and risk.

---

## Decisions

### Decision 1: Nine-root folder structure with numeric prefix

**Adopted.** The repo root contains exactly nine folders, numbered `01_` through `09_`.

```
01_governance/
02_templates/
03_portfolios/
04_docs/
05_hub/
06_state/
07_scripts/
08_command/
09_runs/
```

The numeric `NN_` prefix is a T1 convention — it forces deliberate reading order
in file browsers and IDE sidebars, reflecting the conceptual flow of the system
(definition → operationalisation → execution → control → machine layer).

**Rationale:** Without prefixes, OS-default ordering (alphabetical or creation date)
produces an arbitrary scan order that does not reflect the system's logic. Numeric
prefixes are a low-cost, durable solution that survives file browser differences
across environments.

**Scope of prefix:** root folders only. Internal subfolders, governed object homes
(`P3-PORT-NNNN__slug/`), and LNS-named files are not prefixed. The convention is
intentionally narrow.

---

### Decision 2: T1/T2 isolation via declared path registry

**Adopted.** Agent-navigable paths are declared exclusively in `AGENTS.md` and
`04_docs/REPO_PROFILE.md`. Agents must derive all paths from those sources — never
from folder name inference, folder numbering, or prior session memory.

**Rationale:** If agents infer paths from folder names or numbering, any T1
reordering (inserting a new root folder, renaming a folder) breaks agent navigation
silently. By isolating agent navigation to a declared registry, T1 changes require
updating one file — not hunting through agent memory or hardcoded assumptions. This
makes the repo safe to evolve without coordinating T1 and T2 changes simultaneously.

**Implementation:** `AGENTS.md` contains the canonical path declaration table in
prose-readable format. `04_docs/REPO_PROFILE.md` contains the same data in
machine-readable YAML format. Both must be updated before any root folder rename
or reorder is committed.

---

### Decision 3: Governance consolidation into `01_governance/`

**Adopted.** The root folders `standards/`, `framework/`, and `decisions/` are
retired as standalone roots. Their contents are consolidated under `01_governance/`
with the following internal structure:

```
01_governance/
├─ standards/     — frozen versioned standards (LNS, etc.)
├─ framework/     — governing framework specifications (P3 framework)
├─ playbooks/     — operating guides and how-to references
└─ decisions/     — repo-wide and cross-cutting ADRs
```

**Rationale:** Standards, framework, playbooks, and decisions are all governance
artifacts — they define the rules the system runs on. Separating them into peer
root folders created an artificial split in what is logically a single governance
library. An agent cold-starting to understand the system's rules had to navigate
three different root folders. Consolidation reduces cognitive load for both human
and agent readers.

**Key distinction preserved:** `02_templates/` remains a standalone root folder.
Templates are downstream of governance (they operationalise it) and upstream of
execution (agents reach for them when creating new objects). The bridge position
between `01_governance/` and `03_portfolios/` is intentional and correct.

---

### Decision 4: `02_templates/` as bridge layer

**Adopted.** `02_templates/` is retained as a standalone root folder positioned
between `01_governance/` and `03_portfolios/`.

**Rationale:** Templates are not governance artifacts (they do not define rules)
and they are not execution artifacts (they do not contain live work). They
operationalise governance for agents and humans creating new governed objects. The
bridge position reflects this dependency: templates depend on governance (they
must conform to standards) and they enable execution (agents copy them to create
portfolios, programs, projects, task packets). Nesting templates inside
`01_governance/` would misrepresent their function.

---

### Decision 5: YAML companion files at every governed object home (CP1)

**Adopted.** Every portfolio, program, and project home carries a sibling
`entity.yaml` alongside its primary governing `.md` file. Every task packet home
carries a sibling `packet.yaml`.

```
P3-PORT-NNNN__slug/
├─ P3-PORT-NNNN__slug__vX.Y.md    — human context and narrative
└─ entity.yaml                     — machine-readable source of truth
```

**Rationale:** Markdown files are not reliably parseable by agents for structured
data extraction. An agent querying the status, owner, or dependencies of a portfolio
by parsing Markdown is performing fragile text extraction. `entity.yaml` provides
a typed, structured record for every field agents need to query or update. The
`.md` file is retained for human readability and agent narrative context — it is
not replaced.

**Source of truth rule:** for structured fields (status, dates, assignees,
dependencies), `entity.yaml` is truth. If the two files disagree on a structured
field, `entity.yaml` wins.

---

### Decision 6: Derived JSON registers in `06_state/` (CP2)

**Adopted.** Manual Markdown registers for portfolios, programs, projects, and
task packets are retired. Derived JSON registers are generated by
`07_scripts/rebuild-state.ps1` by scanning all `entity.yaml` and `packet.yaml`
files in `03_portfolios/`.

```
06_state/registers/
├─ portfolio-register.json    — derived from entity.yaml scans
├─ program-register.json
├─ project-register.json
├─ task-register.json
├─ decision-register.json
└─ artifact-register.json
```

**Rationale:** Manually maintained Markdown registers create a three-write problem:
every entity change requires updating the entity file, the Markdown register, and
any downstream derived artifact. At solo-operator scale with AI agents as the
execution layer, three-write operations are a guaranteed drift vector. Derived JSON
registers eliminate manual register maintenance. Agents query JSON (fast, typed,
structured); humans manage `entity.yaml` (structured but human-readable).

**Retained Markdown registers:** `decision-register.md` and `exception-register.md`
are retained as human-maintained files in `01_governance/decisions/`. These cross-
cutting governance records do not map cleanly to a single entity type and benefit
from human curation. `repo-register.md` is retained in `04_docs/` as a repo-level
reference document.

---

### Decision 7: `06_state/` as machine-managed zone with declared input contract (CP3)

**Adopted.** `06_state/` is a machine-managed zone. It is divided into two layers
with explicit authoring contracts:

| Subfolder | Type | Who writes |
|---|---|---|
| `inputs/` | Human-authored YAML | Human operator (Alpha) |
| `registers/` | Derived JSON | `07_scripts/rebuild-state.ps1` |
| `graph/` | Derived graph | `07_scripts/rebuild-state.ps1` |
| `audit/` | Immutable log | Agent workers (append only) |

**Rationale:** Without an explicit zone contract, the boundary between what humans
maintain and what agents write is ambiguous. Ambiguity produces both human edits
to machine-managed files (invalidated on next script run) and agent edits to
human-managed files (overwriting deliberate human decisions). The zone contract
makes the boundary unambiguous and machine-enforceable.

`inputs/` holds cross-cutting YAML registers for concerns that cannot be derived
from entity files alone: risks, dependencies, benefits, tracked artifacts. These
require human judgment to populate and maintain.

---

### Decision 8: ADR-DECN IDs are globally sequential

**Adopted.** `ADR-DECN` IDs form a single global sequence across all scopes
(Enterprise, Portfolio, Program, Project). Scope is recorded in the `scope_level`
front matter field — not in the ID or the folder path.

**Rationale:** Scope-partitioned ID ranges (e.g., `0001–0099` for Enterprise,
`0100–0199` for Portfolio) create collision risk as any range fills, and they
require range management. Global sequences are simpler: the next ID is always
the current maximum plus one, regardless of where the ADR is filed. The
`decision-register.md` in `01_governance/decisions/` is the authority for the
current maximum ID.

`ADR-ARCH` IDs are a separate sequence reserved for architecture decisions about
the repo structure itself.

---

## Alternatives considered

### Alternative A: No numeric prefixes on root folders

Rejected. Without prefixes, OS-default ordering (alphabetical) produces an
arbitrary scan order. `01_governance/` would sort after `09_runs/` in reverse-
alphabetical file browsers. The cognitive overhead of reorienting on every file
browser open is non-trivial at daily-driver frequency.

### Alternative B: Agent paths inferred from folder numbering

Rejected. Allowing agents to infer paths from `NN_` numbering would create a
dependency between T1 (human visual convention) and T2 (agent navigation). Any
reordering of root folders — a normal evolution as the repo matures — would
silently break agent navigation. The declared registry model costs one file
update per reorder but eliminates all silent breakage.

### Alternative C: Retain standalone `decisions/` root folder

Rejected. Decisions are governance artifacts. Their logical home is the governance
library (`01_governance/`), not as a peer root folder to `03_portfolios/` and
`05_hub/`. The standalone root implied decisions were operationally equivalent to
portfolio structure and hub intake, which misrepresents their function.

### Alternative D: Flat task-packets with symlinks

Rejected. The externally proposed flat `task-packets/` structure with symlinks
was evaluated and rejected for the Luphay environment. Git on Windows handles
symlinks poorly and they break across clone environments. The deeply nested
structure is traversal-heavy but navigable via the declared path registry and
JSON registers. The symlink approach would introduce a platform dependency
without a reliable cross-environment implementation.

### Alternative E: Retain manual Markdown registers

Rejected. Manual registers require three-write maintenance (entity file + Markdown
register + derived JSON). At solo-operator scale this is a guaranteed drift vector.
Derived JSON registers, regenerated by script from `entity.yaml` scans, eliminate
the manual maintenance burden while preserving queryable structure.

---

## Consequences

### Positive

- T1 and T2 are fully isolated — root folder reordering does not break agent
  navigation.
- Governance artifacts are consolidated in a single library (`01_governance/`),
  reducing agent cold-start navigation cost.
- Entity data has a single source of truth (`entity.yaml`) with a structured
  query layer (`06_state/registers/*.json`).
- Machine vs. human authoring boundaries are explicit and unambiguous.
- Register maintenance burden is eliminated for entity registers.

### Constraints introduced

- `AGENTS.md` and `REPO_PROFILE.md` must be updated before any root folder
  rename or reorder is committed. These files are the control surfaces for
  agent navigation — they are not optional maintenance.
- `rebuild-state.ps1` must be run after any entity state change to keep JSON
  registers current. Until this script is fully implemented (P3-T44-0), agents
  must be aware that registers may lag entity files.
- `ADR-ARCH-0001` (this document) must be versioned whenever the root hierarchy
  changes. Structural drift without a corresponding ADR version is a governance
  violation.

### Open items at v0.1

- `validate.ps1` (P3-T43-0) is not yet implemented. LNS compliance checking and
  required-file presence checking are manual until the script is built.
- `rebuild-state.ps1` (P3-T44-0) is not yet implemented. JSON registers are
  seeded as empty stubs. Agents should treat register data as unavailable until
  the script is built and run against the first real portfolio.
- `08_command/` is deferred pending an authorising ADR for the command surface design.
- LNS v0.4 (STD-SYS-0001) status is `active` in this repo but the source document
  carries `Draft` status — this self-authorisation risk is a known open flag
  (see decision register).

---

*ADR-ARCH-0001 v0.1 — luphay-p3-governance — 2026-03-29*
