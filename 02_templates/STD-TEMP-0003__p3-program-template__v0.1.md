---
id: STD-TEMP-0003
family: STD-TEMP
version: 0.2
status: active
template_for: program
---

# STD-TEMP-0003 — P3 Program Template
This file is the canonical program-home creation contract for
`luphay-p3-governance`. The Markdown scaffold below, the `entity.yaml` scaffold
below, and the required folder and stub-file set together form the single
source of truth for new program homes. Do not use a separate
`entity-template-program.yaml`.

## Required home contents

- primary `P3-PROG-NNNN__slug__vX.Y.md`
- `entity.yaml`
- `docs/`
- `decisions/`
- `projects/`

## Required `docs/` stubs

- `overview.md`
- `scope.md`
- `roadmap.md`
- `dependencies.md`
- `risks.md`
- `notes.md`

## Primary Markdown scaffold

```markdown
---
id: P3-PROG-NNNN
object_type: program
version: 0.1
status: draft
owner: ""
parent_id: P3-PORT-NNNN
created_on: YYYY-MM-DD
---

# P3-PROG-NNNN — Program Title
## Purpose

Describe the combined outcome this program owns.

## Scope

Describe the delivery boundary and coordination intent.

## Included projects

- None yet.
```

## `entity.yaml` scaffold

```yaml
id: P3-PROG-NNNN
object_type: program
title: ""
slug: ""
version: '0.1'
status: draft
owner: ""
path: 03_portfolios/P3-PORT-NNNN__portfolio-slug/programs/P3-PROG-NNNN__slug
primary_doc: P3-PROG-NNNN__slug__v0.1.md
parent_id: P3-PORT-NNNN
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

- Purpose
- Scope
- Included projects

## Operating rules

- Allowed `status` values are `draft`, `active`, `closing`, `closed`, and
  `archived`.
- `children` lists project folders relative to the program home.
- `path` must match the actual program-home path relative to repo root.
- `primary_doc` must match the actual program governing filename.
