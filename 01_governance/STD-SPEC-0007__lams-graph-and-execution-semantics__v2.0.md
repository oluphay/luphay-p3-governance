---
# ===================================================================
# LAMS Front Matter (self-describing)
# ===================================================================
artifact:
  title: "LAMS Graph and Execution Semantics"
  kind: SPEC
  subtype: INFRASTRUCTURE_SPECIFICATION
  artifact_id: "STD-SPEC-0007"
  uid: "<ULID_PENDING_REGISTRY>"
  version: "v2.0.0"
  status: DRAFT
  classification: INTERNAL
  language: en
  format: markdown
  tags: ["lams", "graph", "execution", "coordination", "infrastructure"]

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
    derived_from: ["STD-SPEC-0006@v2.0.0"]
  inputs:
    - input_id: "STD-SPEC-0006"
      version_resolution:
        strategy: semver
        value: "v2.0.0"
      kind: SPEC
      role: source_of_truth
      missing_input_behavior: REJECT
    - input_id: "STD-NORM-0002"
      version_resolution:
        strategy: semver
        value: "v0.3"
      kind: SPEC
      role: constraint
      missing_input_behavior: REJECT

graph:
  participation_level: FULL
---

# LAMS Graph and Execution Semantics
## Companion Specification

**Document ID:** STD-SPEC-0007
**Version:** v2.0.0
**Status:** DRAFT
**Last Updated:** 2026-04-14
**Canonical Owner:** Platform Governance / Compliance Architecture

---

## 0. Purpose

This specification defines the infrastructure-level technical requirements for the LAMS Coordination Control Plane, covering:

- **Layer 1 (Core normative):** Materialized graph compilation, UID registry, graph query requirements, freshness propagation, and edge inference rules.
- **Layer 2 (Optional extension):** Execution event schema, execution receipts, health signal model, and attestation object schema.
- **Layers 3–5 (Deferred):** Multi-actor coordination, gap detection, and adaptive capabilities — described at the requirements level for forward compatibility but not normatively binding in v2.0.0.

This specification is a companion to `STD-SPEC-0006` (LAMS Core Specification v2.0.0). It does not redefine the LAMS header schema; it defines what infrastructure does with header data after extraction.

---

## 1. Scope

### 1.1 Applies to
- Graph compilation pipelines and CI integrations
- UID registry implementations
- Graph query APIs and CLIs
- Execution event logging infrastructure
- Agent runtime adapters
- Health signal aggregation services
- Conformance integration infrastructure

### 1.2 Does not replace
- The LAMS header schema (`STD-SPEC-0006`)
- The Luphay Error Standard (`STD-NORM-0002`)
- Domain-specific agent runtime implementations
- Event bus or message broker specifications

---

## 2. Maturity Model

| Section | Layer | v2.0.0 Status | Normative force |
|---|---|---|---|
| §3 Graph Compilation Model | 1 | Core normative | MUST requirements |
| §4 UID Registry | 1 | Core normative | MUST requirements |
| §5 Graph Query Interface | 1 | Core normative | MUST/SHOULD requirements |
| §6 Freshness Propagation | 1 | Core normative | MUST requirements |
| §7 Execution Event Schema | 2 | Optional extension | SHOULD/MAY requirements |
| §8 Execution Receipt Standard | 2 | Optional extension | SHOULD/MAY requirements |
| §9 Health Signal Model | 2 | Optional extension | SHOULD/MAY requirements |
| §10 Attestation Object Schema | 2 | Optional extension | MAY requirements |
| §11 Multi-Actor Coordination | 3 | Deferred | Informative only |
| §12 Gap Detection Model | 4 | Deferred | Informative only |
| §13 Adaptive Capabilities | 5 | Deferred | Informative only |

---

## 3. Graph Compilation Model (Layer 1 — Core Normative)

### 3.1 Purpose

The materialized graph compiles the relationship declarations from every LAMS header into a live, queryable, continuously updated directed graph. The graph is infrastructure — not an optional CI report.

### 3.2 Normative requirements

**GES-MUST-01** A conformant graph compiler MUST extract the following fields from every LAMS header where `graph.participation_level` is `FULL`: `artifact.uid`, `artifact.artifact_id`, `artifact.version`, `artifact.status`, `relationships.inputs[].input_id`, `relationships.outputs[].output_id`, `relationships.where_used[].consumer_artifact_id`, `relationships.lineage.*`.

**GES-MUST-02** For `graph.participation_level: HEADER_ONLY`, the compiler MUST extract identity fields (`artifact.uid`, `artifact.artifact_id`, `artifact.version`, `artifact.status`) but MAY omit relationship fields.

**GES-MUST-03** For `graph.participation_level: EXCLUDED`, the compiler MUST NOT include the artifact in the graph.

**GES-MUST-04** The compiler MUST infer reverse edges per `STD-SPEC-0006` LAMS-MUST-15: if artifact A declares artifact B as an input, the graph MUST register A as a consumer of B. Inferred edges MUST be labeled as `edge_source: INFERRED` to distinguish them from `edge_source: DECLARED`.

**GES-MUST-05** The graph MUST be re-compiled or incrementally updated whenever a LAMS header in the source repository is modified.

**GES-MUST-06** The compiler MUST detect and report dangling references — edges that point to a `uid` or `artifact_id` that does not exist in the graph. Dangling references MUST emit `LES__TRACEABILITY__BROKEN__DEPENDENCY-LINK`.

**GES-MUST-07** The compiler MUST detect and report orphan artifacts — artifacts with no incoming or outgoing edges. Orphans MUST emit `LES__TRACEABILITY__UNLINKED__ARTIFACT`.

### 3.3 Graph node schema

```yaml
graph_node:
  uid: "<ULID_OR_UUIDV7>"                    # from artifact.uid
  artifact_id: "<ORG-NAMING-ID>"              # from artifact.artifact_id
  version: "<VERSION>"                        # from artifact.version
  status: "<STATUS>"                          # from artifact.status
  profile: "<STUB|LITE|STD|RELEASE>"          # derived from header completeness
  participation_level: "<FULL|HEADER_ONLY>"   # from graph.participation_level
  confidence: "<HIGH|LOW>"                    # HIGH for STD/RELEASE; LOW for STUB
  updated_at: "<ISO_8601>"                    # from governance.updated_at
  fanout_class: "<LOW|MEDIUM|HIGH|CRITICAL>"  # from graph.fanout_class or computed
```

### 3.4 Graph edge schema

```yaml
graph_edge:
  source_uid: "<ULID_OR_UUIDV7>"              # the artifact declaring the relationship
  target_uid: "<ULID_OR_UUIDV7>"              # the artifact referenced
  relationship_type: "<INPUT|OUTPUT|WHERE_USED|SUPERSEDES|DERIVED_FROM|FORKS_FROM|RELATED>"
  edge_source: "<DECLARED|INFERRED>"          # DECLARED = explicitly in header; INFERRED = reverse-edge inference
  role: "<source_of_truth|reference|constraint|test_vector|context_pack>"  # from inputs[].role, if applicable
  version_resolution:
    strategy: "<semver|commit|hash|latest>"
    value: "<VERSION_STRING>"
  missing_behavior: "<REJECT|WARN|SKIP>"      # from inputs[].missing_input_behavior
```

### 3.5 Graph compilation output

The graph compiler MUST produce a serializable graph artifact in JSON or equivalent structured format. The output MUST include:
- A list of all nodes conforming to §3.3
- A list of all edges conforming to §3.4
- A compilation metadata block containing: compilation timestamp, source repository URI, total node count, total edge count, dangling reference count, orphan count, inferred edge count

---

## 4. UID Registry (Layer 1 — Core Normative)

### 4.1 Purpose

The UID registry is a persistent store that maps every `artifact.uid` to its `artifact.artifact_id` and `canonical_path`. It resolves LAMS v1.1 Open Item C-01 (repo-wide UID registry with conflict detection).

### 4.2 Normative requirements

**GES-MUST-08** A conformant UID registry MUST reject registration of a UID that is already assigned to a different `artifact_id`.

**GES-MUST-09** On collision, the registry MUST emit `LES__IDENTITY__DUPLICATE__ARTIFACT-ID` and halt registration.

**GES-MUST-10** The registry MUST support lookup by UID → artifact_id and reverse lookup by artifact_id → UID.

**GES-MUST-11** The registry MUST be updated atomically with graph compilation. A UID that exists in a header but not in the registry MUST be registered during compilation. A UID that exists in the registry but not in any header MUST be flagged as orphaned.

**GES-MUST-12** The registry MUST accept both ULID and UUIDv7 formats per `STD-SPEC-0006` LAMS-MUST-16. Implementations MUST NOT reject a UID based solely on which of the two formats it uses.

### 4.3 Registry entry schema

```yaml
uid_registry_entry:
  uid: "<ULID_OR_UUIDV7>"
  uid_format: "<ULID|UUIDV7>"                 # which format this UID uses
  artifact_id: "<ORG-NAMING-ID>"
  canonical_path: "<REPO_PATH_OR_URI>"
  version: "<CURRENT_VERSION>"
  status: "<CURRENT_STATUS>"
  first_registered_at: "<ISO_8601>"
  last_seen_at: "<ISO_8601>"
  registry_status: "<ACTIVE|ORPHANED|CONFLICT>"
```

---

## 5. Graph Query Interface (Layer 1 — Core Normative)

### 5.1 Purpose

A conformant implementation MUST provide a query interface over the materialized graph.

### 5.2 Required query capabilities

**GES-MUST-13** The interface MUST support the following queries:

| Query | Description |
|---|---|
| `dependents(uid)` | Return all artifacts that directly depend on the given artifact |
| `dependencies(uid)` | Return all artifacts that the given artifact directly depends on |
| `transitive_dependents(uid)` | Return all artifacts transitively downstream |
| `transitive_dependencies(uid)` | Return all artifacts transitively upstream |
| `impact_analysis(uid)` | Return the full downstream impact set with edge types |
| `orphans()` | Return all artifacts with no incoming or outgoing edges |
| `dangling_references()` | Return all edges pointing to non-existent targets |

### 5.3 Recommended query capabilities

The interface SHOULD additionally support:
- `staleness_cascade(uid)` — return all downstream artifacts affected by staleness of the given artifact
- `coverage_report()` — return the percentage of artifacts in the repository that participate in the graph at each level (FULL, HEADER_ONLY, EXCLUDED, no header)
- `subgraph(uid, depth)` — return a bounded neighborhood around a given artifact

### 5.4 Interface binding

The initial implementation SHOULD be a CLI tool. An API binding MAY be provided as a subsequent enhancement. The specification does not mandate a specific technology; JSON over stdout is sufficient.

---

## 6. Freshness Propagation (Layer 1 — Core Normative)

### 6.1 Purpose

When an artifact's `governance.updated_at` changes, downstream dependents with `graph.health_propagation.propagate_staleness: true` MUST be evaluated for potential staleness.

### 6.2 Normative requirements

**GES-MUST-14** When an artifact is updated, the graph compiler or a freshness propagation service MUST traverse all direct dependents and evaluate whether their declared `freshness.max_age` is exceeded relative to the upstream change.

**GES-MUST-15** Freshness propagation MUST NOT automatically change the `artifact.status` of downstream artifacts. It MUST only emit notifications or set health signals. Staleness detection emits `LES__LIFECYCLE__STALE__ARTIFACT` with agent behavior governed by the downstream artifact's declared `agent_freshness_behavior`.

**GES-MUST-16** Freshness notifications MUST include: the updated artifact's UID, the dependent artifact's UID, the time of the upstream change, and the dependent's declared `freshness.max_age`.

---

## 7. Execution Event Schema (Layer 2 — Optional Extension)

### 7.1 Purpose

When adopted, execution events provide a structured record of what happens when artifacts are acted upon.

### 7.2 Status

This section is an **optional extension** in LAMS v2.0.0. Implementations MAY adopt it. When adopted, the requirements in this section become binding for the adopting implementation.

### 7.3 Event schema

```yaml
execution_event:
  event_id: "<ULID_OR_UUIDV7>"
  artifact_uid: "<ULID_OR_UUIDV7>"            # the artifact acted upon
  actor:
    actor_type: "<HUMAN|AGENT|SYSTEM|PIPELINE>"
    actor_id: "<IDENTIFIER>"
    agent_class: "<READ_ONLY|MODIFIER|PUBLISHER|ORCHESTRATOR>"  # if actor_type is AGENT
  operation: "<READ|MODIFY|PUBLISH|RETIRE|VALIDATE|EXECUTE>"
  timestamp: "<ISO_8601_ZULU>"
  outcome: "<SUCCESS|FAILURE|PARTIAL|TIMEOUT|REJECTED>"
  output_artifacts: ["<ULID_OR_UUIDV7>"]      # artifacts produced by this operation
  conformance_result:
    run_id: "<RUN_ID_OR_EMPTY>"
    status: "<PASS|FAIL|N_A>"
  error_code: "<LES_CODE_OR_EMPTY>"            # LES code if outcome is FAILURE or REJECTED
  notes: "<OPTIONAL_HUMAN_READABLE_NOTES>"
```

### 7.4 Implementation guidance

- Events SHOULD be stored in an append-only log.
- Events SHOULD align with OpenLineage run event models where applicable.
- Event retention SHOULD match the artifact's declared `retention.retention_period`.
- Implementations SHOULD NOT log events for artifacts with `graph.participation_level: EXCLUDED`.

---

## 8. Execution Receipt Standard (Layer 2 — Optional Extension)

### 8.1 Purpose

When an agent completes a permitted operation, it writes a structured receipt. Receipts are the foundation of agent accountability.

### 8.2 Status

This section is an **optional extension** in LAMS v2.0.0.

### 8.3 Receipt schema

```yaml
execution_receipt:
  receipt_id: "<ULID_OR_UUIDV7>"
  event_id: "<ULID_OR_UUIDV7>"                # references the execution_event
  artifact_uid: "<ULID_OR_UUIDV7>"
  agent_id: "<AGENT_IDENTIFIER>"
  operation: "<OPERATION_PERFORMED>"
  cold_start_result:
    fields_resolved: ["<FIELD_PATH>"]
    invariants_evaluated: ["<CONSTRAINT_ID>"]
    invariant_results: "<ALL_PASS|VIOLATION_DETECTED>"
  input_resolution_result:
    inputs_resolved: ["<INPUT_ID>"]
    inputs_unresolved: ["<INPUT_ID>"]
    unresolved_behavior_applied: ["<REJECT|WARN|SKIP>"]
  sanitization_result:
    scan_performed: true
    scan_outcome: "<CLEAN|VIOLATION_DETECTED>"
  outcome: "<SUCCESS|FAILURE|PARTIAL>"
  timestamp: "<ISO_8601_ZULU>"
  attestation:                                  # optional; see §10
    content_hash: "<SHA256>"
    environment_fingerprint: "<OPTIONAL>"
    signature: "<BASE64_OR_EMPTY>"
```

### 8.4 Compliance classification

Agents that produce execution receipts are classified as **compliant**. Agents that do not are classified as **unattested**. The system SHOULD track which agent classes are compliant and which are not.

---

## 9. Health Signal Model (Layer 2 — Optional Extension)

### 9.1 Purpose

A composite health signal per artifact, derived from freshness, conformance, dependency health, and execution history.

### 9.2 Status

This section is an **optional extension** in LAMS v2.0.0.

### 9.3 Health signal schema

```yaml
artifact_health:
  artifact_uid: "<ULID_OR_UUIDV7>"
  computed_at: "<ISO_8601_ZULU>"
  signals:
    freshness:
      status: "<FRESH|STALE|UNKNOWN>"
      max_age: "<DECLARED_MAX_AGE>"
      last_updated: "<ISO_8601>"
    conformance:
      status: "<PASS|FAIL|NOT_TESTED|N_A>"
      last_run_at: "<ISO_8601_OR_EMPTY>"
    dependency_health:
      status: "<ALL_HEALTHY|DEGRADED|CRITICAL|UNKNOWN>"
      unhealthy_dependencies: ["<ULID_OR_UUIDV7>"]
    last_execution:
      outcome: "<SUCCESS|FAILURE|PARTIAL|NONE>"
      timestamp: "<ISO_8601_OR_EMPTY>"
  composite_health: "<HEALTHY|DEGRADED|CRITICAL|UNKNOWN>"
```

### 9.4 Composite health computation

- `HEALTHY` — all four signals are positive (FRESH, PASS, ALL_HEALTHY, SUCCESS)
- `DEGRADED` — one or more signals are non-positive but none are critical
- `CRITICAL` — any signal is in a critical state (STALE + REJECT policy, FAIL, CRITICAL dependencies)
- `UNKNOWN` — insufficient data to compute health

---

## 10. Attestation Object Schema (Layer 2 — Optional Extension)

### 10.1 Purpose

Extends the `integrity` block from a static hash to a structured attestation binding content hash, execution environment fingerprint, and policy context hash.

### 10.2 Status

This section is an **optional extension** in LAMS v2.0.0. It is recommended for high-sensitivity artifacts (`classification: CONFIDENTIAL` or above).

### 10.3 Attestation schema

```yaml
attestation:
  attestation_id: "<ULID_OR_UUIDV7>"
  artifact_uid: "<ULID_OR_UUIDV7>"
  content_hash:
    algorithm: "sha256"
    value: "<64HEX>"
  environment_fingerprint:
    platform: "<OS_AND_VERSION>"
    toolchain: "<TOOL_AND_VERSION>"
    ci_run_id: "<CI_RUN_ID_OR_EMPTY>"
  policy_context:
    policy_hash: "<SHA256_OF_ACTIVE_POLICY_SET>"
    lams_version: "v2.0.0"
  signer:
    key_id: "<KEY_IDENTIFIER>"
    algorithm: "<SIG_ALG>"
    signature: "<BASE64>"
  issued_at: "<ISO_8601_ZULU>"
```

### 10.4 Implementation guidance

- Attestation objects SHOULD align with SLSA provenance patterns where applicable.
- Signing infrastructure requirements are out of scope for this specification; see future `STD-SPEC` for key management.
- Attestation objects MAY be stored alongside the artifact or in a separate attestation registry.

---

## 11. Multi-Actor Coordination Primitives (Layer 3 — Deferred)

### 11.1 Status

This section is **deferred** and **informative only** in LAMS v2.0.0. It is included to preserve continuity with the unified upgrade synthesis and to signal the intended direction for future versions.

### 11.2 Intended capabilities (informative)

When realized, Layer 3 will specify:
- Artifact-level operation locks and leases
- Coordination handshake protocol for cross-artifact operations
- Intent composition (deriving effective scope from input intents)
- Cross-artifact transaction boundaries with commit/rollback semantics
- Agent class registry with coordination privileges (read-only, modifier, publisher, orchestrator)
- Constraint inheritance rules
- Escalation routing integration

### 11.3 Dependencies

Layer 3 requires Layer 2 (execution awareness) to be fully operational. It also requires a distributed lock service or lightweight equivalent.

### 11.4 Open design questions

- Lock granularity: artifact-level vs. section-level
- Lease duration and renewal policy
- Deadlock detection and resolution strategy
- Intent composition algebra (union vs. intersection of constraint sets)

---

## 12. Gap Detection Model (Layer 4 — Deferred)

### 12.1 Status

This section is **deferred** and **informative only** in LAMS v2.0.0.

### 12.2 Intended capabilities (informative)

When realized, Layer 4 will specify:
- Structural gap detection (phantom artifacts — declared dependencies with no target)
- Coverage analysis (compare artifact graph against domain models)
- Contradiction detection (conflicting assumptions or constraints across artifacts)
- Suggested artifact generation (pre-populated LAMS headers for missing artifacts)
- Assumption drift detection (external signal monitoring against declared assumptions)
- Graph completeness scoring
- Extended constraint class vocabulary: `CONFIRMED`, `ASSUMED`, `CONTESTED`, `UNKNOWN`

### 12.3 Dependencies

Layer 4 requires Layer 3 (multi-actor coordination) for composed intent and cross-artifact analysis.

---

## 13. Adaptive Capabilities (Layer 5 — Deferred)

### 13.1 Status

This section is **deferred** and **informative only** in LAMS v2.0.0. It represents the moonshot destination described in the unified upgrade synthesis.

### 13.2 Intended capabilities (informative)

When realized, Layer 5 will specify:
- Self-healing artifact graphs (auto-generated draft artifacts for known gap patterns)
- Adaptive schema evolution via extension registry
- Cross-organization artifact federation via trust protocol
- Organizational memory queries over graph + execution logs + lineage
- Uncertainty-native operations (confidence-qualified outputs)
- Adaptive governance (dynamic governance parameter tuning)
- Emergent workflow detection (pattern mining over lifecycle events)
- Semantic interoperability mapping (JSON-LD contexts for LAMS fields)
- Autonomy budgets for high-uncertainty graph regions

### 13.3 Dependencies

Layer 5 requires all of Layers 0–4 fully operational, plus ecosystem maturity and cross-organization adoption.

---

## 14. Error Handling

This specification adopts the same LES alignment model as `STD-SPEC-0006` §9. All LES codes referenced below are registered in `STD-NORM-0002` v0.3.

| Failure Mode | Triggering Requirement | LES Code | LES Stage | Agent Behavior |
|---|---|---|---|---|
| Graph compilation failure | GES-MUST-01 | `LES__EXECUTION__FAILED__VALIDATION-STEP` | SEED | REJECT |
| Dangling reference detected | GES-MUST-06 | `LES__TRACEABILITY__BROKEN__DEPENDENCY-LINK` | CONDITIONAL | BLOCKING for graph compilation; ADVISORY for isolated validation |
| Orphan artifact detected | GES-MUST-07 | `LES__TRACEABILITY__UNLINKED__ARTIFACT` | CONDITIONAL | ADVISORY |
| UID collision in registry | GES-MUST-09 | `LES__IDENTITY__DUPLICATE__ARTIFACT-ID` | CONDITIONAL | REJECT |
| UID format rejected | GES-MUST-12 | `LES__IDENTITY__INVALID__ARTIFACT-ID` | CONDITIONAL | REJECT |
| Freshness propagation failure | GES-MUST-14 | `LES__EXECUTION__FAILED__VALIDATION-STEP` | SEED | REJECT |
| Staleness detected via propagation | GES-MUST-15 | `LES__LIFECYCLE__STALE__ARTIFACT` | SEED | Per declared freshness policy; default WARN |
| Execution event write failure | §7 | `LES__EXECUTION__FAILED__WORKFLOW-STEP` | Redirect to `LES__EXECUTION__TIMEOUT__WORKFLOW-STEP` or `FAILED__VALIDATION-STEP` | Per failure type |
| Receipt attestation invalid | §8 | `LES__INTEGRITY__MISMATCH__CONTENT-HASH` | SEED | REJECT |
| Health signal computation failure | §9 | `LES__EXECUTION__FAILED__VALIDATION-STEP` | SEED | REJECT |

---

## 15. Changelog

- **v2.0.0** — Initial specification. Defines materialized graph compilation, UID registry (both ULID and UUIDv7), graph query interface, freshness propagation (Layer 1 — core normative). Defines execution event schema, receipt standard, health signal model, attestation object schema (Layer 2 — optional extension). Documents deferred capabilities for Layers 3–5. LES alignment via `STD-NORM-0002` v0.3; all infrastructure error codes registered. 2026-04-14 harmonization pass aligned supporting-standard references to current LES with no change to the LAMS v2 infrastructure baseline. Companion to `STD-SPEC-0006`.