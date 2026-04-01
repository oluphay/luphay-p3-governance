# MERIDIAN PRIMARY REFERENCE
## The Baseline Specification for the Enterprise AI Decision Hub

---

```
Document ID:     MERIDIAN-REF-001
Version:         0.4-draft
Status:          DRAFT — Integrated Harness Posture PR v2
Classification:  Internal · Strategic
Issued:          2026-04-01
Owner:           Meridian Program
Next Review:     Pre-final integration review or major taxonomy change → v0.4-final
```

---

## THE PROMISE

> *"Meridian gives enterprise decision-makers a fixed reference line for the AI landscape — a living system that makes the right questions visible, maps responsibility clearly, and turns landscape intelligence into grounded adoption decisions."*

Meridian is not a directory. It is not a review site. It is not a consulting engagement.

It is a classification engine, a decision surface, and a research instrument — built on a taxonomy with genuine IP depth and designed to serve enterprise buyers who need to answer questions that no existing tool currently answers.

---

## HOW TO USE THIS DOCUMENT

| Use Case | How to Apply |
|---|---|
| Product development | Map every feature to a Reference ID — features without a Reference ID are out of scope |
| Red Team session | Attack each Reference ID category independently before attacking the whole |
| Iteration versioning | Increment version on Red Team completion; log all changes in Version History |
| Research sprint | Select a Reference ID, scope the question, log outputs against that ID |
| LuDRACO alignment | Cross-reference Meridian Reference IDs against LuDRACO Reference IDs using the alignment table in Section 6 |
| Stakeholder communication | Cite Reference IDs to prevent topic drift across sessions |

**Document scope rule (v0.3):** Categories 1–5 are buyer-facing — they define what a buyer sees, uses, and trusts. Category 6 is internal-only and must not appear in any buyer-facing Meridian surface (product UI, public content, marketing materials). Category 6 governs how Meridian captures intelligence and aligns with LuDRACO; exposing it to buyers would collapse the classification independence that makes Categories 1–5 credible.

---

## THE STACK

The Meridian promise implies a layered product. Upper layers break if lower layers are absent.

```
┌─────────────────────────────────────────────────────────────┐
│  6  MARKET INTELLIGENCE & RESEARCH INSTRUMENT  [INTERNAL]   │
├─────────────────────────────────────────────────────────────┤
│  5  THE TOOL ECOSYSTEM MAP                                   │
├─────────────────────────────────────────────────────────────┤
│  4  THE DECISION SURFACE                                     │
├─────────────────────────────────────────────────────────────┤
│  3  EXECUTION MODEL                                          │
├─────────────────────────────────────────────────────────────┤
│  2  THE GOVERNANCE PLANE                                     │
├─────────────────────────────────────────────────────────────┤
│  1  THE CLASSIFICATION SYSTEM                                │
└─────────────────────────────────────────────────────────────┘
```

The Classification System is the foundation. Everything Meridian offers — decision guidance, obligation mapping, tool evaluation, regulatory fit — depends on the classification system being correct, stable, and maintained.

---

## THE MECHANISM

How a buyer moves through Meridian.

```
Enterprise buyer arrives with a question
     │
     ▼  [classify the system or tool in question]
Layer × Column coordinate established (e.g. 2C)
     │
     ├── [Layer 0?] → architectural context provided
     │     Governance-decision flow does not apply;
     │     buyer is routed to infrastructure guidance
     │
     ▼  [Layers 1–3: execution mode identified]
Synchronous / Asynchronous / Continuous
     │
     ▼  [requested system profile captured]
Target class · target mode · intended operating reach
     │
     ▼  [Harness Posture validated from evidence]
H0 / H1 / H2 / H3 / H4
     │
     ▼  [requested vs. validated profile compared]
Harness gap identified · routing need determined
     │
     ▼  [governance obligations surfaced]
What the vendor owns · What the operator owns · What evidence is required
     │
     ▼  [routing and decision guidance applied]
Autonomy / ownership / boundary downgrade or defer · Buy / Rent / Build recommendation with rationale
     │
     ▼  [regulatory and risk context added]
Obligations, frameworks, evidence requirements
     │
     ▼  [implementation pathway surfaced]
Tools, frameworks, governance layer requirements
     │
     ▼  [buyer exits with a grounded decision]
Implementation clarity · Responsibility clarity · Risk clarity · Operator-fit clarity
```

**Mechanism scope note (v0.4 draft):** Layer 0 classifications provide architectural context (what infrastructure a system is built on) but do not enter the governance-decision flow. A model API (0A) or a vector database (0B/0C) is a material, not a system with an operator making adoption decisions. The governance plane, decision surface, and buy/rent/build logic apply to Layers 1–3, where a human operates, reviews, or monitors a system that can act. Harness Posture is an operator-fit overlay, not a third taxonomy axis. It applies only to Layers 1–3 after execution mode is established.

---

## THE DISTINCTION

What Meridian is not — critical for positioning, product integrity, and market messaging.

| What it resembles | What it actually is | Why the distinction matters |
|---|---|---|
| A tool directory | A classification and decision engine | Directories list; Meridian classifies and governs |
| An analyst report | A living interactive platform | Reports are static; Meridian updates with the landscape |
| A vendor comparison site | A governance obligation surfacing system | Comparisons describe features; Meridian surfaces who is responsible for what |
| A consulting engagement | A scalable decision framework | Consulting is bespoke and slow; Meridian is self-service and fast |
| A compliance checklist | A governance context engine | Checklists confirm; Meridian surfaces what questions to ask |
| An awesome-list | A structured taxonomy with decision logic | Lists are flat inventories; Meridian has classification depth |

---

---

# CATEGORY 1 — THE CLASSIFICATION SYSTEM

**Promise Clause:** *"...a fixed reference line for the AI landscape..."*
**Layer:** Foundation
**Stack Position:** 1 of 6
**Why This Category Exists:** Every decision Meridian supports depends on a buyer being able to correctly classify what they are using, building, or evaluating. Classification is the IP. It is what makes Meridian structurally different from every existing substitute.

**Applicable Activities:** Product development · Research · Red Team · Content · Versioning

---

### 1.1 The Autonomy Axis — Layers 0 through 3

**Reference ID:** 1.1
**Description:** The vertical classification axis. Organises AI systems by their primary operating mode — from passive infrastructure through conversational intelligence, supervised action, to systemic autonomy.

**The four layers:**

| Layer | Name | Primary mode | Human role | Mechanism scope |
|---|---|---|---|---|
| 0 | Infrastructure | Data, compute, routing, models | Builder / operator | Architectural context only — does not enter the governance-decision flow |
| 1 | Conversation | Human drives, AI talks | Primary operator | Full governance-decision flow |
| 2 | Supervised Action | AI executes, human reviews | Reviewer / approver | Full governance-decision flow |
| 3 | Systemic Autonomy | Headless, continuous, event-driven | Monitor / circuit breaker | Full governance-decision flow |

**Key Questions:**
- Does the system mainly talk, or does it mainly act?
- Is there a human in the normal operating loop, or only in the exception path?
- Is the system triggered by a prompt, a batch job, or an environmental event?

**Classification rule:** A system is classified by its *primary* operating mode, not its maximum capability. A chat interface with a code interpreter is still Layer 1 if conversation is its defining mode.

**Layer 0 scope rule (v0.3):** Layer 0 exists in the taxonomy because infrastructure decisions carry governance implications (data residency, vendor dependency, model provenance). But Layer 0 objects are *materials*, not *systems with operators making adoption decisions*. The buyer mechanism, governance plane, and buy/rent/build decision surface apply to Layers 1–3. Layer 0 classification provides architectural context — it answers "what is this built on?" not "how should I govern this?"

**Boundary: Layer 1 → Layer 2:** A system exits Layer 1 when it can take actions through tools or environment controls, observe the results of those actions, and continue operating without requiring the human to drive every step.

**Boundary: Layer 2 → Layer 3:** A system moves to Layer 3 when its operational trigger is environmental (event-driven, continuous) rather than human-initiated, and when no human is in the normal operating loop.

---

### 1.2 The Ownership Axis — Columns A, B, C

**Reference ID:** 1.2
**Description:** The horizontal classification axis. Organises AI systems and tools by who built the surface or runtime, and for whom.

**The three columns:**

| Column | Name | Definition | Governance implication |
|---|---|---|---|
| A | Native / Foundational | Built by the vendor that owns the underlying model or platform ecosystem | Vendor governs runtime; operator configures within vendor limits |
| B | Third-Party / Aggregator | Built by a separate company; offered externally as a product or service | Operator is responsible for vendor due diligence; runtime is vendor-owned |
| C | Internal / Custom Enterprise | Built for self-use by a company, team, or founder; not primarily for the market | Operator owns all governance; no vendor controls to rely on |

**Key Questions:**
- Who built the runtime?
- Does the operator own the runtime, or do they license access to it?
- Was the system built for the market, or for internal use?

**Critical distinction — customisation does not change the column:** A team that heavily configures a Column B product has not moved to Column C. The column is determined by runtime ownership, not configuration depth. If the runtime belongs to a vendor, the column is B regardless of how much the operator has customised it.

**Critical distinction — 1C vs 1B for enterprise AI products:** Commercial AI products sold to enterprises (e.g. Glean, Hebbia) are Column B, not Column C, even when deployed inside an enterprise. Column C means the system was *built* for self-use. Purchased commercial products are always B.

---

### 1.3 The Full Matrix — Twelve Canonical Positions

**Reference ID:** 1.3
**Description:** The intersection of the two axes produces a canonical 4 × 3 matrix. Every AI system and tool can be placed in one of these twelve positions.

| Layer | A: Native | B: Third-Party | C: Internal |
|---|---|---|---|
| **0: Infrastructure** | Model APIs & weights (OpenAI API, Anthropic API, Llama) | Compute, routing & managed data platforms (AWS Bedrock, Pinecone SaaS, Weaviate Cloud) | Self-hosted & fine-tuned (on-premise, proprietary data lakes, custom fine-tunes) |
| **1: Conversation** | Native vendor chat (Claude.ai, ChatGPT, Gemini App) | Third-party / aggregated chat (Perplexity, Poe, You.com) | Internal custom RAG assistant (self-built knowledge chatbots, policy assistants, private workspaces) |
| **2: Supervised Action** | Native code / terminal agents (Claude Code, GitHub Copilot Workspace) | Agentic products / IDEs (Cursor, Devin, Windsurf) | Custom supervised agents with HITL (LangGraph, CrewAI-based internal agents with approval gates) |
| **3: Systemic Autonomy** | Autonomous vendor services (black-box continuous execution) | Agentic RPA platforms (background multi-agent swarms) | Proprietary headless swarms (internal M2M systems, continuous auditors, pipeline gatekeepers) |

---

### 1.4 Boundary Conditions and Edge Cases

**Reference ID:** 1.4
**Description:** The classification rules that resolve ambiguous cases. These are the most important content in the classification system — the boundary conditions are where buyer confusion is highest and where Meridian's value is clearest.

**Canonical edge cases:**

| Scenario | Correct classification | Reasoning |
|---|---|---|
| Sophisticated chat with memory and file upload | Layer 1 | Defining mode is still conversation; human is still primary operator |
| Native vendor agent connected to the operator's own repo | 2A | Runtime is vendor-owned; operator has customised within vendor environment |
| Internal team builds on OpenAI/Anthropic APIs | 2C | Team owns the runtime; API is a material, not the product |
| Third-party company wraps frontier APIs and sells result | 2B | External, productised, runtime belongs to the builder |
| Enterprise buys a commercial AI product and configures it heavily | 1B or 2B | Column stays B; runtime is vendor-owned regardless of configuration depth |
| Internal system later offered to outside customers | 2C → 2B | Column changes when runtime is offered to the market |
| Self-hosted vector database (pgvector, Milvus) | Layer 0C infrastructure | Operator owns the data and the runtime |
| Hosted SaaS vector database (Pinecone, Weaviate Cloud) | Layer 0B | External vendor holds the data; vendor due diligence required |

**Common misclassifications to surface explicitly in the product:**
- Calling every chat interface an agent
- Treating a prompt wrapper as an agent system
- Using brand familiarity rather than behaviour to classify
- Confusing customisation depth with runtime ownership
- Treating purchased commercial products as internal builds

**Adversarial classification protocol (v0.3):** Vendor-submitted or vendor-contested classification claims must be evaluated against the two classification questions (ref 1.5) and the boundary conditions above. Classification decisions are never influenced by commercial relationships, including sponsored placement (ref 6.6). If a paying vendor's product is reclassified, the reclassification proceeds and the vendor is notified — the commercial relationship does not constitute grounds for appeal. See ref 6.6 monetisation conflict protocol.

---

### 1.5 The Two Classification Questions

**Reference ID:** 1.5
**Description:** The canonical shortcut. Any system can be classified by answering these two questions in sequence.

**Question 1 — What is the system's primary mode?**
- Mainly conversation; human drives execution → **Layer 1**
- AI executes with human review / approval gates → **Layer 2**
- Headless, continuous, event-driven; no human in normal loop → **Layer 3**
- Raw data, compute, models, or routing; no user interface → **Layer 0**

**Question 2 — Who built the surface or runtime, and for whom?**
- The model vendor also built the product surface → **A**
- A third party built it and offers it externally → **B**
- Your team built it for internal / self-use → **C**

---

---

# CATEGORY 2 — THE GOVERNANCE PLANE

**Promise Clause:** *"...maps responsibility clearly..."*
**Layer:** Transversal
**Stack Position:** 2 of 6
**Why This Category Exists:** The governance plane is the primary differentiator between Meridian and every existing substitute. No current directory, report, or comparison tool surfaces governance obligations by system classification. This is the capability that makes hidden risks visible and enterprise buyers accountable.

**Applicable Activities:** Product development · Regulatory content · Obligation mapping · Persona messaging

---

### 2.1 The Governance Scaling Rules

**Reference ID:** 2.1
**Description:** The rules that determine how strict governance requirements are, based on system position in the matrix.

**Two scaling directions:**

**Direction 1 — Downward (deeper autonomy):** As systems move from Layer 1 toward Layer 3, the risk surface expands. Governance strictness must increase proportionally. A Layer 3C system running continuously with no human in the loop requires the most complete governance architecture of any system class.

**Direction 2 — Rightward toward Column C (owned runtime):** Column C systems demand the most rigorous internal governance not because they are inherently riskier than Column B systems, but because the operator owns the runtime and has no vendor controls to rely on. There is no vendor to audit, no vendor SLA, no vendor accountability path. The operator must supply all governance.

**Critical clarification:** This is not the same as saying Column C systems are riskier than Column B. A Column B agentic product running inside an enterprise (e.g. Devin, n8n) can carry significant risk precisely because the team has less control. The governance *approach* differs: Column B governance is vendor due diligence, data residency checks, and egress controls. Column C governance is audit pipelines, guardrails, and runtime monitoring — built and owned by the operator.

---

### 2.2 Security and Guardrails

**Reference ID:** 2.2
**Description:** The active protection layer. Prevents prompt injection, data leakage, output toxicity, and unauthorized execution.

**What belongs here:**
- AI firewalls (intercept and inspect inputs/outputs before execution)
- Prompt injection defense
- Data Loss Prevention (DLP) for AI outputs
- Output content filtering and toxicity detection
- Input validation and sanitisation

**Governance requirement trigger:** Any Layer 2 or Layer 3 system, regardless of column. Strictness scales with autonomy layer. Mandatory at Layer 3.

**Representative tools:** NeMo Guardrails, Lakera Guard, Cloudflare AI Gateway

---

### 2.3 Observability and Evaluation

**Reference ID:** 2.3
**Description:** The telemetry layer. Makes visible what the agent is doing, how much it costs, and whether it is degrading over time.

**What belongs here:**
- Trace logging of every tool call, prompt, and response
- Hallucination rate monitoring
- Token cost and latency tracking
- Model performance degradation detection over time
- Evaluation pipelines for quality assessment

**Governance requirement trigger:** Any Layer 2 or Layer 3 system before production deployment. Observability is a prerequisite for trusting a system — not optional once a system acts autonomously.

**Representative tools:** LangSmith, Langfuse, Helicone, Arize AI, Datadog LLM Observability

**Critical distinction:** Observability tools record what happened. They do not govern before events execute. This distinction separates the observability layer from the LuDRACO governance layer — and must be surfaced explicitly in Meridian's product content.

**LuDRACO alignment note (v0.2):** LuDRACO's v1.1.0 architecture introduces a formal verification boundary between probabilistic AI outputs and the deterministic rule engine. The Intent Pipeline outputs a strictly typed DSL that is semantically validated and cryptographically signed before the rule engine accepts it. This boundary is the structural answer to the observability-vs-governance distinction: observability records what happened; LuDRACO's verification boundary prevents invalid inputs from reaching execution. Meridian should surface this distinction when buyers reach the observability gap.

---

### 2.4 Compliance and Audit

**Reference ID:** 2.4
**Description:** The evidence layer. Creates legally usable records of AI actions, decisions, and reasoning.

**What belongs here:**
- Cryptographic action logging
- RAG citation tracing and source attribution
- Mapping AI behaviour to regulatory frameworks (SOC 2, ISO 27001, GDPR, HIPAA, EU AI Act)
- Decision audit trails with full context preservation
- Evidence export for regulatory review

**Governance requirement trigger:** Column C systems at Layer 2 or 3 — mandatory. Column B systems at Layer 2 or 3 — vendor due diligence required; operator must confirm audit trail availability.

**Regulatory frameworks in scope:** EU AI Act (especially high-risk AI systems), SEC AI guidance, UK FCA AI strategy, NIST AI RMF, HIPAA (healthcare), SOC 2 Type II, ISO 27001.

**LuDRACO alignment note (v0.2):** LuDRACO's golden thread architecture now uses a Write-Ahead Log (WAL) pattern — actions execute against a high-speed local state and settle asynchronously onto the immutable ledger via cryptographic hash-chaining. This decouples execution latency from ledger settlement, addressing the performance concern inherent in synchronous immutable writes. Meridian's compliance content should note that the golden thread's "permanence" claim applies to event integrity, timestamps, signatures, and custody links — not to indefinite retention of sensitive payloads, which is subject to regulatory retention schedules. This distinction prevents buyer misunderstanding at the audit trail evaluation point.

---

### 2.5 Column B Governance Protocol

**Reference ID:** 2.5
**Description:** The specific governance obligations for Column B systems. These differ structurally from Column C governance and must be treated separately in Meridian's decision guidance.

**Required steps for any Column B system at Layer 2 or 3:**
- Vendor security review (SOC 2 Type II, ISO 27001, penetration test reports)
- Data residency validation — confirm where data is processed and stored
- Training data consent — confirm vendor does not train on operator inputs without consent
- Egress control audit — confirm what data leaves the operator's environment during runtime
- Contractual liability review — confirm who bears responsibility for AI-generated outputs

**Meridian product implication:** The buy/rent/build decision matrix must surface Column B governance obligations at the point a buyer identifies a Column B system — not as an afterthought.

---

---

# CATEGORY 3 — EXECUTION MODEL

**Promise Clause:** *"...turns landscape intelligence into grounded adoption decisions..."*
**Layer:** Diagnostic overlay
**Stack Position:** 3 of 6
**Why This Category Exists:** Execution mode is the most diagnostically valuable dimension for Layer 2 systems, where the same architectural class can produce dramatically different risk profiles depending on how it is triggered. Surfacing execution mode early in Meridian's classification flow changes architecture decisions before systems are built.

**Applicable Activities:** System evaluation · Architecture guidance · Governance requirement mapping

---

### 3.1 Synchronous Mode

**Reference ID:** 3.1
**Description:** The system waits for a human prompt and responds immediately. The human is always the initiating actor.

**Characteristics:** Real-time response, human-initiated, bounded by the interaction session.

**Typical layers:** Layer 1 (always synchronous). Layer 2 (IDE autocomplete, chat-triggered agent tasks).

**Governance posture:** Lowest risk posture. Human is in the loop at every initiation event.

**Example:** Chat interface, IDE code suggestion, prompt-triggered document review.

---

### 3.2 Asynchronous Mode

**Reference ID:** 3.2
**Description:** The system processes large datasets or tasks offline, without real-time human interaction. Results are returned after processing completes.

**Characteristics:** Batch-triggered, no real-time oversight, human reviews output after completion.

**Typical layers:** Layer 2 (batch document processing, evaluation pipelines). Layer 3 (large-scale automated pipelines).

**Governance posture:** Medium risk. Human sees output but does not monitor execution. Audit trail and output validation are critical.

**Example:** Extracting metadata from thousands of legacy documents overnight. Running evals across a model output dataset.

---

### 3.3 Continuous Mode

**Reference ID:** 3.3
**Description:** The system listens for environmental triggers and autonomously initiates workflows. It runs until stopped. Nobody asks it to start; nobody tells it to stop.

**Characteristics:** Event-driven, persistent, no human in the normal operating loop.

**Typical layers:** Layer 3 (defining mode). Advanced Layer 2C (event-triggered supervised agents).

**Governance posture:** Highest risk posture. System acts without human awareness. Circuit breakers, escalation paths, and comprehensive audit trails are mandatory.

**Example:** A webhook from a new GitHub PR triggers a full agent review pipeline. An incoming email triggers autonomous triage and routing. A data pipeline change fires a compliance check.

**Meridian product implication:** Any system identified as continuous must be flagged explicitly in the evaluation protocol. These are the systems most likely to act without human awareness in a production environment.

---

### 3.4 Mode-Layer Affinity and Diagnostic Value

**Reference ID:** 3.4
**Description:** The relationship between execution mode and layer classification, and where the diagnostic value is highest.

**Affinity map:**

| Mode | Layer affinity | Diagnostic value |
|---|---|---|
| Synchronous | Layer 1 (always); Layer 2 (common) | Low — mode confirms Layer 1 classification |
| Asynchronous | Layer 2C / 3C (primary) | Medium — distinguishes processing-heavy 2C from synchronous 2C |
| Continuous | Layer 3 (defining) | High — identifies highest-governance systems; common misclassification point |

**Highest diagnostic value:** Layer 2 systems. A supervised agent can legitimately operate in all three modes simultaneously. A Layer 2C agent that processes documents in batch, responds to IDE prompts synchronously, and triggers on GitHub webhooks uses all three modes — each requiring different infrastructure and oversight patterns.

**Meridian product implication:** The execution mode classifier is surfaced through ref 4.7 (Execution Mode Classifier) as a secondary question after layer/column classification. It deepens the classification; it does not replace it. Harness Posture (ref 4.8) is evaluated after execution mode to determine whether the operator can safely support the identified trigger pattern.

---

---

# CATEGORY 4 — THE DECISION SURFACE

**Promise Clause:** *"...a living system that makes the right questions visible..."*
**Layer:** Product capability
**Stack Position:** 4 of 6
**Why This Category Exists:** The classification system and governance plane are the intellectual foundation. The decision surface is the product that makes that foundation accessible and actionable for enterprise buyers who are not AI architects. This is what Meridian looks like and how it behaves as a product.

**Applicable Activities:** Product development · UX design · MVP scoping · Persona testing

---

### 4.1 Interactive AI Landscape Explorer

**Reference ID:** 4.1
**Description:** The primary discovery surface. An interactive, filterable view of the AI landscape organised by the Layer × Column taxonomy.

**Core capabilities:**
- Filter by layer (0–3), column (A/B/C), execution mode, or category (orchestration, observability, guardrails, etc.)
- Chip-level classification with deployment model indicators (hosted SaaS vs. self-hosted)
- Section-level descriptions explaining what each category does and when to use it
- Distinction between tools that build systems (infrastructure) and products that are themselves systems (e.g. Dify, n8n as 2B products)
- Recommendation annotations showing minimum Harness Posture where a use case or deployment pattern depends on operator capability

**MVP scope:** The ai_agent_capability_map_v2 artifact is the functional MVP of this capability. It requires extension with layer/column filtering, governance obligation linking, and Harness Posture annotation before it is a decision tool rather than a reference map.

**Versioned artifact:** ai_agent_capability_map_v2.html

---

### 4.2 Buy / Rent / Build Decision Matrix

**Reference ID:** 4.2
**Description:** The primary decision guidance surface. Translates a buyer's requirements, validated Harness Posture, risk profile, and governance obligations into a structured recommendation: buy a native product (A), rent a third-party product (B), or build internal (C).

**Core logic:**

| Signal | Recommendation direction |
|---|---|
| Regulated environment with strict data residency and operator can sustain owned-runtime controls | Build (2C) |
| Standard enterprise use case; vendor governance acceptable | Rent (2B) |
| Model vendor ecosystem deeply embedded | Buy (2A) |
| Need runtime ownership for compliance and validated posture supports it | Build (2C) |
| Speed to value is primary constraint | Rent (2B) |
| Proprietary domain knowledge is the differentiator | Build (2C) |
| Continuous/autonomous mode required with full audit and validated posture supports continuous operation | Build (2C or 3C) |

**Harness Posture as a decision signal (v0.4 draft):**

| Validated posture | Recommendation tendency | Why |
|---|---|---|
| H0–H1 | Bias toward Buy (A) or Rent (B) | Operator lacks strong owned-runtime governance controls |
| H2 | Bounded 1C / 2B / some 2C viable | Operator can run repeatable workflows but may not support high-governance continuous systems |
| H3 | 2C becomes realistic where strategic need justifies ownership | Operator can absorb serious governance obligations |
| H4 | Continuous 2C / 3C can be considered | Operator has autonomous-operation control architecture |

**Requested vs. validated rule (v0.4 draft):** Meridian distinguishes between the buyer's requested target and the safest system profile that can be responsibly operated now. If the requested profile exceeds the validated posture floor, Meridian recommends the validated profile, identifies the delta as a Harness Gap, and routes the buyer through a downgrade or deployment-deferral path (refs 4.5, 4.6, 4.8).

**Counter-signals — when NOT to build (v0.3):**

| Signal | Why building is the wrong choice |
|---|---|
| Team lacks governance engineering capability | Column C requires the operator to supply all governance — audit trails, guardrails, escalation paths, monitoring. If the team cannot build and maintain these, the governance gap is worse than the vendor dependency risk. Rent (2B) with rigorous vendor due diligence (ref 2.5) is safer. |
| Use case is non-differentiating and well-served by existing products | Building a custom agent for a commodity use case (e.g. code review, document summarisation) that mature 2A or 2B products already serve creates maintenance liability without competitive advantage. Buy (2A) or Rent (2B). |
| Time-to-production is critical and governance maturity is low | Column C systems require governance infrastructure before the system can operate responsibly. If the team needs to ship this quarter and has no governance layer, a governed 2B product with vendor controls is faster and lower-risk. |
| Regulatory environment is standard and vendor certifications cover it | If the vendor holds SOC 2 Type II, ISO 27001, and the operator's regulatory requirements are met by vendor certifications, the compliance burden of Column C exceeds the risk of Column B. |
| Total cost of governance ownership exceeds vendor licensing | Column C governance is not free. Audit pipelines, security infrastructure, monitoring, and compliance documentation are ongoing costs. If the cost of building and maintaining governance exceeds the vendor licensing cost for a governed 2B product, building destroys value. |

**Key question Meridian must answer that no substitute does:** "If I build it, what do I own? If I rent it, what do I still owe?"

**Complementary questions (v0.4 draft):**
- "If I build it, can I actually govern it? And if I can't, is renting safer than building without governance?"
- "What is the safest validated profile we can run right now without pretending our operator capability is higher than it is?"

---

### 4.3 Obligation Mapping

**Reference ID:** 4.3
**Description:** For any system at any Layer × Column coordinate, Meridian surfaces the governance obligations the operator must address and identifies who is responsible for each obligation.

**Obligation map by column:**

**Column A obligations:**

| Obligation | Responsible party | Evidence required | Tooling guidance |
|---|---|---|---|
| Appropriate use within vendor terms | Operator | Usage policy acknowledgment, internal use guidelines | Internal policy documentation |
| Prompt quality and output review | Operator | Review logs, quality standards | Quality assessment frameworks |
| Model safety and runtime integrity | Vendor | Vendor security documentation, model cards | N/A (vendor-supplied) |
| API availability and usage policy enforcement | Vendor | SLA documentation, uptime records | N/A (vendor-supplied) |

**Column B obligations:**

| Obligation | Responsible party | Evidence required | Tooling guidance |
|---|---|---|---|
| Vendor security review | Operator | SOC 2 Type II report, ISO 27001 cert, pen test reports | Vendor assessment framework (ref 4.5) |
| Data residency validation | Operator | Data processing agreement, residency confirmation | Data flow mapping tools |
| Training data consent | Operator | Written vendor confirmation, contractual clause | Legal review |
| Egress control audit | Operator | Network traffic analysis, data flow documentation | DLP tools, network monitoring |
| Contractual liability review | Operator | Liability clauses in vendor agreement | Legal review |
| Runtime security and feature quality | Vendor | Vendor's own certifications, incident response policy | N/A (vendor-supplied) |

**Column C obligations:**

| Obligation | Responsible party | Evidence required | Tooling guidance |
|---|---|---|---|
| Audit trail construction | Operator | Logged action records with full context | Langfuse (self-hosted), custom logging infrastructure |
| Guardrail implementation | Operator | Guardrail configuration, test results, bypass documentation | NeMo Guardrails, Lakera Guard (ref 5.6) |
| Escalation path design | Operator | Documented escalation rules, HITL approval model | Custom (see LuDRACO ref 7.1–7.4 for governed approach) |
| Governance documentation | Operator | System governance policy, operating procedures | Internal documentation |
| Regulatory mapping | Operator | Framework compliance matrix, evidence packages | Compliance tooling (framework-specific) |
| Runtime monitoring | Operator | Observability dashboards, alerting configuration | LangSmith, Langfuse, Datadog LLM Obs (ref 5.5) |
| All Column B obligations (self-applied) | Operator | Self-assessment against Column B checklist | Operator treats themselves as their own vendor |

**Obligation map maturity note (v0.3):** The obligation maps above represent the v0.3 structured format. They surface obligations, responsible parties, evidence requirements, and tooling guidance — but do not yet include validation criteria (how to confirm an obligation is met) or regulatory framework linkage (which specific regulations trigger which specific obligations). These two dimensions are required for Meridian to deliver a complete obligation mapping capability and are scoped for v0.4. Harness Posture (ref 4.8) does not change which obligations exist; it determines whether the operator can responsibly absorb them at the requested system profile.

**LuDRACO alignment note (v0.2):** LuDRACO v1.1.0 introduces hierarchical obligation weighting — all obligations are assigned strict priority classes at ingestion (Statutory Law > Contractual SLA > Internal Policy). This hierarchy provides a deterministic tie-breaker when obligations conflict, preventing deadlocks in automated rule engines. Meridian should surface this capability when buyers at the Column C obligation mapping step discover conflicting governance requirements they cannot resolve manually.

**Meridian product implication:** The obligation map must be surfaced once Meridian has established the system coordinate, execution mode, and operator-fit context. This is the moment of maximum value for the buyer and the moment of maximum differentiation from substitutes.

---

### 4.4 Regulatory and Governance Fit Guidance

**Reference ID:** 4.4
**Description:** Maps the buyer's regulatory environment to their system classification, and surfaces the specific governance requirements triggered by that combination.

**Regulatory frameworks in scope (v0.2):**
- EU AI Act — particularly high-risk AI system classification and conformity requirements
- GDPR — data processing, residency, and consent requirements for AI systems
- HIPAA — healthcare data processing constraints for AI-assisted systems
- SOC 2 Type II — trust service criteria applicable to AI runtime systems
- ISO 27001 — information security management requirements
- SEC AI guidance — disclosure and fiduciary requirements for AI in financial contexts
- NIST AI RMF — risk management framework for AI systems

**GTM priority alignment (v0.2):** LuDRACO's v1.1.0 GTM strategy narrows its initial regulatory target to SOC 2 Type II and ISO 27001, specifically serving B2B AI SaaS operators. Meridian's regulatory content covers the full scope above, but content depth and conversion event design should prioritise SOC 2 and ISO 27001 pathways first. Buyers arriving through these two frameworks represent the highest-probability LuDRACO conversion segment. Expansion to GDPR, HIPAA, and EU AI Act follows once the SOC 2 / ISO 27001 wedge is established.

**Guidance logic:** Regulatory requirements are additive to governance obligations. A Layer 3C system in a HIPAA-regulated environment carries the full Column C governance obligation *plus* HIPAA-specific requirements. The intersection must be surfaced, not listed separately. Regulated environments can also raise the minimum Harness Posture required for a recommendation even when the base system class is unchanged.

---

### 4.5 Vendor and Tool Evaluation Protocol

**Reference ID:** 4.5
**Description:** A structured intake protocol for evaluating any new tool before integration. Derived from the System Intake & Evaluation Protocol in the AI System Taxonomy v0.3 and extended in v0.4 draft with Harness Posture validation and routing logic.

**Six-step protocol:**

**Step 1 — Map the coordinates.**  
Identify Layer (0–3) and Column (A/B/C). If it is a commercial product you purchase, the column is B. If you built it for internal use, the column is C.

**Step 2 — Determine execution mode.**  
Synchronous, asynchronous, or continuous. For Layer 2C systems, document all modes in use.

**Step 3 — Capture the Requested System Profile.**  
Record the target system class, target execution pattern, and intended operating reach the buyer wants to deploy. This captures ambition without assuming the operator can safely support it yet.

**Step 4 — Validate Harness Posture.**  
Assign H0–H4 based on control evidence, not self-description. Meridian asks for architecture and operating facts, then validates posture from evidence classes defined in ref 4.8.

**Step 5 — Apply governance requirements and routing policy.**  
Surface obligations by column and by regulatory context, then compare the Requested System Profile to the Validated System Profile Meridian can responsibly recommend. If a Harness Gap exists, apply routing logic before final recommendation.

**Step 6 — Flag continuous systems.**  
Any system in continuous mode must be documented in the system inventory regardless of layer or column. Any Layer 3 or continuous Layer 2C recommendation requires posture-floor validation before Meridian can recommend production deployment.

**Requested vs. validated profile rule (v0.4 draft):**
- **Requested System Profile** = the system class, mode, and operating reach the buyer wants to run
- **Validated System Profile** = the system class, mode, and operating reach Meridian says the buyer can responsibly operate now

Meridian must not proceed directly from execution mode to recommendation. It must first validate whether the operator has the harness required to carry the requested profile responsibly.

**Harness Gap Routing Policy (v0.4 draft):**  
When the Requested System Profile exceeds the Validated Harness Posture, Meridian must route the buyer using one or more of four downgrade levers:

1. **Autonomy downgrade** — reduce trigger autonomy while preserving the general system purpose  
2. **Ownership downgrade** — reduce operator-owned runtime burden  
3. **Boundary downgrade** — reduce action reach or generative freedom  
4. **Deployment deferral** — do not recommend production deployment yet

**Deterministic fallback matrix:**

| Scenario | Condition | Routing action | Result |
|---|---|---|---|
| Autonomy downgrade | Requested profile includes continuous mode but validated posture is below the required floor | Strip continuous execution; require human trigger or batch execution | Continuous → Asynchronous or Synchronous |
| Ownership downgrade | Requested profile requires Column C ownership but validated posture cannot support owned runtime | Shift recommendation to a vendor-managed pattern | Build → Rent |
| Boundary downgrade | Requested profile includes broad generative or state-changing freedom but containment evidence is insufficient | Narrow the action or output surface | Open-ended / state-changing → bounded / approval-gated / read-only |
| Deployment deferral | No safe lower-profile fit exists without unacceptable risk | Defer production recommendation | Pilot / shadow / evaluation only |

**Protocol integrity note (v0.4 draft):** Harness Posture does not replace the governance requirements in this protocol. It determines whether the operator is currently equipped to satisfy them at the requested profile.

---

### 4.6 Use-Case and Workflow-to-Tool Mapping

**Reference ID:** 4.6
**Description:** Maps enterprise use cases and workflow types to the appropriate system class and tooling stack. Enables buyers who know what they want to do — but not what to use — to navigate to a recommendation.

**Use-case decision map (v0.4 draft):**

| Use case | Default recommendation | Why | Minimum Harness Posture | When to deviate | Fallback routing if posture insufficient | Deviation direction |
|---|---|---|---|---|---|---|
| Knowledge management and internal Q&A | Layer 1C with RAG (LlamaIndex, Haystack + internal vector store) | Internal data stays internal; no vendor sees queries or documents | H1 | Data is non-sensitive and team lacks RAG expertise | Ownership downgrade to 1B managed product if internal RAG controls are absent | Rent (1B) — e.g. Glean, Hebbia |
| Code generation and review | Layer 2A (Claude Code, GitHub Copilot) or 2B (Cursor) | Mature products with strong vendor governance; commodity use case | H1–H2 | Proprietary codebase with strict IP controls | Stay with 2A / 2B managed product before building 2C; add egress controls and approval gates first | Build (2C) with egress controls |
| Document processing at scale | Layer 2C asynchronous (LangGraph + batch pipeline) | Scale requires custom orchestration; batch mode needs audit trail | H2 | Volume is low and turnaround is not critical | Autonomy downgrade to smaller bounded batch workflow or ownership downgrade to vendor-managed extraction | Rent (2B) — commercial extraction products |
| Compliance monitoring | Layer 2C or 3C continuous (proprietary orchestration + guardrails) | Regulatory evidence must be operator-owned; continuous mode demands full governance | H3 for 2C, H4 for 3C continuous | Team lacks governance engineering capability | Autonomy downgrade from continuous to asynchronous review and/or ownership downgrade to 2B with vendor audit trail | Start with 2B with vendor audit trail; migrate to 2C when governance maturity permits |
| Multi-step research workflows | Layer 2C supervised (CrewAI, AutoGen with HITL gates) | Multi-step requires operator control over agent loop | H2 | Research is exploratory, not production-critical | Boundary downgrade to supervised low-reach workflow or autonomy downgrade to human-triggered research support | Use 1A / 1B conversational tools; defer agent build |
| Workflow automation with integrations | Layer 2B (n8n, Dify) or 2C if governance requires ownership | 2B is faster to deploy; 2C gives runtime ownership | H2 for bounded use, H3+ for regulated or state-changing use | Automation touches regulated data or requires audit trail | Boundary downgrade to read-only or approval-gated automation; ownership downgrade to governed vendor-managed product if owned runtime is not supportable | Build (2C) with full Column C governance |

**Routing rule (v0.4 draft):** The table above assumes the default recommendation is only valid if the minimum Harness Posture is met. If posture is below the minimum, Meridian must route to the specified fallback before recommending production deployment.

---

### 4.7 Execution Mode Classifier

**Reference ID:** 4.7
**Description:** The product surface for execution mode identification. Surfaced as a secondary question after layer/column classification, as specified in the mechanism flow. *(Added v0.3 — Red Team finding 7.)*

**Product behaviour:** After a buyer establishes their Layer × Column coordinate, Meridian asks: "How is this system triggered?" The answer determines execution mode and surfaces the corresponding governance posture. Harness Posture validation (ref 4.8) follows execution mode identification.

**Classification logic:**

| Trigger pattern | Execution mode | Governance posture surfaced |
|---|---|---|
| Human prompt, real-time response expected | Synchronous | Lowest risk — human in loop at every initiation |
| Batch job, offline processing, results returned after completion | Asynchronous | Medium risk — audit trail and output validation required |
| Environmental event, webhook, continuous listener, no human initiator | Continuous | Highest risk — circuit breakers, escalation paths, and comprehensive audit mandatory |
| Multiple triggers — system operates in more than one mode | Multi-modal | Each mode's governance posture applies independently; document all modes |

**Layer 2 emphasis:** For Layer 2 systems, the execution mode classifier is the highest-value secondary question. A 2C system operating in continuous mode carries a fundamentally different governance requirement than a 2C system operating synchronously — even though both occupy the same Layer × Column coordinate. This is where Meridian's classification depth exceeds any existing substitute.

**Relationship note (v0.4 draft):** Execution mode answers *how the system is triggered*. Harness Posture answers *whether the operator can safely support that trigger pattern*. Execution mode deepens system classification. Harness Posture deepens recommendation quality.

---

### 4.8 Harness Posture Classifier

**Reference ID:** 4.8
**Description:** The decision-surface module that validates the operator's current ability to safely operationalize, govern, monitor, constrain, and improve the classified AI system under the identified execution mode. *(Added v0.4 draft — Harness Posture integration.)*

**Canonical definition:** Harness Posture is the operator's validated ability to safely operationalize, govern, monitor, constrain, and improve the classified AI system under the identified execution mode. It is not a property of the tool alone; it is a property of the operator-system fit.

**Position in the mechanism:** Surfaced after Layer × Column classification and execution mode identification, and before obligation surfacing, routing policy, and buy/rent/build guidance.

**Evidence classes:**

| Evidence class | What it proves | Representative evidence |
|---|---|---|
| Policy evidence | Named accountability and documented operating intent exist | Production owner, operating procedure, review criteria, escalation policy |
| System evidence | The actual system has enforced controls | Permission boundaries, sandboxing, tool allowlists, approval gate implementation |
| Runtime evidence | The operator can detect, constrain, and intervene in live operation | Alerting, audit logs, runtime telemetry, rollback path, kill switch, circuit breaker |
| Assurance evidence | The operator can verify and improve the system over time | Test evidence, regression evidence, incident review trail, audit packages, change control record |

**Assignment rule (v0.4 draft):** Harness Posture is assigned at the highest level for which all mandatory evidence conditions are satisfied and no disqualifying condition is present. Meridian does not ask "How mature are you?" It asks for control facts and validates posture from those facts.

**Common disqualifiers:**
- No named production owner
- No durable audit trail for production actions
- No ability to halt execution after anomaly detection
- No review model for state-changing actions
- No runtime monitoring evidence for Layer 2+ operation

**H-scale:**

| Level | Name | Mandatory evidence | Typical fit | Disqualifiers for higher posture |
|---|---|---|---|---|
| H0 | Ad hoc | No durable operating scaffold; exploratory use only | Casual or fragmented AI use | No owner, no durable logging, no repeatable controls |
| H1 | Assisted | Named owner or team, documented intended use, basic output review norm, basic access control | Layer 1A / 1B / 1C, some low-risk 2A / 2B usage | No system-enforced controls, no audit trail for production tasks, no operational escalation path |
| H2 | Operational | All H1 controls plus enforced permission boundaries, bounded tool or action surface, durable execution logging, basic runtime monitoring, defined rollback or fallback action, documented approval logic for sensitive actions | Many 1C systems, many 2B systems, bounded 2C synchronous or asynchronous systems | No formal incident response path, no evidence packaging discipline, no containment for unexpected outputs or actions |
| H3 | Governed | All H2 controls plus formal audit trail retention, enforced review or approval model for governed actions, structured incident path, runtime observability with actionable alerting, evaluation or regression discipline, evidence package generation, change control | Serious 2C production deployments, regulated 2B deployments, some continuous 2C systems if continuous-specific controls are present | No circuit breaker for continuous execution, no event-trigger containment, no always-on oversight for persistent systems |
| H4 | Autonomous-ready | All H3 controls plus circuit breaker or equivalent hard-stop mechanism, event-trigger governance and containment, full-context logging for triggers and actions, persistent monitoring for unattended operation, explicit exception routing to human review, runtime isolation appropriate to system reach, tested recovery or shutdown procedure | Continuous 2C, Layer 3 evaluation and deployment, high-governance autonomous environments | N/A — highest posture tier |

**Posture floor logic (v0.4 draft):**

| System or mode pattern | Minimum posture floor |
|---|---|
| Layer 1 conversation use | H1 |
| Layer 2B synchronous | H1–H2 |
| Layer 2C synchronous | H2 |
| Layer 2C asynchronous | H2 |
| Layer 2C continuous | H3–H4 depending on action surface |
| Layer 3 continuous | H4 |
| Regulated Column C at Layer 2+ | H3 |
| State-changing continuous systems | H4 |

**Product behaviour:** Meridian captures the Requested System Profile, validates Harness Posture from evidence, compares the requested profile against posture-floor requirements, and applies the Harness Gap Routing Policy where necessary.

**Output behaviour:**
- Validated Harness Posture
- Requested System Profile
- Validated System Profile
- Harness Gap status
- Routing action, if any
- Recommendation rationale
- Required uplift actions before progression to a higher system profile

**Non-goal note (v0.4 draft):** Harness Posture is not a replacement for Layer × Column, not a generic enterprise AI maturity model, not a security certification framework, and not a synonym for MLOps / LLMOps tooling. It exists to sharpen Meridian's decision logic.


---

---

# CATEGORY 5 — THE TOOL ECOSYSTEM MAP

**Promise Clause:** *"...a living system that combines landscape discovery and implementation guidance..."*
**Layer:** Content layer
**Stack Position:** 5 of 6
**Why This Category Exists:** The tool ecosystem is the content that populates the landscape explorer. It is the living inventory that must be maintained, versioned, and classified using the Category 1 system. The ecosystem map has genuine IP value because of *how* it classifies tools — not just that it lists them.

**Applicable Activities:** Content maintenance · Competitive monitoring · Version control · Tool intake

**Ecosystem scope note (v0.3):** The tool ecosystem map currently provides detailed tooling guidance for Layers 0–2. Layer 3 tooling guidance (ref 5.8) is included at a structural level but is acknowledged as the thinnest section. Layer 3 is an emerging category where the market is still forming — commercial products are sparse and most implementations are proprietary. The ecosystem map will deepen Layer 3 coverage as the market matures. This gap is tracked and acknowledged rather than hidden.

---

### 5.1 Orchestration Frameworks

**Reference ID:** 5.1
**Description:** Libraries and frameworks that provide the wiring to chain model calls, tool invocations, memory, and state. These are construction materials — they build 2C systems; they are not themselves systems.

**Classification:** Builds 2C (these are infrastructure, not products)

**Sub-categories:**

**General-purpose:** LangChain, LangGraph, Litechain (JS), Orchestral, microAgents

**Multi-agent:** AutoGen, CrewAI, Agno

**Enterprise / language-specific:** Semantic Kernel (.NET), Akka (JVM), Rasa, Microsoft Bot Framework

**Key distinction for Meridian content:** Rasa occupies a unique position — it combines deterministic dialog management with LLM capability, making it the natural choice for regulated 2C environments where full probabilistic model freedom is not acceptable. This distinction must be surfaced in the tool description.

---

### 5.2 Tool Definition and Extension

**Reference ID:** 5.2
**Description:** Primitives that define the action surface a model can reach into. Without tool definition, an agent is constrained to Layer 1 regardless of the orchestration framework around it.

**Classification:** Cross-layer (applies across all Layer 2 classes)

**Tools:** LangChain Tools, MCP Toolbox (toolbox-langchain), langchain-dev-utils

**Key distinction for Meridian content:** Tool definition is the mechanism that makes Layer 2 work. It is architecturally foundational — a system without tool definition cannot meaningfully act, regardless of its orchestration sophistication.

---

### 5.3 RAG and Pipeline Frameworks

**Reference ID:** 5.3
**Description:** Frameworks for data ingestion, indexing, retrieval, and grounded response generation. Primary use in Layer 1C (knowledge chat) and Layer 2C (retrieval inside agent loops).

**Classification:** Enables 1C / 2C

**Tools:** LlamaIndex (data-ingestion first), Haystack (pipeline-architecture first)

**Key distinction:** LlamaIndex optimises for getting data into an index quickly. Haystack optimises for composing retrieval pipelines with explicit control over each stage. Choice depends on whether the primary constraint is ingestion speed or retrieval pipeline flexibility.

---

### 5.4 Vector Stores and Persistence

**Reference ID:** 5.4
**Description:** The database layer for semantic search and persistent agentic memory. Deployment model determines governance obligations — this is the most important classification dimension in this category.

**Critical distinction — self-hosted vs. hosted:**

| Tool | Deployment | Classification | Governance implication |
|---|---|---|---|
| pgvector | Self-hosted (Postgres extension) | Enables 1C / 2C | Operator owns data and runtime entirely |
| Milvus | Self-hostable (open source) | Enables 1C / 2C | Operator owns data and runtime entirely |
| Weaviate Cloud | Hosted SaaS | External vendor (0B) | Data residency obligations; vendor due diligence required |
| Pinecone | Hosted SaaS | External vendor (0B) | Data residency obligations; vendor due diligence required |

**Meridian product implication:** Hosted vector stores must be visually distinguished from self-hosted stores in the landscape explorer. Using a hosted vector store with enterprise data is a vendor relationship with data residency implications — not internal infrastructure. Visual treatment: dashed border for hosted SaaS chips.

---

### 5.5 Observability and Evaluation Tools

**Reference ID:** 5.5
**Description:** Telemetry infrastructure that sits beside agent systems to make their behaviour visible, measurable, and evaluable.

**Classification:** Cross-layer (horizontal infrastructure; does not map to A/B/C)

**Tools:** LangSmith (LangChain-native, hosted), Langfuse (open-source, self-hostable, MIT license), Helicone, Arize AI, Datadog LLM Observability

**Key content for Meridian:** Langfuse's MIT license and self-hostability make it the default recommendation for data-sensitive 2C environments where LangSmith's hosted nature creates data residency concerns. This distinction should be surfaced in the tool description.

---

### 5.6 Guardrail and Security Tools

**Reference ID:** 5.6
**Description:** Active protection layer. Intercepts and inspects AI inputs and outputs before and after execution to prevent injection, leakage, and unauthorized actions.

**Classification:** Cross-layer (applies to any Layer 2 or 3 system; mandatory at Layer 3)

**Tools:** NeMo Guardrails (NVIDIA, open-source, highly configurable), Lakera Guard (hosted API, enterprise-grade injection detection), Cloudflare AI Gateway (edge-level routing, rate limiting, caching, logging)

**Key content for Meridian:** These tools govern *before* or *at* execution, not after. This distinguishes them from observability tools (which record) and audit tools (which prove). The pre-execution governance posture is what makes them critical for Layer 3 systems.

---

### 5.7 Visual and Low-Code Builders (2B Products)

**Reference ID:** 5.7
**Description:** The exception category. These tools are not construction materials — they are Layer 2B products in their own right. Using them means operating a third-party agent system, not building an internal one.

**Classification:** Is 2B (these are products, not build tools)

**Tools:** Dify, n8n, Flowise, Langflow, Botpress

**Critical Meridian content:** A team that uses n8n to run an agent workflow is operating a 2B system. The runtime is vendor-owned. Governance obligations are the operator's; vendor controls are the vendor's. This must be stated explicitly and prominently in Meridian's product surface for this category — it is the most common misclassification in this space.

**Governance implication for 2B buyers:** Column B governance protocol (ref 2.5) applies. Data residency, training consent, and egress controls must be validated before connecting these systems to internal data.

---

### 5.8 Layer 3 — Autonomous and Continuous System Infrastructure

**Reference ID:** 5.8
**Description:** Infrastructure, patterns, and emerging tooling for Layer 3 systems — headless, continuous, event-driven systems operating without a human in the normal loop. *(Added v0.3 — Red Team finding 3.)*

**Classification:** Builds or enables 3C (autonomous system infrastructure)

**Why this section is thin:** Layer 3 is an emerging category. Most Layer 3 implementations are proprietary internal systems — built by companies for their own use, not productised. The commercial tooling market for Layer 3 is nascent. Meridian tracks this category because it carries the highest governance requirements of any system class, and buyers who discover they are operating Layer 3 systems need at minimum an architectural pattern reference.

**Architectural patterns for Layer 3 systems:**
- **Circuit breaker infrastructure:** Automated shutdown triggers when system behaviour exceeds defined parameters. Not optional at Layer 3 — a continuous system without a circuit breaker is ungovernable.
- **Escalation path infrastructure:** Mechanism for routing high-risk, low-confidence decisions to human review even in headless systems. Requires integration with alerting and on-call systems.
- **Comprehensive audit trail:** Every action, every trigger, every environmental event must be logged with full context. Without this, a Layer 3 system cannot be explained after the fact.
- **Event-driven orchestration:** Webhook listeners, message queue consumers, cron-triggered pipelines — the trigger infrastructure that makes a system continuous.

**Emerging tooling (v0.3):**
- Event-driven orchestration applicable to Layer 3: Temporal (workflow orchestration with durability guarantees), Apache Airflow (scheduled pipeline orchestration), Prefect (data pipeline orchestration with observability)
- Circuit breaker and escalation: largely custom-built; no dominant commercial product for AI-specific circuit breaking
- Guardrails at Layer 3: NeMo Guardrails and Lakera Guard (ref 5.6) apply at Layer 3; mandatory, not optional
- Observability at Layer 3: same tools as ref 5.5, but continuous monitoring configuration differs from Layer 2 batch monitoring

**Meridian product implication:** Layer 3 is where Meridian's classification value is highest and ecosystem content is thinnest. Buyers who classify a system as Layer 3 should be surfaced architectural patterns even when specific commercial tool recommendations are not available. The governance requirements are clear even when the tooling market is not.

---

---

# CATEGORY 6 — MARKET INTELLIGENCE AND RESEARCH INSTRUMENT

**Promise Clause:** *"...a living system..."*
**Layer:** Strategic layer
**Stack Position:** 6 of 6 · **INTERNAL ONLY — not buyer-facing** *(v0.3)*
**Why This Category Exists:** Meridian is not only a product for enterprise buyers. It is a research instrument for LuDRACO. Every buyer interaction surfaces pain points, reveals classification gaps, and identifies where the market is forming around governance infrastructure. This category governs how that intelligence is captured and used.

**Applicable Activities:** Market research · LuDRACO product development · Persona development · Monetisation · Partnership

**Classification independence rule (v0.3):** Category 6 content must never appear in any buyer-facing Meridian surface. Meridian's value depends on buyers trusting the classification system as independent. Category 6 documents the strategic relationship with LuDRACO, conversion event design, and monetisation — exposing this to buyers would collapse the independence that makes Categories 1–5 credible. All buyer-facing content draws from Categories 1–5 only. Category 6 is for program operators, product managers, and the LuDRACO team.

---

### 6.1 Target Personas

**Reference ID:** 6.1
**Description:** The enterprise decision-maker personas Meridian is designed to serve. Each persona arrives with different primary questions and different conversion events for LuDRACO.

| Persona | Primary Meridian question | LuDRACO conversion trigger |
|---|---|---|
| Enterprise Architect | "What should I build vs. buy, and what does owning the runtime actually require?" | Discovers 2C governance gap — no governance layer on their agentic stack |
| Chief Risk Officer | "Which of our AI systems could expose us to regulatory action, and which ones can we not currently audit?" | Discovers continuous systems with no audit trail |
| Compliance Officer | "What do our AI systems owe under GDPR, EU AI Act, HIPAA? Can we prove compliance?" | Discovers they have deployed high-risk AI with no evidence architecture |
| CTO / VP Engineering | "Are we actually owning our stack or just renting someone else's runtime?" | Discovers Column B misclassification — calls external products "internal agents" |
| General Counsel | "Who is liable when an AI system makes a bad decision? What can we prove?" | Discovers no chain of custody between AI decision and human accountability |

**GTM priority alignment (v0.2):** LuDRACO's narrowed GTM targets B2B AI SaaS operators seeking SOC 2 Type II and ISO 27001 compliance. Within this segment, the highest-probability conversion personas are the CTO / VP Engineering (discovers the 2C governance gap when evaluating SOC 2 audit readiness) and the Chief Risk Officer (discovers unauditable autonomous systems during ISO 27001 risk assessment). Meridian content, onboarding flows, and conversion event design should weight these two personas first for the initial GTM phase. The Enterprise Architect, Compliance Officer, and General Counsel personas remain in scope for the full product but are secondary conversion targets until the SOC 2 / ISO 27001 wedge is proven.

---

### 6.2 Pain Point Map

**Reference ID:** 6.2
**Description:** The structural pain points that Meridian's classification logic will surface during buyer interaction. These are the conversion events — the moments when a buyer realizes they have a problem they did not know to name.

**Pain point 1 — The accountability gap:** A buyer classifies a tool as Column C and realizes they own all governance obligations with no vendor fallback. The immediate question: "How do I govern something I own?" This is the primary LuDRACO entry point.

**Pain point 2 — The continuous system exposure:** A buyer identifies a system running in continuous mode and realizes it is acting without human awareness. No circuit breaker, no audit trail, no escalation path. This is the Layer 3 governance gap.

**Pain point 3 — The Column B misclassification:** A buyer discovers they have been treating Column B products as Column C systems. They call the vendor's runtime their "internal agent." The Hub reveals this misclassification and the governance exposure it creates.

**Pain point 4 — The regulatory gap without architecture:** A buyer in a regulated sector discovers they are under EU AI Act or SEC obligations with deployed AI systems they cannot explain or audit. The governed evidence chain — scoped to event integrity, timestamps, signatures, and custody links (not indefinite payload retention) — is the architectural answer to this gap.

**Pain point 5 — The HITL design gap:** A buyer building Layer 2C supervised agents realizes they have no formal model for what a human must approve, under what conditions, with what evidence. This maps directly to LuDRACO's human-agent collaboration layer (LuDRACO ref IDs 7.1–7.4).

**LuDRACO alignment note (v0.2):** LuDRACO v1.1.0 introduces safe harbor defaults and confidence-weighted escalation (LuDRACO ref IDs 4.5, 7.2) that directly address this pain point. Escalation triggers now algorithmically evaluate the risk profile of the obligation against the confidence score of the agent's proposed action. Low-risk, high-confidence edge cases are handled autonomously; high-risk operations are strictly governed. This prevents the "escalation death spiral" where surfacing every edge case to a human causes alert fatigue and negates the ROI of automation. Meridian should surface this capability as the answer when buyers at pain point 5 ask "how do I design the approval model?"

**Pain point 6 — The hosted data exposure:** A buyer discovers their vector store is a SaaS product they've been treating as internal infrastructure. Their enterprise embeddings are on a third-party server with data residency obligations they have not assessed.

**Pain point 7 — The harness gap (v0.4 draft):** A buyer correctly classifies a system and understands its governance obligations, but Meridian validates that the operator does not yet have the practical operating scaffold required to run the requested profile responsibly. The system is attractive in principle; the organization cannot safely carry it in practice.

---

### 6.3 Competitive Substitutes

**Reference ID:** 6.3
**Description:** What enterprise buyers currently use instead of Meridian. Understanding substitutes defines Meridian's positioning and the switching cost it must overcome.

| Substitute | What buyers actually get | Critical gap |
|---|---|---|
| Gartner / Forrester reports | Analyst opinion, vendor quadrants | Static, expensive, not actionable, no governance obligation mapping |
| G2 / Capterra / PeerSpot | User reviews, feature comparisons | Consumer-grade, no classification depth, no enterprise governance lens |
| GitHub awesome-lists | Raw tool inventories | Flat, unclassified, no decision logic, no obligation mapping |
| Vendor websites | Vendor's own framing | Commercially motivated, no independent buy/build/rent guidance |
| Consulting engagements | Custom advice | Slow, expensive, not scalable, locked in one firm's worldview |
| Internal architecture research | DIY synthesis | Takes months, often outdated, not maintained |
| Sequoia / a16z landscape maps | Investor-oriented landscape diagrams | Static, no decision logic, no governance layer, wrong audience |
| NIST AI RMF | Governance framework | Too abstract for tool selection; not a buying tool |

**Meridian's primary wedge:** None of these substitutes answers the obligation surfacing question — who is responsible for what when an enterprise uses a given AI system. That question is completely absent from every existing substitute. That is Meridian's structural competitive position.

---

### 6.4 LuDRACO Alignment and Conversion Events

**Reference ID:** 6.4
**Description:** The explicit mapping between Meridian's classification output and LuDRACO's product entry points. This is the strategic architecture that makes Meridian a business asset beyond its standalone value as a reference product.

**The strategic relationship:**
- Meridian creates problem awareness; LuDRACO sells the solution
- Meridian surfaces the governance obligation gap; LuDRACO provides the governed operating layer
- Meridian generates intent-aware traffic (buyers who already understand classification); LuDRACO benefits from dramatically shorter sales cycles

**LuDRACO architectural state (v0.2):** The following architectural decisions from LUDRACO-REF-001 v1.1.0 are now confirmed and affect the conversion event logic:

- **Formal verification boundary.** The Intent Pipeline outputs a strictly typed DSL that is semantically validated and cryptographically signed before the Deterministic Rule Engine accepts it. Raw LLM outputs are rejected. This is the structural answer to the "determinism paradox" — how a system that ingests probabilistic AI input can make a deterministic governance guarantee.
- **WAL-based golden thread.** Actions execute against a high-speed Write-Ahead Log and settle asynchronously onto the immutable ledger via cryptographic hash-chaining. This decouples execution speed from evidence integrity. Permanence applies to event integrity, timestamps, signatures, and custody links — not indefinite retention of sensitive payloads (subject to regulatory retention schedules).
- **Hierarchical obligation weighting.** All obligations are assigned strict priority classes at ingestion (Statutory Law > Contractual SLA > Internal Policy), providing a deterministic tie-breaker when obligations conflict.
- **Safe harbor defaults.** Escalation triggers evaluate both the risk profile of the obligation and the confidence score of the agent's proposed action. Low-risk, high-confidence edge cases are handled autonomously.
- **Narrowed GTM.** Initial regulatory target is SOC 2 Type II and ISO 27001, serving B2B AI SaaS operators. Expansion to GDPR, HIPAA, EU AI Act, and FCA follows.

**Conversion event map:**

| Meridian interaction | Pain point surfaced | LuDRACO product relevance |
|---|---|---|
| Buyer classifies a 2C system and reads Column C obligations | Accountability gap | LuDRACO is the governance operating layer for 2C systems |
| Buyer identifies a Layer 3 continuous system | No circuit breaker, no audit trail | LuDRACO's policy enforcement gate and golden thread (WAL architecture) |
| Buyer hits the HITL design section at Layer 2C | No formal approval model | LuDRACO ref IDs 7.1–7.4 (human-agent collaboration) with safe harbor defaults |
| Buyer reads the observability vs. governance distinction | Discovers pre-execution governance gap | LuDRACO governs before execution via the formal verification boundary (DSL); observability tools record after |
| Buyer in regulated sector reaches regulatory fit guidance | Evidence architecture gap | LuDRACO's golden thread as compliance infrastructure — prioritise SOC 2 / ISO 27001 pathways first |
| Buyer discovers conflicting obligations at Column C | No resolution mechanism for contradictory requirements | LuDRACO's hierarchical obligation weighting provides deterministic conflict resolution |
| Buyer requests a 2C or 3C system and fails Harness Posture validation | Harness gap — desired system exceeds current operator-fit | LuDRACO becomes relevant as the governed operating architecture that closes the operator-capability gap over time |

**LuDRACO cross-reference index:**

| Meridian ref ID | Maps to LuDRACO ref ID | Notes (v0.2 / v0.4 draft) |
|---|---|---|
| 2.1 (Governance scaling) | 8.1, 8.2 (Trust and compliance architecture) | — |
| 2.2 (Security & guardrails) | 5.4, 8.3 (Policy enforcement, security posture) | — |
| 2.3 (Observability) | 9.1, 9.2 (Observability and memory systems) | LuDRACO 2.1 (Intent Pipeline DSL) formalises the boundary between observation and governance |
| 2.4 (Compliance & audit) | 6.1–6.7 (The golden thread) | LuDRACO 6.1, 6.2 now specify WAL + async ledger settlement; 6.7 scoped to event integrity, not indefinite payload retention |
| 4.3 (Obligation mapping) | 3.1–3.6 (Obligation systems) | LuDRACO 3.2, 3.6 now include hierarchical obligation weighting with strict priority classes |
| 4.4 (Regulatory fit) | 10.3 (Regulatory tailwinds) | LuDRACO 3.4, 10.2, 10.4 narrowed to SOC 2 + ISO 27001 initial target |
| 4.8 (Harness Posture) | 7.1–7.4, 8.1–8.3, 9.1–9.2 | Meridian validates operator-fit; LuDRACO provides the governed operating architecture that can raise posture over time |
| 6.2 pain point 5 (HITL gap) | 7.1–7.4 (Human-agent collaboration) | LuDRACO 4.5, 7.2 add safe harbor defaults and confidence-weighted escalation |
| 6.2 pain point 7 (Harness gap) | 7.1–7.4, 8.1–8.3 | New internal conversion signal introduced in Meridian v0.4 draft |

**Open cross-reference item (v0.2):** LuDRACO baseline review (Finding 4) identified a developer experience gap — no dedicated ref ID for SDK design, API ergonomics, or onboarding. If a new LuDRACO ref ID is added for developer experience, a Meridian cross-reference entry should be added mapping to it from ref 4.6 (use-case and workflow mapping) or a new Meridian ref ID for developer-facing adoption content.

---

### 6.5 Research Tagging Protocol

**Reference ID:** 6.5
**Description:** The protocol for converting Meridian user behaviour and intelligence into structured research inputs for LuDRACO product development.

**Tagging rule:** Every piece of intelligence gathered through Hub user behaviour must be tagged against a Meridian Reference ID and at least one LuDRACO Reference ID before entering the research system. This is how the Hub becomes a governed research instrument rather than just a content product.

**Intelligence types to capture:**
- Which classification questions buyers cannot answer (reveals taxonomy gaps)
- Where buyers stop in the evaluation protocol (reveals UX and content friction points)
- Which pain points generate the most engagement (reveals LuDRACO messaging priority)
- Which regulatory frameworks buyers select most frequently (reveals market segment concentration)
- Which tools buyers are evaluating together (reveals buying patterns and competitor clusters)
- Where buyers fail Harness Posture validation or trigger routing logic (reveals operator-fit distribution and Harness Gap frequency)

**GTM intelligence priority (v0.2):** Given LuDRACO's narrowed GTM, the research tagging protocol should flag SOC 2 and ISO 27001 interactions with highest priority. Buyer behaviour around these two frameworks represents the most actionable product intelligence for the initial LuDRACO commercialisation phase.

---

### 6.6 Monetisation Paths

**Reference ID:** 6.6
**Description:** The revenue model options for Meridian as a standalone product. Sequenced by MVP viability and strategic alignment with the LuDRACO funnel.

**Path 1 — Sponsored placement for relevant vendors (near-term):** Vendors pay for featured placement within their correct classification category. Placement is classification-accurate — it does not override the taxonomy. A hosted vector store cannot be placed in the self-hosted section.

**Path 2 — Paid visibility for listed companies (near-term):** Extended tool profiles, case studies, integration guides. Revenue from tools wanting deeper coverage within their correct classification position.

**Path 3 — Targeted advertising to enterprise AI buyers (medium-term):** High-intent traffic from enterprise decision-makers at the governance obligation and buy/rent/build decision points. Valuable advertising surface for governance, compliance, and GRC vendors.

**Path 4 — LuDRACO conversion (strategic, ongoing):** The highest-value monetisation path. Buyers who discover the 2C governance gap through Meridian and convert to LuDRACO enterprise customers. This path is not advertising revenue — it is the strategic rationale for building Meridian.

**GTM alignment note (v0.2):** Path 4 conversion design should initially target the SOC 2 / ISO 27001 segment identified in LuDRACO's narrowed GTM. This means prioritising conversion events at regulatory fit guidance (ref 4.4) and obligation mapping (ref 4.3) for buyers who select SOC 2 or ISO 27001 as their framework. The B2B AI SaaS CTO/CRO persona (ref 6.1) is the primary conversion target for this phase.

**Monetisation integrity rule:** Meridian's classification accuracy is its core asset. Any monetisation path that compromises classification accuracy destroys the product's value proposition. Sponsored content must be clearly marked. Classification positions are never for sale.

**Monetisation conflict protocol (v0.3):** *(Added — Red Team finding 5.)*

- **Classification authority separation.** Classification decisions (ref 1.4, 1.5) are made by the classification team. Monetisation relationships (Paths 1–3) are managed by the commercial team. The classification team has no visibility into which vendors are paying customers. The commercial team has no authority over classification decisions. Reclassification of a paying vendor proceeds on taxonomic grounds alone.
- **Reclassification procedure for paying vendors.** If a paying vendor's product is reclassified to a different category, the vendor is notified of the new classification with reasoning. The vendor may submit a classification appeal using the adversarial classification protocol (ref 1.4). The appeal is evaluated by the classification team. Commercial relationship status is not disclosed to the classification team and is not a factor in the appeal.
- **Mandatory disclosure.** All sponsored placement (Path 1) and paid visibility (Path 2) content is clearly marked as paid in the buyer-facing surface. Buyers must be able to distinguish paid content from classification content at a glance.
- **Annual audit.** An annual review confirms that no classification decision has been influenced by a commercial relationship. Results are logged in the document governance record.

---

---

## VERSION HISTORY

| Version | Date | Status | Change Summary | Author |
|---|---|---|---|---|
| 0.4-draft | 2026-04-01 | DRAFT | Integrated Harness Posture PR v2 into the primary reference. Changes: updated the mechanism to capture Requested System Profile, validate Harness Posture, compare requested vs. validated profiles, and apply routing before final recommendation; hardened ref 4.2 with Harness Posture as an explicit decision signal; rewrote ref 4.5 from a four-step to a six-step protocol; rewrote ref 4.6 to include minimum posture and fallback routing; updated ref 4.7 to clarify the sequencing relationship between execution mode and Harness Posture; added new ref 4.8 Harness Posture Classifier with evidence classes, H0–H4 posture levels, assignment rule, disqualifiers, posture floors, and output behaviour; added pain point 7 (Harness Gap) to ref 6.2; extended ref 6.4 and ref 6.5 to capture Harness Gap conversion signals and research tagging; harmonised ref 4.3, ref 4.4, ref 3.4, the cross-reference index, and the build artifact record so the new routing logic does not conflict with the existing Meridian flow. Ref ID count: 36 (added 4.8). | Meridian Program |
| 0.3 | 2026-03-29 | SUPERSEDED | Red Team of Meridian v0.2. 10 findings across 4 severity levels (2 Critical, 3 High, 4 Medium, 1 Low). Changes: (Critical-1) Rewrote ref 4.3 obligation mapping from prose descriptions to structured obligation maps with columns for obligation, responsible party, evidence required, and tooling guidance — with maturity note scoping validation criteria and regulatory linkage for v0.4. Softened distinction table from "obligation mapping system" to "governance obligation surfacing system." (Critical-2) Added counter-signals table to ref 4.2 — five scenarios where building is wrong and renting is safer. Added complementary question. (High-3) Added ref 5.8 for Layer 3 autonomous system infrastructure with architectural patterns and emerging tooling, with explicit acknowledgment that this is the thinnest section. (High-4) Added Category 6 classification independence rule — Category 6 is internal-only, must not appear in buyer-facing surfaces. Added [INTERNAL] tag to stack diagram. Added document scope rule to How to Use. (High-5) Added monetisation conflict protocol to ref 6.6 — classification authority separation, reclassification procedure for paying vendors, mandatory disclosure, annual audit. Added adversarial classification protocol to ref 1.4. (Medium-6) Added Layer 0 scope rule to ref 1.1, mechanism scope note to mechanism flow, and mechanism scope column to layer table. (Medium-7) Added ref 4.7 Execution Mode Classifier as a product surface; updated ref 3.4 to reference it. (Medium-8) Rewrote ref 4.6 from flat list to decision map with columns for default recommendation, reasoning, deviation conditions, and deviation direction. (Medium-9) Scoped golden thread permanence in ref 6.2 pain point 4 and ref 6.4 architectural state block. Ref ID count: 35 (added 4.7, 5.8). | Meridian Program |
| 0.2 | 2026-03-29 | SUPERSEDED | Integrated three LuDRACO PRs: (1) LUDRACO-REF-001 v1.0.0 baseline creation confirming 10-category / 64 ref ID structure; (2) LUDRACO-REF-001 baseline readiness review validating cross-reference alignment and surfacing 6 findings; (3) LUDRACO-REF-001 v1.1.0 Red Team architecture and GTM hardening introducing formal verification boundary (DSL), WAL-based golden thread, hierarchical obligation weighting, safe harbor defaults, and narrowed GTM (SOC 2 + ISO 27001). Changes: added LuDRACO alignment notes to ref IDs 2.3, 2.4, 4.3, 4.4; updated conversion event map and cross-reference index in ref 6.4 with architectural state and notes column; added GTM priority alignment to ref IDs 6.1, 6.5, 6.6; enhanced pain point 5 in ref 6.2 with safe harbor default context; added new conversion event row for obligation conflict resolution; added open cross-reference item for LuDRACO developer experience gap. No Reference IDs added or removed. | Meridian Program |
| 0.1-baseline | 2026-03-29 | SUPERSEDED | Initial document. 6 categories, 33 numbered Reference IDs. Synthesised from full taxonomy development session including Layer Map v1, Quick Reference Card v1, AI System Taxonomy v0.3, Capability Map v1–v2, Gym Drive session, and Strategic Synthesis packet. | Meridian Program |
---

## DOCUMENT GOVERNANCE

| Field | Value |
|---|---|
| Review trigger | Red Team completion, major taxonomy change, new regulatory development, significant competitive shift, or quarterly program review |
| Amendment process | All changes versioned (minor: 0.Y.z, major: X.0.0), dated, and logged in Version History |
| Reference ID stability | Reference IDs 1.1–6.6 are stable from baseline. New topics append (4.7, 5.8 added at v0.3; 4.8 added at v0.4 draft); existing IDs are never reassigned |
| Deprecation | Deprecated topics marked DEPRECATED with date and reason — never deleted |
| Distribution | Categories 1–5: Internal · Strategic — share with explicit authorization only. Category 6: Internal only — never buyer-facing |
| Relationship to LuDRACO | This document is a strategic partner document to LUDRACO-REF-001. Cross-reference table maintained in ref ID 6.4. Meridian v0.4-draft remains aligned to LUDRACO-REF-001 v1.1.0 |

---

## CROSS-REFERENCE INDEX

| If you are working on... | Primary Meridian Reference IDs |
|---|---|
| Core taxonomy and classification | 1.1, 1.2, 1.3, 1.4, 1.5 |
| Governance obligation mapping | 2.1, 2.2, 2.3, 2.4, 2.5, 4.3 |
| Execution mode and architecture guidance | 3.1, 3.2, 3.3, 3.4, 4.7 |
| Product capabilities and MVP scope | 4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8 |
| Harness Posture and routing logic | 4.2, 4.5, 4.6, 4.7, 4.8, 6.2 |
| Tool ecosystem content (Layers 0–2) | 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7 |
| Tool ecosystem content (Layer 3) | 5.8 |
| LuDRACO alignment and conversion | 6.4 |
| Market positioning and competitive gaps | 6.3, 6.4 |
| Enterprise buyer personas | 6.1, 6.2 |
| Monetisation design and integrity | 6.6 |
| Research and intelligence capture | 6.2, 6.4, 6.5 |
| Regulatory content | 2.4, 4.4, 6.4 |
| Vector store governance | 5.4, 2.5 |
| Execution mode classification | 3.1, 3.2, 3.3, 3.4, 4.7, 4.8 |
| Classification independence and integrity | 1.4, 6.6 |

---

```
─────────────────────────────
BUILD ARTIFACT SET
─────────────────────────────
Deliverable produced:    MERIDIAN-PRIMARY-REFERENCE-v0.4-draft.md
Files or outputs:        1 versioned markdown file
Validation evidence:     6 categories, 36 numbered Reference IDs (1 added: 4.8),
                         Harness Posture PR v2 integrated and flow-checked:
                           Mechanism updated to requested → posture →
                           compare → obligations → routing → recommendation
                           Ref 3.4, ref 4.5, ref 4.7, and ref 4.8
                           sequencing harmonised
                           Ref 4.3 obligation surfacing aligned to the new
                           decision flow so posture does not conflict with
                           obligations
                           Ref 4.2, ref 4.5, and ref 4.6 routing logic
                           aligned so downgrade paths are deterministic
                           Category 6 pain point, conversion, and research
                           tagging logic extended to cover the Harness Gap
                           Cross-reference index and version history updated
Logical flow check:      No logical break introduced by the PR.
                         Harness Posture functions as a tertiary overlay,
                         not a competing taxonomy axis; Layer × Column
                         remains primary, execution mode remains secondary,
                         and buyer-facing / internal category boundaries
                         remain intact.
Source sweep:            MERIDIAN-REF-001 v0.3,
                         Harness Posture PR v1,
                         Pre-Commit Refinement Report,
                         Harness Posture PR v2
Acceptance criteria:     No existing Reference IDs reassigned ·
                         1 new Reference ID added (4.8) ·
                         Mechanism, protocol, and use-case routing aligned ·
                         Category 1 taxonomy preserved ·
                         Category 6 firewall preserved ·
                         Cross-reference index updated ·
                         Version history complete
Deviations from plan:    Two pre-existing consistency issues corrected:
                         ref 1.3 now refers to twelve canonical positions,
                         matching the 4 × 3 matrix already shown in v0.3;
                         historical Reference ID counts were normalised to
                         actual numbered ref entries.
Open implementation:     Ref 4.8 questionnaire UI and any numeric scoring
                         remain out of scope for this draft.
                         Ref 4.3 obligation maps still lack validation
                         criteria and regulatory framework linkage.
                         Ref 5.8 Layer 3 tooling remains thin and will
                         deepen as the market matures.
Recommended follow-up:   Finalise v0.4 by pressure-testing ref 4.8
                         evidence rules on real buyer scenarios, then
                         decide whether to freeze the H-scale wording
                         or refine it before release.
─────────────────────────────
MODE LOG
Date:          2026-04-01
Mode:          Integration → Consistency pass
Context:       Seated / Deep work / spec integration + flow validation
Topic:         Meridian Primary Reference — integrate Harness Posture
               PR v2 into v0.4-draft
Output type:   Updated governing reference + build artifact set
Key output:    v0.4-draft produced with 36 numbered Reference IDs, new ref 4.8,
               requested vs. validated profile logic, deterministic
               routing policy, and no logical conflict introduced into
               Meridian's stack or buyer flow
TOC status:    No TOC generated
Next mode:     Review — final wording pass or release-candidate prep
─────────────────────────────
```
