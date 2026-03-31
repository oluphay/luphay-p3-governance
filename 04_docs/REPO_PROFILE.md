# REPO_PROFILE

Machine-oriented repo profile snapshot for `luphay-p3-governance`.

## Identity

- repo_name: `luphay-p3-governance`
- scaffold_version: `0.4`
- generated_on: `2026-03-29`
- hierarchy_model: `Portfolio -> Program -> Project -> Task Packet`

## Canonical path declarations

```yaml
repo_root: .
governance_library: 01_governance/
templates_root: 02_templates/
portfolios_root: 03_portfolios/
repo_docs: 04_docs/
hub_root: 05_hub/
state_root: 06_state/
scripts_root: 07_scripts/
command_surface: 08_command/
runtime_output: 09_runs/
```

## Current scaffold counts

- portfolios: 1
- programs: 1
- projects: 1
- task_packets: 1
- decisions: 5

## State contract

- source object metadata lives in `entity.yaml` and `packet.yaml`
- cross-cutting human-authored state inputs live in `06_state/inputs/`
- derived JSON registers live in `06_state/registers/`
- relationship graph lives in `06_state/graph/dependency-graph.json`
