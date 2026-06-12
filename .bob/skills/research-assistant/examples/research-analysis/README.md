# Research Analysis Examples

This directory contains practical examples of different research analysis methodologies for synthesizing information, comparing competitors, tracking trends, and identifying gaps.

## Overview

Research analysis transforms raw sources into actionable insights. These examples demonstrate systematic approaches to different types of analysis, from literature reviews to competitive intelligence.

## Analysis Types

### [Literature Review](literature-review.md)
**Purpose**: Synthesize multiple sources on a topic to identify themes, patterns, and insights

**When to Use**:
- Understanding a new topic or domain
- Synthesizing analyst reports and documentation
- Identifying consensus and contradictions
- Building foundational knowledge

**Key Features**:
- Multi-source synthesis
- Theme identification
- Pattern recognition
- Structured documentation

**Example Scenario**: Creating a literature review on API management trends from Gartner and Forrester reports

**Typical Duration**: 3-5 days for 8-10 sources

### [Competitive Analysis](competitive-analysis.md)
**Purpose**: Compare competitors across capabilities, pricing, and positioning

**When to Use**:
- Vendor selection and evaluation
- Market positioning decisions
- Product strategy development
- Competitive intelligence

**Key Features**:
- Structured comparison matrices
- Strengths/weaknesses analysis
- Decision frameworks
- Strategic insights

**Example Scenario**: Comparing Kong, Apigee, and MuleSoft API gateways

**Typical Duration**: 4-7 days for 3-4 competitors

### [Trend Analysis](trend-analysis.md)
**Purpose**: Identify patterns and predict future directions using time-series data

**When to Use**:
- Strategic planning
- Market forecasting
- Technology adoption tracking
- Change detection

**Key Features**:
- Time-series comparison
- Pattern identification
- Future predictions
- Emerging theme detection

**Example Scenario**: Analyzing API security trends over 2 years using versioned sources

**Typical Duration**: 3-5 days with good versioned data

### [Gap Analysis](gap-analysis.md)
**Purpose**: Identify missing information and prioritize additional research

**When to Use**:
- Before making critical decisions
- When research feels incomplete
- Planning additional investigation
- Risk assessment

**Key Features**:
- Coverage assessment
- Gap prioritization
- Source recommendations
- Action planning

**Example Scenario**: Identifying gaps in API gateway vendor research

**Typical Duration**: 1-2 days for assessment

## Standard Research Process

All analysis types follow this general workflow:

### 1. Define Scope
- Clarify research question
- Set boundaries
- Identify audience
- Determine depth

### 2. Discover Sources
- Search across categories
- Use grep/find commands
- Identify relevant materials
- Assess source quality

### 3. Extract Information
- Use consistent templates
- Gather comparable data
- Note key findings
- Track sources

### 4. Synthesize Findings
- Identify patterns
- Compare across sources
- Note contradictions
- Build insights

### 5. Analyze & Conclude
- Draw conclusions
- Generate insights
- Make recommendations
- Assess confidence

### 6. Document Results
- Create structured report
- Include evidence
- Cite sources
- Provide appendices

### 7. Review & Validate
- Check completeness
- Verify accuracy
- Assess objectivity
- Get feedback

## Source Discovery Commands

### Find Sources by Category
```bash
# List all sources in a category
find sources/Gartner/ -name "*.md" -type f

# Count sources per category
find sources/ -type d -maxdepth 1 | while read dir; do
  echo "$(basename $dir): $(find $dir -name "*.md" 2>/dev/null | wc -l)"
done
```

### Search for Topics
```bash
# Find sources mentioning a topic
grep -r "API Gateway" sources/ --include="*.md" -l

# Search with context
grep -r -C 3 "microservices" sources/ --include="*.md"

# Find multiple terms
grep -r -E "security|authentication|authorization" sources/ --include="*.md" -l
```

### Find Recent Sources
```bash
# Sources from last 7 days
find sources/ -name "*.md" -mtime -7

# Sources from specific month
find sources/ -name "*-2024-06-*.md"

# List by date
ls -lt sources/**/*.md | head -20
```

### Find Versioned Sources
```bash
# Find all versions of a page
find sources/ -name "features-20*.md" | sort

# Compare versions
ls -t sources/Competitors/Kong/features-*.md | head -2
```

## Analysis Best Practices

### 1. Source Management
- **Track all sources**: Maintain complete source list
- **Note dates**: Record publication/scrape dates
- **Assess quality**: Evaluate source credibility
- **Document searches**: Record search strategies used

### 2. Extraction Consistency
- **Use templates**: Consistent extraction format
- **Same metrics**: Extract comparable information
- **Note confidence**: Flag uncertain information
- **Track changes**: Note when sources updated

### 3. Synthesis Rigor
- **Multiple sources**: Don't rely on single source
- **Look for patterns**: Identify recurring themes
- **Note contradictions**: Don't ignore conflicts
- **Distinguish facts from opinions**: Be objective

### 4. Analysis Quality
- **Evidence-based**: Support conclusions with data
- **Acknowledge limitations**: Note gaps and uncertainties
- **Consider alternatives**: Explore different interpretations
- **Avoid bias**: Check for confirmation bias

### 5. Documentation Standards
- **Clear structure**: Logical organization
- **Proper citations**: Reference all sources
- **Executive summary**: Quick overview
- **Appendices**: Supporting details

## Common Workflows

### Workflow 1: Vendor Evaluation
```
1. Literature Review → Understand market landscape
2. Competitive Analysis → Compare specific vendors
3. Gap Analysis → Identify missing information
4. Additional Research → Fill critical gaps
5. Final Recommendation → Make decision
```

### Workflow 2: Market Research
```
1. Literature Review → Current state understanding
2. Trend Analysis → Historical evolution
3. Gap Analysis → Future uncertainties
4. Predictions → Forward-looking insights
5. Strategy Recommendations → Actionable guidance
```

### Workflow 3: Technology Assessment
```
1. Literature Review → Technology overview
2. Competitive Analysis → Solution comparison
3. Trend Analysis → Adoption trajectory
4. Gap Analysis → Implementation unknowns
5. Decision Framework → Selection criteria
```

## Quality Checklist

### Before Starting Analysis
- [ ] Research question clearly defined
- [ ] Scope and boundaries set
- [ ] Target audience identified
- [ ] Success criteria established
- [ ] Timeline and resources allocated

### During Analysis
- [ ] Sources systematically discovered
- [ ] Information consistently extracted
- [ ] Patterns objectively identified
- [ ] Contradictions acknowledged
- [ ] Progress documented

### After Analysis
- [ ] All sources cited
- [ ] Conclusions supported by evidence
- [ ] Limitations acknowledged
- [ ] Recommendations actionable
- [ ] Document well-structured
- [ ] Peer review completed

## Tools and Commands

### Source Discovery
```bash
# Find all markdown files
find sources/ -name "*.md" -type f

# Search for keywords
grep -r "keyword" sources/ --include="*.md"

# List by category
ls -R sources/
```

### Data Extraction
```bash
# Extract headings
grep -r "^##" sources/ --include="*.md"

# Extract lists
grep -r "^- " sources/ --include="*.md"

# Extract quotes
grep -r "^>" sources/ --include="*.md"
```

### Comparison
```bash
# Compare two files
diff file1.md file2.md

# Compare with context
diff -u file1.md file2.md

# Side-by-side comparison
diff -y file1.md file2.md
```

### Statistics
```bash
# Word count
wc -w sources/**/*.md

# Line count
wc -l sources/**/*.md

# File count
find sources/ -name "*.md" | wc -l
```

## Output Templates

### Executive Summary Template
```markdown
# [Analysis Type]: [Topic]

## Executive Summary
[2-3 paragraphs summarizing key findings]

## Key Findings
1. [Finding 1]
2. [Finding 2]
3. [Finding 3]

## Recommendations
1. [Recommendation 1]
2. [Recommendation 2]
3. [Recommendation 3]

## Next Steps
1. [Action 1]
2. [Action 2]
```

### Detailed Report Template
```markdown
# [Analysis Type]: [Topic]

## Executive Summary
[Overview]

## Methodology
[Approach and sources]

## Analysis
[Detailed findings]

## Conclusions
[Synthesis and insights]

## Recommendations
[Actionable guidance]

## Appendices
[Supporting materials]
```

## Common Pitfalls

### 1. Insufficient Sources
❌ Relying on 1-2 sources
✅ Use multiple sources for validation

### 2. Confirmation Bias
❌ Cherry-picking supporting evidence
✅ Actively seek contradictory evidence

### 3. Outdated Information
❌ Using old sources without noting
✅ Check dates and use recent sources

### 4. Lack of Structure
❌ Unorganized findings
✅ Use consistent templates and frameworks

### 5. Weak Conclusions
❌ Conclusions not supported by evidence
✅ Link conclusions directly to findings

### 6. Missing Context
❌ Analyzing in isolation
✅ Consider market and external factors

### 7. Poor Documentation
❌ Missing sources or unclear citations
✅ Properly cite and document everything

## Integration with Workflow

### After Document Conversion
1. Convert PDFs/documents to markdown
2. Organize in appropriate categories
3. Begin analysis using examples

### After Web Scraping
1. Scrape competitor/documentation sites
2. Version for change tracking
3. Analyze using appropriate methodology

### Before Report Generation
1. Complete analysis
2. Synthesize findings
3. Generate final report using pandoc

## Related Documentation

- [Document Conversion Examples](../document-conversion/) - Converting sources to markdown
- [Web Scraping Examples](../web-scraping/) - Gathering web-based sources
- [Report Generation Examples](../report-generation/) - Creating final reports
- [Main SKILL.md](../../SKILL.md) - Complete skill documentation

## Advanced Topics

### Multi-Dimensional Analysis
Combine multiple analysis types:
- Literature Review + Competitive Analysis
- Trend Analysis + Gap Analysis
- All four for comprehensive research

### Automated Analysis
Use scripts to:
- Extract common patterns
- Generate comparison matrices
- Track changes over time
- Identify emerging themes

### Collaborative Analysis
Best practices for team research:
- Divide sources among team members
- Use consistent templates
- Regular synthesis meetings
- Shared documentation

## Support

For questions or issues:
1. Review the specific analysis example
2. Check the best practices section
3. Consult the main SKILL.md
4. Refer to source discovery commands

## Examples Summary

| Analysis Type | Duration | Complexity | Best For |
|---------------|----------|------------|----------|
| Literature Review | 3-5 days | Medium | Understanding topics |
| Competitive Analysis | 4-7 days | High | Vendor selection |
| Trend Analysis | 3-5 days | Medium | Forecasting |
| Gap Analysis | 1-2 days | Low | Planning research |

Choose the analysis type based on your research objectives and available time.