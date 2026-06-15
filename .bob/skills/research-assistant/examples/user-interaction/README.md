# User Interaction Examples

This directory contains examples demonstrating effective user interaction patterns for the Research Assistant skill.

## Overview

Effective user interaction requires:
- Understanding user intent
- Asking clarifying questions
- Maintaining conversation context
- Providing clear options
- Showing progress
- Suggesting next steps

## Examples

### [Complete Research Workflow](example-complete-workflow.md)

**Scenario**: End-to-end research project from initialization to final delivery

**Demonstrates**:
- Project initialization and scoping
- Source gathering (conversion and scraping)
- Multi-phase analysis (trends, comparison, framework)
- Report generation (multiple formats)
- Iterative refinement
- Complete delivery

**Key Concepts**:
- Maintaining context across 2-week project
- Proactive suggestions at each phase
- Progress updates for long operations
- Multiple deliverable formats
- Professional project completion

**Duration**: 2 weeks (20 hours of work)

**Deliverables**:
- Executive summary (3 pages)
- Full research report (24 pages)
- Presentation (13 slides)

**When to Use**:
- Comprehensive research projects
- Multiple sources and analysis types
- Professional deliverables required
- Timeline-driven work

## Interaction Patterns

### Pattern 1: Question-Driven Initialization

**When**: Starting new projects

**Approach**:
```
Bob: "Let me understand your needs:
1. What's your primary goal?
2. What's your timeline?
3. What deliverables do you need?
4. Do you have existing sources?"
```

**Benefits**:
- Clarifies scope upfront
- Sets expectations
- Identifies requirements
- Prevents rework

### Pattern 2: Progressive Disclosure

**When**: Complex multi-step workflows

**Approach**:
```
Bob: "We've completed:
✓ Project initialization
✓ Source gathering
→ Currently: Analysis phase

Next steps:
1. Trend analysis
2. Vendor comparison
3. Report generation"
```

**Benefits**:
- Shows progress
- Maintains context
- Reduces overwhelm
- Clear next steps

### Pattern 3: Option Presentation

**When**: Multiple valid paths forward

**Approach**:
```
Bob: "I can proceed in three ways:
1. Quick analysis (30 minutes)
2. Standard analysis (2 hours)
3. Deep analysis (4 hours)

Which fits your timeline?"
```

**Benefits**:
- Empowers user choice
- Sets time expectations
- Matches user needs
- Transparent about effort

### Pattern 4: Confirmation Before Action

**When**: Significant or destructive operations

**Approach**:
```
Bob: "I'll convert 5 PDFs to markdown:
- Output: sources/analyst-reports/
- Images: Excluded
- Naming: Descriptive with year

Proceed?"
```

**Benefits**:
- Prevents mistakes
- Confirms understanding
- Builds trust
- Allows corrections

### Pattern 5: Progress Updates

**When**: Long-running operations

**Approach**:
```
Bob: "Analyzing 7 sources...
✓ 1/7: Gartner report (12 trends)
✓ 2/7: Forrester report (8 trends)
→ 3/7: IDC report (in progress)"
```

**Benefits**:
- Reduces anxiety
- Shows activity
- Provides feedback
- Manages expectations

## Command Categories

### Document Conversion

**Common Commands**:
- "Convert [file] to markdown"
- "Process all PDFs in [folder]"
- "Convert [file] and export images"

**Response Pattern**:
1. Identify file location
2. Confirm target directory
3. Check image handling
4. Execute conversion
5. Report results

### Web Scraping

**Common Commands**:
- "Scrape [URL] to markdown"
- "Get content from [URL list]"
- "Extract [content] from [URL]"

**Response Pattern**:
1. Confirm URL(s)
2. Determine target directory
3. Execute scraping
4. Check for related links
5. Report results

### Research Tasks

**Common Commands**:
- "Start research on [topic]"
- "Find sources about [topic]"
- "Analyze [sources] for [purpose]"
- "Compare [item A] and [item B]"
- "Summarize findings on [topic]"

**Response Pattern**:
1. Clarify scope and goals
2. Identify or gather sources
3. Perform analysis
4. Create structured output
5. Suggest next steps

### Report Generation

**Common Commands**:
- "Create executive summary"
- "Generate competitive analysis report"
- "Export research to Word document"
- "Create literature review"

**Response Pattern**:
1. Review available content
2. Select appropriate template
3. Populate with findings
4. Generate document(s)
5. Offer additional formats

## Conversation Flow Stages

### Stage 1: Initialization

**Goals**:
- Understand requirements
- Set scope and timeline
- Create project structure
- Identify sources

**Key Questions**:
- What's your goal?
- What's your timeline?
- What deliverables do you need?
- Do you have existing sources?

### Stage 2: Source Gathering

**Goals**:
- Convert documents
- Scrape web content
- Organize materials
- Update indexes

**Key Actions**:
- Batch conversion
- Web scraping
- File organization
- Metadata creation

### Stage 3: Analysis

**Goals**:
- Extract insights
- Identify patterns
- Create comparisons
- Synthesize findings

**Key Outputs**:
- Trend analysis
- Comparison matrices
- Decision frameworks
- Synthesis documents

### Stage 4: Report Generation

**Goals**:
- Create deliverables
- Format professionally
- Export to required formats
- Deliver results

**Key Deliverables**:
- Executive summaries
- Full reports
- Presentations
- Supporting materials

### Stage 5: Completion

**Goals**:
- Confirm delivery
- Archive project
- Suggest follow-ups
- Close gracefully

**Key Actions**:
- Final confirmation
- File organization
- Next steps suggestion
- Professional closure

## Best Practices

### 1. Ask Before Acting

Always confirm significant actions:
```
Bob: "I'll convert 10 PDFs. This will take ~5 minutes. Proceed?"
```

### 2. Show Progress

Update during long operations:
```
Bob: "Converting PDFs... ✓ 3/10 complete"
```

### 3. Provide Context

Include relevant information:
```
Bob: "✓ Converted 45 pages
Last updated: 2024-03-15 (per document)
Related sources: 3 found"
```

### 4. Offer Options

Give users choices:
```
Bob: "I can:
1. Analyze now (2 hours)
2. Add more sources first
3. Review project setup"
```

### 5. Suggest Next Steps

Guide the workflow:
```
Bob: "Analysis complete! Next:
1. Create comparison matrix
2. Generate executive summary
3. Export to Word"
```

### 6. Maintain Context

Track conversation state:
```
Bob: "We've completed phases 1-3.
Currently: Report generation
Remaining: Final review and delivery"
```

### 7. Handle Errors Gracefully

Explain and suggest solutions:
```
Bob: "✗ Conversion failed: File password-protected

Solutions:
1. Remove password
2. Provide password
3. Skip this file"
```

### 8. Confirm Understanding

Repeat back what you understood:
```
Bob: "Let me confirm:
- Convert 5 PDFs
- Save to sources/analyst-reports/
- Exclude images
- Create project

Correct?"
```

## Common Scenarios

### Scenario 1: Unclear Request

**User**: "Analyze the report"

**Bob Response**:
```
"I found multiple reports. Which one?
1. gartner-mq-2024.pdf
2. forrester-wave-2024.pdf
3. idc-marketscape-2024.pdf

Or specify the file path."
```

### Scenario 2: Missing Information

**User**: "Convert PDFs to markdown"

**Bob Response**:
```
"I'll help convert PDFs. A few questions:
1. Where are the PDFs located?
2. Where should I save the markdown files?
3. Should I include images?
4. Any specific naming convention?"
```

### Scenario 3: Ambiguous Goal

**User**: "Research API management"

**Bob Response**:
```
"I can help with API management research. What's your focus?
1. Market trends and predictions
2. Vendor comparison
3. Technology evaluation
4. Implementation best practices
5. All of the above"
```

### Scenario 4: Time Constraints

**User**: "I need this by tomorrow"

**Bob Response**:
```
"I can deliver by tomorrow. To prioritize:
1. What's most critical? (trends, comparison, recommendations)
2. What format? (summary, full report, presentation)
3. What depth? (high-level, detailed, comprehensive)

I'll focus on what matters most for your timeline."
```

## Error Handling

### File Not Found

```
Bob: "✗ File not found: ~/Downloads/report.pdf

Please check:
1. File path is correct
2. File exists in location
3. You have read permissions

Or provide the correct path."
```

### Conversion Failed

```
Bob: "✗ Conversion failed: report.pdf

Error: Unsupported file format

Solutions:
1. Convert to PDF first
2. Use different tool
3. Provide alternative format"
```

### Network Error

```
Bob: "✗ Scraping failed: Connection timeout

Possible causes:
1. Website is down
2. Network connectivity issue
3. URL is incorrect

Would you like me to:
1. Retry
2. Try alternative URL
3. Skip for now"
```

### Analysis Error

```
Bob: "✗ Analysis incomplete: Insufficient data

Issue: Only 1 source available, need at least 2 for comparison

Solutions:
1. Add more sources
2. Change analysis type
3. Proceed with single-source analysis"
```

## Integration with Workflow

### Complete Research Flow

1. **Initialize** → [Folder Management Examples](../folder-management/)
2. **Gather Sources** → [Document Conversion](../document-conversion/), [Web Scraping](../web-scraping/)
3. **Analyze** → [Research Analysis Examples](../research-analysis/)
4. **Generate Reports** → [Report Generation Examples](../report-generation/)
5. **Deliver** → User Interaction (this directory)

## Related Documentation

### Guides
- [Common Commands Guide](../../guides/common-commands.md) - Individual command patterns
- [Conversation Flows Guide](../../guides/conversation-flows.md) - Multi-turn interactions

### Other Examples
- [Folder Management](../folder-management/) - Project organization
- [Document Conversion](../document-conversion/) - Converting sources
- [Web Scraping](../web-scraping/) - Gathering content
- [Research Analysis](../research-analysis/) - Analysis methodologies
- [Report Generation](../report-generation/) - Creating reports

### Main Documentation
- [Main SKILL.md](../../SKILL.md) - Complete skill documentation

## Summary

Effective user interaction:
- Asks clarifying questions
- Maintains conversation context
- Provides clear options
- Shows progress
- Confirms understanding
- Suggests next steps
- Handles errors gracefully
- Delivers professionally

Use these patterns to create smooth, efficient research workflows that meet user needs and exceed expectations.