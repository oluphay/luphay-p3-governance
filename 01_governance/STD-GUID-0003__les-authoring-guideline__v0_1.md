---
id: STD-GUID-0003
title: LES Authoring Guideline
status: draft
version: v0.1
steward: Platform Governance / Alpha Kamara
governing_standard: STD-NORM-0002
related_artifacts:
  - id: STD-NORM-0002
    title: LES Core Specification
    relationship: governing-standard
    role: Normative authority — this guideline translates STD-NORM-0002
      rules into practical authoring guidance; where they conflict,
      STD-NORM-0002 governs
    direction: upstream

  - id: STD-REFR-0007
    title: LES Family Taxonomy Reference
    relationship: companion-reference
    role: Authoritative family definitions — read before choosing a family
    direction: peer

  - id: STD-REFR-0008
    title: LES Seed Catalog
    relationship: companion-reference
    role: Existing codes — consult to confirm non-duplication and
      understand authoring patterns in practice
    direction: peer

  - id: STD-TEMP-0015
    title: LES Catalog Entry Template
    relationship: operational-tool
    role: The template this guideline supports completing
    direction: peer
created_by: Alpha Kamara
created_at: 2026-04-12
---

# STD-GUID-0003 — LES Authoring Guideline
**Version:** v0.1 | **Status:** draft | **Governing standard:** STD-NORM-0002

---

## Changelog

### v0.1 — 2026-04-12
- Initial guideline. Covers the full authoring sequence for a LES code entry: family selection through petition submission. Derived from STD-NORM-0002, STD-REFR-0007, and WBS-01.3 v0.2.

---

## 1. Purpose

This guideline helps practitioners author conformant, useful LES codes. It translates the normative rules in STD-NORM-0002 into practical thinking steps, worked examples, and common mistake patterns.

This document is advisory — judgment is permitted. Where this guideline and STD-NORM-0002 conflict, STD-NORM-0002 governs.

**Who this is for:** anyone authoring a new LES code petition, reviewing an existing code for conformance, or consuming the LES registry for the first time.

---

## 2. Before you author

Three checks before writing anything:

**Check 1 — Does the code already exist?**
Open STD-REFR-0008 and search for codes in the family you have in mind. If a close match exists, map to it rather than creating a duplicate. Near-matches with different objects are the most common duplication pattern.

**Check 2 — Is the condition general enough?**
A LES code must be expressible across more than one Luphay system or context. Ask: *would a different Luphay system ever emit this failure?* If the answer is "only our system could have this problem," the condition belongs in your consuming standard's local handling, not in LES.

**Check 3 — Is this a petition or a mapping?**
If an existing code covers the condition — even loosely — it is a mapping. If genuinely no code covers it, it is a petition. Petitions require a completed STD-TEMP-0015.

---

## 3. Choosing FAMILY — the most important decision

Family is the hardest block to get right because multiple families can seem plausible for the same failure.

**Start with the three-question test:**

```
FAMILY   = what kind of thing is wrong?
CATEGORY = how is it wrong?
OBJECT   = what specific thing is affected?
```

Answer only the first question first. Do not jump ahead to category or object.

**Apply the family test:**
Write one sentence describing the failure without using any LES family names. Then ask: *what is the core nature of what is wrong?*

| If the answer is... | Consider family... |
|---|---|
| An identifier or name is inconsistent or unresolvable | IDENTITY |
| Something required was not supplied or cannot be found | INPUT |
| The current condition makes the action impossible | STATE |
| A truth that must always hold has been broken | INVARIANT |
| Stage, status, freshness, or lifecycle progression | LIFECYCLE |
| A reference link or evidence chain is missing or broken | TRACEABILITY |
| Permission or approval is missing or denied | AUTHORIZATION |
| A rule, mandate, or prohibition is violated | POLICY |
| A configuration or profile is missing or wrong | CONFIGURATION |
| A prerequisite is unavailable before the action begins | DEPENDENCY |
| The action ran and then failed | EXECUTION |
| Content consistency or hash agreement is broken | INTEGRITY |
| A hygiene gate or content scan failed | SANITIZATION |
| Source origin or issuer trust cannot be verified | PROVENANCE |
| Security controls, secrets, or threat detection | SECURITY |

**If two families still seem equally valid**, apply the boundary rules in STD-REFR-0007 §7. The boundary rules are deterministic — they will resolve the tie.

**Common family mistakes:**

*Naming the emitting component as the family.*
Bad: `LES__AGENT__FAILED__CONTRACT-CHECK`
Why wrong: AGENT is the emitter, not the failure type. The failure is about a missing contract — use INPUT or DEPENDENCY.
Correct: `LES__INPUT__MISSING__AGENT-CONTRACT`

*Using STATE as a catch-all.*
STATE is for invalid current-condition problems. It is not a fallback when nothing else fits. If you are reaching for STATE because you cannot decide, re-read the family list. LIFECYCLE, INVARIANT, DEPENDENCY, and EXECUTION are all more specific than STATE for their respective conditions.

*Confusing AUTHORIZATION and POLICY.*
AUTHORIZATION is about permission — can this actor do this action? POLICY is about compliance — has a governing rule been violated? An unauthorized action can also violate policy, but the primary failure is authorization if the question is about actor scope.

---

## 4. Choosing CATEGORY — the failure mode

Once family is confirmed, category answers: *how is the failure manifesting?*

Select from the preferred category bands for your family (STD-NORM-0002 §5.3 or STD-REFR-0007 §5). If no band word fits cleanly, propose a new category — but first check whether the mismatch indicates a wrong family selection.

**Preferred category selection logic:**

| If the governed thing... | Lean toward... |
|---|---|
| Is completely absent | MISSING |
| Exists but cannot be located or resolved | UNRESOLVED |
| Exists but the value is not recognized | INVALID |
| Exists but the action from it is not permitted | ILLEGAL (STATE only) |
| Exists but contradicts another declaration | MISMATCH or CONFLICT |
| A step ran and returned failure | FAILED |
| A step ran out of time | TIMEOUT |
| Was blocked before it could proceed | BLOCKED |
| Has exceeded a time or currency limit | STALE or EXPIRED |
| Has been violated as a rule | VIOLATION |
| Has been explicitly denied | DENIED |

**STATE — INVALID vs ILLEGAL (the most common STATE confusion):**
- `INVALID` — the state value is not recognized. It should not exist.
- `ILLEGAL` — the state value is recognized and valid, but the action being attempted from it is not permitted.

The test: can you find this state value in the system's declared state model? If no → INVALID. If yes, but the action is blocked → ILLEGAL.

**Common category mistakes:**

*Carrying family semantics into category.*
Bad: `LES__STATE__MISSING-INPUT__FILE`
Why wrong: MISSING-INPUT belongs in the FAMILY position (INPUT), not the category position.
Correct: `LES__INPUT__MISSING__FILE`

*Using the same category for everything in a family.*
If every code in your family uses FAILED, category is not doing its job. FAILED means the action ran and produced a failure result. It is not a general-purpose category for any bad outcome.

---

## 5. Choosing OBJECT — the affected target

Object answers: *what specific thing is affected?*

**The object is a noun, not a verb, not a sentence, not an explanation.**

Start with the most specific stable identifier for the affected thing. Then ask: *does this object need a qualifier to be unambiguous?* If yes, add one `-QUALIFIER`. If the qualifier itself needs narrowing, add another. Keep the object as short as the condition allows.

**Object vocabulary guidance:**

Prefer stable enterprise terms over local implementation labels:

| Instead of... | Use... |
|---|---|
| `agent_contract` (field name) | `AGENT-CONTRACT` |
| `sha256` (algorithm name) | `CONTENT-HASH` |
| `status` (generic) | `STATUS-TRANSITION` or `LIFECYCLE-STATUS` |
| `input_x` (local variable) | `REQUIRED-INPUT` |
| `the file that was supposed to be there` | `REQUIRED-ARTIFACT` |

**When to use compound object tokens:**
Use `-QUALIFIER` when the single primary token is ambiguous across multiple failure conditions in the same family/category. Example: `HASH` alone is ambiguous — is it a content hash or a signature hash? `CONTENT-HASH` is precise.

Do not compound for specificity that only matters to one consuming standard. If only LAMS would ever emit this object, it likely belongs in LAMS's local handling, not in LES.

**Common object mistakes:**

*Narrative in the object position.*
Bad: `LES__INPUT__MISSING__USER-DID-NOT-PROVIDE-THE-FILE`
Correct: `LES__INPUT__MISSING__REQUIRED-FILE`

*Using a field name as the object.*
Bad: `LES__INTEGRITY__MISMATCH__integrity_content_hash_sha256`
Correct: `LES__INTEGRITY__MISMATCH__CONTENT-HASH`

*Object that is too generic.*
Bad: `LES__DEPENDENCY__UNRESOLVED__THING`
The object must identify the affected thing with enough specificity to be useful in a log.
Correct: `LES__DEPENDENCY__UNRESOLVED__REQUIRED-ARTIFACT`

---

## 6. Writing the description

The description is the plain-language statement of the failure condition. It is read by both humans and agents.

**Five rules for descriptions:**

1. **State the condition, not the cause.** What is wrong, not why it happened.
2. **Enterprise scope, not consumer scope.** A reader who doesn't know LAMS should understand the condition.
3. **One to three sentences maximum.** If you need more, the code is probably too specific.
4. **No implementation jargon.** No field names, variable names, or stack trace language.
5. **Include examples if the condition is general.** A parenthetical `Example applications:` block is acceptable when the code covers a range of manifestations.

**Good description pattern:**
*[What exists or is happening] + [what is wrong with it] + [consequence for processing].* Optionally: `Example applications: ...`

**Worked example:**
`LES__IDENTITY__MISMATCH__ARTIFACT-ID`

Bad: *"The artifact_id field in the YAML front matter doesn't match the filename. This violates LAMS-MUST-03 and means the agent can't know which one is right."*

Good: *"The canonical identifier for an artifact or governed object disagrees across declared representations. The object cannot be reliably addressed until the conflict is resolved. Example applications: filename ID does not match front matter ID; registry ID does not match embedded object ID."*

---

## 7. Writing agent behavior

Agent behavior tells a consuming agent exactly what to do when it receives this code. Vague instructions produce inconsistent agent behavior.

**Structure:**

```
[PRIMARY ACTION] — [specific operational instruction]; [what to surface]; [what not to do]
```

Primary action choices:
- `REJECT` — halt immediately; do not proceed; surface the error
- `WARN` — surface the condition; continue with caution or apply declared policy
- `PROCEED` — the condition is informational; continue

**When to use each:**

| Primary action | Use when |
|---|---|
| REJECT | The failure makes proceeding unsafe, incorrect, or non-compliant |
| WARN | The failure is potentially recoverable or the system has a declared fallback |
| PROCEED | The condition is informational and should not block the operation |

**Variable behavior pattern:**
Some codes have agent behavior that depends on the consuming system's declared policy. In these cases state the variable first, then the default:

*"Apply the consuming system's declared freshness behavior — WARN, REJECT, or PROCEED. Default to WARN if no behavior is declared."*

---

## 8. Writing human action

Human action tells the operator what to do after the code fires. It must be actionable, not generic.

**Structure:**

1. **Investigate** — what to look at first
2. **Remediate** — what to fix
3. **Retry** — what condition allows a retry

Bad: *"Fix the problem and try again."*

Good: *"Review the artifact for currency; re-approve and update the review timestamp if still valid; retire and replace if superseded."*

---

## 9. Writing the dashboard label

The dashboard label is the short string that appears in log aggregation, metrics, and observability dashboards. It must be scannable at speed.

**Format:** `[family concept] [mode] — [object concept]`

**Rules:**
- All lowercase except proper nouns
- Maximum 8 words
- Use plain language — no LES grammar syntax
- Should match the code semantics without copying the code verbatim

| Code | Dashboard label |
|---|---|
| `LES__IDENTITY__MISMATCH__ARTIFACT-ID` | Identity mismatch — artifact ID |
| `LES__LIFECYCLE__STALE__ARTIFACT` | Lifecycle stale — artifact |
| `LES__EXECUTION__TIMEOUT__WORKFLOW-STEP` | Execution timeout — workflow step |
| `LES__SANITIZATION__FAILED__CONTENT-SCAN` | Sanitization failed — content scan |

---

## 10. Quick conformance check

Before submitting, parse your code mentally using this check:

```
LES__[FAMILY]__[CATEGORY]__[OBJECT]
 ↑      ↑          ↑          ↑
fixed  What       How       What thing
       kind?      wrong?    affected?
```

Then confirm:
- [ ] All characters uppercase
- [ ] `__` between every block (not `_`)
- [ ] `-` used only within blocks for qualification
- [ ] All three content blocks present
- [ ] FAMILY is in the STD-REFR-0007 controlled set
- [ ] CATEGORY is in the preferred band or formally proposed
- [ ] OBJECT is a noun identifying the affected thing — not a narrative
- [ ] Description is enterprise-scoped and 1–3 sentences
- [ ] Agent behavior has a primary action and operational detail
- [ ] Human action has investigate → remediate → retry structure
- [ ] Dashboard label is under 8 words, scannable, lowercase

---

## 11. Common mistakes reference

| Mistake | Pattern | Correction |
|---|---|---|
| Single-underscore delimiters | `LES_INPUT_MISSING_X` | `LES__INPUT__MISSING__X` |
| Emitter as family | `LES__AGENT__FAILED__Y` | `LES__EXECUTION__FAILED__Y` |
| Family work in category | `LES__STATE__MISSING-INPUT__Z` | `LES__INPUT__MISSING__Z` |
| Narrative in object | `LES__INPUT__MISSING__USER-FORGOT-IT` | `LES__INPUT__MISSING__REQUIRED-INPUT` |
| Missing OBJECT block | `LES__INPUT__MISSING` | `LES__INPUT__MISSING__REQUIRED-INPUT` |
| Consumer-specific object | `LES__INTEGRITY__MISMATCH__lams_content_hash` | `LES__INTEGRITY__MISMATCH__CONTENT-HASH` |
| INVALID vs ILLEGAL confusion | Using INVALID when state is recognized | Check: is the state value recognized? If yes and action is blocked → ILLEGAL |
| STATE as catch-all | Using STATE when LIFECYCLE or DEPENDENCY fits | Re-read family list; STATE is for non-lifecycle current-condition failures |
