# AGENTIC NATIVE REPO PRIMARY REFERENCE — CODEX + CLAUDE CODE + HUMAN-FRIENDLY

## Document Control
- **Title:** Agentic Native Repo Primary Reference — Codex + Claude Code + Human-Friendly
- **Version:** v1.0
- **Status:** Primary reference
- **Posture:** Dual-agent native, Windows-first, GitHub-remote friendly, human-friendly where necessary
- **Purpose:** Define the canonical repo structure, instruction layering, validation contract, commit/ignore policy, and operating model for a repository that must work cleanly with both Codex agents and Claude Code agents without forcing one tool to imitate the other
- **Merged from:**  
  - `DUAL_AGENT_REPO_BLUEPRINT__codex_app__claude_code__windows__v1.0.md`  
  - `agentic-repo-structure.md`

---

## 1. Governing Position

This standard locks in the following stance:

1. **`AGENTS.md` is the primary shared instruction surface.**  
   Treat it as the main repo-wide operating contract that both humans and agent workflows can orient around.

2. **`CLAUDE.md` remains required for Claude Code, but it should be thin.**  
   It should point to the same underlying truth as `AGENTS.md` and add only Claude-specific guidance, not duplicate the whole repo policy stack.

3. **Durable truth belongs in normal repo documents, not in giant agent prompts.**  
   Shared architecture, validation, operational guidance, policies, specs, and task packets belong in versioned repo artifacts.

4. **Native tool surfaces stay native.**  
   - Codex repo config lives in `.codex/config.toml`
   - Codex repo skills live in `.agents/skills/`
   - Claude shared settings, rules, hooks, skills, and optional subagents live under `.claude/`

5. **The repo must stay human-friendly.**  
   Humans should be able to understand the system from `README.md`, `START_HERE.md`, architecture docs, ADRs, and operational docs without reverse-engineering agent-only files.

6. **One cross-vendor writer at a time per worktree.**  
   Codex and Claude Code must not both write to the same working tree at the same time. If parallel work is needed, use separate branches or worktrees.

7. **Validation must be explicit, deterministic, and easy to run.**  
   In a Windows-first repo, the canonical validation entrypoint should be a PowerShell script such as `scripts/validate.ps1`. Cross-platform wrappers are optional, but there must be one obvious pass/fail command.

8. **Ephemeral run artifacts stay out of Git.**  
   Session notes, transcripts, scratch outputs, and generated intermediates belong in `runs/` or external logs, not in the durable source tree.

---

## 2. Design Principles

### 2.1 Single Source of Truth
Do not spread the same durable rule across `AGENTS.md`, `CLAUDE.md`, skills, hooks, and random docs. Put the rule in one canonical place, then have tool-native entrypoints point to it.

### 2.2 Native, Not Flattened
Codex and Claude Code have different customization surfaces. Respect those differences:
- shared truth in repo docs
- Codex-specific behavior in `.codex/` and `.agents/skills/`
- Claude-specific behavior in `.claude/`

### 2.3 Human-Readable Control Plane
A future operator should be able to open the repo root and quickly understand:
- what this repo is
- how to start
- how to validate
- where architecture truth lives
- where task execution happens
- what is safe to edit
- what is not safe to commit

### 2.4 Progressive Disclosure
Keep always-on files concise. Put deeper workflow details in `docs/agent-guides/`, `docs/operations/`, and skills that load when needed.

### 2.5 Durable vs. Ephemeral Separation
Keep these distinct:
- **Durable:** docs, policies, specs, tasks, architecture, scripts, workflows
- **Ephemeral:** transcripts, scratch output, generated reports, temporary artifacts, personal settings

### 2.6 Path-Specific Guidance Without Duplication
Use:
- nested `AGENTS.md` only when a subtree genuinely needs Codex-local rules
- `.claude/rules/` for Claude path- or topic-specific behavior
- shared deep guidance in `docs/agent-guides/`

Default stance: do **not** duplicate whole subtrees of guidance unless necessary.

### 2.7 Validation Before Closeout
Any meaningful change should leave behind:
- a clean diff
- a recorded validation result
- updated docs/tests if behavior changed
- a task/spec reference if the change was non-trivial

### 2.8 Windows-First, Cross-Platform-Tolerant
Design for Windows local work first, but avoid needless lock-in:
- PowerShell as the primary script surface
- forward-slash paths in docs
- `.gitattributes` to normalize line endings
- optional bash/make wrappers only where they genuinely help

### 2.9 Scale by Adding Layers, Not by Rewriting the Spine
The same base repo should scale from:
- solo founder
- small dual-agent setup
- larger multi-agent or regulated environment

That means the root spine should stay stable while optional layers expand.

---

## 3. Canonical Repo Tree

```text
repo/
├─ README.md                              # Human-first project overview
├─ START_HERE.md                          # Fast onboarding map for humans and agents
├─ AGENTS.md                              # Primary shared instruction surface
├─ CLAUDE.md                              # Thin Claude-native companion to AGENTS.md
├─ CONTRIBUTING.md                        # Human contribution norms
├─ SECURITY.md                            # Vulnerability disclosure and security posture
├─ CODEOWNERS                             # Review ownership map
├─ LICENSE
├─ .gitignore
├─ .gitattributes
├─ .editorconfig
├─ .env.example                           # Non-secret environment template
│
├─ .codex/
│  └─ config.toml                         # Codex project-scoped config
│
├─ .agents/
│  └─ skills/
│     ├─ repo-intake/
│     │  └─ SKILL.md
│     ├─ build-test-verify/
│     │  └─ SKILL.md
│     └─ change-closeout/
│        └─ SKILL.md
│
├─ .claude/
│  ├─ settings.json                       # Commit only if truly project-shared
│  ├─ settings.local.json                 # Local only; gitignored
│  ├─ rules/
│  │  ├─ testing.md
│  │  ├─ docs.md
│  │  └─ security.md
│  ├─ hooks/
│  │  ├─ post-edit-lint.ps1
│  │  └─ stop-summary.ps1
│  ├─ skills/
│  │  ├─ repo-intake/
│  │  │  └─ SKILL.md
│  │  ├─ build-test-verify/
│  │  │  └─ SKILL.md
│  │  └─ change-closeout/
│  │     └─ SKILL.md
│  └─ agents/                             # Optional: project-specific Claude subagents
│
├─ .github/
│  ├─ workflows/
│  │  ├─ ci.yml
│  │  ├─ secret-scan.yml                  # Recommended
│  │  └─ agent-gate.yml                   # Recommended where agent PR review is formalized
│  ├─ pull_request_template.md
│  └─ ISSUE_TEMPLATE/
│     ├─ feature_request.md
│     ├─ bug_report.md
│     └─ agent_task.md
│
├─ docs/
│  ├─ architecture/
│  │  ├─ overview.md
│  │  ├─ adr/
│  │  │  ├─ README.md
│  │  │  └─ ADR-0001-...
│  │  ├─ components/
│  │  └─ diagrams/
│  ├─ agent-guides/
│  │  ├─ repo-intake.md
│  │  ├─ build-test-verify.md
│  │  ├─ change-closeout.md
│  │  └─ database-migrations.md
│  └─ operations/
│     ├─ validation.md
│     ├─ recovery.md
│     └─ release.md
│
├─ policies/
│  ├─ agent-permissions.md
│  ├─ review-requirements.md
│  ├─ secret-handling.md
│  └─ data-handling.md
│
├─ specs/
│  ├─ _template.md
│  └─ ...
│
├─ tasks/
│  ├─ _template.md
│  ├─ pending/
│  ├─ active/
│  └─ done/
│
├─ prompts/                               # Optional: only if prompts are first-class repo artifacts
├─ evals/                                 # Optional: strongly recommended for AI-heavy repos
│
├─ src/
│  └─ AGENTS.md                           # Optional nested Codex guidance for a subtree
│
├─ tests/
│
├─ scripts/
│  ├─ bootstrap.ps1
│  ├─ validate.ps1
│  ├─ lint.ps1
│  └─ test.ps1
│
├─ infra/                                 # Optional deployment / IaC layer
├─ observability/                         # Optional dashboards, alerts, runbooks
├─ examples/                              # Optional worked examples and templates
│
└─ runs/                                  # Gitignored ephemeral agent outputs
   └─ .gitkeep
```

---

## 4. Control Surface by Role

| Path | Role | Audience | Commit Rule | Notes |
|---|---|---|---|---|
| `README.md` | Human-first overview | Human + agent | Commit | Keep concise and orienting |
| `START_HERE.md` | Fast repo map | Human + agent | Commit | The quickest operational entrypoint |
| `AGENTS.md` | Primary shared instruction plane | Codex + humans + other agent workflows | Commit | Keep concise; point to deeper docs |
| `CLAUDE.md` | Claude Code persistent project instructions | Claude Code | Commit | Thin companion, not a second constitution |
| `.codex/config.toml` | Codex repo-scoped behavior | Codex | Commit | Only project-shared settings |
| `.agents/skills/**` | Codex native skills | Codex | Commit | Canonical Codex repo skill root |
| `.claude/settings.json` | Claude project settings | Claude Code | Commit only if team-shared | Permissions, hooks, plugins, env, etc. |
| `.claude/settings.local.json` | Local overrides | Claude Code | Ignore | Personal and machine-specific only |
| `.claude/rules/**` | Claude path/topic rules | Claude Code | Commit | Prefer this over duplicating nested CLAUDE files |
| `.claude/hooks/**` | Deterministic lifecycle automation | Claude Code | Commit if project-wide | Use only for enforceable, repeatable actions |
| `.claude/skills/**` | Claude native skills | Claude Code | Commit | Mirror shared workflow concepts, not giant duplicated prose |
| `.claude/agents/**` | Optional project-specific subagents | Claude Code | Commit when used | Add only when specialization is justified |
| `docs/architecture/**` | Architecture truth | Human + agent | Commit | Includes ADRs, diagrams, component docs |
| `docs/agent-guides/**` | Deep workflow guidance | Human + agent | Commit | Referenced by skills and instruction files |
| `docs/operations/**` | Operational runbooks | Human + agent | Commit | Validation, recovery, release, etc. |
| `policies/**` | Guardrails and approval rules | Human + agent | Commit | Especially important in regulated workflows |
| `specs/**` | Pre-change design artifacts | Human + agent | Commit | Use for non-trivial work |
| `tasks/**` | Agent task packets and execution queue | Human + agent | Commit | Moves from pending → active → done |
| `scripts/**` | Stable execution surface | Human + agent | Commit | Validation should point here |
| `.github/workflows/**` | CI and merge controls | Human + agent | Commit | CI is part of repo truth |
| `runs/**` | Ephemeral outputs | Local runtime | Ignore contents | Keep directory, not contents |

---

## 5. Instruction Layering Strategy

### 5.1 Shared Always-On Layer
The shared always-on layer should be:

- `README.md`
- `START_HERE.md`
- `AGENTS.md`
- `CLAUDE.md`
- `docs/architecture/overview.md`
- `docs/operations/validation.md`

This is the minimum stable control plane.

### 5.2 Codex Layer
For Codex, use:

- root `AGENTS.md`
- nested `AGENTS.md` only when a subtree truly needs local instructions
- `.codex/config.toml`
- `.agents/skills/`

### 5.3 Claude Layer
For Claude Code, use:

- root `CLAUDE.md`
- `.claude/settings.json`
- `.claude/rules/`
- `.claude/hooks/`
- `.claude/skills/`
- `.claude/agents/` only if specialization is justified

### 5.4 Shared Deep Reference Layer
Put durable, detailed procedures in:

- `docs/agent-guides/`
- `docs/operations/`
- `docs/architecture/`
- `policies/`

Instruction files and skills should point here instead of repeating the same guidance.

### 5.5 Local-Only Layer
Keep these out of repo truth unless there is a deliberate, scrubbed project-wide reason:

- `~/.codex/config.toml`
- `~/.claude/settings.json`
- `~/.claude/CLAUDE.md`
- `.claude/settings.local.json`
- `.git/info/exclude`
- `.env`
- secrets, tokens, credentials
- machine-specific scratch files

### 5.6 Default Rule for Path-Specific Behavior
Default preference order:

1. shared deep guide in `docs/agent-guides/`
2. nested `AGENTS.md` for Codex subtree behavior
3. `.claude/rules/` for Claude path-specific behavior
4. nested `CLAUDE.md` only as an exception

This keeps the repo native to both tools while minimizing duplication drift.

---

## 6. Validation Contract

### 6.1 Canonical Command
For a Windows-first repo, the canonical validation entrypoint should be:

```powershell
pwsh -File scripts/validate.ps1
```

This command should either:
- run the full required validation suite directly, or
- orchestrate lower-level scripts such as `lint.ps1`, `test.ps1`, and build checks

### 6.2 Optional Wrappers
You may also expose:
- `make ci`
- `npm run ci`
- `just validate`

But those are wrappers. The repo must still define one authoritative validation contract and document it in `docs/operations/validation.md`.

### 6.3 Validation Requirements
`validate.ps1` should cover, as applicable:

- lint
- tests
- type checks
- build or compile checks
- secret scan
- schema or migration verification
- docs update checks if docs are part of the acceptance contract

### 6.4 Rule
No task is “done” until:
- the required checks pass, or
- an approved exception is recorded in the task/spec/PR context

---

## 7. Operating Model

### 7.1 One-Agent-at-a-Time Rule
For the same working tree:
- do **not** let Codex and Claude Code edit concurrently
- do **not** switch tools mid-flight without clean handoff

If parallelism is needed:
- use separate branches or worktrees
- isolate the change lane
- re-run validation before merge

### 7.2 Clean Handoff Sequence
When switching between Codex and Claude Code:

1. run `git status`
2. review the diff
3. run the validation contract
4. commit, stash, or discard outstanding changes
5. update the relevant task packet or notes
6. close the current agent session
7. open the next tool on a clean, known state

### 7.3 Task Flow
Use this progression:

```text
Issue / request
  → spec (if needed)
  → task packet
  → tasks/pending/
  → tasks/active/
  → implementation + validation
  → PR / review
  → tasks/done/
```

### 7.4 When Specs Are Required
Require a spec for:
- architecture changes
- cross-cutting refactors
- new workflows or control surfaces
- changes that affect multiple packages or teams
- policy-sensitive or regulated behavior

Do not require specs for:
- tiny typo fixes
- narrow local bug fixes with obvious scope
- purely clerical updates

### 7.5 Review Model
At minimum:
- low-risk changes: CI + normal review
- medium-risk changes: CI + code owner review
- high-risk changes: CI + explicit human approval from named owners

Agent-generated changes must never bypass the review path defined by the repo.

---

## 8. Commit / Ignore Policy

### 8.1 Commit These
Commit the repo’s shared truth:

- `README.md`
- `START_HERE.md`
- `AGENTS.md`
- `CLAUDE.md`
- `.codex/config.toml`
- `.agents/skills/**`
- `.claude/settings.json` when genuinely project-shared
- `.claude/rules/**`
- `.claude/hooks/**` when project-wide
- `.claude/skills/**`
- `.claude/agents/**` when intentionally used
- `.github/**`
- `docs/**`
- `policies/**`
- `specs/**`
- `tasks/**`
- `scripts/**`
- `.gitattributes`
- `.gitignore`
- `.editorconfig`

### 8.2 Ignore These
Ignore local, secret, or generated state:

- `.claude/settings.local.json`
- `.env`
- `.env.*`
- secrets
- credentials
- dependency caches
- virtual environments
- build artifacts
- coverage outputs
- `runs/**` contents
- local transcripts or scratch files
- OS/editor clutter

### 8.3 Conditional / Optional
Use only when justified:

- `prompts/` if prompts are versioned product artifacts
- `evals/` if AI behavior needs regression testing
- `infra/` if deployment or IaC is repo-managed
- `observability/` if dashboards and runbooks are maintained in-repo
- project-scoped MCP configuration only when scrubbed and truly shareable

---

## 9. Windows-First Implementation Notes

### 9.1 Path Style
Use forward-slash repo-relative paths in documentation:

- `docs/architecture/overview.md`
- `scripts/validate.ps1`
- `src/module_x/`

This stays readable across GitHub, editors, and terminal contexts.

### 9.2 Script Surface
Default to PowerShell for project scripts in a Windows-first repo.

Add bash only when:
- CI requires it
- WSL/Linux contributors need it
- cross-platform portability is part of the acceptance criteria

### 9.3 Line Endings
Commit a `.gitattributes` file so line endings are predictable.

Starter policy:

```gitattributes
* text=auto
*.ps1 text eol=crlf
*.bat text eol=crlf
*.sh  text eol=lf
*.yml text eol=lf
*.yaml text eol=lf
*.md  text eol=lf
```

### 9.4 Explicit Invocation
Do not rely on implicit shell assumptions. Prefer explicit calls such as:

```powershell
pwsh -File scripts/validate.ps1
pwsh -File scripts/bootstrap.ps1
```

### 9.5 Cross-Platform Tolerance
If you later add:
- `make ci`
- `npm run ci`
- containerized validation
- WSL support

keep them aligned to the same underlying validation contract rather than creating separate truths.

---

## 10. Starter Profile vs. Scaled Profile

### 10.1 Minimum Strong Starter Set
Start with these:

- `README.md`
- `START_HERE.md`
- `AGENTS.md`
- `CLAUDE.md`
- `.gitignore`
- `.gitattributes`
- `.editorconfig`
- `.env.example`
- `.codex/config.toml`
- `.agents/skills/`
- `.claude/skills/`
- `docs/architecture/overview.md`
- `docs/operations/validation.md`
- `src/`
- `tests/`
- `scripts/validate.ps1`
- `.github/workflows/ci.yml`

### 10.2 Add Next
Add these once the repo has real repeatable workflows:

- `.claude/settings.json`
- `.claude/rules/`
- `.claude/hooks/`
- `docs/architecture/adr/`
- `docs/agent-guides/`
- `specs/`
- `tasks/`
- `policies/`

### 10.3 Add Only When Justified
Add these only when the repo actually needs them:

- `.claude/agents/`
- `prompts/`
- `evals/`
- `infra/`
- `observability/`
- `examples/`

---

## 11. Anti-Patterns to Avoid

### 11.1 Duplicate Truth
Bad pattern:
- one rule in `AGENTS.md`
- a slightly different version in `CLAUDE.md`
- a third version in a skill
- a fourth version in a hook comment

Fix:
- put the durable rule in one canonical place
- let native files point to that place

### 11.2 Overgrown Always-On Files
Do not turn `AGENTS.md` or `CLAUDE.md` into giant manuals. Keep them concise and stable.

### 11.3 Root Clutter
Do not dump every tool artifact into the repo root. Use `.codex/`, `.claude/`, `.github/`, and `docs/`.

### 11.4 Hidden Validation
Do not make the pass/fail contract implicit. The repo should have one obvious validation command.

### 11.5 Committing Ephemeral Runs
Do not commit transcripts, scratch notes, or generated output into durable governance folders.

### 11.6 Simultaneous Cross-Vendor Writes
Do not let Codex and Claude Code race on the same working tree.

### 11.7 Unnecessary Enterprise Bloat
Do not create `policies/`, `observability/`, `evals/`, and subagents just because they sound mature. Add them when the repo earns them.

### 11.8 Missing Human Surfaces
Do not build a repo that only an agent can understand. Human operators must be able to recover the logic from the docs.

---

## 12. Locked Decisions

These decisions are locked by this reference unless there is a later superseding version:

1. **Primary shared instruction file:** `AGENTS.md`
2. **Claude-native companion file:** `CLAUDE.md`
3. **Canonical Codex repo skill root:** `.agents/skills/`
4. **Canonical Claude project namespace:** `.claude/`
5. **Shared durable truth lives in:** `docs/`, `policies/`, `specs/`, `tasks/`
6. **Ephemeral outputs live in:** `runs/` (gitignored)
7. **Windows-first validation entrypoint:** `scripts/validate.ps1`
8. **Cross-vendor simultaneous writes:** forbidden on the same worktree
9. **Human-friendly surfaces required:** `README.md`, `START_HERE.md`, architecture docs, validation docs
10. **Nested path guidance default:** Codex uses nested `AGENTS.md` when needed; Claude uses `.claude/rules/` by default

---

## 13. Adoption Sequence

Use this order to implement the standard:

### Step 1 — Establish the control plane
Create:
- `README.md`
- `START_HERE.md`
- `AGENTS.md`
- `CLAUDE.md`

### Step 2 — Lock the validation contract
Create:
- `scripts/validate.ps1`
- `docs/operations/validation.md`
- `.github/workflows/ci.yml`

### Step 3 — Add native skill surfaces
Create:
- `.agents/skills/`
- `.claude/skills/`

Mirror the same workflow concepts across both, but keep each skill entrypoint thin.

### Step 4 — Add architecture truth
Create:
- `docs/architecture/overview.md`
- `docs/architecture/adr/`

### Step 5 — Add execution governance
Create:
- `specs/`
- `tasks/`
- `policies/`

### Step 6 — Scale only where the repo proves the need
Only then add:
- hooks
- subagents
- evals
- observability
- infra layers
- advanced policy controls

---

## 14. Final Opinionated Blueprint

If you want the short version, use this model:

- **Use `AGENTS.md` as the shared repo contract**
- **Use `CLAUDE.md` as the Claude-native adapter**
- **Keep Codex native with `.codex/config.toml` and `.agents/skills/`**
- **Keep Claude native with `.claude/settings.json`, `.claude/rules/`, `.claude/hooks/`, and `.claude/skills/`**
- **Keep durable truth in normal repo docs**
- **Use `specs/` and `tasks/` for non-trivial execution**
- **Use `runs/` for ephemeral outputs and keep it out of Git**
- **Make Windows validation explicit through `scripts/validate.ps1`**
- **Do not let Codex and Claude edit the same worktree simultaneously**
- **Keep the repo legible to a human operator at all times**

That is the merged standard.

---

## 15. Source Basis

This reference was unified from the two source documents above and normalized into one primary repo standard. It retains the core dual-agent structure from the dual-agent blueprint, absorbs the stronger governance and lifecycle layers from the broader agentic repo structure, and resolves conflicts in favor of:

- cross-tool shared control via `AGENTS.md`
- native tool-specific surfaces for Codex and Claude
- human-friendly root documentation
- Windows-first operational practicality
- minimal duplication of durable instructions
