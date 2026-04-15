# Luphay Spec-Driven Development (LU-SDD)
## Primary Reference
**Version:** v0.3  
**Status:** Foundational operating standard  
**Owner:** Luphay Technologies  
**Posture:** Repo-native, dual-agent (two LLM agents: Codex + Claude Code), human-governed, Windows-friendly, GitHub-remote friendly  
**Supersedes:** LU-SDD v0.2  
**Checked against official OpenAI Codex and Anthropic Claude Code documentation:** March 13, 2026

### v0.3 Change Summary

- **"Dual-agent" defined explicitly.** The posture header now clarifies that "dual-agent" refers to two LLM agents (Codex + Claude Code) operating under a single human governor. The three-actor structure is documented, not assumed.
- **Deviation Protocol added to the synthesize step.** Any human override of LLM-produced material at the synthesize step must produce a lightweight Deviation Record: what was overridden, why, and by whom. Deviation Records are repo-native artifacts, not optional notes.
- **Review gate exit criteria defined.** Phase 2 (Counter-review and synthesis) now has three explicit exit conditions that must be satisfied before a spec is approved. A review that cannot satisfy all three is escalated, not passed.
- **"Freeze" replaced with "Version Lock" throughout.** Version Lock closes the active build cycle and assigns a version identifier. Artifacts remain mutable via versioned amendment — compatible with audit and correction requirements in regulated environments. All references to "freeze" in the operating loop, phases, doctrine, and checklist updated accordingly.
- **LLM Compatibility Contract introduced.** Each LLM role carries a defined minimum behavior contract. When an LLM update produces output inconsistent with the contract, a Drift Flag is raised and the loop pauses pending human assessment. See Section 8.9.
- **Maturity model external validation added.** Levels 3–5 now require a peer validation event before the level is claimed. Levels 1–2 remain self-assessed. See Section 6.3.

---

### v0.2 Change Summary

- **`specs/` is the canonical truth root.** ADRs, acceptance contracts, and task-linked spec material all live under `specs/`. The `docs/` tree is explanatory only.
- **Artifact stack collapsed for solo-founder reality.** Block spec and task packet may be combined into a single document at solo scale. Nine artifact classes reduced to a practical operating set.
- **Exploratory spike exemption added** with explicit promotion criteria.
- **Lightweight handoff mode added** alongside the full handoff protocol.
- **Waiver / exception process added** with hard reconciliation timelines.
- **Explicit SDD maturity mapping.** v0.2 targets Level 2–3 (Guided / Enforced SDD) per the SDD Reference Framework.
- **Role principle elevated over tool assignment defaults.**
- **Closeout made mandatory-minimal**, not optional.
- **Operational checklist cross-referenced** to governing sections.
- **Future version notes** consolidated in a dedicated section.

---

## 1. Purpose

This document defines **Luphay Spec-Driven Development (LU-SDD)** as the working development framework for building serious systems inside a repository through governed collaboration between:

- **Human operator / architect**
- **OpenAI Codex**
- **Anthropic Claude Code**

LU-SDD exists to replace giant one-shot prompts with a **repeatable, artifact-gated, reviewable operating model**.

The purpose is not merely to get code faster.

The purpose is to build systems by:
- reducing ambiguity before execution,
- turning intent into durable repo truth,
- separating proposal from criticism,
- building in bounded tasks,
- validating every meaningful change,
- and version-locking completed work into a clean, inspectable record.

---

## 2. Design Thesis

**Luphay Spec-Driven Development is a repo-native method for governed software creation in which specs become the truth layer, tasks become the bounded execution lane, agents operate in explicit roles, and implementation is accepted only after review and verification.**

In LU-SDD:

- the **repo** is the operating environment,
- the **spec stack** is the truth layer,
- **tasks** are the bounded assignment unit,
- **Codex** and **Claude Code** are role-bound workers, not constitutional authority,
- the **human** is the synthesis authority,
- the **diff** is the visible answer,
- **verification** is the proof,
- and the **commit** is the version-locked record.

---

## 3. Foundational Position

### 3.1 The repo is not storage
The repo is the shared operating environment for truth, handoff, review, validation, and integration.

### 3.2 Specs are the source of truth
`specs/` is the canonical root for all normative truth artifacts. Implementation, documentation, and tooling are downstream of specs.

### 3.3 One writer per worktree
Codex and Claude Code must not both write to the same working tree at the same time.

### 3.4 Human remains the constitutional authority
Agents may draft, critique, build, and validate.
Only the human decides what becomes canon.

### 3.5 No giant-blob prompting
A single prompt such as "build the whole system" is not an operating model.
LU-SDD builds systems **piece by piece** through governed tasks.

### 3.6 Review is mandatory
A plausible summary is not completion.
The diff must be reviewed.

### 3.7 Verification is mandatory
A change is not done because it looks right.
A change is done when the declared proof has passed.

### 3.8 Exploration is allowed, promotion is governed
Time-boxed spikes, research branches, throwaway prototypes, and sandbox experiments are allowed outside full LU-SDD controls while they remain exploratory. See Section 16 for the promotion boundary.

---

## 4. Scope

LU-SDD governs:

- greenfield systems,
- architectural changes,
- agentic software projects,
- compliance systems,
- regulated or audit-sensitive platforms,
- repo-native operating systems,
- and complex systems where traceability matters.

It is especially well-suited to Luphay work such as DRACO, DCA, DNC, compliance kernels, evidence systems, and other truth-heavy systems.

---

## 5. Non-Goals

LU-SDD is **not**:

- waterfall bureaucracy,
- documentation theater,
- prompt-only control,
- a ban on exploration,
- a claim that every line of code must be generated,
- or a claim that all work must begin with a massive spec package.

What matters is that exploratory work is **promoted into governed truth** before it becomes relied upon.

---

## 6. Maturity Posture

### 6.1 v0.2 target: Guided / Enforced SDD (Level 2–3)

Per the SDD Reference Framework maturity model:

| Level | Title | LU-SDD v0.2 Status |
|-------|-------|---------------------|
| 0 | Pre-Spec | Below target |
| 1 | Spec-Adjacent | Below target |
| **2** | **Guided SDD** | **Minimum v0.2 operating floor** |
| **3** | **Enforced SDD** | **v0.2 stretch target for key boundaries** |
| 4 | Strict SDD | Future maturity target |

v0.2 requires:
- authored specs as primary inputs,
- review against those specs,
- explicit task packaging,
- declared validation commands,
- controlled handoffs,
- anti-drift discipline,
- and a waiver process for governed exceptions.

v0.2 does **not** yet require:
- machine-readable normative specs in IDL or schema form,
- generated or mechanically synchronized contract artifacts,
- compatibility policy enforcement gates,
- drift detection in CI,
- or formal waiver reconciliation automation.

### 6.2 Upgrade path to Level 3–4

A later LU-SDD version may require:
- machine-readable normative specs,
- generated or mechanically synchronized contract artifacts,
- compatibility policy enforcement,
- drift gates in CI,
- formal waiver handling with automated reconciliation,
- and boundary enforcement through deterministic or mechanically constrained controls.

That stricter posture remains a future maturity target and will be scoped when the first full build lane proves the v0.2 baseline.

### 6.3 External validation requirement for Level 3–5

Maturity levels 3, 4, and 5 require a peer validation event before the level may be claimed. At minimum, one external reviewer (a colleague, auditor, or designated peer outside the immediate team) must confirm the evidence supports the claimed level. The confirmation must be recorded in `specs/` or a designated governance artifact.

Levels 1 and 2 remain self-assessed.

**Rule:** Self-attestation at Level 3 or above is not a maturity claim. It is a maturity hypothesis.

---

## 7. Core Principles

### Principle 1 — Spec precedence
The spec is a primary input to work, not a reverse-engineered explanation after the fact.

### Principle 2 — Durable truth belongs in the repo
Durable rules, architecture, workflows, and acceptance contracts must live in versioned artifacts, not only in transient prompts.

### Principle 3 — Role separation beats tool mystique
The important thing is not "which agent is smarter."
The important thing is which **role** the agent is playing in a given step.

### Principle 4 — Review and build are different jobs
The same intelligence that can generate a change is not automatically the best intelligence to critique it.

### Principle 5 — Bounded tasks beat vague ambition
A serious system is built through clear, reviewable tasks.

### Principle 6 — Handoffs must be explicit
Every agent switch must include a known state, clear scope, and a declared objective.

### Principle 7 — Truth hierarchy must be written
When artifacts disagree, the repo must already define what outranks what.

### Principle 8 — CI/CD is part of the method
Validation is not a side quest.
It is part of the core development loop.

### Principle 9 — No parallel truth
READMEs, old notes, comments, and improvised prompts may explain the system.
They may not silently redefine it.

### Principle 10 — Reduce ambiguity before coding
The goal of LU-SDD is not to create more documents.
The goal is to reduce unmanaged ambiguity before implementation.

---

## 8. Role Model

A single tool may play multiple roles across time, but the **role contract** must remain explicit.

### 8.1 Governing rule
**The tool may change. The role must not become fuzzy.**

A role is a hat, not a permanent identity. The same agent may draft specs in one phase and validate code in another. What matters is that at any given moment, the active role is declared and bounded.

### 8.2 Human Synthesizer / Architect
Owns:
- system intent,
- final synthesis,
- canon decisions,
- scope arbitration,
- priority,
- and final acceptance.

### 8.3 Spec Architect Agent
Owns:
- breaking an idea into structured specs,
- proposing system boundaries,
- surfacing missing sections,
- and drafting the first clean version of truth artifacts.

### 8.4 Counter-Review Agent
Owns:
- critiquing decomposition,
- identifying gaps or ambiguity,
- attacking assumptions,
- and pressure-testing the proposed structure.

### 8.5 Task Architect Agent
Owns:
- translating approved spec material into a build-ready task,
- defining expected outputs,
- defining test expectations,
- and declaring definition of done.

### 8.6 Build Agent
Owns:
- implementing the approved task,
- keeping scope bounded,
- updating relevant code and docs,
- and leaving behind a reviewable diff.

### 8.7 Validation Agent
Owns:
- testing conformance to the task,
- checking drift against governing truth,
- strengthening verification where needed,
- and producing a validation result.

### 8.8 Closeout Agent
Owns:
- packaging lessons learned,
- updating registries,
- moving tasks to done,
- preparing the next lane,
- and reconciling spec truth against implementation reality.

Closeout is **mandatory-minimal**: every completed task must produce at least a task state update and a brief closeout note. The closeout note may be as short as two sentences for trivial tasks, but it must exist. Without closeout, stale specs accumulate silently.

### 8.9 LLM Compatibility Contract

Each LLM agent role in LU-SDD carries a **Compatibility Contract**: a declared set of minimum required behaviors for that role. The contract defines what outputs, formats, and compliance behaviors the role must reliably produce for the loop to hold.

**When to raise a Drift Flag:**
A Drift Flag is raised when an LLM update produces output that deviates materially from the Compatibility Contract for a given role — for example, a build agent that begins generating out-of-scope changes, or a validation agent that stops producing structured rejection findings.

**What happens when a Drift Flag is raised:**
- The active lane is paused.
- The human assesses whether the deviation is acceptable for the task at hand.
- Either the Compatibility Contract is updated to reflect the new behavior (with a version note), or the task is reassigned to a compatible tool.
- No Drift Flag may be silently absorbed. It must be resolved or explicitly accepted.

**Where Compatibility Contracts live:**
Compatibility Contracts are repo-native governance artifacts. They live in `specs/` or alongside `AGENTS.md` as authored reference material.

**Rule:** LLM tool updates are outside Luphay's control. The Compatibility Contract is the mechanism that makes drift visible rather than silent.

---

## 9. Default Tool Role Assignment

This section provides a starting posture for tool-to-role mapping. It is a snapshot, not a permanent law — tools evolve, and assignments should follow capability rather than habit.

### 9.1 Default Luphay posture for v0.2

| Stage | Default Primary | Default Secondary | Human Role |
|---|---|---|---|
| Requirement breakdown / early spec draft | Claude Code | Codex | Provide intent and constraints |
| Counter-review of spec shape | Codex | Claude Code | Synthesize and approve |
| Task packet preparation | Claude Code | Codex | Confirm scope and DOD |
| Implementation | Codex | Claude Code | Bound scope and review results |
| Independent validation | Claude Code | Codex | Decide accept / rework |
| Closeout | Either | Either | Confirm version lock |
| Final synthesis / merge readiness | Human | Agent support as needed | Canon decision |

### 9.2 When to override defaults
Override the default assignment when:
- one tool demonstrably outperforms the other for a specific task type,
- the task requires capabilities only one tool offers (e.g., specific file access, sandboxing),
- the current tool is mid-session and switching would cost more than staying,
- or the human simply prefers a different assignment for a given lane.

The override is fine. The role staying clear is what matters.

---

## 10. Control Surface Model

LU-SDD assumes a repo with distinct control surfaces.

### 10.1 Human-facing root
- `README.md` — what this repo is
- `START_HERE.md` — fastest orientation path

### 10.2 Shared agent instruction plane
- `AGENTS.md` — shared repo-wide operating law
- `CLAUDE.md` — Claude-specific companion, kept thin

### 10.3 Tool-native config surfaces
- `.codex/config.toml` — Codex project execution policy
- `.claude/settings.json` — Claude Code project settings
- `.claude/settings.local.json` — local non-committed overrides
- `.claude/hooks/` or hook-configured scripts — enforceable Claude guardrails when justified

### 10.4 Workflow reuse surfaces
- `.agents/skills/` — Codex-native skills
- `.claude/skills/` — Claude-native skills
- `scripts/` — deterministic repo commands
- `tests/` — validation wall
- `evals/` — optional but recommended for AI-heavy repos

### 10.5 Truth surfaces
- `specs/` — **canonical truth root** for all normative artifacts

### 10.6 Explanatory surfaces
- `docs/architecture/` — explanatory architecture material (subordinate to `specs/`)
- `docs/operations/` — runbooks and recovery guidance
- `docs/agent-guides/` — deep workflow guidance for agent skills

### 10.7 Execution surfaces
- `tasks/` — bounded work packets and execution queue
- `src/`, `apps/`, `services/`, `packages/` — implementation surface
- `runs/` — ephemeral outputs, not durable truth

### 10.8 Governance surfaces
- `policies/` — operating constraints and guardrails

---

## 11. Canonical Repo Shape

```text
repo/
├─ README.md
├─ START_HERE.md
├─ AGENTS.md
├─ CLAUDE.md
│
├─ .codex/
│  └─ config.toml
│
├─ .agents/
│  └─ skills/
│
├─ .claude/
│  ├─ settings.json
│  ├─ settings.local.json        # gitignored
│  ├─ skills/
│  ├─ hooks/                     # optional scripts or referenced hook assets
│  └─ agents/                    # optional specialized Claude subagents
│
├─ specs/                         # CANONICAL TRUTH ROOT
│  ├─ vision/                    # why the system exists
│  ├─ system/                    # top-level behavior and domains
│  ├─ architecture/              # components, boundaries, data flow
│  ├─ blocks/                    # bounded subsystem specs
│  ├─ acceptance/                # acceptance contracts
│  ├─ adr/                       # architectural decision records
│  └─ waivers/                   # governed exceptions with reconciliation
│
├─ tasks/                         # EXECUTION QUEUE (not truth)
│  ├─ pending/
│  ├─ active/
│  ├─ blocked/
│  └─ done/
│
├─ docs/                          # EXPLANATORY (subordinate to specs/)
│  ├─ architecture/              # diagrams, rationale, explanatory material
│  ├─ operations/                # runbooks, recovery, validation guide
│  └─ agent-guides/              # deep workflow guidance
│
├─ policies/
│
├─ src/ or apps/ or services/ or packages/
├─ tests/
├─ scripts/
├─ evals/                        # optional, recommended for AI-heavy systems
└─ runs/                         # gitignored ephemeral artifacts
```

### 11.1 Truth root rule
**`specs/` is the canonical truth root.** When `docs/` and `specs/` disagree, `specs/` wins. The `docs/` tree exists to explain, illustrate, and operationalize — not to define or override normative truth.

### 11.2 Where ADRs live
ADRs live in `specs/adr/`. An ADR is a normative decision record that constrains future implementation. It is truth, not explanation.

### 11.3 Where task packets live
Task packets live in `tasks/`. A task packet is an execution artifact — it is derived from truth but is not truth itself. When a task packet and its governing block spec disagree, the block spec wins.

### 11.4 Repo doctrine
The root must answer these questions fast:
- What is this repo?
- What governs work here?
- Where does truth live?
- Where does implementation live?
- How do I validate work?
- What is safe to edit?
- What must not be committed?

---

## 12. Artifact Stack

LU-SDD does not treat "the spec" as one file.
It uses an artifact stack, organized by function.

### 12.1 Normative truth artifacts (live in `specs/`)

**Vision Spec** — why the system exists, target outcome, problem frame, success criteria, major non-goals.

**System Spec** — top-level behavior, main domains, operating model, major interfaces.

**Architecture Spec** — major components, boundaries, data flow, trust boundaries, constraints, rationale.

**Block Spec** — one bounded subsystem or major capability: inputs/outputs, dependencies, invariants, constraints, implementation boundaries.

**Acceptance Contract** — how success is proven: what tests must pass, what evidence must exist, what rejection conditions apply.

**ADR / Decision Record** — a durable architectural decision: why it was made, what alternatives were rejected, what future consequences exist.

**Waiver Record** — a governed exception: what is waived, why, scope, compensating controls, reconciliation timeline, expiry. See Section 21.

### 12.2 Execution artifacts (live in `tasks/`)

**Task Packet** — one bounded unit of work: exact objective, files/paths in scope, out-of-scope items, validation commands, definition of done, closeout expectations.

**Closeout Note** — what changed, what was learned, what remains risky, what should happen next. Mandatory-minimal for every completed task.

**Validation Report** — what was checked, what passed, what failed, drift detected, what remains unresolved.

### 12.3 Explanatory artifacts (live in `docs/`)

READMEs, diagrams, rationale narratives, examples, runbooks, agent guides, transcripts, temporary planning drafts.

### 12.4 Solo-founder collapse rule

At solo scale, the following collapses are explicitly permitted:

- A **block spec and its first task packet** may live in the same document when the block has only one active task. Split them when the block grows multiple concurrent tasks.
- A **vision spec and system spec** may be combined for small systems. Split them when the system has more than one major domain.
- An **acceptance contract** may be inlined as a section of the task packet rather than maintained as a separate file.
- A **closeout note** may be appended to the task packet rather than maintained separately.

**Rule:** collapsing is fine when it reduces overhead without hiding truth. If two concerns start competing inside one document, split them.

---

## 13. Normative vs Explanatory Truth

### 13.1 Normative artifacts
These may define or constrain the active truth of the system:

- approved vision spec,
- approved system spec,
- approved architecture spec,
- approved block spec,
- approved acceptance contract,
- approved ADR,
- approved waiver record,
- machine-enforced config or validation rules.

**All normative artifacts live in `specs/`.**

### 13.2 Explanatory artifacts
These may explain the system but must not silently overrule normative truth:

- READMEs,
- docs/ content,
- notes,
- diagrams,
- examples,
- transcripts,
- temporary planning drafts,
- exploratory prompt logs.

### 13.3 Rule
Explanatory artifacts may clarify truth.
They may not replace truth.

---

## 14. Truth Hierarchy

When artifacts disagree, use this precedence model.

### 14.1 Behavior precedence
1. Active human decision for the current governed change
2. Approved ADR or approved architecture/system truth (in `specs/`)
3. Approved block spec (in `specs/blocks/`)
4. Approved task packet (in `tasks/`)
5. Implementation code
6. Explanatory documentation (in `docs/`)

### 14.2 Proof precedence
When the dispute is about whether work is complete:
1. Acceptance contract (in `specs/acceptance/`)
2. Validation report
3. CI/test output
4. Human final acceptance

### 14.3 Interpretation rule
If behavior is ambiguous, higher behavior truth wins.
If completion is ambiguous, higher proof truth wins.

---

## 15. Standard Operating Phases

### Phase 0 — Frame the work
Input: raw idea, problem statement, request, or change need.
Output: initial scope statement, named system or block, first working boundary.
Exit gate: the work is understandable enough to draft truth.

### Phase 1 — Spec formation
Goal: turn intent into structured truth artifacts.
Actions: draft system spec, break into blocks, identify assumptions, define constraints, name boundaries.
Output: first draft spec material.
Exit gate: there is a structured artifact worth reviewing.

### Phase 2 — Counter-review and synthesis
Goal: subject the spec to intelligent criticism before build begins.
Actions: second agent critiques structure, identifies missing sections, proposes better decomposition, attacks ambiguity.
Output: review findings, synthesized version, approved truth revision.

**Review gate exit criteria (all three must be satisfied):**
1. Spec coverage confirmed against the stated task scope — no material gaps remain open.
2. No unresolved contradictions between LLM agent outputs — where outputs diverge, the divergence is explicitly resolved.
3. Human operator sign-off is logged — either in the task packet, spec header, or a brief synthesis note in `specs/`.

A review that cannot satisfy all three conditions is **escalated**, not passed. An escalation note documents what is unresolved and why the loop is paused.

**Deviation Protocol:**
When the human synthesizer overrides, rejects, or materially alters LLM-produced spec material at this step, a **Deviation Record** must be produced. Fields:
- what was overridden (specific section or output)
- why (bounded justification)
- decision (what replaced it or was accepted instead)
- owner (human operator, by default)

Deviation Records are repo-native artifacts. They may be appended to the relevant spec, inlined in the task packet, or filed in `specs/adr/` if the deviation constitutes a durable architectural decision. A synthesize override with no Deviation Record violates spec authority.

Exit gate: spec is approved enough to prepare work.

### Phase 3 — Build readiness
Goal: convert approved truth into a bounded executable task.
Actions: create task packet, define DOD, define tests, define acceptance evidence, bound paths in scope.
Output: build-ready task.
Exit gate: builder does not need to invent the assignment while coding.

### Phase 4 — Build
Goal: implement exactly the bounded task.
Actions: code changes, doc updates, test additions, local validation, clean diff preparation.
Output: reviewable diff, updated artifacts, validation attempt.
Exit gate: implementation exists and is reviewable.

### Phase 5 — Independent validation
Goal: test conformance to truth rather than merely admire the output.
Actions: diff review, acceptance check, test execution, drift check, failure analysis.
Output: validation report, accept / reject / revise decision.
Exit gate: either accepted or explicitly returned for rework.

### Phase 6 — Closeout and version lock
Goal: turn accepted work into durable repo history.
Actions: task state update, closeout note, commit/merge preparation, spec reconciliation if implementation revealed truth drift.
Output: version-locked record, clear next step.
Exit gate: the lane can be repeated tomorrow without reinvention.

**Version Lock definition:** Version Lock closes the active build cycle and assigns a version identifier to the completed work. Unlike a terminal freeze, Version Lock does not seal an artifact permanently — it closes the current iteration. Subsequent corrections or changes open a new governed cycle with a new version. This preserves the gate while remaining compatible with auditability and amendment requirements in regulated environments.

**Closeout is mandatory.** See Section 8.8.

---

## 16. Exploratory Spike Exemption

### 16.1 What is allowed
Time-boxed spikes, research branches, throwaway prototypes, and sandbox experiments may operate outside full LU-SDD controls.

### 16.2 When work remains exploratory
A prototype remains exploratory only while **all** of the following are true:

- it is being used to learn, de-risk, or compare options rather than serve as a committed contract surface,
- it is isolated from production-bound consumers and critical integrations,
- it is not being presented as authoritative behavior for dependent teams or users,
- it is not being promoted into a persistent shared environment as the expected implementation baseline.

### 16.3 When the exemption ends
The exploratory exemption ends when the work crosses into **any** of the following:

- formal roadmap commitment,
- shared integration with other systems or teams,
- reuse as the basis for a production-bound implementation,
- dependency by downstream consumers,
- release candidate or persistent environment promotion.

### 16.4 What happens at promotion
At the promotion boundary, the work must be retrofitted with at least:

- a minimal normative spec in `specs/` (block spec or system spec as appropriate),
- a declared owner,
- a boundary declaration,
- and a task packet for the next governed work unit.

### 16.5 Rule
Exploration that never gets promoted can stay informal forever.
Exploration that gets promoted must enter the governed lane.

---

## 17. Canonical LU-SDD Loop

```text
idea
  → frame
  → draft spec
  → counter-review
  → human synthesis
  → approved block
  → task packet
  → acceptance contract
  → build
  → review
  → validate
  → closeout
  → commit / merge (version lock)
```

### 17.1 Short form
**frame → spec → review → synthesize → task → build → validate → version-lock**

---

## 18. Handoff Protocol

Every agent switch must use a bounded handoff. Two modes are available depending on the weight of the switch.

### 18.1 Short handoff (default for solo founder)
Use when switching tools for lightweight or continuation work within the same task lane.

Required fields:
- current branch
- current repo state (clean / dirty / what's pending)
- active task and objective
- validation status (passing / failing / untested)

That's it. Four fields. Write them in the task packet, a commit message, or a quick note at the top of the next session.

### 18.2 Full handoff
Use when switching tools across task boundaries, handing off to a different person, or resuming after a significant break.

Required fields:
- current branch or worktree
- current repo state
- artifact under review or implementation
- role requested of next agent
- exact objective
- files or paths in scope
- out-of-scope boundaries
- required validation commands
- unresolved questions
- expected output format

### 18.3 Handoff rule
Do not hand off vague motion.
Hand off a known state with a bounded question.

### 18.4 Clean handoff checklist
Before switching agents:

- run `git status`
- inspect current diff
- update the task packet
- record validation status
- commit, stash, or discard if needed
- ensure the next agent is not inheriting ambiguity by accident

---

## 19. Task Packet Minimum Schema

Every non-trivial LU-SDD task should answer the following.

At solo scale, this may be a single markdown file in `tasks/active/` with the acceptance contract inlined and the closeout note appended. See Section 12.4 for collapse rules.

### 19.1 Task identity
- task ID
- title
- linked block spec (in `specs/blocks/`)
- linked acceptance contract (inline or in `specs/acceptance/`)

### 19.2 Objective
- what exactly is to be achieved

### 19.3 Scope
- paths/files/components in scope

### 19.4 Out of scope
- what must not be touched

### 19.5 Inputs
- governing specs
- ADRs
- fixtures
- relevant dependencies

### 19.6 Expected outputs
- code changes
- docs
- tests
- config changes
- reports

### 19.7 Validation commands
- lint
- unit tests
- integration tests
- schema validation
- deterministic checks
- any repo-specific command

### 19.8 Definition of done
- what must be true for the task to be considered complete

### 19.9 Closeout requirements
- task status move
- lessons learned note (mandatory-minimal)
- follow-up tasks created if needed
- spec reconciliation note if implementation revealed drift

---

## 20. Acceptance Contract Minimum Schema

Each meaningful task should have an acceptance contract that states:

- governing truth reference (which spec in `specs/`)
- success conditions
- rejection conditions
- required evidence
- commands to run
- artifacts to inspect
- manual review requirements
- whether CI must pass before acceptance
- whether an ADR or doc update is required

### 20.1 Rule
If success cannot be stated, the task is not ready.

### 20.2 Solo-founder shortcut
The acceptance contract may be inlined as a `## Acceptance` section in the task packet. It must still answer the questions above, even if briefly.

---

## 21. Waiver / Exception Process

### 21.1 When to use a waiver
Use a waiver when:
- a task cannot meet its acceptance contract for a known, bounded reason,
- a spec requirement must be temporarily bypassed,
- a policy is being deferred rather than abandoned,
- or a validation check is being skipped with explicit justification.

### 21.2 Waiver record fields
Every waiver must include:

- **waiver ID**
- **what is waived** — specific requirement, check, or policy
- **why** — bounded justification
- **scope** — what tasks, blocks, or boundaries are affected
- **compensating controls** — what is being done instead, if anything
- **owner** — who is accountable for reconciliation
- **reconciliation timeline** — when the waiver must be resolved (see 21.3)
- **expiry** — hard date or event after which the waiver is void

### 21.3 Reconciliation requirements
Every waiver must specify:

- a tracked remediation artifact (ticket, task, or explicit note in `specs/waivers/`),
- a target correction date or revalidation checkpoint,
- the specific release or governance gate at which the exception must be re-justified or closed,
- and what happens if reconciliation does not occur (e.g., blocks promotion, forces re-approval).

### 21.4 Where waivers live
Waiver records live in `specs/waivers/`. They are normative truth — a waiver is a governed decision, not a casual note.

### 21.5 Rule
No waiver may remain an open-ended background condition. A "temporary" exception that has no forced reconciliation event is governance theater.

---

## 22. Validation Doctrine

### 22.1 Review the diff, not the summary
A summary is an interpretation.
The diff is the materialized answer.

### 22.2 Separate spec validation from implementation validation
Spec validation asks:
- Is the task coherent?
- Is it buildable?
- Is it testable?
- Does it align to system truth?

Implementation validation asks:
- Was the task actually fulfilled?
- Did the code stay in scope?
- Did required tests pass?
- Did drift occur?

### 22.3 Validation wall
A task is not complete unless it has crossed the declared validation wall.

Examples:
- test suite pass,
- schema pass,
- policy pass,
- lint pass,
- CI pass,
- reviewer acceptance,
- or regulated evidence generation.

### 22.4 No plausibility-as-proof
"Looks good" is not a sufficient control in LU-SDD.

---

## 23. CI/CD Posture

LU-SDD assumes that CI/CD is not external decoration.

CI/CD should reinforce the truth stack by:
- running declared validation commands,
- making drift visible,
- blocking obvious regressions,
- enforcing required checks,
- and preserving evidence.

### 23.1 Minimum v0.2 requirement
Every non-trivial task should declare at least one deterministic validation command.

### 23.2 Stronger posture later
Later maturity may add:
- compatibility gates,
- generated artifact checks,
- contract drift checks,
- policy engines,
- and formal release gates.

---

## 24. One-Writer Rule

### 24.1 Core rule
Do not let Codex and Claude Code write concurrently to the same worktree.

### 24.2 If parallelism is needed
Use:
- separate branches,
- separate worktrees,
- clearly separated task boundaries,
- and re-validation before merge.

### 24.3 Why this matters
Parallel uncontrolled writing creates:
- hidden drift,
- unclear ownership,
- reconciliation noise,
- and false confidence.

---

## 25. Skills and Reusable Workflows

LU-SDD treats repeated workflows as first-class reusable assets.

### 25.1 Codex skill candidates
- repo intake
- spec drafting
- block decomposition
- build-test-verify
- change closeout
- diff review
- validation report generation

### 25.2 Claude skill candidates
- task packet drafting
- acceptance contract drafting
- independent validator
- architecture counter-review
- completion gate hook logic

### 25.3 Rule
If you repeat a workflow more than a few times, convert it from memory into a skill or script.

---

## 26. Claude Hook Posture

Claude Code hooks may be used as guardrails when the cost of drift or unsafe execution is meaningful.

### 26.1 Appropriate use cases
- blocking dangerous commands,
- enforcing task completion checks,
- requiring validation before a task is marked complete,
- protecting sensitive paths,
- or rejecting forbidden changes.

### 26.2 Guardrail principle
Use hooks for **enforceable constraints**, not for poetic aspirations.

### 26.3 Caution
Guardrails should be deterministic, testable, and clearly owned.
Do not create a hook maze nobody understands.

---

## 27. Failure Modes and Countermeasures

### Failure 1 — Giant-prompt dependency
**Symptom:** trying to build the whole system in one prompt.
**Countermeasure:** require block specs and task packets.

### Failure 2 — Decorative specs
**Symptom:** documents exist but no task or validation path references them.
**Countermeasure:** every non-trivial task must link to governing truth in `specs/`.

### Failure 3 — Role collapse
**Symptom:** the same lane both invents and certifies truth.
**Countermeasure:** separate draft, review, build, and validate roles.

### Failure 4 — Vague handoffs
**Symptom:** the next agent reopens the entire problem.
**Countermeasure:** enforce handoff packets (short or full per Section 18).

### Failure 5 — No truth hierarchy
**Symptom:** code, docs, and task notes all compete as truth.
**Countermeasure:** `specs/` is the truth root. See Section 14.

### Failure 6 — Review theater
**Symptom:** only summary text is reviewed.
**Countermeasure:** require diff review.

### Failure 7 — No validation wall
**Symptom:** work is considered done because the output sounds plausible.
**Countermeasure:** require acceptance contract + validation commands.

### Failure 8 — Parallel uncontrolled writing
**Symptom:** agents create merge confusion and ownership blur.
**Countermeasure:** one-writer rule plus worktree discipline.

### Failure 9 — Stale specs
**Symptom:** code evolves faster than truth artifacts.
**Countermeasure:** mandatory-minimal closeout must reconcile spec truth. See Section 8.8.

### Failure 10 — Overengineering the process
**Symptom:** the system becomes so formal that no task gets done.
**Countermeasure:** use solo-founder collapse rules (Section 12.4), short handoffs (Section 18.1), and start with one trustworthy lane, not cathedral process.

### Failure 11 — Permanent temporary waivers
**Symptom:** exceptions granted during crunch never get reconciled.
**Countermeasure:** waiver process with hard reconciliation timelines. See Section 21.

---

## 28. Minimal First Strong Version of LU-SDD

The minimum version worth operationalizing is:

- one real repo,
- one root `AGENTS.md`,
- one thin `CLAUDE.md`,
- one `.codex/config.toml`,
- one `.claude/settings.json`,
- one system spec (in `specs/system/`),
- one block spec (in `specs/blocks/`),
- one task packet (in `tasks/`, with acceptance contract inlined),
- one validation command path,
- one build skill,
- one review/validation skill,
- and one real task completed through the full loop including mandatory closeout and version lock.

### 28.1 Rule
Do not scale the framework before one full lane has worked end to end.

---

## 29. DRACO Example — First LU-SDD Lane

### 29.1 System
**DRACO Compliance Engine**

### 29.2 Candidate first block
**Obligation ingestion boundary**

### 29.3 Example first task
Create a bounded task that:
- ingests one known regulatory clause,
- normalizes it into a structured obligation record,
- stores it in an initial canonical schema,
- and validates the mapping with fixtures.

### 29.4 Governing artifacts
- system spec for DRACO compliance engine → `specs/system/`
- architecture spec for ingestion path → `specs/architecture/`
- block spec for obligation ingestion → `specs/blocks/`
- task packet for single-clause parser → `tasks/active/`
- acceptance contract (inlined in task packet or in `specs/acceptance/`)

### 29.5 Acceptance example
The task is accepted only if:
- the input fixture is preserved,
- the output record matches the expected schema,
- tests pass,
- the changed paths stay in scope,
- and the task packet + closeout note are updated.

### 29.6 Why this is a good first lane
It is:
- real enough to matter,
- bounded enough to finish,
- easy to review,
- and clear enough to verify.

---

## 30. Recommended Initial Operating Cadence

### Step 1
Write the system and block truth first (into `specs/`).

### Step 2
Have one agent counter-review the structure.

### Step 3
Human synthesizes and approves canon.

### Step 4
Have a task architect produce a build-ready task packet (into `tasks/`).

### Step 5
Have the build agent implement exactly that task.

### Step 6
Have the validation agent review the diff, run checks, and report.

### Step 7
Human decides accept, revise, or split follow-up tasks.

### Step 8
Version-lock cleanly: closeout note, task state update, commit.

---

## 31. Operational Checklist for v0.2

### 31.1 Governance
- [ ] `AGENTS.md` exists → Section 10.2
- [ ] `CLAUDE.md` exists and is thin → Section 10.2
- [ ] `.codex/config.toml` exists → Section 10.3
- [ ] `.claude/settings.json` exists or is intentionally deferred → Section 10.3
- [ ] One-writer rule is documented → Section 24

### 31.2 Truth
- [ ] `specs/` directory exists as canonical truth root → Section 11
- [ ] System spec exists in `specs/system/` → Section 12.1
- [ ] First block spec exists in `specs/blocks/` → Section 12.1
- [ ] Truth hierarchy is written → Section 14
- [ ] Normative vs explanatory rule is written → Section 13

### 31.3 Execution
- [ ] Task packet template or first real task packet exists → Section 19
- [ ] Acceptance contract exists (standalone or inlined) → Section 20
- [ ] Validation command path exists → Section 22
- [ ] Handoff protocol is understood (short or full) → Section 18

### 31.4 Validation
- [ ] Diff review doctrine exists → Section 22.1
- [ ] At least one deterministic validation command exists → Section 23.1
- [ ] Closeout pattern exists and is mandatory-minimal → Section 8.8
- [ ] Review gate exit criteria are understood (three conditions) → Section 15 Phase 2

### 31.5 Exception handling
- [ ] Waiver process is understood → Section 21
- [ ] `specs/waivers/` directory exists (may be empty) → Section 21.4
- [ ] Deviation Protocol is understood → Section 15 Phase 2
- [ ] LLM Compatibility Contract posture understood → Section 8.9

### 31.6 Proof of life
- [ ] One real task completed through the full loop including closeout and version lock

---

## 32. Operating Doctrine

The core doctrine of LU-SDD v0.3 is:

- the repo is the operating environment,
- `specs/` is the truth root,
- the task is the execution lane,
- the agent is a role-bound worker,
- the human is the synthesis authority,
- the diff is the visible answer,
- validation is proof,
- the commit is the version-locked record,
- closeout is mandatory,
- waivers are governed,
- overrides are recorded,
- LLM drift is flagged and resolved,
- and exploration is welcome so long as promotion is disciplined.

This is how Luphay turns agentic development from a chat habit into a governed build system.

---

## 33. Source Basis

### 33.1 Official external basis
Checked against the following official materials on March 13, 2026:

- OpenAI — *Introducing Codex*
- OpenAI Codex docs — *AGENTS.md*, *Config basics*, *Worktrees*, *Review*, *Skills*, *Codex cloud*
- Anthropic Claude Code docs — *Overview*, *Settings*, *Hooks*, *Advanced setup*

### 33.2 Internal project basis
This v0.2 also reflects and synthesizes the following Luphay project references:

- *Codex-native Spec-Driven Development — Primary Reference Playbook*
- *Agentic Native Repo Primary Reference — Codex + Claude Code + Human-Friendly* (v1.0)
- *Spec-Driven Development Reference Framework* (v1.2)
- LU-SDD v0.1
- v0.1 → v0.2 review findings

---

## 34. Future Version Notes

Tracked items for v0.4 and beyond. Not commitments — candidates for when the operating lane proves the need.

### 34.1 Templates and scaffolding
- Formal task packet template (markdown with frontmatter)
- Formal acceptance contract template
- Canonical handoff template (short + full)
- Repo-ready starter tree generator (scaffolds the canonical shape from Section 11)

### 34.2 Strictness upgrade (toward Level 4)
- Machine-readable normative specs (OpenAPI, JSON Schema, or custom IDL)
- Generated or mechanically synchronized contract artifacts
- Compatibility policy enforcement gates
- Drift detection in CI (spec vs. implementation)
- Formal waiver reconciliation automation
- Contract test suite as part of validation wall
- Boundary enforcement through deterministic or mechanically constrained controls

### 34.3 Operational improvements
- Task lifecycle automation (pending → active → done state machine)
- Skill library for common LU-SDD workflows (codified from repeated patterns)
- Closeout-to-registry pipeline (auto-update indexes when tasks complete)
- Multi-repo governance (shared specs across Luphay repos)
- Agent performance tracking (which tool-role assignments produce best results)

### 34.4 Scale readiness
- Multi-contributor handoff protocol (beyond solo founder)
- Review delegation rules
- Parallel lane governance (multiple active tasks with dependency tracking)
- Release governance (spec-gated release trains)

### 34.5 DRACO-specific extensions
- Compliance evidence as a first-class artifact class in the spec stack
- Audit trail requirements integrated into closeout
- Regulatory mapping specs (obligation → control → evidence chain)
- DRACO kernel proof artifacts linked to spec truth

---

## 35. Final Position

LU-SDD v0.2 does not assume AGI.

It assumes something more practical:

that if durable truth is placed in the repo under `specs/`, work is broken into governed tasks, agents are assigned explicit roles, every change is reviewed and verified, exceptions are governed with hard timelines, and closeout is never skipped — then serious systems can be built more reliably than with giant improvisational prompting.

That is the Luphay bet.
