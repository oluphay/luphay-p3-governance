# P3 ↔ STD-SPEC-0008 Alignment Review and Plan

## 1. Executive assessment

- Overall alignment status: **partially compatible**
- Current P3 posture is **not structurally divergent** from `STD-SPEC-0008 v1.2`; the core P3 architecture is broadly compatible, but the live repo currently has truth-location drift, stale indexes, and missing shared native-tool surfaces.
- Top 5 findings:
  - Durable P3 truth exists on disk but is not consistently committed or tracked. The clearest examples are `03_portfolios/P3-PORT-0002__p3-live-operations/`, `03_portfolios/P3-PORT-0003__luphay-canonical-atlas/`, and `04_docs/operations/p3-live-workflow.md`, which are live on disk and referenced by control docs but are currently untracked.
  - The authoritative fast-query layer is stale relative to live truth. `06_state/registers/*.json` and human registers in `01_governance/` lag the actual repo contents.
  - The shared control plane exists, but it is drifting. `AGENTS.md`, `CLAUDE.md`, README surfaces, the older tree spec, and the live repo no longer agree on several key paths and current-state claims.
  - STD-SPEC-0008-native shared tool surfaces are mostly absent. There is no committed `.codex/`, `.agents/`, or `.github/`; `.claude/` exists only as ignored local material; `.gitignore` currently blocks future adoption of shared native surfaces.
  - The live root is no longer the nine-root v0.4 tree alone. Extra undeclared roots and spillover content exist, especially `00_day_one/`, `99_archive/`, and root-level files inside `01_governance/` that are outside the declared subfolder model.

## 2. What P3 already gets right

- `AGENTS.md` is functioning as the primary shared instruction surface, which is directly aligned to `STD-SPEC-0008`.
- `README.md` and `START_HERE.md` provide a human-legible root entrypoint, so the repo is not agent-only.
- Numbered root folders remain a valid P3 specialization. They preserve human visual orientation without breaking the standard’s intent.
- Declared path isolation via `AGENTS.md` and `04_docs/REPO_PROFILE.md` is a strong implementation of the standard’s “human-friendly and agent-safe” control-plane requirement.
- `03_portfolios/` is a valid P3-native equivalent for the repo’s governed business and execution container model.
- `entity.yaml` and `packet.yaml` are strong machine-readable sources of truth and are more structured than the baseline standard requires.
- `06_state/inputs/`, `06_state/registers/`, `06_state/graph/`, and `06_state/audit/` are a valid deliberate machine-state layer, not accidental clutter.
- `07_scripts/validate.ps1` and `07_scripts/rebuild-state.ps1` are already separated by responsibility, which matches the standard’s validation and state-regeneration posture.
- `04_docs/architecture/` and `04_docs/operations/` are good P3-native equivalents of the standard’s `docs/architecture/` and `docs/operations/` layering.
- Task packets under projects are a legitimate governed equivalent of the standard’s `tasks/` concept. P3 already has a stronger execution model than a flat repo-level task queue.
- `09_runs/` exists and is ignored, which is aligned to the standard’s `runs/` principle even though the root path is P3-numbered.

## 3. Alignment gaps

### GAP-01 — Durable truth is not consistently committed
- Current state: live portfolios, projects, and workflow docs exist on disk but are untracked, while root control files already describe them as current operational truth.
- Target state: every artifact treated as durable repo truth is committed, versioned, and queryable; anything intentionally local remains explicitly local and is not referenced as canonical truth.
- Severity: Critical
- Rationale: STD-SPEC-0008 requires durable truth to live in committed repo artifacts. P3’s own model also treats `03_portfolios/` and `04_docs/` as durable zones, so leaving live canonical content untracked breaks both models.

### GAP-02 — State and governance indexes are stale relative to live truth
- Current state: `06_state/registers/*.json`, `01_governance/decision-register.md`, `01_governance/framework-register.md`, and `01_governance/playbook-register.md` do not fully represent the live on-disk repo. Examples include missing `P3-PORT-0003`, missing later ADR files, and a playbook register that still says no playbooks are registered.
- Target state: human-maintained and machine-derived indexes match live governed truth, or are explicitly marked as stale until a baseline sync is completed.
- Severity: Critical
- Rationale: P3 agents are instructed to query registers instead of traversing the tree. When the registers drift, the repo’s own operating model becomes unreliable.

### GAP-03 — Shared control surfaces are drifting
- Current state: `AGENTS.md`, `CLAUDE.md`, `README.md`, `START_HERE.md`, `03_portfolios/README.md`, and the older tree spec no longer tell a fully consistent story. `CLAUDE.md` is also thick and role-heavy rather than a thin adapter.
- Target state: root control surfaces agree on the live repo shape, `AGENTS.md` remains the shared law, and `CLAUDE.md` becomes a thin Claude-native adapter that points back to shared truth.
- Severity: High
- Rationale: the standard explicitly warns against duplicate truth and overgrown always-on files. The control plane is present, but it needs harmonization.

### GAP-04 — Shared native agent surfaces are missing or only local
- Current state: there is no committed `.codex/config.toml`, no `.agents/skills/`, no committed `.claude/settings.json`, no `.claude/rules/`, no `.claude/skills/`, and no `.github/`. The only `.claude/` content is local-only and ignored.
- Target state: add the minimal justified shared native surfaces for Codex and Claude, with local overrides remaining ignored.
- Severity: High
- Rationale: the repo is explicitly dual-agent in posture, so the absence of committed shared native surfaces is a real alignment gap rather than optional polish.

### GAP-05 — `.gitignore` blocks future shared native-surface adoption and creates mixed-mode zones
- Current state: `.gitignore` ignores `.claude/`, `.codex/`, `05_hub/`, and `09_runs/` wholesale, while some tracked files still live under `05_hub/`. This creates partial-truth zones and blocks standard-aligned shared configuration adoption.
- Target state: ignore rules become granular. Shared repo-native surfaces are commit-eligible; local overrides and ephemeral contents remain ignored.
- Severity: High
- Rationale: the current ignore policy reflects an immediate-use local workflow, not the target dual-agent-native operating model.

### GAP-06 — Validation is real but too narrow for the target contract
- Current state: `07_scripts/validate.ps1` passes and enforces structural integrity well, but it does not yet cover shared native surfaces, docs-layer consistency, ignore-policy expectations, or CI parity. There is also no `.github/workflows/ci.yml`.
- Target state: one explicit validation contract, documented in `04_docs/operations/validation.md`, with local script and CI covering the same required checks.
- Severity: Medium
- Rationale: the repo already has a validator, which is good. The gap is breadth, not absence.

### GAP-07 — Hub posture is ambiguous between local staging and governed durable intake
- Current state: `05_hub/` is described as a controlled intake/promotion surface, but current docs also describe it as local staging in the immediate-use phase, while `.gitignore` ignores the whole hub. At the same time, tracked READMEs and very large ignored triage content coexist under the same root.
- Target state: choose one posture explicitly for the near term:
  - local-only staging with minimal committed contract docs, or
  - governed durable intake with granular commit policy
- Severity: Medium
- Rationale: the concept itself is valid P3 specialization; the problem is the mixed operating mode.

### GAP-08 — The internal governing copy of the standard is stale and misclassified
- Current state: the repo contains `01_governance/standards/STD-REFR-0006__agentic-native-repo-primary-reference__v1.0.md`, while the governing external reference for this review is `STD-SPEC-0008__agentic-native-repo-primary-reference__v1.2.md`.
- Target state: the internal governed reference is updated or superseded so the repo’s own standards layer reflects the current target standard and correct family/classification.
- Severity: Medium
- Rationale: alignment work should not be driven forever from an external download while the in-repo standard remains older and differently classified.

### GAP-09 — The live root and governance library contain undeclared spillover
- Current state: undeclared root zones such as `00_day_one/` and `99_archive/` exist on disk, and `01_governance/` contains many root-level files outside `standards/`, `framework/`, and `playbooks/`.
- Target state: every governed artifact is either:
  - placed in a declared home,
  - explicitly archived under a declared policy, or
  - kept local and excluded from canonical truth
- Severity: High
- Rationale: P3’s path-isolation model depends on declared homes. Spillover weakens recoverability and increases ambiguity about what is canonical.

### GAP-10 — Several locked-core repo hygiene surfaces are still missing
- Current state: `.gitattributes`, `.editorconfig`, `.env.example`, `CONTRIBUTING.md`, `SECURITY.md`, `CODEOWNERS`, and `LICENSE` are missing.
- Target state: add the missing locked-core or strongly recommended hygiene surfaces that are justified for this repo.
- Severity: Low
- Rationale: these are important but secondary compared with the truth-baseline and control-plane issues.

## 4. Mapping model

| P3 construct | STD-SPEC-0008 construct | Current assessment | Recommendation |
|---|---|---|---|
| `README.md` | `README.md` | Direct equivalent exists | Preserve as-is, then refresh content |
| `START_HERE.md` | `START_HERE.md` | Direct equivalent exists | Preserve as-is, then refresh content |
| `AGENTS.md` | `AGENTS.md` | Direct equivalent exists and is primary | Preserve as-is, fix drift and tighten references |
| `CLAUDE.md` | `CLAUDE.md` | Equivalent exists, but too heavy | Literal surface preserved; content should be thinned |
| `04_docs/architecture/**` | `docs/architecture/**` | Strong P3-native equivalent exists | Mapping only recommended |
| `04_docs/operations/**` | `docs/operations/**` | Strong P3-native equivalent exists | Mapping only recommended |
| `01_governance/standards/` | `policies/` plus parts of `specs/` | Partial equivalent | Preserve as P3-native governance layer; do not flatten to root `policies/` |
| `01_governance/framework/` | architecture / design reference docs | Equivalent exists | Preserve as-is |
| `01_governance/playbooks/` | `docs/agent-guides/**` / workflow guides | Equivalent exists but thinly populated | Mapping only recommended; expand as needed |
| `01_governance/decisions/` plus decision register | `docs/architecture/adr/` and ADR index | Equivalent exists | Preserve P3 decision model; clean up register location truth |
| `02_templates/` | `specs/_template.md` and `tasks/_template.md` roles | Strong P3-native equivalent exists | Preserve as-is |
| `03_portfolios/.../task-packets/` | `tasks/` | Strong governed equivalent exists | Mapping only recommended; no root `tasks/` folder needed |
| Project / program / portfolio Markdown + YAML | `specs/` plus execution metadata | Strong P3-native governed-object model exists | Preserve as-is |
| `05_hub/input_hub/` and `05_hub/output_hub/` | intake / pending / staged execution areas | Functional equivalent exists | Preserve concept; clarify local vs durable posture |
| `06_state/inputs/`, `registers/`, `graph/`, `audit/` | no literal baseline equivalent | Deliberate P3 specialization | Preserve as-is |
| `07_scripts/validate.ps1` | `scripts/validate.ps1` | Functional equivalent exists | Preserve numbered root; no literal flattening needed |
| `07_scripts/rebuild-state.ps1` | supporting scripts under `scripts/` | Functional equivalent exists | Preserve as-is |
| `09_runs/` | `runs/` | Direct equivalent with numbered-root variation | Preserve as-is |
| `.claude/settings.local.json` and `.claude/worktrees/` | local-only Claude surfaces | Only local compatibility is present | Keep local-only material ignored; add shared surfaces separately if adopted |
| `.codex/config.toml` | `.codex/config.toml` | No current equivalent | Literal adoption recommended if dual-agent-native posture is confirmed |
| `.agents/skills/` | `.agents/skills/` | No current equivalent | Literal adoption recommended |
| `.claude/settings.json`, `.claude/rules/`, `.claude/skills/` | same | No committed equivalent | Literal adoption recommended at minimal viable scope |
| `.github/workflows/ci.yml` | same | Missing | Literal adoption recommended |
| `.mcp.json` | same | Missing | No current equivalent; adopt only if shared MCP is actually needed |

## 5. Recommended target posture

- Adopt literally:
  - `AGENTS.md` remains the primary shared instruction surface.
  - `CLAUDE.md` remains required, but as a thin adapter.
  - `.codex/config.toml`
  - `.agents/skills/`
  - minimal shared `.claude/` surfaces: `settings.json`, `skills/`, `rules/`
  - `.github/workflows/ci.yml`
  - `.gitattributes`
  - `.editorconfig`
  - `.env.example`
- Adapt into P3-native equivalents:
  - keep `04_docs/architecture/` instead of creating a new unprefixed `docs/architecture/`
  - keep `04_docs/operations/` instead of creating a parallel root `docs/operations/`
  - keep `07_scripts/` instead of introducing a second root `scripts/`
  - keep `03_portfolios/.../task-packets/` as the repo’s execution-governance surface instead of adding a flat root `tasks/`
  - keep P3 governance truth in `01_governance/` rather than flattening it into root `policies/` and root `specs/`
- Remain intentionally different:
  - numbered root folders
  - `03_portfolios/` as the canonical business container
  - the YAML companion model
  - `06_state/` as durable machine-managed derived state
  - global ADR-DECN sequencing and scoped decision homes
  - deferred rename sequencing for path-sensitive changes
- Do not adopt literally unless justified later:
  - root `specs/`
  - root `tasks/`
  - `.mcp.json`
  - `.claude/agents/`
  - `.claude/output-styles/`
  - `.claude/commands/`
- Recommended end-state summary:
  - keep the P3 spine
  - align the control plane
  - formalize committed native tool surfaces
  - synchronize indexes to live truth
  - remove ambiguous mixed-mode zones

## 6. Sequenced alignment plan

### Phase 0 — protect truth / baseline
- Objective: decide what on-disk material is canonical before any structural alignment work begins.
- Exact files/folders likely affected:
  - `03_portfolios/P3-PORT-0002__p3-live-operations/`
  - `03_portfolios/P3-PORT-0003__luphay-canonical-atlas/`
  - `04_docs/operations/p3-live-workflow.md`
  - `01_governance/decision-register.md`
  - `06_state/registers/*.json`
  - `06_state/graph/dependency-graph.json`
  - `05_hub/`
  - `00_day_one/`
  - `99_archive/`
- Dependencies:
  - Alpha decision on which untracked materials are canonical versus local-only
  - agreement on the near-term posture for `05_hub/`
- Risk notes:
  - highest risk phase; mistakes here would either discard real truth or elevate local clutter into canon
  - do not regenerate state until the canonical set is decided
- Completion criteria:
  - every live canonical artifact is either committed or explicitly excluded
  - the repo has one agreed baseline of truth for alignment work

### Phase 1 — control surfaces
- Objective: harmonize the shared root control plane and document the live P3-to-standard mapping.
- Exact files/folders likely affected:
  - `README.md`
  - `START_HERE.md`
  - `AGENTS.md`
  - `CLAUDE.md`
  - `04_docs/REPO_PROFILE.md`
  - `04_docs/architecture/overview.md`
  - `03_portfolios/README.md`
- Dependencies:
  - Phase 0 truth baseline
- Risk notes:
  - path declarations are agent-critical; update control surfaces before any path-sensitive moves
  - thinning `CLAUDE.md` must not remove necessary Claude-specific adaptation
- Completion criteria:
  - no control surface contradicts the live repo state
  - `CLAUDE.md` points to shared truth instead of restating repo law
  - README/START_HERE remain sufficient for human recoverability

### Phase 2 — validation and operational contract
- Objective: expand the validation contract from structural checks to repo-closeout truth, and establish CI parity.
- Exact files/folders likely affected:
  - `07_scripts/validate.ps1`
  - `04_docs/operations/validation.md`
  - `04_docs/operations/recovery.md`
  - `.github/workflows/ci.yml`
  - `.gitattributes`
  - `.editorconfig`
  - `.env.example`
- Dependencies:
  - Phase 1 complete
  - Alpha approval for any newly introduced root surfaces not currently declared
- Risk notes:
  - adding enforcement too early will produce noisy failures if truth-baseline drift still exists
  - new root surfaces may require ADR and path-registry updates before implementation
- Completion criteria:
  - one canonical validation command is documented and reproducible
  - CI runs the same required checks as the local contract
  - validation responsibilities and rebuild-state responsibilities are clearly separated

### Phase 3 — native agent surfaces
- Objective: add the minimum justified shared Codex and Claude repo-native surfaces without duplicating repo law.
- Exact files/folders likely affected:
  - `.gitignore`
  - `.codex/config.toml`
  - `.agents/skills/`
  - `.claude/settings.json`
  - `.claude/skills/`
  - `.claude/rules/`
  - optionally `.mcp.json`
- Dependencies:
  - Phase 1 complete
  - Phase 2 validation contract stable enough to guard the new surfaces
  - Alpha approval and likely ADR coverage for newly declared root hidden folders
- Risk notes:
  - root hidden folders are structural additions in the current P3 regime
  - overbuilding these surfaces too early would violate the standard’s anti-bloat posture
- Completion criteria:
  - shared native surfaces exist and are commit-eligible
  - local-only overrides remain ignored
  - skills/settings point to shared docs rather than restating policy

### Phase 4 — governance/doc layering cleanup
- Objective: reconcile stale in-repo standards, registers, and spillover content with the new aligned baseline.
- Exact files/folders likely affected:
  - `01_governance/standards/STD-REFR-0006__agentic-native-repo-primary-reference__v1.0.md` or its successor
  - `01_governance/standards-register.md`
  - `01_governance/framework-register.md`
  - `01_governance/playbook-register.md`
  - `01_governance/decision-register.md`
  - `01_governance/`
  - `99_archive/`
  - `00_day_one/`
- Dependencies:
  - Phase 0 truth classification
  - Phase 1 control-surface alignment
  - any required ADRs for archival or structure decisions
- Risk notes:
  - moving governance files before register cleanup will break references
  - do not “clean up” by deleting materials that may still be the only live copy
- Completion criteria:
  - every governed file is either registered, moved to a declared home, or explicitly deprecated
  - the in-repo standard set reflects the current governing target

### Phase 5 — optional advanced surfaces
- Objective: add only the advanced surfaces that the repo has clearly earned.
- Exact files/folders likely affected:
  - `.mcp.json`
  - `.claude/output-styles/`
  - `.claude/agents/`
  - `04_docs/operations/mcp-servers.md`
  - `01_governance/playbooks/`
  - selected `05_hub/` subareas if governed promotion becomes durable
- Dependencies:
  - prior phases complete
  - demonstrated operational need
- Risk notes:
  - most likely place for avoidable enterprise bloat
  - keep optional surfaces out until the repo proves the need
- Completion criteria:
  - every optional surface has a clear owner, purpose, and validation/home policy

## 7. Change inventory

### Add
- `.gitattributes`
- `.editorconfig`
- `.env.example`
- `.github/workflows/ci.yml`
- `.codex/config.toml`
- `.agents/skills/`
- `.claude/settings.json`
- `.claude/skills/`
- `.claude/rules/`
- `04_docs/operations/mcp-servers.md` only if `.mcp.json` is adopted
- updated in-repo governed copy of `STD-SPEC-0008 v1.2` or approved successor path

### Modify
- `README.md`
- `START_HERE.md`
- `AGENTS.md`
- `CLAUDE.md`
- `.gitignore`
- `04_docs/REPO_PROFILE.md`
- `04_docs/architecture/overview.md`
- `04_docs/operations/validation.md`
- `04_docs/operations/recovery.md`
- `03_portfolios/README.md`
- `07_scripts/validate.ps1`
- `01_governance/decision-register.md`
- `01_governance/standards-register.md`
- `01_governance/framework-register.md`
- `01_governance/playbook-register.md`
- `06_state/registers/*.json` via `07_scripts/rebuild-state.ps1`, not by direct edit
- `06_state/graph/dependency-graph.json` via `07_scripts/rebuild-state.ps1`, not by direct edit

### Move
- root-level spillover files from `01_governance/` into `01_governance/standards/`, `01_governance/framework/`, or `01_governance/playbooks/` after classification
- selected contents of `99_archive/` into declared archival or governed homes after policy decision
- any durable materials currently marooned in ignored local-only zones into declared tracked homes

### Deprecate
- using `.gitignore` blanket ignores for shared repo-native surfaces
- treating ignored local `.claude/` content as if it were project-shared truth
- treating `05_hub/` as both canonical durable intake and entirely local staging at the same time
- treating `STD-REFR-0006__agentic-native-repo-primary-reference__v1.0.md` as current once the repo adopts the v1.2 target
- using undeclared root spillover as silent canonical storage

### Preserve unchanged
- `01_` through `09_` numbered root folder model
- `03_portfolios/` as the canonical governed business container
- portfolio/program/project/task-packet nesting
- `entity.yaml` / `packet.yaml` companion model
- `06_state/inputs/`, `06_state/registers/`, `06_state/graph/`, `06_state/audit/` contract
- `07_scripts/rebuild-state.ps1` as the canonical state-regeneration script
- `09_runs/` as the ephemeral runtime zone
- decision scope logic and global ADR-DECN sequencing

## 8. Risks and cautions

- Path-sensitive change risk:
  - adding `.codex/`, `.agents/`, `.github/`, and shared `.claude/` as committed root surfaces is a structural change in the current P3 regime and should be treated as ADR-sensitive work
  - control surfaces and path registries must be updated before any path-sensitive moves are committed
- Sequencing hazard:
  - do not run a final state rebuild until Phase 0 decides whether untracked portfolios and docs are canonical; otherwise the repo may regenerate state around the wrong truth set
- Live inspection overruled the old tree spec in these areas:
  - the live root contains `00_day_one/` and `99_archive/`
  - `01_governance/decision-register.md` exists at the governance root, not under `01_governance/decisions/`
  - `03_portfolios/` contains more than the single example lane described in older docs
  - `04_docs/operations/p3-live-workflow.md` exists live but is not part of the tracked committed spine
  - `01_governance/playbooks/` is no longer “future only”
- Human decision needed before migration in these areas:
  - whether `P3-PORT-0002` and `P3-PORT-0003` are now canonical durable truth
  - whether `05_hub/` stays local-only for the near term or becomes a committed governed intake surface
  - whether new root hidden tool folders should be authorized now
  - what the long-term declared home for archive/day-one materials should be
  - how the repo wants to internalize `STD-SPEC-0008 v1.2`

## 9. Recommended first implementation slice

The smallest safe first slice is a **truth-baseline and control-surface harmonization pass**, not a native-tool-surface rollout.

- Confirm the canonical status of:
  - `03_portfolios/P3-PORT-0002__p3-live-operations/`
  - `03_portfolios/P3-PORT-0003__luphay-canonical-atlas/`
  - `04_docs/operations/p3-live-workflow.md`
- Update only the shared truth surfaces needed to reflect that decision:
  - `README.md`
  - `START_HERE.md`
  - `AGENTS.md`
  - `CLAUDE.md`
  - `04_docs/REPO_PROFILE.md`
  - `03_portfolios/README.md`
- After that truth decision is locked, run `07_scripts/rebuild-state.ps1` so `06_state/registers/*.json` and `06_state/graph/dependency-graph.json` match live truth.

Why this slice first:
- it materially improves alignment immediately
- it does not require flattening the repo
- it avoids introducing new root surfaces before the baseline is trustworthy
- it reduces the risk of building `.codex/`, `.agents/`, `.claude/`, or `.github/` on top of stale repo law

## 10. Open decisions

- Should `03_portfolios/P3-PORT-0002__p3-live-operations/` be promoted into committed canonical truth now, or remain local until further review?
- Should `03_portfolios/P3-PORT-0003__luphay-canonical-atlas/` be treated as canonical and included in the register layer now?
- Should `05_hub/` remain a local staging surface for the immediate phase, or should selected subareas become committed governed truth?
- Does Alpha want to authorize new root hidden native-tool surfaces now: `.codex/`, `.agents/`, `.github/`, and shared `.claude/`?
- Should the internal reference be superseded to a governed `STD-SPEC-0008 v1.2` copy, and if so under which in-repo family/id/path?
- What is the declared long-term home for `99_archive/` and any future archive/day-one materials?
- Is project-shared MCP expected soon enough to justify `.mcp.json` and MCP operations docs, or should that remain deferred?

## 11. Suggested follow-on task packets

- `TASK-ARCH-[next]__baseline-live-governed-truth`
  - Confirm which live untracked artifacts are canonical and prepare the baseline sync.
- `TASK-DOCS-[next]__harmonize-root-control-surfaces`
  - Align `README.md`, `START_HERE.md`, `AGENTS.md`, `CLAUDE.md`, and `REPO_PROFILE.md`.
- `TASK-ARCH-[next]__authorize-native-tool-surfaces`
  - Record the ADR/path-registry decision for `.codex/`, `.agents/`, `.github/`, and shared `.claude/`.
- `TASK-OPS-[next]__expand-validation-and-ci-contract`
  - Broaden `validate.ps1`, add CI, and document the final validation scope.
- `TASK-GOVN-[next]__reconcile-governance-registers-and-spillover`
  - Clean up registers, internal standards drift, and undeclared governance/archive material.
