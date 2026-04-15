---
id: STD-TEMP-0004
family: STD-TEMP
version: 0.2
status: active
template_for: portfolio
---

# STD-TEMP-0004 — P3 Portfolio Template
This file is the canonical portfolio-home creation contract for
`luphay-p3-governance`. The Markdown scaffold below, the `entity.yaml` scaffold
below, and the required folder and stub-file set together form the single
source of truth for new portfolio homes. Do not use a separate
`entity-template-portfolio.yaml`.

## Required home contents

- primary `P3-PORT-NNNN__slug__vX.Y.md`
- `entity.yaml`
- `docs/`
- `decisions/`
- `programs/`

## Required `docs/` stubs

- `overview.md`
- `scope.md`
- `roadmap.md`
- `governance.md`
- `dependencies.md`
- `risks.md`
- `notes.md`

## Primary Markdown scaffold

```markdown
---
id: P3-PORT-NNNN
object_type: portfolio
version: 0.1
status: draft
owner: ""
created_on: YYYY-MM-DD
---

# P3-PORT-NNNN — Portfolio Title
## Purpose

Describe the strategic outcome this portfolio owns.

## Scope

Define the operating boundary and horizon.

## Governance

Record the main governance posture, constraints, and decision surface.

## Included programs

- None yet.
```

## `entity.yaml` scaffold

```yaml
id: P3-PORT-NNNN
object_type: portfolio
title: ""
slug: ""
version: '0.1'
status: draft
owner: ""
path: 03_portfolios/P3-PORT-NNNN__slug
primary_doc: P3-PORT-NNNN__slug__v0.1.md
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
- created_on
- updated_on
- labels
- dependencies
- children

## Required primary sections

- Purpose
- Scope
- Governance
- Included programs

## Operating rules

- Allowed `status` values are `draft`, `active`, `closing`, `closed`, and
  `archived`.
- `children` lists program folders relative to the portfolio home.
- `path` must match the actual portfolio-home path relative to repo root.
- `primary_doc` must match the actual portfolio governing filename.
