---
id: ADR-DECN-0006
title: Canonical Template Contract for Operational Start
version: v0.1
status: accepted
decision_type: Operational
scope_level: Enterprise
effective_date: 2026-04-02
related_artifacts:
  - 02_templates/STD-TEMP-0001__task-packet-template__v0.1.md
  - 02_templates/STD-TEMP-0002__p3-project-template__v0.1.md
  - 02_templates/STD-TEMP-0003__p3-program-template__v0.1.md
  - 02_templates/STD-TEMP-0004__p3-portfolio-template__v0.1.md
  - 01_governance/playbooks/PBK-PROC-0001__entity-creation-playbook__v0.1.md
  - 07_scripts/validate.ps1
supersedes: ~
created_by: Codex
created_at: 2026-04-02
---

# ADR-DECN-0006 — Canonical Template Contract for Operational Start

**Status:** Accepted
**Effective Date:** 2026-04-02
**Scope:** Enterprise

## 1. Context

`02_templates/` contained two parallel template layers:

- published `STD-TEMP-*` Markdown files that the playbook already treated as
  canonical
- separate loose YAML scaffold files that were not part of the published
  workflow and had already drifted from the live entity and packet schema

That split created an operational blind spot at the exact point where the
system needs to become usable for day-one work. A human or agent could not rely
on a single file in `02_templates/` to create a valid governed object without
cross-checking live examples, scripts, and register shape.

Additional gaps were present:

- the published templates were too thin to scaffold from directly
- entity-home validation existed only indirectly, while task packets had the
  only strong contract enforcement
- pattern files defined required folders but not the exact stub files needed in
  `docs/`

## 2. Decision

The repo adopts the following operating contract for templates:

### 2.1 `STD-TEMP-*` files are the only canonical template source

Each entity type is governed by its matching `STD-TEMP-*` Markdown file in
`02_templates/`. These files are the authoritative creation contract for new
portfolio, program, project, and task-packet homes.

### 2.2 Loose YAML template files are removed from active use

`entity-template-portfolio.yaml`, `entity-template-program.yaml`,
`entity-template-project.yaml`, and `packet-template.yaml` are retired as
duplicate sources of truth and removed from `02_templates/`.

### 2.3 Every canonical template must be executable

Each active `STD-TEMP-*` file must contain:

- the primary Markdown scaffold
- the sibling `entity.yaml` or `packet.yaml` scaffold
- the required subfolder set
- the required `docs/` stub files where applicable
- the status and operating rules needed to create a valid home on first pass

### 2.4 Validation enforces the operational contract

`07_scripts/validate.ps1` becomes the enforcement point for:

- absence of retired duplicate template files
- presence of the canonical `STD-TEMP-*` files
- required entity-home folders and `docs/` stubs
- required entity and packet YAML fields
- packet governance fields needed for live execution

## 3. Rationale

### 3.1 One template contract is required to start operating

The system cannot move from scaffold to live use if template authors and packet
authors have to infer which file is canonical. One visible, documented, and
validated contract removes that ambiguity.

### 3.2 Executable templates reduce creation-time drift

If the template itself includes the exact Markdown skeleton, YAML shape, and
stub file set, a new governed home can be created without consulting multiple
files or reverse-engineering a live example.

### 3.3 Validation must cover entities, not only packets

Operational start depends on portfolio, program, and project homes being just
as structurally reliable as task packets. Extending validation closes that gap
before the repo accumulates more malformed homes.

## 4. Consequences

**Positive:**

- `02_templates/` now has one active source of truth
- new governed homes can be scaffolded directly from published templates
- entity-home creation is more deterministic and easier to validate
- validation catches template drift and missing operational scaffolding earlier

**Constraint introduced:**

- the existing template file paths remain stable during this operational-start
  reconciliation so current references do not break; the canonical contract is
  carried by file content and front-matter version

## 5. Related decisions

- `ADR-DECN-0005` — LNS Formula Wins for Standards and Task Packets
- `ADR-ARCH-0001` — Canonical Repo Hierarchy and Navigation Model

*luphay-p3-governance · decisions/ · ADR-DECN-0006*
