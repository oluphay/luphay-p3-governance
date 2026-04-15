---
# ===================================================================
# LAMS Front Matter (self-describing)
# ===================================================================
artifact:
  title: "Luphay Artifact Metadata Standard (LAMS) — Core Specification"
  kind: SPEC
  subtype: METADATA_STANDARD
  artifact_id: "STD-SPEC-0006"
  uid: "<ULID_PENDING_REGISTRY>"
  version: "v2.0.0"
  status: DRAFT
  classification: INTERNAL
  language: en
  format: markdown
  tags: ["lams", "metadata", "governance", "artifact-standard", "agent-contract"]

ownership:
  canonical_author: "Platform Governance / Alpha Kamara"
  authors: ["Alpha Kamara", "AI-assisted drafting"]
  owner_role: "Platform Governance Lead"
  maintainers: ["Platform Governance"]

governance:
  created_at: "2026-04-13T00:00:00Z"
  updated_at: "2026-04-14T00:00:00Z"
  change_policy:
    model: supersede-dont-rewrite
    versioning: semver
    breaking_change_rule: MAJOR
    changelog_required: true

relationships:
  lineage:
    supersedes: ["LUP-LAMS-STD-0001@v1.1.0"]
  inputs:
    - input_id: "STD-NORM-0001"
      version_resolution:
        strategy: semver
        value: "v1.1"
      kind: SPEC
      role: constraint
      missing_input_behavior: REJECT
    - input_id: "STD-NORM-0002"
      version_resolution:
        strategy: semver
        value: "v0.3"
      kind: SPEC
      role: constraint
      missing_input_behavior: REJECT
    - input_id: "STD-SPEC-0007"
      version_resolution:
        strategy: semver
        value: "v2.0.0"
      kind: SPEC
      role: reference
      missing_input_behavior: WARN

graph:
  participation_level: FULL
---

# Luphay Artifact Metadata Standard (LAMS)
## Core Specification

**Document ID:** STD-SPEC-0006
**Legacy alias:** LUP-LAMS-STD-0001
**Version:** v2.0.0
**Status:** DRAFT
**Last Updated:** 2026-04-14
**Canonical Owner:** Platform Governance / Compliance Architecture

---

## 0. Purpose

LAMS defines a **universal, machine-readable metadata header** (front matter) to be embedded at the top of **every Luphay artifact** (Markdown by default, extensible to other formats).

The goal is to give any authorized actor — Human, AI Agent, or System — a **complete operational context** for an artifact:

- **Identity** — stable UID, naming ID, version, status, classification
- **Ownership & authorization** — who can create, modify, publish, and retire
- **Governance** — change policy, review cadence, stability, freshness
- **Portfolio context** — company, division, product, program, project, workstream
- **Intent** — mission, scope, typed constraints, audience, assumptions
- **Relationships** — lineage, inputs with resolution strategies, outputs, where-used
- **Agent contract** — permitted operations, cold-start sequence, failure semantics
- **Operational contract** — execution modes, determinism, failure semantics
- **Traceability** — Req ⇄ Test ⇄ Evidence, conformance runs
- **Security & retention** — PII, access control, sanitization, retention, archive/deletion
- **Integrity & attestation** — hashes, signatures, context commitments
- **Graph integration** — hooks for materialized graph compilation and health propagation

**LAMS as Coordination Control Plane.** LAMS is the governance-first substrate where every artifact is a governed, executable contract; every dependency is resolvable and typed; every action is observable, attributable, and attestable; every agent interaction is policy-bounded; and structural gaps in organizational knowledge are detectable. The artifact — not the agent — is the primary locus of governance. Authority lives in the artifact's LAMS header and the materialized graph, not in agents or external orchestrators.

**v2.0.0 Change Summary.** This version introduces: the materialized graph integration model (graph compilation hooks, UID registry requirements, edge inference rules); the LAMS-STUB profile for legacy artifact integration; ten design invariants elevated to normative requirements; an execution awareness extension surface (optional); a document-wide LES-aligned error handling model; and restructured conformance profiles. See §13 Changelog.

---

## 1. Scope

### 1.1 Applies to
- Specifications, policies, ADRs, PRDs, NFRs
- Runbooks, playbooks, SOPs
- Conformance & test strategy (CTS), RTMs, test plans
- Schemas, datasets, catalogs, registries
- Prompt packs, agent contracts, system manifests
- Reports, assessments, audits, evidence packs
- Legacy artifacts via the LAMS-STUB profile

### 1.2 Does not replace
- Domain content inside the artifact (LAMS is metadata, not the spec itself)
- Implementation-level documentation (kept in engineering docs)
- Jurisdiction/Instrument text (kept in instrument packs)
- The Luphay Error Standard (LES, `STD-NORM-0002`) — LES is autonomous; LAMS adopts LES codes but does not define error taxonomy
- The Luphay Naming Standard (LNS, `STD-NORM-0001`) — LNS governs artifact naming; LAMS governs artifact metadata

### 1.3 Layered capability model (informative summary)

LAMS v2.0.0 addresses Layers 0 and 1 of the LAMS Coordination Control Plane. Higher layers are defined in the companion specification `STD-SPEC-0007`.

| Layer | Name | v2.0.0 Status |
|---|---|---|
| 0 | Static Header (Foundation) | Core normative |
| 1 | Materialized Graph (Knowledge Index) | Core normative |
| 2 | Execution Awareness (Control Plane) | Optional extension (see `STD-SPEC-0007`) |
| 3 | Multi-Actor Coordination | Deferred (see `STD-SPEC-0007`) |
| 4 | Gap Detection & Problem Discovery | Deferred (see `STD-SPEC-0007`) |
| 5 | Adaptive Coordination Substrate | Deferred (see `STD-SPEC-0007`) |

---

## 2. Design Invariants

The following invariants are normative. They apply across all current and future LAMS layers. Implementers, agents, and consumers MUST NOT violate these invariants. Violation of any invariant MUST emit `LES__INVARIANT__VIOLATION__DESIGN-INVARIANT`.

**INV-01: Artifact Sovereignty.** The artifact is the primary locus of governance. Agents do not possess inherent authority — authority is granted, restricted, and verified against the artifact's LAMS header. The artifact, not the agent, is the organizational citizen.

**INV-02: Explicitness Over Inference for Critical State.** For critical fields — UID, version, status, invariant constraints — the system MUST use declared values, never inferred ones. On ambiguity, the system halts rather than guesses.

**INV-03: Contract-Driven Agent Behavior.** Agent execution MUST always be gated (`agent_execution_permitted`), limited by permitted operations, and governed by explicit failure semantics. An agent that cannot determine its permissions on an artifact MUST halt and escalate.

**INV-04: Graph Integrity Over Speed.** A correct graph is more valuable than a fast graph. If the graph declares that artifact A depends on artifact B, then B MUST exist, be resolvable, and be in a compatible state. Incomplete graphs degrade gracefully; incorrect graphs are prohibited.

**INV-05: Graceful Degradation.** Higher layers MUST degrade gracefully when lower layers are incomplete. If the graph is partially materialized, operations still function for the materialized portions. Each layer is additive, never breaking.

**INV-06: Human Escalation Always Available.** At every layer, there MUST be a path from automated action to human judgment. The `agent_contract.escalation_path` is the seed; this principle survives into all future coordination, detection, and self-healing capabilities.

**INV-07: Schema Continuity.** Every expansion MUST be expressible as an extension of the LAMS YAML schema, not a replacement. A LAMS v1.1 header MUST remain valid and interpretable in a v2.0.0-compliant system, even if it does not use v2.0.0 features. Forward compatibility is non-negotiable.

**INV-08: Audit Trail Is Permanent.** Every action taken by any actor on any artifact MUST be recorded in an append-only log when execution awareness (Layer 2+) is active. The audit trail is never optional, never truncated, and never overwritten.

**INV-09: Sanitization Scales With Power.** As agents gain more capability, sanitization and injection protection MUST scale correspondingly. LAMS-MUST-12 is the seed; at higher layers, protection MUST be proportionally stronger.

**INV-10: Header First.** Every layer builds on the foundation that every artifact has a structured, machine-readable header. If the header is not present, nothing above works. There is no "post-header" architecture.

---

## 3. Normative Requirements (MUST rules)

### 3.1 Preserved from v1.1.0

**LAMS-MUST-01** Every artifact MUST include a LAMS header at the top of the file.

**LAMS-MUST-02** `artifact.uid` MUST be globally unique and MUST NOT change across moves/renames. On UID collision or resolution failure, agents MUST surface the conflict and halt — not proceed with inference.

**LAMS-MUST-03** `artifact.artifact_id` MUST follow Luphay naming conventions (LNS `STD-NORM-0001`).

**LAMS-MUST-04** `artifact.version`, `artifact.status`, and `governance.change_policy` MUST be present.

**LAMS-MUST-05** If `artifact.status` is `FROZEN` or `ACTIVE` (release-grade), `integrity.content_hash.sha256` MUST be populated. LAMS-LITE artifacts reaching `ACTIVE` status MUST undergo a mandatory header upgrade to LAMS-STD before the status transition is permitted.

**LAMS-MUST-06** If an artifact depends on other artifacts, it MUST list them in `relationships.inputs`. Each input MUST declare `version_resolution.strategy` and `missing_input_behavior`.

**LAMS-MUST-07** If other artifacts depend on this artifact (known), it MUST list them in `relationships.where_used`.

**LAMS-MUST-08** If an artifact produces downstream artifacts, it MUST list them in `relationships.outputs`.

**LAMS-MUST-09** Access control MUST be declared for any artifact classified above INTERNAL.

**LAMS-MUST-10** If the artifact makes conformance claims, `traceability.conformance` MUST be populated.

**LAMS-MUST-11** Every artifact intended for agentic consumption MUST populate `agent_contract`. If `agent_contract` is absent, agents MUST treat the artifact as non-executable and surface a governance warning.

**LAMS-MUST-12** Freetext fields (mission, assumptions, notes, use_cases, scope.excludes) MUST NOT contain executable syntax, prompt-injection patterns, or instructions addressed to an LLM. Enforcement is via CI lint rule `LAMS-LINT-SANITIZE-01`.

**LAMS-MUST-13** Any assumption or scope exclusion with `constraint_class: INVARIANT` MUST be evaluated by an agent before any action is taken on the artifact. Invariant violation MUST result in `REJECT` behavior — agents MUST NOT proceed on inference.

### 3.2 New in v2.0.0

**LAMS-MUST-14** Every artifact MUST declare `graph.participation_level` indicating whether the artifact participates in the materialized graph and at what fidelity. Valid values: `FULL`, `HEADER_ONLY`, `EXCLUDED`. Default if absent: `HEADER_ONLY`.

**LAMS-MUST-15** Implementations that compile the materialized graph MUST infer reverse edges: if artifact A declares artifact B as an input, the graph MUST automatically register A as a consumer of B. Inferred edges MUST be reported separately from declared edges.

**LAMS-MUST-16** UID generation MUST use ULID or UUIDv7 to ensure temporal ordering and global uniqueness. Both formats are permitted; implementations MUST accept either. A conformant implementation MUST provide a UID registry with collision detection.

**LAMS-MUST-17** LAMS-STUB artifacts MUST be explicitly marked as `profile: STUB` and `agent_execution_permitted: false`. LAMS-STUB artifacts MUST NOT declare `conformance_claim: PARTIAL` or `FULL`.

**LAMS-MUST-18** When `artifact.status` transitions from one state to another, the transition MUST be a valid transition in the LAMS lifecycle model (§5.5). Invalid transitions MUST be rejected.

**LAMS-MUST-19** Implementations MUST emit a structured error code from the LES registry (`STD-NORM-0002`) for every LAMS-MUST rule violation. Ad hoc error identifiers are prohibited. Codes at CONDITIONAL stage in LES MUST be used as specified; implementations MUST NOT substitute local identifiers while codes are pending full acceptance.

**LAMS-MUST-20** The design invariants declared in §2 MUST NOT be violated by any conformant implementation, agent, or consuming system at any layer.

---

## 4. LAMS Front Matter Template (YAML)

> Copy/paste this block at the top of your Markdown artifact. Fields marked `# REQUIRED` must be populated. Fields marked `# AGENT-CRITICAL` are evaluated first by agents during cold-start. Fields marked `# NEW v2.0` are additions in this version.

```yaml
---
# ===================================================================
# Luphay Artifact Metadata Standard (LAMS) — v2.0
# Governing specification: STD-SPEC-0006
# Agentic consumption: governed via agent_contract section (§6a)
# Graph participation: governed via graph section (§6b)
# ===================================================================

# 0) Artifact Identity (non-negotiable)
artifact:
  title: "<HUMAN_READABLE_TITLE>"                                         # REQUIRED
  kind: "<SPEC|POLICY|ADR|PRD|NFR|DESIGN|RUNBOOK|PLAYBOOK|TEST_PLAN|CTS|RTM|DATASET|SCHEMA|PROMPT|REPORT|CODE_MANIFEST|OTHER>"  # REQUIRED
  subtype: "<OPTIONAL_MORE_SPECIFIC_TYPE>"
  artifact_id: "<ORG-NAMING-ID>"                                          # REQUIRED | AGENT-CRITICAL
  uid: "<ULID_OR_UUIDV7>"                                                 # REQUIRED | AGENT-CRITICAL — MUST NOT change across renames/moves — both ULID and UUIDv7 accepted
  version: "v<MAJOR>.<MINOR>.<PATCH>"                                     # REQUIRED | AGENT-CRITICAL
  status: "<DRAFT|ACTIVE|FROZEN|DEPRECATED|ARCHIVED>"                     # REQUIRED | AGENT-CRITICAL
  classification: "<PUBLIC|INTERNAL|CONFIDENTIAL|PROPRIETARY|RESTRICTED>" # REQUIRED
  language: "en"
  format: "markdown"
  canonical_path: "<REPO_PATH_OR_URI>"
  tags: ["<DOMAIN_TAG>", "<PRODUCT_TAG>", "<TOPIC_TAG>"]

# 1) Ownership & Authorization
ownership:
  canonical_author: "<PERSON_OR_SYSTEM_OF_RECORD>"
  authors: ["<PERSON|AGENT|SYSTEM>"]
  owner_role: "<FUNCTIONAL_OWNER_ROLE>"
  maintainers: ["<TEAM_OR_ROLE>"]
  approvers:
    required_roles: ["<ARCH_OWNER>", "<SEC_OWNER>", "<QA_CONFORMANCE_OWNER>", "<COMPLIANCE_OWNER>"]
    approved_by: ["<NAME_OR_SYSTEM>"]
    approved_at: "<ISO_8601_ZULU_OR_LOCAL>"
  authorized_actors:
    create: ["<ROLE|TEAM|AGENT_CLASS>"]
    modify: ["<ROLE|TEAM|AGENT_CLASS>"]
    publish: ["<ROLE|TEAM|AGENT_CLASS>"]
    retire: ["<ROLE|TEAM|AGENT_CLASS>"]

# 2) Time, Change Control, Stability, and Freshness
governance:
  created_at: "<ISO_8601>"                                                # REQUIRED
  updated_at: "<ISO_8601>"                                                # REQUIRED
  effective_date: "<ISO_8601_OR_EMPTY>"
  review_cycle: "<quarterly|semiannual|annual|ad-hoc>"
  next_review_at: "<ISO_8601_OR_EMPTY>"
  change_policy:
    model: "<supersede-dont-rewrite|living-doc|append-only>"
    versioning: "<semver|calendar|commit-based>"
    breaking_change_rule: "<MAJOR|explicit_approval_required>"
    changelog_required: true
  stability:
    normative_keywords: ["MUST", "MUST NOT", "SHOULD", "SHOULD NOT", "MAY"]
    sections:
      - name: "<SECTION_NAME>"
        stability: "<Invariant|Stable|Evolving|Experimental>"
  freshness:
    max_age: "<e.g., 90_days|30_days|indefinite>"                        # AGENT-CRITICAL
    staleness_check_required: true
    agent_freshness_behavior: "<WARN|REJECT|PROCEED>"                    # AGENT-CRITICAL
    freshness_check_artifact_id: "<REGISTRY_OR_INDEX_ID_OR_EMPTY>"

# 3) Project & Portfolio Context
portfolio:
  company: "Luphay Technologies"
  division: "<DIVISION_OR_LINE_OF_BUSINESS>"
  product: "<PRODUCT_NAME_OR_FAMILY>"
  program: "<PROGRAM_NAME_OR_EMPTY>"
  project:
    project_id: "<PROJECT_ID>"
    project_name: "<PROJECT_NAME>"
    project_repo: "<REPO_URI_OR_NAME>"
    project_home: "<DOC_OR_PATH>"
  workstream: "<WORKSTREAM_OR_EMPTY>"
  sprint_or_milestone: "<MILESTONE_OR_EMPTY>"

# 4) Purpose & Scope (human + machine clarity)
# CONSTRAINT CLASS RULES:
#   constraint_class: INVARIANT — agent MUST evaluate before any action; violation = REJECT
#   constraint_class: CONTEXT   — informational; agent may continue if not met
intent:
  mission: "<ONE_PARAGRAPH_PURPOSE>"
  scope:
    includes: ["<WHAT_THIS_COVERS>"]
    excludes:
      - value: "<WHAT_THIS_EXPLICITLY_DOES_NOT_COVER>"
        constraint_class: "<INVARIANT|CONTEXT>"
  audience: ["Engineering", "Security", "Compliance", "Audit", "Product", "Operations"]
  use_cases: ["<PRIMARY_USE_CASE_1>"]
  assumptions:
    - id: "ASSUMP-01"
      value: "<ASSUMPTION_TEXT>"
      constraint_class: "<INVARIANT|CONTEXT>"
  definitions_ref: ["<GLOSSARY_ARTIFACT_ID_OR_URI>"]

# 5) Relationships & Lineage
relationships:
  lineage:
    supersedes: ["<ARTIFACT_ID@VERSION>"]
    derived_from: ["<ARTIFACT_ID@VERSION>"]
    forks_from: ["<ARTIFACT_ID@VERSION>"]
    related: ["<ARTIFACT_ID@VERSION>"]
  inputs:
    - input_id: "<ARTIFACT_ID_OR_DATASET_ID>"                            # AGENT-CRITICAL
      version_resolution:
        strategy: "<semver|commit|hash|latest>"
        value: "<VERSION_STRING_OR_COMMIT_OR_HASH>"
      kind: "<SPEC|DATASET|REG_TEXT|POLICY|CODE|OTHER>"
      role: "<source_of_truth|reference|constraint|test_vector|context_pack>"
      location: "<URI_OR_PATH>"
      missing_input_behavior: "<REJECT|WARN|SKIP>"                       # AGENT-CRITICAL
      integrity:
        sha256: "<OPTIONAL_HASH>"
        signature: "<OPTIONAL_SIG>"
      notes: "<WHY_THIS_INPUT_MATTERS>"
  outputs:
    - output_id: "<ARTIFACT_ID_OR_DATASET_ID>"
      kind: "<SPEC|TABLE|SCHEMA|CODE|RUN_LOG|EVIDENCE_PACK|OTHER>"
      location: "<URI_OR_PATH>"
      consumers: ["<PROJECT_ID>", "<TEAM>"]
      notes: "<WHAT_IT_ENABLES>"
  where_used:
    - consumer_project_id: "<PROJECT_ID>"
      consumer_artifact_id: "<ARTIFACT_ID>"
      usage_type: "<normative_dependency|informative_reference|runtime_dependency|compliance_evidence|test_dependency>"
      notes: "<HOW_IT_IS_USED>"

# 6a) Agent Contract
agent_contract:
  agent_execution_permitted: "<true|false>"                               # AGENT-CRITICAL
  permitted_operations:
    - "<read_for_context>"
    - "<read_for_execution>"
    - "<modify_with_approval>"
    - "<modify_autonomously>"
    - "<reference_in_generation>"
  cold_start_sequence:
    - "artifact.uid"
    - "artifact.version"
    - "artifact.status"
    - "governance.freshness"
    - "agent_contract.agent_execution_permitted"
    - "agent_contract.permitted_operations"
    - "intent.assumptions[constraint_class=INVARIANT]"
    - "intent.scope.excludes[constraint_class=INVARIANT]"
    - "relationships.inputs"
    - "security.sanitization.agent_visible_fields"
    - "graph.participation_level"                                         # NEW v2.0
  hard_constraints:
    - constraint_id: "<ASSUMP-01|SCOPE-EXCL-01>"
      description: "<HUMAN_READABLE_CONSTRAINT>"
      violation_behavior: "REJECT"
  failure_semantics:
    on_missing_agent_contract: "REJECT"
    on_stale_artifact: "<WARN|REJECT|PROCEED>"
    on_invariant_violation: "REJECT"
    on_unresolvable_uid: "REJECT"
    on_unresolvable_input: "<REJECT|WARN|SKIP>"
  version_conflict_behavior: "<REJECT|WARN_AND_USE_DECLARED|USE_LOCAL>"
  escalation_path: "<SLACK_CHANNEL|TICKET_SYSTEM|HUMAN_ROLE|EMPTY>"

# 6b) Graph Integration (NEW v2.0)
graph:
  participation_level: "<FULL|HEADER_ONLY|EXCLUDED>"                      # REQUIRED | AGENT-CRITICAL — NEW v2.0
  # FULL: all relationship and identity fields are compiled into the materialized graph
  # HEADER_ONLY: identity fields only; relationships not compiled
  # EXCLUDED: artifact does not appear in the materialized graph
  health_propagation:
    propagate_staleness: true                                              # when this artifact's freshness expires, downstream consumers are notified
    propagate_conformance: true                                            # when this artifact's conformance state changes, downstream consumers are notified
  graph_metadata:
    fanout_class: "<LOW|MEDIUM|HIGH|CRITICAL>"                            # informative — indicates how many downstream consumers depend on this artifact
    # HIGH/CRITICAL fanout artifacts SHOULD receive stricter review requirements

# 7) Operational Contract
operations:
  lifecycle_stage: "<design|build|run|audit|retire>"
  execution_modes: ["<compile>", "<run>", "<referee>", "<replay>"]
  determinism:
    required: "<true|false>"
    definition: "<WHAT_DETERMINISM_MEANS_FOR_THIS_ARTIFACT_TYPE>"
    test_artifact_id: "<TEST_PLAN_ID_OR_EMPTY>"
    agent_violation_behavior: "<REJECT|WARN>"
  replay_required: true
  failure_semantics: ["REJECT", "LOCK", "WARN"]
  required_tools:
    - name: "<TOOL_NAME>"
      version: "<PINNED_VERSION_OR_RANGE>"
      role: "<authoring|build|test|publish|audit>"
  entrypoints:
    - name: "<HOW_TO_EXECUTE_OR_VALIDATE>"
      command: "<CLI_OR_RUNNER_REFERENCE>"
      inputs: ["<INPUT_IDS>"]
      outputs: ["<OUTPUT_IDS>"]

# 8) Traceability & Evidence
traceability:
  id_prefixes:
    requirement: "REQ-"
    control: "CTRL-"
    test: "TS-"
    evidence: "EVID-"
    change: "CHG-"
  rtm:
    required: true
    rtm_artifact_id: "<RTM_ARTIFACT_ID_OR_EMPTY>"
  conformance:
    conformance_claim: "<NONE|PARTIAL|FULL>"
    suite_artifact_id: "<CTS_OR_TEST_SUITE_ID>"
    last_conformance_run:
      run_id: "<RUN_ID_OR_EMPTY>"
      status: "<PASS|FAIL|N/A>"
      run_at: "<ISO_8601_OR_EMPTY>"
  evidence_links: ["<EVIDENCE_PACK_ID_OR_URI>"]

# 9) Security, Privacy, Compliance, and Sanitization Posture
security:
  data_sensitivity: "<NONE|LOW|MODERATE|HIGH>"
  pii: "<none|possible|present>"
  secrets: "<none|possible|present>"
  encryption_required: "<at_rest|in_transit|both|none>"
  access_control:
    read: ["<ROLE|TEAM>"]
    write: ["<ROLE|TEAM>"]
    admin: ["<ROLE|TEAM>"]
  legal_basis_or_policy_refs: ["<POLICY_ID_OR_URI>"]
  jurisdiction: ["<US-PA>", "<EU>"]
  sanitization:
    lint_rule: "LAMS-LINT-SANITIZE-01"
    agent_visible_fields:
      - "artifact.uid"
      - "artifact.version"
      - "artifact.status"
      - "artifact.kind"
      - "artifact.title"
      - "governance.freshness"
      - "intent.mission"
      - "intent.scope"
      - "intent.assumptions"
      - "relationships.inputs"
      - "agent_contract"
      - "graph"                                                           # NEW v2.0
    agent_excluded_fields:
      - "integrity.signatures"
      - "retention.archival_location"
      - "security.access_control"
      - "release_stamp"
    freetext_fields_requiring_scan:
      - "intent.mission"
      - "intent.use_cases"
      - "intent.assumptions[].value"
      - "intent.scope.excludes[].value"
      - "relationships.inputs[].notes"
      - "relationships.outputs[].notes"
      - "relationships.where_used[].notes"

# 10) Retention, Archival, and Deletion
retention:
  policy_id: "<RETENTION_POLICY_ID>"
  retention_period: "<e.g., 7_years|90_days|indefinite>"
  legal_hold_capable: true
  archival_location: "<WORM_VAULT_URI_OR_PATH>"
  deletion_protocol: "<PROCESS_OR_TICKET_FLOW>"

# 11) Integrity / Attestation
integrity:
  canonicalization_rule: "<CANON_RULESET_ID_OR_EMPTY>"
  content_hash:
    sha256: "<64HEX_OR_EMPTY>"
  signatures:
    - signer: "<SYSTEM_OR_KEY_ID>"
      alg: "<SIG_ALG_OR_EMPTY>"
      sig: "<BASE64_OR_EMPTY>"
  context_commitment:
    policy_context_hash: "<HASH_OR_EMPTY>"
    environment_fingerprint: "<OPTIONAL>"

# 12) Release Stamp
release_stamp:
  release_id: "<REL_ID_OR_EMPTY>"
  released_by: "<PERSON|AGENT|SYSTEM>"
  released_at: "<ISO_8601_OR_EMPTY>"
  notes: "<SHORT_RELEASE_NOTES>"
  changelog:
    - "CHG-001: <WHAT_CHANGED>"
---
```

---

## 5. Profiles

### 5.1 LAMS-STUB (NEW in v2.0.0)

For legacy artifacts that cannot receive a full LAMS header but must appear as nodes in the materialized graph.

**Required fields:** `artifact.uid`, `artifact.title`, `artifact.artifact_id` (may be auto-generated from filename), `artifact.status` (MUST be `LEGACY`), `artifact.classification`, `graph.participation_level` (MUST be `HEADER_ONLY`).

**Restrictions:**
- `agent_execution_permitted` MUST be `false`
- STUB artifacts MUST NOT declare `conformance_claim: PARTIAL` or `FULL`
- STUB artifacts MUST NOT declare any `constraint_class: INVARIANT` assumptions
- STUB relationship data is treated as low-confidence by the graph compiler
- STUB artifacts are explicitly marked in the graph as low-confidence nodes
- STUB artifacts MAY be auto-generated from existing metadata (filenames, git history, directory structure)

**Upgrade path:** STUBs may be upgraded to LITE or STD as the artifact is reviewed. Upgrade requires manual population of required fields for the target profile.

### 5.2 LAMS-LITE

For lightweight artifacts where full header overhead is not warranted.

**Permitted fields:** `artifact`, `ownership`, `governance` (excluding `freshness`), `portfolio.project`, `intent.mission`, `intent.assumptions` (CONTEXT class only), `relationships.inputs` (required), `relationships.where_used` (required), `graph.participation_level` (defaults to `HEADER_ONLY`).

**Restrictions:**
- `agent_execution_permitted` MUST be set to `false` for all LAMS-LITE artifacts
- LAMS-LITE artifacts MUST NOT declare `conformance_claim: FULL`
- LAMS-LITE artifacts MUST NOT graduate to `ACTIVE` or `FROZEN` status without a full header upgrade to LAMS-STD (enforced via LAMS-MUST-05)
- `INVARIANT`-class assumptions MUST NOT appear in LAMS-LITE headers; reclassify as CONTEXT or upgrade to LAMS-STD
- LAMS-LITE artifacts MAY participate in the graph at `HEADER_ONLY` level but MUST NOT set `participation_level: FULL` without upgrading to LAMS-STD

### 5.3 LAMS-STD

Full header. Recommended default for all governed artifacts. All fields available. `graph.participation_level` defaults to `FULL`.

### 5.4 LAMS-RELEASE

Full header + `integrity.content_hash.sha256` populated + all `approvers` populated + `release_stamp` populated. Required for artifacts in `FROZEN` status.

### 5.5 Profile precedence and lifecycle model

```
STUB → LITE → STD → RELEASE
```

Each upgrade requires populating the additional mandatory fields of the target profile. Downgrades are prohibited for artifacts in `ACTIVE` or `FROZEN` status.

**Valid status transitions:**

```
DRAFT → ACTIVE → FROZEN
DRAFT → ACTIVE → DEPRECATED → ARCHIVED
DRAFT → DEPRECATED → ARCHIVED
ACTIVE → DEPRECATED → ARCHIVED
FROZEN → DEPRECATED → ARCHIVED
LEGACY (STUB only — no transitions out without profile upgrade)
```

Invalid transitions MUST be rejected per LAMS-MUST-18 with `LES__LIFECYCLE__INVALID__STATUS-TRANSITION`.

---

## 6. Agent Consumption Protocol (Human-Readable Reference)

This section describes how a conformant agent MUST consume a LAMS artifact. It is the plain-language equivalent of `agent_contract`.

### Step 1 — Cold-start sequence
Agent resolves fields in the order declared in `agent_contract.cold_start_sequence`. Fields not in the sequence are background context and may be deferred.

### Step 2 — Execution gate
Agent checks `agent_contract.agent_execution_permitted`. If `false`, the agent treats the artifact as read-only reference and surfaces a governance notice. No further agentic action is taken.

### Step 3 — Freshness check
Agent compares `governance.updated_at` against `governance.freshness.max_age`. If stale, agent applies `governance.freshness.agent_freshness_behavior` and emits `LES__LIFECYCLE__STALE__ARTIFACT`.

### Step 4 — Invariant evaluation
Agent evaluates all `constraint_class: INVARIANT` entries in `intent.assumptions` and `intent.scope.excludes`. Any violation → `REJECT` with `LES__INVARIANT__VIOLATION__HARD-CONSTRAINT`. Agent MUST NOT substitute inference for a violated invariant.

### Step 5 — Input resolution
For each entry in `relationships.inputs`, agent resolves using `version_resolution.strategy`. If an input is unresolvable, agent applies the declared `missing_input_behavior` for that input, falling back to `agent_contract.failure_semantics.on_unresolvable_input`. Unresolvable inputs emit `LES__DEPENDENCY__UNRESOLVED__REQUIRED-ARTIFACT`.

### Step 6 — Permitted operation check
Agent verifies that the intended operation is listed in `agent_contract.permitted_operations`. If not listed, agent halts with `LES__AUTHORIZATION__DENIED__REQUIRED-APPROVAL` and escalates via `agent_contract.escalation_path`.

### Step 7 — Sanitization
Agent restricts its read scope to fields listed in `security.sanitization.agent_visible_fields`. Freetext fields listed in `freetext_fields_requiring_scan` are scanned for injection patterns before processing. Scan failure emits `LES__SANITIZATION__FAILED__CONTENT-SCAN`.

### Step 8 — Graph context resolution (NEW v2.0)
If `graph.participation_level` is `FULL` or `HEADER_ONLY`, the agent MAY query the materialized graph (per `STD-SPEC-0007`) for transitive dependencies, downstream consumers, and health signals before executing operations. This step is informative for v2.0.0 and becomes mandatory when execution awareness (Layer 2) is adopted.

---

## 7. Recommended Standard Sections (Optional but Strongly Recommended)

After the front matter, prefer a predictable human layout:

```markdown
## 0. Executive Summary
## 1. Mission & Scope
## 2. Artifact Role in the Portfolio
## 3. Inputs (Source-of-Truth Pack)
## 4. Outputs (Produced Artifacts / Tables / Run Logs)
## 5. Where-Used (Downstream Consumers)
## 6. Agent Contract Summary (plain-language version of agent_contract block)
## 7. Operational Contract (How to Validate / Execute)
## 8. Traceability (Req ⇄ Test ⇄ Evidence)
## 9. Security / Privacy / Retention Notes
## 10. Graph Integration Notes (NEW v2.0)
## 11. Changelog
```

---

## 8. Conformance

### 8.1 Conformance levels

| Level | Meaning |
|---|---|
| **LAMS-CONFORM-HEADER** | Artifact contains a valid LAMS header conforming to the declared profile (STUB, LITE, STD, or RELEASE). All applicable MUST rules for that profile are satisfied. |
| **LAMS-CONFORM-GRAPH** | Artifact header is compilable by a conformant graph compiler (`STD-SPEC-0007`). All relationship fields are resolvable or declare appropriate `missing_input_behavior`. Graph hooks are populated. |
| **LAMS-CONFORM-FULL** | Both HEADER and GRAPH conformance are satisfied. Agent consumption protocol is fully supported. |

### 8.2 Conformance claims

Artifacts declare their conformance posture in `traceability.conformance.conformance_claim`:
- `NONE` — no conformance claim made
- `PARTIAL` — partial conformance; `suite_artifact_id` MUST reference the applicable test suite. Incomplete claims emit `LES__TRACEABILITY__INCOMPLETE__CONFORMANCE-CLAIM` as ADVISORY.
- `FULL` — full conformance; `suite_artifact_id` MUST reference the applicable test suite and `last_conformance_run` MUST be populated. Incomplete FULL claims emit `LES__TRACEABILITY__INCOMPLETE__CONFORMANCE-CLAIM` as REJECT.

---

## 9. Error Handling Model (LES Alignment)

LAMS v2.0.0 adopts the Luphay Error Standard (LES, `STD-NORM-0002` v0.3) as the exclusive error naming system for all governed failure conditions. LAMS does not define its own error taxonomy.

### 9.1 Principles

1. LAMS failure modes map to LES codes from the normative registry.
2. All 12 LAMS-petitioned codes were conditionally accepted in LES v0.2 and remain conditionally accepted in LES v0.3 via `TASK-CHNG-0001`. Conditional acceptance means: codes are in the registry and implementations MUST use them; they become fully locked when `STD-SPEC-0006` reaches ACTIVE status.
3. Error codes emitted by LAMS-conformant implementations MUST be syntactically conformant LES codes per `STD-NORM-0002` §4.
4. Implementations MUST NOT define ad hoc error identifiers for failure conditions that are covered by a LES code.

### 9.2 LAMS failure mode → LES mapping

| LAMS Failure Mode | Triggering MUST Rule | LES Code | LES Stage | Agent Behavior |
|---|---|---|---|---|
| Missing LAMS header | LAMS-MUST-01 | `LES__INPUT__MISSING__REQUIRED-INPUT` | SEED | REJECT |
| UID collision or resolution failure | LAMS-MUST-02 | `LES__IDENTITY__MISMATCH__ARTIFACT-ID` | SEED | REJECT |
| UID inference attempted | LAMS-MUST-02 | `LES__IDENTITY__MISMATCH__ARTIFACT-ID` | SEED | REJECT |
| artifact_id naming violation | LAMS-MUST-03 | `LES__IDENTITY__INVALID__ARTIFACT-ID` | CONDITIONAL | REJECT |
| Missing required field (version, status, change_policy) | LAMS-MUST-04 | `LES__INPUT__MISSING__REQUIRED-INPUT` | SEED | REJECT |
| Missing content hash on ACTIVE/FROZEN | LAMS-MUST-05 | `LES__INTEGRITY__MISSING__CONTENT-HASH` | CONDITIONAL | BLOCKING for lifecycle promotion; ADVISORY in DRAFT |
| LITE promotion without header upgrade | LAMS-MUST-05 | `LES__LIFECYCLE__PREMATURE__STATUS-TRANSITION` | CONDITIONAL | REJECT |
| Missing input declaration | LAMS-MUST-06 | `LES__INPUT__MISSING__REQUIRED-INPUT` | SEED | REJECT |
| Missing version_resolution on input | LAMS-MUST-06 | `LES__CONFIGURATION__MISSING__REQUIRED-PROFILE` | SEED | REJECT |
| Missing where_used declaration | LAMS-MUST-07 | `LES__TRACEABILITY__MISSING__CONSUMER-LINK` | CONDITIONAL | ADVISORY; BLOCKING for ACTIVE/FROZEN in Assured mode |
| Missing output declaration | LAMS-MUST-08 | `LES__TRACEABILITY__MISSING__OUTPUT-LINK` | CONDITIONAL | ADVISORY; BLOCKING for ACTIVE/FROZEN in Assured mode |
| Missing access control above INTERNAL | LAMS-MUST-09 | `LES__AUTHORIZATION__DENIED__REQUIRED-APPROVAL` | SEED | REJECT |
| Missing conformance declaration | LAMS-MUST-10 | `LES__TRACEABILITY__INCOMPLETE__CONFORMANCE-CLAIM` | CONDITIONAL | REJECT for FULL claims; ADVISORY for PARTIAL |
| Missing agent_contract on agentic artifact | LAMS-MUST-11 | `LES__CONFIGURATION__MISSING__REQUIRED-PROFILE` | SEED | REJECT |
| Injection pattern in freetext | LAMS-MUST-12 | `LES__SANITIZATION__FAILED__CONTENT-SCAN` | SEED | REJECT |
| Invariant violation | LAMS-MUST-13 | `LES__INVARIANT__VIOLATION__HARD-CONSTRAINT` | CONDITIONAL | REJECT |
| Missing graph participation level | LAMS-MUST-14 | `LES__CONFIGURATION__MISSING__REQUIRED-PROFILE` | SEED | REJECT |
| Graph reverse-edge inference failure | LAMS-MUST-15 | `LES__DEPENDENCY__UNRESOLVED__REQUIRED-ARTIFACT` | SEED | Per declared dependency-handling rule; default REJECT |
| UID format violation | LAMS-MUST-16 | `LES__IDENTITY__INVALID__ARTIFACT-ID` | CONDITIONAL | REJECT |
| UID collision in registry | LAMS-MUST-16 | `LES__IDENTITY__DUPLICATE__ARTIFACT-ID` | CONDITIONAL | REJECT |
| STUB profile violation | LAMS-MUST-17 | `LES__POLICY__VIOLATION__MANDATORY-RULE` | SEED | REJECT |
| Invalid status transition | LAMS-MUST-18 | `LES__LIFECYCLE__INVALID__STATUS-TRANSITION` | CONDITIONAL | REJECT |
| Ad hoc error identifier used | LAMS-MUST-19 | `LES__POLICY__VIOLATION__MANDATORY-RULE` | SEED | REJECT |
| Design invariant violation | LAMS-MUST-20 | `LES__INVARIANT__VIOLATION__DESIGN-INVARIANT` | CONDITIONAL | REJECT |
| Artifact staleness detected | Freshness check | `LES__LIFECYCLE__STALE__ARTIFACT` | SEED | Per declared freshness policy; default WARN |
| Unresolvable input | Input resolution | `LES__DEPENDENCY__UNRESOLVED__REQUIRED-ARTIFACT` | SEED | Per declared dependency-handling rule; default REJECT |
| Content hash mismatch | Integrity check | `LES__INTEGRITY__MISMATCH__CONTENT-HASH` | SEED | REJECT |
| Agent operation not permitted | Step 6 | `LES__AUTHORIZATION__DENIED__REQUIRED-APPROVAL` | SEED | REJECT |
| Dangling reference in graph | Graph compilation | `LES__TRACEABILITY__BROKEN__DEPENDENCY-LINK` | CONDITIONAL | BLOCKING for graph compilation; ADVISORY for isolated validation |
| Orphan artifact in graph | Graph compilation | `LES__TRACEABILITY__UNLINKED__ARTIFACT` | CONDITIONAL | ADVISORY |

---

## 10. Implementation Notes (CI/Lint)

### 10.1 Preserved lint rules

- `LAMS-LINT-MUST-01` through `LAMS-LINT-MUST-13` — fail CI if any MUST rule is violated
- `LAMS-LINT-SANITIZE-01` — scan freetext fields for executable syntax and LLM-directed instruction patterns; fail CI on hit
- Fail CI if `FROZEN|ACTIVE` without `integrity.content_hash.sha256`
- Fail CI if `conformance_claim: PARTIAL|FULL` without `suite_artifact_id`
- Fail CI if LAMS-LITE artifact has `agent_execution_permitted: true`
- Fail CI if LAMS-LITE artifact attempts status transition to `ACTIVE` or `FROZEN`

### 10.2 New lint rules (v2.0.0)

- `LAMS-LINT-MUST-14` — fail CI if `graph.participation_level` is absent and no default is applied
- `LAMS-LINT-MUST-16` — fail CI if `artifact.uid` is not a valid ULID or UUIDv7
- `LAMS-LINT-MUST-17` — fail CI if STUB artifact has `agent_execution_permitted: true` or non-LEGACY status
- `LAMS-LINT-MUST-18` — fail CI if a status transition does not match the valid transition set in §5.5
- `LAMS-LINT-GRAPH-01` — warn if `graph.participation_level: FULL` but relationship fields are unpopulated
- `LAMS-LINT-GRAPH-02` — warn if a LITE artifact sets `graph.participation_level: FULL`
- Optionally enforce `artifact_id` format with regex per LNS
- Optionally maintain a repo-wide registry compiling `relationships.*` into a graph index
- Optionally run freshness check in CI: compare `updated_at` + `max_age` against pipeline date

### 10.3 Error emission requirement

All lint rule violations MUST emit a LES-conformant error code per §9.2. Implementations SHOULD include the triggering MUST rule ID in the error payload alongside the LES code.

---

## 11. Backward Compatibility

### 11.1 v1.1.0 header compatibility

A valid LAMS v1.1.0 header is accepted by a v2.0.0-compliant system with the following accommodations:

- If `graph.participation_level` is absent, the system applies the default `HEADER_ONLY`.
- v1.1.0 headers are conformant at `LAMS-CONFORM-HEADER` level but not at `LAMS-CONFORM-GRAPH` level until `graph` fields are populated.
- No existing v1.1.0 MUST rules are removed or relaxed. New MUST rules (14–20) apply only to newly created or actively migrated artifacts.

### 11.2 Migration path

Artifacts created under v1.1.0 SHOULD be migrated to v2.0.0 when they are next modified. Migration consists of:
1. Adding `graph.participation_level` (typically `FULL` for STD, `HEADER_ONLY` for LITE)
2. Verifying UID format compliance (ULID or UUIDv7 — both accepted per LAMS-MUST-16)
3. Reviewing relationship fields for graph compilation readiness

### 11.3 Legacy document ID handling

The v1.1.0 document ID `LUP-LAMS-STD-0001` is retained as an alias for `STD-SPEC-0006` in the artifact registry. Systems resolving the old ID MUST redirect to the new ID. The alias is permanent and will not be reassigned.

---

## 12. Open Items (Deferred to v2.1+)

| Item | Origin | Rationale for deferral |
|---|---|---|
| Multi-agent concurrency protocol | v1.1 FS-04, Synthesis Layer 3 | Requires separate extension spec; tracked in `STD-SPEC-0007` |
| Role class granularity floor | v1.1 AR-01 | Acceptable risk for solo/small team; revisit at enterprise rollout |
| Execution receipt standard | Synthesis Layer 2 | Optional extension in v2.0; normative in a future version |
| Attestation object schema | Synthesis Layer 2 | Optional extension in v2.0; dependent on signing infrastructure |
| Typed uncertainty vocabulary | Synthesis Layer 4 | Deferred; extends constraint_class beyond INVARIANT/CONTEXT |
| Adaptive schema evolution | Synthesis Layer 5 | Moonshot; requires ecosystem maturity |
| Cross-organization federation | Synthesis Layer 5 | Moonshot; requires external adoption |

---

## 13. Changelog

- **v2.0.0** — Major upgrade. Introduced materialized graph integration model (§4 `graph` block, LAMS-MUST-14, LAMS-MUST-15, LAMS-MUST-16). Added LAMS-STUB profile (§5.1) for legacy artifact integration. Elevated ten design invariants to normative requirements (§2). Formalized status transition model (§5.5, LAMS-MUST-18). Adopted `STD-NORM-0002` as the exclusive error naming standard (§9, LAMS-MUST-19); 12 codes conditionally accepted via `TASK-CHNG-0001` and retained in LES v0.3. 2026-04-14 harmonization pass aligned supporting-standard references to LNS v1.1 and LES v0.3 with no change to the LAMS v2 technical baseline. UID format: both ULID and UUIDv7 accepted (LAMS-MUST-16). Added graph-aware conformance levels (§8). Restructured agent cold-start sequence to include graph context. Added backward compatibility guarantees for v1.1.0 headers (§11). Legacy alias `LUP-LAMS-STD-0001` registered for `STD-SPEC-0006`. Schema continuity preserved per INV-07: all v1.1.0 headers remain valid. New MUST rules: LAMS-MUST-14 through LAMS-MUST-20. Companion specification: `STD-SPEC-0007`.
- **v1.1.0** — Agentic AI hardening pass. Added `agent_contract` section. Added `freshness` block. Added typed `version_resolution` and `missing_input_behavior`. Added `constraint_class`. Added `sanitization` block. Hardened LAMS-LITE. Added LAMS-MUST-11 through LAMS-MUST-13.
- **v1.0.0** — Initial standard definition for universal artifact metadata.