# P3 Live Workflow

This is the canonical-for-now workflow reference for `luphay-p3-governance`.
Its location may later be optimized or relocated, but it is the current
workflow truth for the repo.

## Purpose

Use this workflow when Alpha has a real task and wants an agent to execute it
inside the repo without waiting for a richer command surface.

This document does not imply that a committed live production portfolio lane
currently exists in canon. It defines the operating loop to use when such work
is approved and housed in a governed location.

## Default path

1. Start from an approved active project under `03_portfolios/`.
2. Create a task packet home under that project's `task-packets/` folder.
3. Add a primary `TASK-*.md`, a sibling `packet.yaml`, and the folders
   `inputs/`, `outputs/`, `working/`, and `evidence/`.
4. Put the objective, in-scope paths, out-of-scope paths, acceptance criteria,
   and validation command in the primary `TASK-*.md`.
5. Put the structured state in `packet.yaml`: `status`, `owner`, `priority`,
   `active_assignee`, parent IDs, and validation fields.

## Agent pickup

Before execution, the agent reads:

1. `AGENTS.md`
2. `04_docs/REPO_PROFILE.md`
3. The relevant JSON register in `06_state/registers/`
4. The parent project docs that define scope
5. The task packet's primary Markdown file and `packet.yaml`

Pickup means:

- `status` becomes `active`
- `active_assignee` is filled
- the agent works only within the declared in-scope paths

## During execution

- Use `working/` for notes, draft reasoning, and session breadcrumbs.
- Use `outputs/` for the actual work product or change summary.
- Use `evidence/` for proof such as validation logs or screenshots.
- Update `packet.yaml` if the task becomes blocked, returns for rework, or moves
  to review.

## Review and closeout

1. Move the packet to `in-review` when outputs and evidence are present.
2. Human review accepts the packet as `done` or returns it as `blocked` or
   `returned` with the blocking reason.
3. Run `07_scripts/validate.ps1`.
4. Run `07_scripts/rebuild-state.ps1` after any packet or entity state change.
5. Commit the packet, outputs, evidence, and any changed governed files as the
   durable history of the task.

## Current committed posture

- `03_portfolios/P3-PORT-0001__human-friendly-title/` remains the committed
  sample/template hierarchy. It is a shape reference, not a live production
  portfolio lane.
- No committed live production portfolio lane is currently designated in canon.
- Use this workflow document as the canonical operating reference for now, then
  apply it to an approved governed lane when one exists.
