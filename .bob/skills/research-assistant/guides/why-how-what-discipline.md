# Golden Circle Strategy Writing Discipline

Simon Sinek's Golden Circle framework: WHY → HOW → WHAT. Load this guide before generating or reviewing any Golden Circle strategy document.

---

## Core Principles

### Start With WHY

The WHY is the foundation. Write it first. Every other section must connect back to it.

The WHY describes:
- The fundamental belief driving the strategy
- The purpose and conviction behind it
- The change the organization wants to create in the world

The WHY answers: Why does this matter?

Not: What are we selling?

### Purpose Before Activities

Always present in this order:

**WHY → HOW → WHAT**

Never present:

~~WHAT → HOW → WHY~~

The solution should feel like a natural consequence of the belief, not the other way around.

### Authenticity Over Aspiration

Avoid generic mission statements. Prefer:
- Real observations and customer situations
- Real organizational beliefs and lived experiences
- Concrete examples over abstract aspirations

The WHY must feel credible. If it could belong to any company, it is not specific enough.

### Simplicity Over Jargon

Use language that executives, employees, customers, and partners can all understand without a glossary. When in doubt, use a concrete example rather than an abstract concept.

### Inspiration Grounded in Reality

The document should motivate but remain credible. Avoid:
- Grandiose claims
- Unsupported vision statements
- Artificial societal impact language

Link ambition to practical, observable outcomes.

---

## WHY Requirements

The most important section. Never compress or rush it.

### Core Belief

One sentence. Maximum 25 words. Describes what should be true in the world — not what the organization sells. If it reads like a product pitch, rewrite it. If it exceeds 25 words, tighten it — a belief that cannot be expressed concisely has not been fully understood.

### The Tension

The gap between current reality and desired future reality. A strong tension creates urgency. Weak strategies skip this.

Good tension:
- Customers need simplicity but face increasing complexity.
- Organizations require agility but operate through fragmented processes.

Weak tension:
- There are opportunities in the market.

### The Story

Three to four short paragraphs. Use a concrete example that covers:
1. The situation
2. The challenge and its consequences
3. The key insight discovered
4. The conviction that resulted

The story creates emotional understanding without becoming marketing content.

### Change We Want to See

Three statements: for customers, for the market, and for the long-term ecosystem. Focus on transformation, not impact claims.

---

## HOW Requirements

Translates belief into behaviour. Explains how the organization acts differently from competitors.

### Guiding Principles

Exactly 3 to 5 principles. Each must be:
- Memorable — can be recalled without notes
- Actionable — influences real decisions
- Specific — cannot be claimed by every company

Good: "Open ecosystems outperform isolated platforms."
Weak: "We believe in innovation."

### Strategic Choices

Document explicit trade-offs. Every strategy requires them. If no meaningful trade-offs can be identified, challenge the strategy — it is not yet a strategy.

**We Will:** [specific commitments]
**We Will Not:** [explicit exclusions]

### Why We Win

Four elements:
- **Market Assumption** — what most people believe
- **Contrarian Insight** — what we believe differently
- **Strategic Advantage** — why this creates value
- **Supporting Evidence** — concrete proof point

All four are required. An insight without evidence is a hypothesis.

### Customer Experience

Two to three sentences. Describes what customers feel — not what features they use. Focus on confidence, simplicity, and outcomes.

---

## WHAT Requirements

The expression of the strategy. Not the strategy itself. Always presented last.

### Offering

Two to three sentences on what is delivered, who receives value, and what outcomes are enabled. Outcomes before capabilities.

### Core Capabilities

For each capability: what it does and why it matters. Every capability must visibly support the HOW and WHY — if the connection is not clear, the capability does not belong.

### Evidence

Support key claims with metrics, examples, results, or reference points. Unsupported claims in the WHAT undermine the credibility of the entire document.

### Risks & Assumptions

Document major assumptions, key risks, and mitigation approaches. Acknowledging uncertainty increases credibility. A strategy that claims no risks has not been stress-tested.

---

## In Action Requirements

Translates the strategy into a practical, relatable situation.

- **Today** — current customer or organizational situation (concrete, not abstract)
- **With Our Approach** — how the strategy changes outcomes
- **Future State** — what success looks like when fully realized; must be tangible and believable

---

## Prohibited Language

Replace these terms with beliefs, outcomes, evidence, or examples:

| Prohibited | Replace with |
|------------|--------------|
| Industry-leading | [specific metric or ranking] |
| Best-in-class | [specific benchmark] |
| World-class | [specific evidence] |
| Transformational | [specific outcome] |
| Innovative | [specific novel approach] |
| Game-changing | [specific market impact] |
| Next-generation | [specific capability improvement] |
| Revolutionary | [specific behaviour change enabled] |
| Cutting-edge | [specific technical advantage] |
| Synergy | [specific combined capability] |
| Leverage | [specific use of existing asset] |

If a prohibited term appears in the draft, flag it and request a replacement before finalising.

---

## Automated Lint Checks

Run these checks before scoring. Flag any violation in the Structural Compliance table of the review file.

**WHY word count (Core Belief sentence):**
```bash
# Extract Core Belief line and count words (target: ≤ 25)
grep -A1 "## Core Belief" why-how-what.md | tail -1 | wc -w
```

**HOW principles count:**
```bash
# Count numbered guiding principles (target: 3–5)
awk '/## Guiding Principles/,/## Strategic Choices/' why-how-what.md | grep -c "^[0-9]\."
```

**Clarity Ratio (WHY < HOW < WHAT word counts):**
```bash
# WHY section word count
awk '/^# WHY:/,/^# HOW:/' why-how-what.md | wc -w

# HOW section word count
awk '/^# HOW:/,/^# WHAT:/' why-how-what.md | wc -w

# WHAT section word count
awk '/^# WHAT:/,/^# In Action/' why-how-what.md | wc -w
```
Target: WHY word count < HOW word count < WHAT word count. If the ratio is inverted, the document is over-explaining belief and under-delivering on execution detail.

**We/Our ratio (self-absorption check):**
```bash
# Count self-referential words
SELF=$(grep -oi '\bwe\b\|\bour\b\|\bus\b' why-how-what.md | wc -l)

# Count reader/customer-centric words
READER=$(grep -oi '\byou\b\|\byour\b\|\bcustomer\b\|\bcustomers\b' why-how-what.md | wc -l)

echo "Self: $SELF | Reader: $READER | Ratio: $READER:$SELF"
```
Target: reader-centric words ≥ self-referential words (ratio ≥ 1:1).

**Flesch-Kincaid readability (target: grade ≤ 8):**
```bash
python3 -c "
import re

# Install if needed: pip install textstat
try:
    import textstat
    text = open('why-how-what.md').read()
    # Strip markdown syntax
    text = re.sub(r'[#*_\[\]()]', '', text)
    grade = textstat.flesch_kincaid_grade(text)
    ease = textstat.flesch_reading_ease(text)
    print(f'Flesch-Kincaid Grade: {grade:.1f} (target ≤ 8)')
    print(f'Flesch Reading Ease: {ease:.1f} (target ≥ 60)')
except ImportError:
    print('Install textstat: pip install textstat')
"
```

**Prohibited language scan:**
```bash
grep -oi 'industry-leading\|best-in-class\|world-class\|transformational\|innovative\|game-changing\|next-generation\|revolutionary\|cutting-edge\|synergy\|leverage' why-how-what.md
```

---

## Quality Assessment

Score the completed document on each dimension from 0 to 5.

| Dimension | Score | Rationale |
|-----------|-------|-----------|
| Purpose Clarity | /5 | |
| Strategic Focus | /5 | |
| Narrative Coherence | /5 | |
| Differentiation | /5 | |
| Evidence Quality | /5 | |
| Customer Relevance | /5 | |
| Execution Realism | /5 | |
| Writing Clarity | /5 | |
| **Total** | **/40** | |

### Score Interpretation

| Score | Status |
|-------|--------|
| 35–40 | Executive Ready |
| 30–34 | Strong Draft |
| 25–29 | Needs Revision |
| Below 25 | Not Yet Strategic |

Provide a one-sentence rationale for every score. Do not leave rationale blank.

---

## Executive Success Criteria

A Golden Circle strategy document is complete only when a reader can answer all nine questions after one read-through:

1. What do we believe?
2. Why does it matter?
3. What must change?
4. How are we approaching the challenge?
5. What choices are we making?
6. What are we delivering?
7. Why will this succeed?
8. What does success look like?
9. What should happen next?

If any question cannot be answered clearly, continue refining the document before finalising.
