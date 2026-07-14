# PR-FAQ Writing Discipline

Amazon Working Backwards methodology. Load this guide before generating or reviewing any PR-FAQ.

---

## Core Principles

### Customer Obsession

Start with the customer. Work backwards.

Every major claim must answer:
- Who is the customer?
- What problem are they facing?
- Why does it matter?
- What outcome improves?

If the customer is unclear, identify and document assumptions before proceeding.

### Outcomes Before Features

Always present in this order:

**Problem → Outcome → Experience → Capability**

Never present:

~~Feature → Feature → Feature → Claimed Value~~

Customer value must be established before describing any functionality.

### Evidence Over Opinion

Prefer:
- Customer feedback and direct quotes
- Customer interview findings
- Market signals and data
- Usage data and behavioural patterns
- Real-world examples

Avoid unsupported opinions and speculative claims. When evidence is unavailable, explicitly flag the gap (see Customer Evidence Review below).

### Simplicity Over Jargon

Use plain business language. Avoid buzzwords, marketing language, technical jargon, and unnecessary acronyms. If a concept requires extensive explanation, simplify the language — or challenge the underlying idea.

---

## Document Length Limits

Hard limits. Exceeding them is a structural failure, not a style preference.

| Section | Word limit | Equivalent |
|---------|-----------|------------|
| Press Release | 500 words max | 1 Word page |
| FAQ section | 2,500 words max | 5 Word pages |
| Total document | 3,000 words hard cap | 6 Word pages |

Count words before finalising. If any limit is exceeded, cut — do not ask for an exception.

---

## Press Release Requirements

- Written as if the initiative has launched successfully
- Reads like a real external announcement
- Maximum 500 words
- Focuses on customer outcomes, not implementation details
- No feature dumps

**Structure — strict:**
- Title (H1): exactly 1 heading, maximum 15 words
- Subtitle (H2): exactly 1 heading, maximum 30 words
- Body: exactly 5 to 6 paragraph blocks separated by blank lines — no subheadings, no bullet lists, no bold or italic text inside paragraphs

The press release must clearly answer:
1. Who is it for?
2. What problem does it solve?
3. Why is it important?
4. What outcome improves?
5. Why should anybody care?

---

## FAQ Requirements

The FAQ must be longer and more detailed than the press release. Maximum 2,500 words total across all questions and answers.

**Structure — strict:**
- Questions use H3 headings (###): minimum 10, maximum 30 across the entire document
- Each answer is exactly one paragraph block. If an answer spills into multiple paragraphs, it counts against the word limit and signals the answer needs tightening
- No bullet lists, no bold or italic text inside answer paragraphs

Write it as if reviewed by skeptical senior leaders. It must challenge:
- Customer value — is this genuinely valuable?
- Strategic fit — why us, why now?
- Business value — how does this create return?
- Assumptions — what must be true for this to work?
- Risks — what could go wrong?
- Feasibility — can we actually build and deliver this?
- Differentiation — why can't a competitor replicate this immediately?

---

## Strategic Thinking Requirements

### Why Now?

Explain why current conditions make this the right time. Address at least one of:
- Market shift
- Customer behaviour change
- Technology enablement
- Regulatory or economic change
- Organizational readiness

### Why Us?

Explain why the organization is uniquely positioned. What do we have that others don't?

### Strategic Choices

Document explicit trade-offs:

**We Will:**
- [specific commitments]

**We Will Not:**
- [explicit exclusions]

Every strategy requires trade-offs. If no trade-offs are documented, the strategy is not yet complete.

---

## Customer Evidence Review

Assess available evidence before drafting. Classify each problem statement as:

- **Validated** — supported by direct customer evidence
- **Signal** — supported by indirect evidence (market data, analogies, usage patterns)
- **Assumption** — no current evidence; requires validation

If evidence is weak or absent, include this block in the document:

```
⚠ Customer Evidence Gap

This proposal contains limited direct customer validation.
The following problem statements remain assumptions requiring validation:
- [assumption 1]
- [assumption 2]
```

Do not omit the gap warning. Do not soften it.

---

## Red-Team Review

After generating the document, perform a mandatory critical review. This section is always included — never omitted.

Identify issues in each category:

### Unsupported Claims
Claims presented as facts that lack cited evidence.

### Weak Differentiation
Advantages that a well-resourced competitor could replicate within 12 months.

### Hidden Assumptions
Assumptions embedded in the narrative as if they were established facts.

### Adoption Risks
Specific reasons target customers may not adopt: switching costs, workflow disruption, trust barriers, competing priorities.

### Execution Risks
Specific reasons the initiative may fail to deliver: capability gaps, dependencies, timeline risks, resource constraints.

### Missing Information
Questions that must be answered before this document is investment-ready.

---

## Formatting Rules

Standard PR-FAQ discipline forbids formatting tricks to convey meaning. Enforce these counts:

| Element | Press Release | FAQ |
|---------|--------------|-----|
| Bullet or numbered lists | 0 | 0 |
| Bold or italic in body text | 0 | 0 |
| Images or diagrams | 0 | 0 (appendix only) |
| Subheadings inside PR body | 0 | n/a |

Bold syntax (`**`) is only acceptable on H3 question headers as rendered by the markdown parser. It must not appear as an author choice inside paragraph text.

Images and diagrams are strictly isolated to a separate appendix file if necessary. They must not appear in the PR or FAQ sections.

---

## Automated Lint Checks

Run these checks before scoring. Flag any violation in the Quality Assessment.

**Word count:**
```bash
# Total word count
wc -w pr-faq.md

# Press release section only (between # PRESS RELEASE and # FAQ)
awk '/^# PRESS RELEASE/,/^# FAQ/' pr-faq.md | wc -w
```

**Heading counts:**
```bash
# Count H1 headings (expect exactly 1 in PR)
grep -c "^# " pr-faq.md

# Count H3 question headings (expect 10–30)
grep -c "^### " pr-faq.md
```

**Formatting violations:**
```bash
# Bullet lists in PR section (expect 0)
awk '/^# PRESS RELEASE/,/^# FAQ/' pr-faq.md | grep -c "^[*-] "

# Bold/italic in body paragraphs (expect 0 outside headers)
grep -v "^#" pr-faq.md | grep -c "\*\*\|__\|\*[^*]\|_[^_]"
```

**Sentence length:**
```bash
# Approximate average words per sentence (target: under 25)
python3 -c "
import re, sys
text = open('pr-faq.md').read()
sentences = re.split(r'[.!?]+', text)
sentences = [s.strip() for s in sentences if len(s.split()) > 3]
avg = sum(len(s.split()) for s in sentences) / max(len(sentences), 1)
print(f'Sentences: {len(sentences)}, Avg words/sentence: {avg:.1f}')
"
```

Target: average sentence length under 25 words. Flag any sentence exceeding 40 words for revision.

---

## Prohibited Language

Replace these terms with specific outcomes, metrics, or evidence:

| Prohibited | Replace with |
|------------|--------------|
| Industry-leading | [specific metric or ranking] |
| Best-in-class | [specific benchmark] |
| World-class | [specific evidence] |
| Next-generation | [specific capability improvement] |
| Revolutionary | [specific behaviour change enabled] |
| Transformational | [specific outcome] |
| Innovative | [specific novel approach] |
| Cutting-edge | [specific technical advantage] |
| Game-changing | [specific market impact] |
| Synergy | [specific combined capability] |
| Leverage | [specific use of existing asset] |

If a prohibited term appears in the draft, flag it and request a replacement before finalising.

---

## Quality Assessment

Score the completed document on each dimension from 0 to 5. Run Automated Lint Checks first — structural violations automatically cap relevant dimension scores as noted.

### Content Dimensions

| Dimension | Score | Rationale |
|-----------|-------|-----------|
| Customer Problem Clarity | /5 | |
| Customer Benefit Strength | /5 | |
| Differentiation | /5 | |
| Evidence Quality | /5 | |
| Strategic Fit | /5 | |
| Business Viability | /5 | |
| Execution Feasibility | /5 | |
| Writing Clarity | /5 | |
| **Content Total** | **/40** | |

### Structural Compliance

Score each check: 2 = pass, 1 = minor violation, 0 = fail.

| Check | Target | Actual | Score |
|-------|--------|--------|-------|
| Total word count | ≤ 3,000 words | | /2 |
| Press release word count | ≤ 500 words | | /2 |
| FAQ word count | ≤ 2,500 words | | /2 |
| PR title word count | ≤ 15 words | | /2 |
| PR subtitle word count | ≤ 30 words | | /2 |
| PR body paragraph blocks | 5–6 blocks | | /2 |
| H3 question count | 10–30 questions | | /2 |
| Bullet/numbered lists in PR | 0 | | /2 |
| Bullet/numbered lists in FAQ | 0 | | /2 |
| Bold/italic in body paragraphs | 0 | | /2 |
| Average sentence length | < 25 words | | /2 |
| **Structural Total** | | | **/22** |

### Combined Score

| Component | Score |
|-----------|-------|
| Content Total | /40 |
| Structural Total | /22 |
| **Grand Total** | **/62** |

### Score Interpretation

| Grand Total | Status |
|-------------|--------|
| 55–62 | Executive Ready |
| 47–54 | Strong Draft |
| 38–46 | Requires Revision |
| Below 38 | Not Ready For Investment |

A document with a perfect Content score (40/40) but structural failures (< 18/22) cannot be Executive Ready. Structure is not optional.

Provide a one-sentence rationale for every content dimension score. Do not leave rationale blank. List every structural violation with its actual value.

---

## Executive Success Criteria

A PR-FAQ is complete only when an executive can quickly answer all nine questions from the document alone:

1. Who is this for?
2. What problem does it solve?
3. Why does it matter?
4. Why now?
5. Why us?
6. Why should we invest?
7. What evidence supports it?
8. What could go wrong?
9. What does success look like?

If any question cannot be answered clearly, the document requires further work before it is finalised.
