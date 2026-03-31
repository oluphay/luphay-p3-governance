# 06_state

Machine-managed state zone.

## Contract

- `inputs/` is human-authored YAML for cross-cutting concerns that cannot be derived from object-home YAML alone.
- `registers/`, `graph/`, and `audit/` are machine-written outputs.
- Do not manually edit machine-written outputs; regenerate them through `07_scripts/rebuild-state.ps1`.
