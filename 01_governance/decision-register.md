# Decision Register

Human-readable authority index for decision records currently retained in the
repo.

Current operating repo truth comes from `04_docs/REPO_BASELINE.md` together
with the root control plane. Enterprise records in `01_governance/decisions/`
are live repo-governance history. Entries under
`03_portfolios/P3-PORT-0001__human-friendly-title/` are scaffold examples for
the sample/template lane only and do not define live operational canon.

Legacy `DEC-*` artifacts remain in `01_governance/decisions/` for traceability
but are outside the active ADR sequence tracked below.

| ID | Family | Scope | Title | Version | Status | Path | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| ADR-ARCH-0001 | ADR-ARCH | Enterprise | Canonical Repo Hierarchy and Navigation Model | v0.1 | active | `01_governance/decisions/ADR-ARCH-0001__canonical-repo-hierarchy-and-navigation-model__v0.1.md` | Current repo architecture record. |
| ADR-DECN-0001 | ADR-DECN | Enterprise | Human Friendly Title | 0.1 | accepted | `01_governance/decisions/ADR-DECN-0001__human-friendly-title__v0.1.md` | Scaffold placeholder retained for history. |
| ADR-DECN-0002 | ADR-DECN | Portfolio | Human Friendly Title | 0.1 | accepted | `03_portfolios/P3-PORT-0001__human-friendly-title/decisions/ADR-DECN-0002__human-friendly-title__v0.1.md` | Sample/template portfolio decision only. |
| ADR-DECN-0003 | ADR-DECN | Program | Human Friendly Title | 0.1 | accepted | `03_portfolios/P3-PORT-0001__human-friendly-title/programs/P3-PROG-0001__human-friendly-title/decisions/ADR-DECN-0003__human-friendly-title__v0.1.md` | Sample/template program decision only. |
| ADR-DECN-0004 | ADR-DECN | Enterprise | Adopt LNS as Operational Naming Layer | v0.1 | accepted | `01_governance/decisions/ADR-DECN-0004__adopt-lns-as-operational-naming-layer__v0.1.md` | Current enterprise decision record. |
| ADR-DECN-0004 | ADR-DECN | Project | Human Friendly Title | 0.1 | accepted | `03_portfolios/P3-PORT-0001__human-friendly-title/programs/P3-PROG-0001__human-friendly-title/projects/P3-PROJ-0001__human-friendly-title/decisions/ADR-DECN-0004__human-friendly-title__v0.1.md` | Sample/template project decision only; ID collides with enterprise `ADR-DECN-0004`. |
| ADR-DECN-0005 | ADR-DECN | Enterprise | LNS Formula Wins for Standards and Task Packets | v0.1 | accepted | `01_governance/decisions/ADR-DECN-0005__lns-formula-wins-standards-and-task-packets__v0.1.md` | Current enterprise decision record. |
| ADR-DECN-0006 | ADR-DECN | Enterprise | Add SPEC (Specification) Class to STD Internal Standards | v0.1 | active | `01_governance/decisions/ADR-DECN-0006__add-spec-class-to-std-internal-standards__v0.1.md` | Metadata is embedded in a fenced YAML block, so machine rebuild may skip it until normalized. |
| ADR-DECN-0007 | ADR-DECN | Enterprise | Canonical Template Contract for Operational Start | v0.1 | accepted | `01_governance/decisions/ADR-DECN-0007__canonical-template-contract-for-operational-start__v0.1.md` | Filename is `0007`, but the current front matter still says `ADR-DECN-0006`. |
| ADR-DECN-0008 | ADR-DECN | Not declared | Refactoring Standard Naming for Playbooks and External IDs | Not declared | decided | `01_governance/decisions/ADR-DECN-0008__refactoring-standard-naming-for-playbooks-external-IDs.md` | Markdown body only; no machine-readable front matter. |
| ADR-DECN-0009 | ADR-DECN | Not declared | Integration of SPEC (Specification) Class | Not declared | decided | `01_governance/decisions/ADR-DECN-0009__integration-of-SPEC-(specification)-class.md` | Markdown body only; no machine-readable front matter. |
| ADR-DECN-0010 | ADR-DECN | Enterprise | Introduce the Luphay Error Standard (LES) | v0.2 | draft | `01_governance/decisions/ADR-DECN-0010__introduce-luphay-error-standard-les__v0_2.md` | Earlier draft retained for history. |
| ADR-DECN-0010 | ADR-DECN | Enterprise | Introduce the Luphay Error Standard (LES) | v0.3 | draft | `01_governance/decisions/ADR-DECN-0010__introduce-luphay-error-standard-les__v0_3.md` | Latest draft currently on disk. |
| ADR-DECN-0011 | ADR-DECN | Enterprise | Add NORM Class to LNS for Normative Definitional Standards | v0.1 | draft | `01_governance/decisions/ADR-DECN-0011__add-norm-class-to-lns__v0_1.md` | Current enterprise draft. |
| ADR-DECN-0012 | ADR-DECN | Not declared | LES Scope Expansion to Governed Failure Semantics | v0.1 | draft | `01_governance/decisions/ADR-DECN-0012__les-scope-expansion-to-governed-failure-semantics__v0_1.md` | Front matter omits `scope_level`. |
| ADR-DECN-0013 | ADR-DECN | Enterprise | Add PACK class to the Luphay Naming Standard | v0.1 | active | `01_governance/decisions/ADR-DECN-0013__add-pack-class-to-lns__v0.1.md` | Current enterprise decision record. |
| ADR-DECN-0014 | ADR-DECN | Not declared | LES Scope Expansion to Governed Failure Semantics | v0.1 | draft | `01_governance/decisions/ADR-DECN-0014__les-scope-expansion-to-governed-failure-semantics__v0_1.md` | Front matter omits `scope_level`; retains lineage note to `STD-REFR-0008`. |
| ADR-DECN-0015 | ADR-DECN | Enterprise | Lock LAMS v2 Draft Baseline | v0.1 | active | `01_governance/decisions/ADR-DECN-0015__lock-lams-v2-draft-baseline__v0.1.md` | Current enterprise decision record. |
