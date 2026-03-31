# Recovery

When structure drifts or derived state becomes stale:

1. restore missing canonical files or folders
2. correct source metadata in `entity.yaml`, `packet.yaml`, or `06_state/inputs/*.yaml`
3. run `07_scripts/rebuild-state.ps1`
4. run `07_scripts/validate.ps1`
5. review diffs before promotion
