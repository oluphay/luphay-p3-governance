---
id: PBK-PROC-0001
title: "Entity Creation Playbook"
version: v0.1
status: active
scope_level: Enterprise
effective_date: 2026-03-31
---

# PBK-PROC-0001 — Entity Creation Playbook

This playbook governs the end-to-end process for creating a new governed entity
(portfolio, program, project, or task packet) in `luphay-p3-governance`. It
covers the full flow from intake through hub staging to promotion into
`03_portfolios/`. Follow every step in order. No step may be skipped.

---

## Roles

| Role | Responsibility |
|---|---|
| Alpha | Approves at each hub gate; assigns owner and ID class; declares done |
| Agent | Executes steps; surfaces blockers; writes all files from templates |

---

## Phase 1 — Intake

**Step 1. Drop the raw brief.**
Place a plain-text or Markdown brief describing the new entity into
`05_hub/input_hub/raw_drop/`. Name it descriptively but informally — this file
is not governed yet. Example: `new-portfolio-luphay-core-platform.md`.

**Step 2. Triage.**
Agent reads the brief and classifies the entity type (portfolio, program,
project, or task packet). Agent moves the brief from `raw_drop/` to the
appropriate `candidate_*` folder:
- `candidate_portfolios/` — for portfolios
- `candidate_programs/` — for programs
- `candidate_projects/` — for projects
- `candidate_tasks/` — for task packets

Agent surfaces classification to Alpha for confirmation before proceeding.
If the brief is unclear or the entity type is ambiguous, escalate — do not
classify by inference.

**Step 3. Alpha gate — intake approval.**
Alpha confirms the entity type and approves moving to Phase 2. If Alpha
returns the item, move it to `rejected_or_returned/` and stop.

---

## Phase 2 — Pre-creation checks

**Step 4. Confirm parent exists.**
Every entity except a portfolio requires a parent:
- Program → parent portfolio must exist in `03_portfolios/`
- Project → parent program must exist under the portfolio's `programs/`
- Task packet → parent project must exist under the program's `projects/`

Read `06_state/registers/[type]-register.json` to confirm the parent's `id`
and `path`. If the parent does not exist, stop and escalate to Alpha before
proceeding. Do not create a parent speculatively.

**Step 5. Determine the next sequential ID.**
Read the relevant JSON register to find the highest existing ID for the entity
type and increment by one:
- Portfolio: `06_state/registers/portfolio-register.json` → next `P3-PORT-NNNN`
- Program: `06_state/registers/program-register.json` → next `P3-PROG-NNNN`
- Project: `06_state/registers/project-register.json` → next `P3-PROJ-NNNN`
- Task packet: `06_state/registers/task-register.json` → next `TASK-[CLASS]-NNNN`

For task packets, confirm the class code with Alpha (FEAT, FIXE, DEBT, RESR,
ARCH, TEST, INFR, SECU, REVN, DOCS, ADMN, DATA) before proceeding.

**Step 6. Compose the LNS-compliant slug.**
The slug is a short, lowercase, hyphen-separated description of the entity.
Formula: `[type]-[NNNN]__[slug]`. Example: `P3-PORT-0002__luphay-core-platform`.
Confirm the slug with Alpha before writing any files.

---

## Phase 3 — Scaffolding

**Step 7. Load the correct template.**
Read the template for the entity type from `02_templates/`:
- Portfolio: `STD-TEMP-0004__p3-portfolio-template__v0.1.md`
- Program: `STD-TEMP-0003__p3-program-template__v0.1.md`
- Project: `STD-TEMP-0002__p3-project-template__v0.1.md`
- Task packet: `STD-TEMP-0001__task-packet-template__v0.1.md`

Also read the pattern file for the entity type:
- Portfolio pattern: `03_portfolios/STD-REFR-0002__portfolio-home-pattern__v0.1.md`
- Program pattern: `03_portfolios/.../programs/STD-REFR-0003__program-home-pattern__v0.1.md`
- Project pattern: `03_portfolios/.../projects/STD-REFR-0004__project-home-pattern__v0.1.md`

**Step 8. Create the entity folder.**
Create the entity home folder at the correct path under `03_portfolios/`.
The folder name must be the full LNS identifier: `P3-PORT-NNNN__slug` or
`TASK-CLASS-NNNN__slug`. Do not abbreviate.

**Step 9. Write the primary governing Markdown file.**
Filename: `[ID]__[slug]__v0.1.md`. Populate all front matter fields from the
template. Replace every placeholder with real content — no `TBD` in the title,
no `Human Friendly Title`, no placeholder description.

**Step 10. Write the sibling YAML companion file.**
For portfolios, programs, and projects: write `entity.yaml`.
For task packets: write `packet.yaml`.
Populate every field. `owner` must be a real name or role, not `TBD`. Set
`status` appropriately: `draft` for new entities not yet in active work.

**Step 11. Create required subfolders and stub files.**
Use the pattern file (step 7) to identify which subfolders are required.
Create stub `.md` files in `docs/` (or `inputs/`, `outputs/`, `working/`,
`evidence/` for task packets). Stubs may contain only the folder-level heading
— they exist to declare structure, not to contain content yet.

---

## Phase 4 — Validation and promotion

**Step 12. Validate.**
Run `07_scripts/validate.ps1`. It must pass with no errors before proceeding.
If validation fails, fix the structural issue before continuing — do not bypass.

**Step 13. Alpha gate — pre-promotion review.**
Surface the completed entity home to Alpha. Alpha reviews:
- Entity folder name is LNS-compliant
- Primary `.md` file and YAML companion are both present
- No placeholder text remains in the primary governing file
- `entity.yaml` / `packet.yaml` fields are fully populated

Alpha approves or returns with changes. If returned, fix and re-validate.
Do not proceed to step 14 without explicit Alpha approval.

**Step 14. Rebuild state.**
Run `07_scripts/rebuild-state.ps1`. This regenerates:
- `06_state/registers/[type]-register.json`
- `06_state/graph/dependency-graph.json`

Spot-check the new register entry: confirm the `id`, `path`, `parent_id`, and
`status` in the JSON match the `entity.yaml` values exactly.

**Step 15. Log promotion.**
Append an entry to `05_hub/input_hub/promoted_log/` recording:
- Entity ID and slug
- Promotion date (ISO format)
- Parent entity ID (if applicable)
- Approving operator (Alpha)

**Step 16. Commit.**
Stage the new entity folder, the updated JSON registers, the dependency graph,
and the promotion log entry. Commit with a message in the form:

```
Add [P3-PORT-NNNN|P3-PROG-NNNN|P3-PROJ-NNNN|TASK-CLASS-NNNN] — [slug]

[One sentence describing the entity and its purpose.]
```

---

## Escalation conditions

Stop and surface to Alpha (trigger name + conflict description) if:

- Entity type cannot be determined unambiguously from the brief
- Parent entity does not exist in the register
- Slug conflicts with an existing entity slug in the same register
- validate.ps1 fails and the cause cannot be resolved from the error output
- Alpha approval is not received before Phase 4

---

## Quick reference — entity home structure

| Entity type | Primary file | YAML companion | Key subfolders |
|---|---|---|---|
| Portfolio | `P3-PORT-NNNN__slug__vX.Y.md` | `entity.yaml` | `docs/`, `decisions/`, `programs/` |
| Program | `P3-PROG-NNNN__slug__vX.Y.md` | `entity.yaml` | `docs/`, `decisions/`, `projects/` |
| Project | `P3-PROJ-NNNN__slug__vX.Y.md` | `entity.yaml` | `docs/`, `decisions/`, `artifacts/`, `links/`, `task-packets/` |
| Task packet | `TASK-CLASS-NNNN__slug__vX.Y.md` | `packet.yaml` | `inputs/`, `outputs/`, `working/`, `evidence/` |
