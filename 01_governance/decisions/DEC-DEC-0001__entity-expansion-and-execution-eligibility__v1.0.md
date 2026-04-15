---
artifact:
  title: "Decision Record"
  kind: "ADR"
  subtype: "DecisionRecord"
  artifact_id: "DEC-DEC-0001"
  version: "v1.0"
  status: "ACTIVE"
  classification: "INTERNAL"
  format: "markdown"
  tags: ["decision", "log", "founder", "pocket", "LuDRACO", "entity", "eligibility"]

ownership:
  canonical_author: "Alpha"
  owner_role: "Founder"

governance:
  created_at: "2026-03-21"
  updated_at: "2026-03-21"

portfolio:
  company: "Luphay Technologies"

intent:
  mission: "Capture a near-frictionless everyday decision."
---

# Decision — Expand Entity and adopt Execution Eligibility model in LuDRACO DNA

- ID: DEC-DEC-0001
- Date: 2026-03-21
- Type: Architecture / Canonical Definition
- Impact: High
- Reversal Cost: Medium-High
- Review Date: 2026-06-30

## Decision
Keep **Entity** as the first primitive in the canonical LuDRACO DNA chain and expand its definition beyond simple actor identity.

Adopt the following model:
- **Entity** remains a chain-level primitive.
- **Actor Requirements** are defined by the governing **Obligation**.
- Each Entity carries an **Execution Eligibility Profile** representing the time-varying state relevant to valid execution.
- Every valid **ControlRun** must bind to a sealed **Execution Eligibility Snapshot** captured at execution time.
- Evidence produced by an ineligible, unauthorized, out-of-scope, improperly delegated, or capacity-exceeded Entity is not treated as valid compliance-bearing state.

Canonical chain remains:

`Entities → DomainAssets → Obligations → Controls → ControlRuns → EvidenceItems`

## Why
The original LuDRACO Chain defines Entity primarily as the actor, agent, or system that triggers work or holds custody. That is directionally correct, but incomplete for domains where compliance validity depends not only on whether work occurred, but on whether the **right actor** performed it under the **right authority**, within the **right scope**, at the **right time**. fileciteturn6file6turn6file7

The Entity expansion analysis shows that PA Title 55 regulations expose a broader invariant: some obligations are only satisfied when the acting entity meets explicit actor requirements such as role, credential state, authority scope, delegation validity, and capacity constraints. This pattern is not Pennsylvania-specific; it generalizes across healthcare, finance, security, AI governance, operations, and other regulated systems. fileciteturn6file4turn6file5

The prior term **Qualification Profile** was useful but too narrow and too human-centered. The new term **Execution Eligibility Profile** better supports humans, organizations, service accounts, automations, AI agents, and multi-actor control runs while preserving the same intent. It also aligns better with system entities, offline execution, delegation chains, and human-only versus human-or-system obligation modes. fileciteturn6file2turn6file3turn6file5

This decision protects a core chain invariant: a technically complete ControlRun is not compliance-valid unless its acting Entity satisfies the governing Obligation's Actor Requirements at execution time. Therefore, actor legitimacy is elevated from an operational convenience to a chain-level validity condition. fileciteturn6file1turn6file4

## Other options
1. **Keep the original Entity definition unchanged**
   - Simpler, but too weak.
   - Fails to represent cases where the wrong actor invalidates otherwise well-executed work.

2. **Move Entity legitimacy entirely into Layer 2 or operational metadata**
   - Keeps the primitive chain cleaner on paper.
   - Rejected because it allows ControlRun and EvidenceItem structures to appear complete even when the actor was invalid.

3. **Keep “Qualification Profile” as the main term**
   - Works for licensed human roles.
   - Rejected because it underspecifies automation, service accounts, delegated systems, and broader authority-state logic.

4. **Make the chain Pennsylvania-specific**
   - Would fit current Keystone / Title 55 examples closely.
   - Rejected because LuDRACO DNA must remain domain-, sector-, and chapter-agnostic while preserving the same execution-validity intent.

## Risk
- **Model creep:** Entity could become overloaded if identity, authority, governance, and operational state are not kept conceptually separated.
- **Implementation complexity:** Eligibility evaluation introduces more work at ControlRun initiation, sealing, replay, and offline synchronization.
- **Naming migration:** Existing docs using “Qualification Profile” will need harmonization.
- **Overfitting risk:** Future writers may accidentally encode Pennsylvania-specific concepts into the universal primitive.

Mitigation:
- Keep **Entity** as the primitive.
- Keep **Actor Requirements** attached to **Obligations**.
- Treat **Execution Eligibility Profile** as the contextual state object used to test actor legitimacy.
- Seal only the execution-time **Eligibility Snapshot** into ControlRun / EvidenceItem history.

## Next step
1. Patch `LuDRACO-Chain.md` Section 3 using the approved wording.
2. Update `LuDRACO_Entity_Expansion_Analysis.md` to replace **Qualification Profile** with **Execution Eligibility Profile** and **Qualification Gate** with **Entity Eligibility Gate** where appropriate.
3. Propagate the same terminology into Keystone, RegPack Actor Model, ControlRun sealing requirements, and kernel panic conditions.
4. Record this as the canonical rationale for future architecture and IP references.
