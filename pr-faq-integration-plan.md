# PR-FAQ Integration Plan

## Overview

Integrate the Amazon Working Backwards PR-FAQ writing discipline into the Research Assistant skill.
The template (`templates/pr-faq.md`) already exists and is comprehensive. What is missing is:

1. The template is not registered in SKILL.md
2. No PR-FAQ writing discipline is encoded anywhere in the skill
3. No trigger phrases or workflow exist for PR-FAQ generation

The discipline will live in a new `guides/pr-faq-discipline.md` file, referenced from SKILL.md.
SKILL.md gets a registration entry, trigger phrases, and a lightweight PR-FAQ workflow.

---

## Sub-Tasks

---

### Sub-Task 1 — Create `guides/pr-faq-discipline.md`

**Intent:** Encode the full Amazon Working Backwards writing discipline in a dedicated guide file.
This is the authoritative reference Bob loads when generating or reviewing a PR-FAQ.

**Expected Outcomes:**
- File `guides/pr-faq-discipline.md` exists with the complete discipline
- Covers: Core Principles, Outcomes Before Features ordering, Evidence Over Opinion, Prohibited Language, Quality Scoring Rubric (8 dimensions × 0–5), Score Interpretation bands, and the 9 Executive Success Criteria questions

**Todo List:**
1. Create `.bob/skills/research-assistant/guides/pr-faq-discipline.md`
2. Write **Core Principles** section: Customer Obsession, Outcomes Before Features (Problem → Outcome → Experience → Capability ordering), Evidence Over Opinion, Simplicity Over Jargon
3. Write **Press Release Requirements** section: one-page limit, written as if launched, the 5 questions it must answer
4. Write **FAQ Requirements** section: longer than press release, must challenge value/strategy/assumptions/risks/feasibility/differentiation, written for skeptical senior leaders
5. Write **Strategic Thinking Requirements** section: Why Now, Why Us, We Will / We Will Not trade-offs
6. Write **Customer Evidence Review** section: evidence types, gap warning format
7. Write **Red-Team Review** section: 6 categories (Unsupported Claims, Weak Differentiation, Hidden Assumptions, Adoption Risks, Execution Risks, Missing Information)
8. Write **Prohibited Language** section: banned terms list + replacements
9. Write **Quality Assessment** section: 8 dimensions (Customer Problem Clarity, Customer Benefit Strength, Differentiation, Evidence Quality, Strategic Fit, Business Viability, Execution Feasibility, Writing Clarity), 0–5 each, score interpretation (35–40 Executive Ready / 30–34 Strong Draft / 25–29 Requires Revision / <25 Not Ready)
10. Write **Executive Success Criteria** section: the 9 questions an executive must be able to answer from the document

**Relevant Context:**
- The discipline definition provided by user (in conversation) is the source of truth
- `guides/conversation-flows.md` and `guides/quality-assurance.md` are examples of the guide file style
- Status: `[ ] pending`

---

### Sub-Task 2 — Register template and add workflow to `SKILL.md`

**Intent:** Wire the PR-FAQ capability into the skill so Bob knows when to use it, how to drive the
conversation, and where to find the discipline reference.

**Expected Outcomes:**
- `pr-faq.md` appears in the Available Templates list in SKILL.md
- New trigger phrases added for PR-FAQ generation
- New `### PR-FAQ Generation Flow` section under `## User Interaction Patterns`
- Reference to `guides/pr-faq-discipline.md` is explicit in the workflow

**Todo List:**
1. Add `pr-faq.md` to the Available Templates list in SKILL.md (after `why-how-what.md`, ~line 327)
2. Add PR-FAQ trigger phrases to the `### Other Commands` section:
   - `"Write a PR-FAQ for [initiative]"` → Start PR-FAQ Generation Flow
   - `"Draft a PR-FAQ"` → Start PR-FAQ Generation Flow
   - `"Work backwards from the customer"` → Start PR-FAQ Generation Flow
   - `"Review this PR-FAQ"` → Load discipline, run Red-Team Review + Quality Score only
3. Add a `### PR-FAQ Generation Flow` section under `## User Interaction Patterns` with:
   - **Stage 1 — Gather context**: Ask for initiative name, target customer/persona, core customer problem, any existing evidence or research
   - **Stage 2 — Apply discipline**: Load `guides/pr-faq-discipline.md`; populate template following Core Principles; never write Feature → Feature → Feature; flag any claims that lack evidence
   - **Stage 3 — Draft document**: Populate all sections of `templates/pr-faq.md`; Red-Team Review and Quality Score are **mandatory** — always include them; do not omit even if user doesn't ask
   - **Stage 4 — Export**: Use pandoc to produce DOCX output (same pattern as other report types)
   - **Review mode** (triggered by `"Review this PR-FAQ"`): Load discipline, run Red-Team Review and Quality Score against the provided document; output findings only — do not rewrite the document unless asked

**Relevant Context:**
- Available Templates list is at SKILL.md ~line 320–328
- Other Commands section is at SKILL.md ~line 712–731
- User Interaction Patterns section starts at SKILL.md ~line 633
- Import Flow (lines 635–708) is the model for how a staged workflow is written
- Status: `[ ] pending`

---

### Sub-Task 3 — Update skill description frontmatter

**Intent:** Ensure Bob's skill-selection logic recognises PR-FAQ requests and routes to this skill.

**Expected Outcomes:**
- SKILL.md frontmatter `description` field includes PR-FAQ trigger phrases
- The `whenToUse` field in `.bob/custom_modes.yaml` is consistent

**Todo List:**
1. Add to SKILL.md frontmatter `description`: `"write PR-FAQ"`, `"draft PR-FAQ"`, `"work backwards from customer"`, `"PR-FAQ for"` as trigger phrases
2. Check `.bob/custom_modes.yaml` `whenToUse` field — add `"PR-FAQ"`, `"working backwards"`, `"write PR-FAQ"` if not present

**Relevant Context:**
- SKILL.md frontmatter is lines 1–11
- `.bob/custom_modes.yaml` `whenToUse` is lines 49–55
- Status: `[ ] pending`

---

## File Changeset Summary

| File | Change |
|------|--------|
| `.bob/skills/research-assistant/guides/pr-faq-discipline.md` | **Create** — full writing discipline |
| `.bob/skills/research-assistant/SKILL.md` | **Edit** — register template, add workflow, add triggers |
| `.bob/custom_modes.yaml` | **Edit** — add PR-FAQ phrases to `whenToUse` |

No changes to `templates/pr-faq.md` — it is already complete.
