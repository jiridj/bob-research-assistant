# Common Template Elements

> **Purpose:** Shared components used across all research assistant templates to maintain consistency and reduce repetition.

---

## Document Metadata Format

Use this standard footer for all templates:

```markdown
---

**Prepared By:** [Name/Team]
**Date:** [Date]
**Version:** [Version number]
**Classification:** [Confidential / Highly Confidential / Internal Use Only]
**Contact:** [Email/Contact information]
```

---

## Pandoc Conversion Commands

### Basic Conversion to Word

```bash
# Convert markdown to Word document
pandoc [filename].md -o [filename].docx
```

### With Table of Contents

```bash
# Add table of contents with 2 levels of depth
pandoc [filename].md --toc --toc-depth=2 -o [filename].docx
```

### With Corporate Template

```bash
# Use corporate Word template for styling
pandoc [filename].md --reference-doc=corporate-template.docx -o [filename].docx
```

### Combined Options

```bash
# Full conversion with TOC and corporate styling
pandoc [filename].md --toc --toc-depth=2 --reference-doc=corporate-template.docx -o [filename].docx
```

---

## Writing Guidelines

### Be Opinionated
- Take a clear stance - don't hedge
- Use strong language when warranted
- Back opinions with facts
- Acknowledge uncertainty but don't hide behind it

### Be Concise
- Every sentence must add value
- Cut fluff and jargon
- Use bullets and tables for clarity
- Target appropriate length for document type

### Be Honest
- Call out red flags clearly
- Don't oversell opportunities
- Acknowledge what you don't know
- Present both sides fairly, then make the call

### Be Actionable
- Clear recommendations
- Specific next steps
- Defined decision criteria
- Timeline for action

### Use Concrete Examples
- Show, don't tell
- Real scenarios over abstract concepts
- Specific numbers and metrics
- Named companies and products when relevant

---

## Common Section Templates

### Appendices Structure

```markdown
## Appendices

### Appendix A: [Topic]
[Content or link to detailed analysis]

### Appendix B: [Topic]
[Content or link to supporting materials]

### Appendix C: [Topic]
[Content or link to additional resources]

### Appendix D: Data Sources
**Primary Sources:**
- [Source 1 with date and link]
- [Source 2 with date and link]

**Secondary Sources:**
- [Source 1 with date and link]
- [Source 2 with date and link]
```

### Next Steps Template

```markdown
## Next Steps

**Immediate Actions:**
1. [Action 1 with owner and deadline]
2. [Action 2 with owner and deadline]
3. [Action 3 with owner and deadline]

**Follow-up Required:**
- [ ] [Item 1 - description and timeline]
- [ ] [Item 2 - description and timeline]
- [ ] [Item 3 - description and timeline]

**Timeline:**
- **[Date]:** [Milestone]
- **[Date]:** [Milestone]
- **[Date]:** [Milestone]
```

### Risk Assessment Template

```markdown
### Risk Assessment

| Risk | Probability | Impact | Mitigation Strategy |
|------|-------------|--------|---------------------|
| [Risk 1] | High/Med/Low | High/Med/Low | [Strategy] |
| [Risk 2] | High/Med/Low | High/Med/Low | [Strategy] |
| [Risk 3] | High/Med/Low | High/Med/Low | [Strategy] |

**Risk Scoring:**
- **High Impact + High Probability:** Immediate attention required
- **High Impact + Low Probability:** Monitor and prepare contingency
- **Low Impact + High Probability:** Accept or mitigate if cost-effective
- **Low Impact + Low Probability:** Accept risk
```

---

## Common Table Formats

### Rating Scale (5-star)

```markdown
★★★★★ - Excellent / Best in class
★★★★☆ - Very Good / Above average
★★★☆☆ - Good / Average
★★☆☆☆ - Fair / Below average
★☆☆☆☆ - Poor / Significant concerns
```

### Comparison Table

```markdown
| Dimension | Option A | Option B | Winner | Notes |
|-----------|----------|----------|--------|-------|
| [Criterion 1] | [Rating/Value] | [Rating/Value] | [A/B/Tie] | [Context] |
| [Criterion 2] | [Rating/Value] | [Rating/Value] | [A/B/Tie] | [Context] |
| [Criterion 3] | [Rating/Value] | [Rating/Value] | [A/B/Tie] | [Context] |
```

### Timeline/Milestone Table

```markdown
| Phase | Timeline | Key Activities | Success Criteria |
|-------|----------|----------------|------------------|
| [Phase 1] | [Duration] | [Activities] | [Criteria] |
| [Phase 2] | [Duration] | [Activities] | [Criteria] |
| [Phase 3] | [Duration] | [Activities] | [Criteria] |
```

---

## Usage Instructions

1. **Reference this file** at the top of each template with:
   ```markdown
   > 📚 **Shared Resources**: See [_common-elements.md](_common-elements.md) for document metadata, Pandoc commands, and writing guidelines.
   ```

2. **Don't duplicate** content that exists here - reference it instead

3. **Update centrally** - changes here apply to all templates

4. **Maintain consistency** - use these formats across all documents

---

**Last Updated:** 2026-06-20
**Maintained By:** Research Assistant Team