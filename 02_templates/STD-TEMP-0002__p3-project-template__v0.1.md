---
id: STD-TEMP-0002
family: STD-TEMP
version: 0.2
status: active
template_for: project
---

# STD-TEMP-0002 — P3 Project Template
This file is the canonical project-home creation contract for
`luphay-p3-governance`. The Markdown scaffold below, the `entity.yaml` scaffold
below, and the required folder and stub-file set together form the single
source of truth for new project homes. Do not use a separate
`entity-template-project.yaml`.

## Required home contents

- primary `P3-PROJ-NNNN__slug__vX.Y.md`
- `entity.yaml`
- `docs/`
- `decisions/`
- `artifacts/`
- `links/`
- `task-packets/`

## Required `docs/` stubs

- `charter.md`
- `scope.md`
- `plan.md`
- `roadmap.md`
- `dependencies.md`
- `risks.md`
- `assumptions.md`
- `notes.md`

## Primary Markdown scaffold

```markdown
---
id: P3-PROJ-NNNN
object_type: project
version: 0.1
status: draft
owner: ""
parent_id: P3-PROG-NNNN
created_on: YYYY-MM-DD
---

# P3-PROJ-NNNN — Project Title
## Charter

Describe the outcome this project is expected to deliver.

## Scope

Define what is inside and outside the project boundary.

## Execution

Summarize the delivery approach and the role task packets will play.

## Dependencies

- None yet.
```

## `entity.yaml` scaffold

```yaml
id: P3-PROJ-NNNN
object_type: project
title: ""
slug: ""
version: '0.1'
status: draft
owner: ""
path: 03_portfolios/P3-PORT-NNNN__portfolio-slug/programs/P3-PROG-NNNN__program-slug/projects/P3-PROJ-NNNN__slug
primary_doc: P3-PROJ-NNNN__slug__v0.1.md
parent_id: P3-PROG-NNNN
created_on: ""
updated_on: ""
labels: []
dependencies: []
children: []
```

## Required `entity.yaml` fields

- ID
- object_type
- title
- slug
- version
- status
- owner
- path
- primary_doc
- parent_id
- created_on
- updated_on
- labels
- dependencies
- children

## Required primary sections

- Charter
- Scope
- Dependencies
- Execution

## Operating rules

- Allowed `status` values are `draft`, `scoped`, `active`, `review`, `closed`,
  and `archived`.
- `children` lists task-packet folders relative to the project home.
- `path` must match the actual project-home path relative to repo root.
- `primary_doc` must match the actual project governing filename.
