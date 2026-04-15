---
id: STD-TEMP-0001
family: STD-TEMP
version: 0.2
status: active
template_for: task-packet
---

# STD-TEMP-0001 — Task Packet Template
This file is the canonical task-packet creation contract for
`luphay-p3-governance`. The Markdown scaffold below, the `packet.yaml` scaffold
below, and the required folder set together form the single source of truth for
new task packets. Do not use a separate `packet-template.yaml`.

## Required contents in every task-packet home

- primary `TASK-*.md` file
- `packet.yaml`
- `inputs/`
- `outputs/`
- `working/`
- `evidence/`

## Primary Markdown scaffold

```markdown
---
id: TASK-CLASS-NNNN
version: 0.1
status: draft
owner: ""
---

# TASK-CLASS-NNNN — Task Title
## Objective

State the outcome this packet must deliver.

## Scope

- `path/in/scope`

## Out of Scope

- `path/or/topic/out-of-scope`

## Execution Notes

Capture assumptions, dependencies, and operator guidance needed during pickup.

## Acceptance Criteria

- The deliverable is present in `outputs/` or as a governed repo change.
- Evidence needed for review is present in `evidence/`.
- The validation command runs cleanly.

## Validation

Primary command: `powershell -ExecutionPolicy Bypass -File 07_scripts\validate.ps1`

Secondary command: `powershell -ExecutionPolicy Bypass -File 07_scripts\rebuild-state.ps1`

## Closeout / Handoff

Describe the final state, reviewer expectation, and any follow-up work.
```

## `packet.yaml` scaffold

```yaml
id: TASK-CLASS-NNNN
object_type: task-packet
title: ""
slug: ""
packet_class: Change
packet_subtype: ""
governance_mode: Standard
version: v0.1
status: draft
owner: ""
priority: NEXT
active_assignee: ""
definition_of_done: ""
validation_command: powershell -ExecutionPolicy Bypass -File 07_scripts\validate.ps1
validation_status: pending
handoff_note: ""
created_by: ""
created_at: ""
last_updated: ""
started_at: ""
completed_at: ""
parent_portfolio: ""
parent_program: ""
parent_project: ""
labels: []
depends_on: []
blocks: []
notes: ""
```

## Required `packet.yaml` fields

- `id`
- `object_type`
- `title`
- `slug`
- `packet_class`
- `packet_subtype`
- `governance_mode`
- `version`
- `status`
- `owner`
- `priority`
- `active_assignee`
- `definition_of_done`
- `validation_command`
- `validation_status`
- `handoff_note`
- `created_by`
- `created_at`
- `last_updated`
- `started_at`
- `completed_at`
- `parent_project`
- `parent_program`
- `parent_portfolio`
- `labels`
- `depends_on`
- `blocks`
- `notes`

## Required packet sections

- Objective
- Scope
- Out of Scope
- Execution Notes
- Acceptance Criteria
- Validation
- Closeout / Handoff

## Operating rules

- Functional class codes in the folder and primary filename use the LNS class
  token such as `FEAT`, `FIXE`, `DOCS`, or `ARCH`.
- Allowed `status` values are `draft`, `ready`, `active`, `blocked`,
  `in-review`, `done`, and `returned`.
- Allowed `priority` values are `NOW`, `NEXT`, and `LATER`.
- Allowed `governance_mode` values are `Lean`, `Standard`, and `Assured`.
- `active_assignee` must be filled when a packet is `active`, `blocked`,
  `in-review`, or `done`.
