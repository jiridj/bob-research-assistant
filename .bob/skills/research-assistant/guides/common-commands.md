# Common Commands Guide

This guide covers common user commands and how Bob should respond when using the Research Assistant skill.

## Overview

The Research Assistant skill responds to natural language commands across four main categories:
1. Document Conversion
2. Web Scraping
3. Research Tasks
4. Report Generation

## Document Conversion Commands

### Basic Conversion

**User Command**: "Convert [file] to markdown"

**Bob's Response Pattern**:
1. Identify file location
2. Determine target directory
3. Check if images should be included
4. Execute conversion
5. Confirm completion with file location

**Example**:
```
User: "Convert the Gartner report to markdown"

Bob: "I'll convert the Gartner report to markdown. Let me:
1. Locate the PDF file
2. Convert to markdown (excluding images by default)
3. Save to sources/gartner/

Where is the PDF located?"

User: "It's in ~/Downloads/gartner-mq-2024.pdf"

Bob: [Executes conversion]
"✓ Converted successfully
- Input: ~/Downloads/gartner-mq-2024.pdf
- Output: sources/gartner/magic-quadrant-api-management-2024.md
- Pages: 45
- Images: Excluded (use --export-images if needed)

Would you like me to add this to your research project?"
```

### Batch Conversion

**User Command**: "Process all PDFs in [folder]"

**Bob's Response Pattern**:
1. Confirm folder location
2. List PDFs found
3. Confirm target directory structure
4. Ask about image handling
5. Execute batch conversion
6. Report results

**Example**:
```
User: "Process all PDFs in my Downloads folder"

Bob: "I found 3 PDFs in ~/Downloads/:
1. gartner-mq-2024.pdf
2. forrester-wave-2024.pdf
3. aws-whitepaper-security.pdf

Where should I save the converted files?
- sources/gartner/ (for analyst reports)
- sources/vendor-docs/aws/ (for vendor docs)
- Or specify custom locations"

User: "Put Gartner and Forrester in sources/analyst-reports/ and AWS in sources/vendor-docs/aws/"

Bob: [Executes batch conversion]
"✓ Converted 3 PDFs successfully:
1. sources/analyst-reports/gartner-magic-quadrant-2024.md (45 pages)
2. sources/analyst-reports/forrester-wave-2024.md (38 pages)
3. sources/vendor-docs/aws/security-whitepaper-2024.md (52 pages)

All images excluded by default. Would you like me to update the source index?"
```

### Conversion with Images

**User Command**: "Convert [file] and export images"

**Bob's Response Pattern**:
1. Identify file location
2. Confirm image export directory
3. Execute conversion with image export
4. Report results with image count

**Example**:
```
User: "Convert the AWS whitepaper and export images"

Bob: "I'll convert the AWS whitepaper with image export.
- PDF: ~/Downloads/aws-whitepaper.pdf
- Markdown: sources/vendor-docs/aws/whitepaper-2024.md
- Images: sources/vendor-docs/aws/images/

Proceed?"

User: "Yes"

Bob: [Executes conversion]
"✓ Conversion complete:
- Markdown: sources/vendor-docs/aws/whitepaper-2024.md (52 pages)
- Images: 15 diagrams exported to sources/vendor-docs/aws/images/
- Image references: Included in markdown as relative paths

Note: Images are for reference only, not embedded in analysis documents."
```

## Web Scraping Commands

### Single Page Scraping

**User Command**: "Scrape [URL] to markdown"

**Bob's Response Pattern**:
1. Confirm URL
2. Determine target directory
3. Execute scraping
4. Check for related links
5. Report results

**Example**:
```
User: "Scrape https://konghq.com/products/kong-gateway/features to markdown"

Bob: "I'll scrape the Kong Gateway features page.
Target: sources/vendor-docs/kong/features-overview-2024-06-15.md

Proceed?"

User: "Yes"

Bob: [Executes scraping]
"✓ Scraped successfully:
- URL: https://konghq.com/products/kong-gateway/features
- Output: sources/vendor-docs/kong/features-overview-2024-06-15.md
- Content: 850 lines

I found 5 related pages that might be useful:
1. Architecture Overview
2. Plugin Hub
3. Deployment Options
4. Performance Benchmarks
5. Pricing

Would you like me to scrape these as well?"
```

### Multiple URL Scraping

**User Command**: "Get content from [URL list]"

**Bob's Response Pattern**:
1. Confirm URLs
2. Determine target directory structure
3. Execute batch scraping
4. Report results with link discovery

**Example**:
```
User: "Get content from these URLs:
- https://konghq.com/products/kong-gateway/features
- https://konghq.com/products/kong-gateway/architecture
- https://konghq.com/pricing"

Bob: "I'll scrape 3 Kong pages.
Target directory: sources/vendor-docs/kong/
Naming: [page-name]-2024-06-15.md

Proceed?"

User: "Yes"

Bob: [Executes batch scraping]
"✓ Scraped 3 pages successfully:
1. sources/vendor-docs/kong/features-overview-2024-06-15.md (850 lines)
2. sources/vendor-docs/kong/architecture-2024-06-15.md (620 lines)
3. sources/vendor-docs/kong/pricing-2024-06-15.md (340 lines)

Total content: 1,810 lines

I discovered 8 additional related pages. Would you like me to:
1. List them for review
2. Scrape all automatically
3. Skip for now"
```

### Targeted Content Extraction

**User Command**: "Extract [specific content] from [URL]"

**Bob's Response Pattern**:
1. Confirm URL and content type
2. Execute scraping with focus
3. Extract relevant sections
4. Report results

**Example**:
```
User: "Extract pricing information from https://konghq.com/pricing"

Bob: "I'll extract pricing information from Kong's pricing page.
Focus: Pricing tables, plans, and feature comparisons

Proceed?"

User: "Yes"

Bob: [Executes targeted scraping]
"✓ Extracted pricing information:
- Output: sources/vendor-docs/kong/pricing-2024-06-15.md
- Sections extracted:
  - Pricing plans (Free, Plus, Enterprise)
  - Feature comparison matrix
  - Add-on pricing
  - Support tiers

Content: 340 lines focused on pricing

Would you like me to create a comparison with other vendors?"
```

## Research Task Commands

### Start New Research

**User Command**: "Start research on [topic]"

**Bob's Response Pattern**:
1. Create project structure
2. Initialize metadata
3. Ask about sources
4. Suggest research approach

**Example**:
```
User: "Start research on API management trends"

Bob: "I'll set up a research project on API management trends.

Creating:
- research/api-management-trends-2024/
- Project metadata and tracking files
- Source index

What sources should I start with?
1. Analyst reports (Gartner, Forrester, IDC)
2. Vendor documentation (Kong, Apigee, AWS)
3. Industry articles and blogs
4. All of the above"

User: "Start with analyst reports"

Bob: [Creates project structure]
"✓ Project initialized: research/api-management-trends-2024/

I found these analyst reports in sources/:
- Gartner Magic Quadrant API Management 2024
- Forrester Wave API Management 2024
- IDC MarketScape API Management 2024

Would you like me to:
1. Analyze these sources now
2. Add more sources first
3. Review project setup"
```

### Find Sources

**User Command**: "Find sources about [topic]"

**Bob's Response Pattern**:
1. Search across all source directories
2. Rank by relevance
3. Present top matches with context
4. Offer to add to project

**Example**:
```
User: "Find sources about API security"

Bob: "Searching for sources about API security...

Found 8 relevant sources:

High Relevance (3):
1. sources/gartner/market-guide-api-security-2024.md
   - "API Security Market Guide 2024"
   - Topics: Security threats, best practices, vendor landscape
   
2. sources/vendor-docs/aws/api-gateway-security-2024-06-10.md
   - "AWS API Gateway Security Best Practices"
   - Topics: Authentication, authorization, encryption
   
3. sources/forrester/api-security-predictions-2024.md
   - "API Security Predictions 2024"
   - Topics: Emerging threats, security trends

Medium Relevance (5):
[Additional sources...]

Would you like me to:
1. Add these to your current project
2. Create a new API security project
3. Show more details about specific sources"
```

### Analyze Sources

**User Command**: "Analyze [sources] for [purpose]"

**Bob's Response Pattern**:
1. Confirm sources and analysis type
2. Read and extract key information
3. Synthesize findings
4. Create analysis document
5. Offer next steps

**Example**:
```
User: "Analyze the Gartner and Forrester reports for competitive positioning"

Bob: "I'll analyze these reports for competitive positioning:
1. Gartner Magic Quadrant API Management 2024
2. Forrester Wave API Management 2024

Analysis type: Competitive Analysis
Focus: Vendor positioning, strengths, weaknesses

Proceed?"

User: "Yes"

Bob: [Reads and analyzes sources]
"✓ Analysis complete

Created: research/api-management-trends-2024/analysis/competitive-analysis.md

Key Findings:
- 12 vendors analyzed across both reports
- 5 leaders identified (Kong, Apigee, AWS, Azure, MuleSoft)
- 3 emerging challengers
- Key differentiators: Performance, ease of use, ecosystem

Would you like me to:
1. Create a comparison matrix
2. Generate an executive summary
3. Add more sources to the analysis"
```

### Compare Items

**User Command**: "Compare [item A] and [item B]"

**Bob's Response Pattern**:
1. Identify sources for both items
2. Extract relevant information
3. Create comparison matrix
4. Highlight key differences
5. Provide recommendations

**Example**:
```
User: "Compare Kong and Apigee"

Bob: "I'll compare Kong and Apigee using available sources.

Found sources:
Kong (4):
- Gartner MQ positioning
- Forrester Wave evaluation
- Kong features documentation
- Kong architecture documentation

Apigee (4):
- Gartner MQ positioning
- Forrester Wave evaluation
- Apigee capabilities documentation
- Apigee pricing information

Comparison categories:
- Market positioning
- Core capabilities
- Performance
- Pricing
- Ease of use
- Ecosystem

Proceed?"

User: "Yes"

Bob: [Creates comparison]
"✓ Comparison complete

Created: research/api-management-trends-2024/analysis/kong-vs-apigee.md

Summary:
- Kong: Open-source foundation, high performance, plugin ecosystem
- Apigee: Enterprise features, Google Cloud integration, analytics

Detailed comparison matrix included with 15 criteria.

Would you like me to:
1. Add more vendors to the comparison
2. Generate a decision framework
3. Create an executive summary"
```

### Summarize Findings

**User Command**: "Summarize findings on [topic]"

**Bob's Response Pattern**:
1. Review all analysis documents
2. Extract key findings
3. Create structured summary
4. Highlight actionable insights

**Example**:
```
User: "Summarize findings on API management trends"

Bob: "I'll summarize findings from your API management trends research.

Reviewing:
- 3 analyst reports
- 6 vendor documentation pages
- 2 analysis documents
- 1 comparison matrix

Creating summary with:
- Key trends identified
- Market insights
- Vendor positioning
- Recommendations

Proceed?"

User: "Yes"

Bob: [Creates summary]
"✓ Summary complete

Created: research/api-management-trends-2024/summary.md

Key Findings:
1. AI/ML integration is the top trend (mentioned in all 3 analyst reports)
2. Serverless adoption growing (45% increase YoY)
3. Security concerns driving vendor selection
4. Open-source solutions gaining enterprise traction

5 major trends identified
12 vendors analyzed
3 recommendations provided

Would you like me to:
1. Generate an executive summary
2. Create a presentation
3. Export to Word document"
```

## Report Generation Commands

### Create Executive Summary

**User Command**: "Create executive summary"

**Bob's Response Pattern**:
1. Review research findings
2. Use executive summary template
3. Populate with key insights
4. Generate Word document

**Example**:
```
User: "Create executive summary"

Bob: "I'll create an executive summary from your research.

Using:
- Template: templates/executive-summary.md
- Source: research/api-management-trends-2024/
- Format: 2-3 pages, leadership-focused

Content will include:
- Key findings (top 3-5)
- Market insights
- Recommendations
- Next steps

Proceed?"

User: "Yes"

Bob: [Generates summary]
"✓ Executive summary created

Files:
- Markdown: research/api-management-trends-2024/executive-summary.md
- Word: output/api-management-trends-executive-summary.docx

Summary:
- 3 pages
- 5 key findings
- 3 strategic recommendations
- Action items included

Would you like me to:
1. Review the content
2. Generate additional formats (PDF)
3. Create a full research report"
```

### Generate Competitive Analysis Report

**User Command**: "Generate competitive analysis report"

**Bob's Response Pattern**:
1. Use competitive analysis template
2. Populate with comparison data
3. Include matrices and charts
4. Generate Word document

**Example**:
```
User: "Generate competitive analysis report"

Bob: "I'll generate a competitive analysis report.

Using:
- Template: templates/competitive-analysis.md
- Analysis: research/api-management-trends-2024/analysis/
- Vendors: 12 analyzed

Report will include:
- Executive summary
- Vendor profiles
- Comparison matrices
- Strengths/weaknesses
- Recommendations

Proceed?"

User: "Yes"

Bob: [Generates report]
"✓ Competitive analysis report created

Files:
- Markdown: research/api-management-trends-2024/competitive-analysis-report.md
- Word: output/competitive-analysis-report.docx

Report:
- 25 pages
- 12 vendor profiles
- 3 comparison matrices
- Decision framework included

Would you like me to:
1. Review specific sections
2. Add more vendors
3. Create a summary version"
```

### Export to Word

**User Command**: "Export research to Word document"

**Bob's Response Pattern**:
1. Identify research documents
2. Confirm export format
3. Apply template styling
4. Generate Word document

**Example**:
```
User: "Export research to Word document"

Bob: "I'll export your research to Word.

Available documents:
1. Full research report (all analysis)
2. Executive summary only
3. Competitive analysis only
4. Custom selection

Which would you like to export?"

User: "Full research report"

Bob: "Exporting full research report.

Including:
- Executive summary
- Literature review
- Competitive analysis
- Trend analysis
- Recommendations

Template: templates/corporate-template.docx
Output: output/api-management-trends-full-report.docx

Proceed?"

User: "Yes"

Bob: [Generates document]
"✓ Research report exported

File: output/api-management-trends-full-report.docx

Report:
- 45 pages
- Table of contents
- All analysis sections
- Comparison matrices
- Bibliography

Would you like me to:
1. Generate a PDF version
2. Create a presentation
3. Export specific sections"
```

### Create Literature Review

**User Command**: "Create literature review"

**Bob's Response Pattern**:
1. Use literature review template
2. Synthesize sources
3. Identify themes
4. Generate document

**Example**:
```
User: "Create literature review"

Bob: "I'll create a literature review from your sources.

Using:
- Template: templates/literature-review.md
- Sources: 11 documents (3 analyst reports, 6 vendor docs, 2 articles)

Review will include:
- Source overview
- Key themes
- Synthesis of findings
- Gaps identified

Proceed?"

User: "Yes"

Bob: [Creates review]
"✓ Literature review created

Files:
- Markdown: research/api-management-trends-2024/literature-review.md
- Word: output/literature-review.docx

Review:
- 18 pages
- 11 sources synthesized
- 5 key themes identified
- 3 research gaps noted

Would you like me to:
1. Add more sources
2. Focus on specific themes
3. Generate executive summary"
```

## Command Patterns

### Question Clarification

When commands are ambiguous, Bob should ask clarifying questions:

```
User: "Convert the report"

Bob: "I found multiple reports. Which one would you like to convert?
1. gartner-mq-2024.pdf (in ~/Downloads)
2. forrester-wave-2024.pdf (in ~/Downloads)
3. aws-whitepaper.pdf (in ~/Documents)

Or specify the file path."
```

### Confirmation Before Action

For destructive or significant actions, Bob should confirm:

```
User: "Delete old sources"

Bob: "I found 15 sources older than 2 years:
- 8 from 2022
- 5 from 2021
- 2 from 2020

This will move them to sources/archive/.
Proceed? (yes/no)"
```

### Progress Updates

For long-running operations, Bob should provide progress updates:

```
Bob: "Converting 10 PDFs...
✓ 1/10 Complete: gartner-mq-2024.pdf
✓ 2/10 Complete: forrester-wave-2024.pdf
✓ 3/10 Complete: aws-whitepaper.pdf
..."
```

### Error Handling

When errors occur, Bob should explain and suggest solutions:

```
Bob: "✗ Conversion failed: gartner-mq-2024.pdf

Error: File is password-protected

Solutions:
1. Remove password protection
2. Provide password
3. Skip this file and continue with others

What would you like to do?"
```

## Best Practices

### 1. Be Proactive

Suggest next steps after completing tasks:
```
Bob: "✓ Conversion complete. Would you like me to:
1. Add to your research project
2. Update the source index
3. Start analyzing the content"
```

### 2. Provide Context

Include relevant information in responses:
```
Bob: "✓ Scraped Kong features page (850 lines)
Last updated: 2024-06-01 (per website)
Related pages discovered: 5"
```

### 3. Offer Options

Give users choices when multiple paths are available:
```
Bob: "I can create:
1. Executive summary (2-3 pages)
2. Full research report (20-30 pages)
3. Both

Which would you prefer?"
```

### 4. Confirm Understanding

Repeat back what you understood:
```
Bob: "I'll convert 3 Gartner reports to markdown and save them in sources/gartner/. 
Images will be excluded. Is this correct?"
```

### 5. Track Progress

Maintain context across conversation:
```
Bob: "We've completed:
✓ Project initialization
✓ Source conversion (5 documents)
✓ Initial analysis

Next: Generate executive summary?"
```

## Related Documentation

- [Conversation Flows Guide](conversation-flows.md) - Multi-turn interactions
- [Folder Management Examples](../examples/folder-management/) - Project setup
- [Main SKILL.md](../SKILL.md) - Complete skill documentation

## Summary

Effective command handling:
- Understand user intent
- Ask clarifying questions
- Confirm before significant actions
- Provide progress updates
- Suggest next steps
- Handle errors gracefully
- Maintain conversation context