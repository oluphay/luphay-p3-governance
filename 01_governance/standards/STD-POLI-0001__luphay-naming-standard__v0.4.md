# Luphay Naming Standard (LNS)

**Document ID:** LNS-0001  
**Version:** v0.4  
**Status:** Draft  
**Supersedes:** LNS v0.3, LNS v0.2, LNS v0.1, TNS v1, SNS v1, SNS Extended v1, IRNS v1, MANS v1, RNS v1  
**Layer:** Operational — daily-driver naming for all Luphay file families  
**Governance layer:** STD-SYS-0001 (FROZEN) governs the enterprise governance tier; LNS governs the operational tier below it. These do not conflict.

---

## Change log

### v0.4 — 2026-03-27
- Added §9 P3MS — P3 Management Standard family covering Portfolio, Program, and Project hierarchy artifacts.
- `P3` added to §3 Quick Prefix Reference.
- Universal formula prefix list updated to include `P3`.
- `PORT`, `PROG`, `PROJ` retire as standalone prefixes in STD-SYS-0001; they become class codes under `P3` in LNS.
- Decision basis: ADR-DECN-0004.

### v0.3 — 2026-03-27
- Renamed §8 family from `REC` to `ADR`.
- Switched ID from date-keyed (`YYYYMMDD`) to sequence (`NNNN`) across all ADR classes.
- Meeting-type classes (`MEET`, `BORD`, `CLNT`, `PERS`, `INTV`, `WORK`) now carry date in slug as convention, not in the ID position.
- Added `DECN` class — formal governance decision records. Replaces `DEC-DEC-[NNNN]` format from STD-SYS-0001. DEC-0002 and DEC-0003 are the last records filed in the old format.
- Added `ARCH` class — Architecture Decision Records (classic ADRs). Replaces `ADR-[NNNN]` format from STD-SYS-0001 §8.7.
- Removed `DECI` class — superseded by `DECN`.
- Updated §3 Quick Prefix Reference: `REC` → `ADR`.
- Updated §9 violation table: retired `REC-*` anti-patterns, added `ADR` equivalents.
- Updated Purpose section and footer.

### v0.2 — 2026-03-27
- Replaced governing-question class codes in §4 (TASK) with TNS functional class codes.
- `OPS_` retired; replaced by `INFR` throughout.
- Added front matter mapping note linking TNS classes to TPS v2.0 `packet_class` field.
- Updated §9 violation table to include `OPS_` → `INFR`.

### v0.1 — 2026-03-27
- Initial release. Consolidated TNS, SNS, SNS Extended, IRNS, MANS, RNS into one document.

---

## Purpose

This is the naming standard you actually use every day. Pick your file family, apply the formula, name the file. Done.

STD-SYS-0001 exists for governance-layer artifacts — policies, frozen standards, audit-grade documents. LNS exists for everything else: tasks, research, media, records, decisions, and architecture records. If you are unsure which applies, use LNS.

---

## 1. The Universal Formula

Every governed file at Luphay follows this pattern:

```
[PREFIX]-[CLASS]-[ID]__[slug]__vX.Y.[ext]
```

| Token | Description | Format |
| :--- | :--- | :--- |
| **PREFIX** | Family identifier. Fixed per family. | `TASK`, `STD`, `INTL`, `MED`, `ADR`, `P3` |
| **CLASS** | Sub-type within the family. Always 4 characters. | `UPPERCASE` |
| **ID** | Unique identifier within the family. | `NNNN` (sequence, all families) |
| `__` | Separator between the identity block and the description. | Double underscore only |
| **slug** | Human-readable description of the file content. | `kebab-case` |
| **vX.Y** | Version. Major.Minor. | `v0.1`, `v1.0`, `v2.3` |
| **ext** | File extension. | `.md`, `.png`, `.svg`, `.mp4`, etc. |

---

## 2. Shared Formatting Rules

These rules apply to every file family without exception.

**Classes must be exactly 4 characters.** No trailing underscores, no padding with symbols. If a natural abbreviation is 3 characters, add a letter. Examples: `OPS` → `INFR`; `BRD` → `BORD`.

**Slugs are lowercase kebab-case only.** Letters, numbers, and hyphens. No spaces. No special characters. No status words (`final`, `new`, `draft`, `latest`).

**Slugs are 2–8 words.** Describe what the file *is*, not what state it is currently in.

**IDs use leading zeros.** Always `0007`, never `7`.

**All families use sequence IDs (`NNNN`).** There are no date-keyed IDs. For meeting-type ADR classes, carry the date in the slug instead — see §8.

**Version uses `vMAJOR.MINOR`.** For meeting-type ADR classes, `vX` (single digit) is acceptable. For external standards, `vYYYY` (publication year) is acceptable. In all other cases use `vX.Y`.

**Separators:** single hyphen `-` inside tokens; double underscore `__` between the identity block and the slug, and between the slug and the version. Never mix.

**Forbidden in filenames:** spaces, `&`, `/`, `\`, `:`, `;`, `,`, `?`, `!`, `()`, `[]`, `{}`, `#`, `@`, single underscore except in template markers.

**Status, owner, priority, and due dates never appear in filenames.** They belong in front matter.

---

## 3. Quick Prefix Reference

| Prefix | Family | ID type | Primary use |
| :--- | :--- | :--- | :--- |
| `TASK` | Task Packets | Sequence | Governed execution work |
| `STD` | Standards | Sequence (or standard number for external) | Policies, procedures, templates, external standards |
| `INTL` | Intelligence & Research | Sequence | Research, analysis, literature, academic notes |
| `MED` | Media & Assets | Sequence | Visual, audio, and design assets |
| `ADR` | Records & Decisions | Sequence | Meeting records, governance decisions, architecture decisions |
| `P3` | P3 Hierarchy | Sequence | Portfolio, Program, and Project specification documents |

---

## 4. TASK — Task Packets

**Formula:**
```
TASK-[CLASS]-[NNNN]__[slug]__vX.Y.md
```

**Class codes** reflect the functional nature of the work — what you are actually doing. Set at intake. Stable for the life of the packet.

### Development & Technical

| Class | Type |
| :--- | :--- |
| `FEAT` | Feature — new functionality or enhancements |
| `FIXE` | Fix — bug fixes, patches, or error corrections |
| `DEBT` | Debt — refactoring, cleanup, or technical debt |
| `RESR` | Research — spikes, feasibility studies, or exploratory work |
| `ARCH` | Architecture — architectural decisions or system design |

### Quality & Operations

| Class | Type |
| :--- | :--- |
| `TEST` | Test — QA plans, automated tests, or bug validation |
| `INFR` | Infrastructure — CI/CD, environments, or infrastructure changes |
| `SECU` | Security — security audits, patching, or compliance tasks |
| `REVN` | Review — peer reviews or formal document approvals |

### Management & Documentation

| Class | Type |
| :--- | :--- |
| `DOCS` | Documentation — technical writing, user guides, or API docs |
| `ADMN` | Admin — meetings, scheduling, or project overhead |
| `DATA` | Data — migrations, modeling, or analytics tasks |

**Governance fields belong in front matter only.** `packet_class` (governing question per TPS v2.0), `packet_subtype`, `governance_mode`, `packet_weight`, and `proof_burden` are governance state — not filename identity. The TNS class and the TPS `packet_class` coexist: the filename carries the functional class you reason with daily; front matter carries the formal governance classification.

**Typical mapping for reference:**

| TNS class | Typical TPS `packet_class` |
| :--- | :--- |
| `FEAT`, `FIXE`, `DEBT`, `DOCS`, `DATA`, `INFR` | `Change` |
| `RESR`, `ARCH` | `Discovery` |
| `TEST`, `SECU`, `REVN` | `Assurance` |
| `ADMN` | `Change` or `Discovery` depending on context |

**Minimum front matter for a task file:**

```yaml
---
id: TASK-0024
title: User Authentication Flow
packet_class: Change
packet_subtype: feature
governance_mode: Standard
status: active
version: v0.1
created_by:
created_at:
---
```

**Examples:**
```
TASK-FEAT-0024__user-authentication-flow__v0.1.md
TASK-FIXE-0089__header-mobile-alignment__v1.1.md
TASK-RESR-0012__vector-database-benchmark__v1.0.md
TASK-INFR-0512__migrate-to-s3-buckets__v0.8.md
TASK-ARCH-0007__define-agent-routing-model__v0.1.md
TASK-SECU-0031__api-key-rotation-policy__v1.0.md
TASK-DOCS-0018__update-onboarding-guide__v0.1.md
TASK-DEBT-0045__refactor-register-loader__v0.1.md
```

---

## 5. STD — Standards

**Formula:**
```
STD-[CLASS]-[NNNN]__[slug]__vX.Y.md
```

### 5.1 Internal classes

| Class | Type |
| :--- | :--- |
| `POLI` | Policy — binding rules and mandatory requirements |
| `PROC` | Procedure — step-by-step SOPs or operational workflows |
| `TEMP` | Template — master files meant to be copied and filled out |
| `CONS` | Constitution — core governance and foundational principles |
| `GUID` | Guideline — suggested best practices or soft rules |
| `REFR` | Reference — static data, glossaries, or technical specifications |

### 5.2 External classes

| Class | Type |
| :--- | :--- |
| `EXTR` | External — industry standards (ISO, NIST, SOC 2, etc.) |
| `REGL` | Regulatory — mandatory laws or regulations (GDPR, HIPAA, etc.) |
| `ADPT` | Adopted — an external standard officially ratified for internal use |

### 5.3 Special rules for external standards

For `EXTR` and `REGL` classes:

- **ID:** use the actual standard number if possible (`27001` for ISO 27001). If the number is longer than 4 digits, use the last 4.
- **Slug:** always start with the issuing body (`iso-`, `nist-`, `eu-`).
- **Version:** publication year is acceptable (`v2015`, `v2022`).

**Examples:**
```
STD-POLI-0015__data-retention-policy__v1.2.md
STD-PROC-1102__new-hire-onboarding-checklist__v1.0.md
STD-TEMP-0442__weekly-report-template__v2.0.md
STD-CONS-0001__organizational-bylaws__v1.0.md
STD-GUID-0003__code-review-best-practices__v1.0.md
STD-EXTR-9001__iso-quality-management__v2015.md
STD-ADPT-7001__iso-infosec-internal-standard__v1.0.md
STD-REGL-0001__eu-general-data-protection-regulation__v1.0.md
```

---

## 6. INTL — Intelligence & Research

**Formula:**
```
INTL-[CLASS]-[NNNN]__[slug]__vX.Y.md
```

| Class | Domain |
| :--- | :--- |
| `MKTA` | Market Analysis — competitor research, industry trends, SWOT |
| `TECH` | Technical — deep dives into frameworks, architecture, engineering specs |
| `ACAD` | Academic — summaries or implementations of papers and journals |
| `REGI` | Regional — geopolitical or economic intelligence |
| `FINA` | Financial — financial engineering, risk models, market data |
| `LITR` | Literature — books, self-study guides, philosophical works |
| `DATA` | Data Science — exploratory analysis, dataset audits, model testing |

**Domain-specific slug conventions:**
- `ACAD`: include the primary author's last name in the slug.
- `REGI`: start the slug with the country code (`sl-` for Sierra Leone, `us-` for United States).

**Version convention:** use `v0.1` for initial bookmarks and raw notes; `v1.0` once synthesized into a usable insight.

**Examples:**
```
INTL-ACAD-0112__vaswani-attention-is-all-you-need__v1.0.md
INTL-REGI-0550__sl-mining-regulatory-landscape__v2.1.md
INTL-FINA-0882__stochastic-volatility-modeling__v0.9.md
INTL-LITR-0048__greene-48-laws-implementation-notes__v1.2.md
INTL-MKTA-0023__competitor-landscape-ai-compliance__v0.2.md
INTL-TECH-0067__vector-database-architecture-review__v1.0.md
```

---

## 7. MED — Media & Assets

**Formula:**
```
MED-[CLASS]-[NNNN]__[slug]__vX.Y.[ext]
```

Note: `[ext]` is the native file format. Do not use `.md` for media files.

| Class | Type |
| :--- | :--- |
| `LOGO` | Logo — primary branding, icons, and wordmarks |
| `UIUX` | Interface — app screens, wireframes, and prototype exports |
| `PHOT` | Photography — general photography or stock images |
| `PRTR` | Portrait — headshots, portraiture, or family sessions |
| `VIDO` | Video — motion graphics, raw footage, or rendered clips |
| `SOCL` | Social — assets sized for LinkedIn, X, YouTube, etc. |
| `ILLU` | Illustration — vector art, diagrams, or generated imagery |
| `DOCU` | Document — scanned IDs, certifications, or non-standard PDFs |

**Version convention:**
- `v0.x` for working/source files (`.psd`, `.fig`, layered files).
- `v1.0+` for final exports (`.png`, `.svg`, `.mp4`).

**Slug convention:** for portraits and headshots, include the subject name in the slug.

**Examples:**
```
MED-LOGO-0001__luphay-primary-wordmark-dark__v1.2.svg
MED-UIUX-0420__draco-dashboard-compliance-view__v0.8.png
MED-PRTR-0882__alpha-kamara-headshot-outdoor__v1.0.jpg
MED-SOCL-0012__youtube-banner-global-commentary__v1.1.png
MED-ILLU-0034__p3-hierarchy-overview-diagram__v1.0.svg
MED-VIDO-0009__luphay-product-demo-q1__v1.0.mp4
```

---

## 8. ADR — Records & Decisions

**Formula:**
```
ADR-[CLASS]-[NNNN]__[slug]__vX.md
```

All ADR files use sequence IDs (`NNNN`). The family contains two kinds of content with different slug and version conventions — meeting-type records and durable decision records.

---

### 8.1 Meeting-type classes

These are temporal records tied to a specific event. Include the date at the start of the slug in `YYYYMMDD` format so files remain scannable and sortable. Version uses a single digit.

| Class | Type |
| :--- | :--- |
| `MEET` | Meeting — internal syncs, team huddles, project updates |
| `BORD` | Board — leadership, stakeholder, or board-level meetings |
| `CLNT` | Client — external meetings with partners, clients, or vendors |
| `PERS` | Personal — 1-on-1s, performance reviews, mentorship sessions |
| `INTV` | Interview — hiring records, candidate feedback, screening notes |
| `WORK` | Workshop — brainstorming sessions, design sprints, strategy workshops |

**Slug convention:** `[YYYYMMDD]-[description]`

**Version convention:**
- `v0` for rough notes taken during the session.
- `v1` for cleaned or approved record distributed to the team.

**Examples:**
```
ADR-MEET-0047__20260327-weekly-engineering-sync__v1.md
ADR-BORD-0012__20260401-q1-portfolio-review-board__v1.md
ADR-CLNT-0008__20260315-acme-corp-onboarding-call__v1.md
ADR-INTV-0031__20260520-software-lead-candidate-review__v0.md
ADR-PERS-0019__20260318-alpha-weekly-checkin__v0.md
ADR-WORK-0005__20260310-p3-governance-design-sprint__v1.md
```

---

### 8.2 Durable decision classes

These are versioned, referenceable records that are not tied to a single event date. Use a descriptive slug with no date. Version uses `vX.Y`.

| Class | Type |
| :--- | :--- |
| `DECN` | Decision — formal governance decision record. Replaces the `DEC-DEC-[NNNN]` format previously governed by STD-SYS-0001 §8.6. |
| `ARCH` | Architecture — Architecture Decision Records (ADRs). Replaces the `ADR-[NNNN]` format previously governed by STD-SYS-0001 §8.7. |

**Note on `DECN` and the 4-character rule.** `DEC` is 3 characters. `DECN` is the conformant 4-character form. The concept is identical — a durable record of a formal decision with rationale, alternatives considered, and follow-on actions.

**Note on backcompatibility.** DEC-0001 through DEC-0003 were filed in the old `DEC-DEC-[NNNN]` format. Those files are not renamed. All new decision records use `ADR-DECN-[NNNN]`. The decision register maps both ID spaces.

**Version convention:** `vX.Y` — decisions are versioned documents, not point-in-time snapshots.

**Examples:**
```
ADR-DECN-0004__adopt-lns-as-operational-naming-layer__v0.1.md
ADR-DECN-0005__lns-formula-wins-standards-and-task-packets__v0.1.md
ADR-ARCH-0001__repo-layout-and-spine-structure__v0.1.md
ADR-ARCH-0002__agent-routing-capability-based-model__v0.1.md
```

---

## 9. P3 — Portfolio, Program, and Project Hierarchy

**Formula:**
```
P3-[CLASS]-[NNNN]__[slug]__vX.Y.md
```

P3MS governs hierarchy specification documents — the Portfolio card, Program card, and Project card that define scope, boundaries, goals, ownership, and milestones for each governance node in the P3 framework.

P3MS does not govern task packets (§4 TASK), registers, review packets, or other artifacts that belong to a project but do not define its identity.

| Class | Type |
| :--- | :--- |
| `PORT` | Portfolio — collection of programs aligned to a strategic objective |
| `PROG` | Program — set of related projects managed for combined benefit |
| `PROJ` | Project — temporary endeavor to create a unique product or capability |

**Version convention:** `v0.x` while the hierarchy node is being scoped; `v1.0` once the node is formally chartered and active.

**Slug convention:** use the entity's short name or code — the name the node is known by inside the organization.

**Examples:**
```
P3-PORT-0001__draco-platform__v0.1.md
P3-PORT-0002__internal-delivery-capability__v1.0.md
P3-PROG-0004__repo-native-governance__v0.1.md
P3-PROG-0007__rules-policy-compilation__v1.0.md
P3-PROJ-0012__task-rollup-engine__v0.1.md
P3-PROJ-0015__p3-governance-hub__v1.0.md
```

**Minimum front matter:**

```yaml
---
id: P3-PORT-0001
title: DRACO Platform Portfolio
class: Portfolio
status: active
version: v1.0
owner:
strategic_horizon: Now | Next | Later
created_by:
created_at:
---
```

---

## 10. Violation Reference

Common naming errors and their fixes.

| Anti-pattern | Problem | Fix |
| :--- | :--- | :--- |
| `TASK-OPS_-0512__...` | Retired class; trailing underscore illegal | Use `INFR` |
| `ADR-BRD_-0012__...` | Trailing underscore in class token | Use `BORD` |
| `ADR-ONE1-0019__...` | Digit in class token; non-standard | Use `PERS` |
| `TASK-FEAT-1024__user-auth-final__v1.0` | Status word in slug (`final`) | Drop `final`; use front matter `status: active` |
| `STD-POLI-0015__data-retention-APPROVED__v1.2` | Status in slug | Remove; use front matter `status: approved` |
| `TASK-CHNG-7__create-register__v1.0` | No leading zeros | Use `0007` |
| `MED-LOGO-0001__luphay logo dark v1.2.svg` | Spaces in filename | Use hyphens and double underscores per formula |
| `TASK-DISC-0011__evaluate-options__v0.1.md` | Governing-question class code (old v0.1 style) | Use TNS functional class — e.g. `RESR` or `ARCH` |
| `REC-MEET-20260327__weekly-sync__v1.md` | Old REC prefix; date in ID position | Use `ADR-MEET-[NNNN]__[YYYYMMDD]-weekly-sync__v1.md` |
| `ADR-MEET-0047__weekly-sync__v1.md` | Meeting-type class missing date in slug | Add date: `ADR-MEET-0047__20260327-weekly-sync__v1.md` |
| `DEC-DEC-0004__...` | Old DEC format (retired after DEC-0003) | Use `ADR-DECN-[NNNN]__[slug]__vX.Y.md` |
| `PORTFOLIO-PORT-0001__...` | Old long-form hierarchy formula | Use `P3-PORT-0001__...` |
| `PROJECT-PROJ-0012__...` | Old long-form hierarchy formula | Use `P3-PROJ-0012__...` |

---

## 11. Front Matter Minimum

Every governed file should carry at minimum:

```yaml
---
id: [FAMILY]-[NNNN]
title: [Human readable title]
status: draft | active | frozen | archived
version: v0.1
created_by:
created_at:
---
```

Task files should additionally carry:

```yaml
packet_class: Discovery | Change | Assurance | Incident | Release
packet_subtype: [e.g. feature, bugfix, spike, compliance_review]
governance_mode: Lean | Standard | Assured
```

Decision records (`ADR-DECN`) should additionally carry:

```yaml
decision_type: [e.g. Governance, Architecture, Operational]
scope_level: Enterprise | Portfolio | Program | Project
effective_date:
related_artifacts:
supersedes:
```

P3 hierarchy documents (`P3-PORT`, `P3-PROG`, `P3-PROJ`) should additionally carry:

```yaml
class: Portfolio | Program | Project
strategic_horizon: Now | Next | Later
owner:
```

Status, owner, priority, and classification live in front matter — never in the filename.

---

*LNS v0.4 — Luphay Technologies — Operational naming layer*  
*Governance layer: STD-SYS-0001 (FROZEN)*  
*Decision basis: DEC-0002, DEC-0003, ADR-DECN-0004*
