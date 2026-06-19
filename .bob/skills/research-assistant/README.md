# Research Assistant Skill

Streamline your research workflow with automated document conversion, web scraping, analysis, and report generation.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Workflows](#workflows)
- [Examples](#examples)
- [Troubleshooting](#troubleshooting)
- [Advanced Usage](#advanced-usage)
- [Project Structure](#project-structure)
- [Best Practices](#best-practices)

## Overview

The Research Assistant skill helps you:

- **Convert documents** to markdown using docling (PDF, DOCX, PPTX)
- **Scrape web content** using crawl4ai
- **Organize research materials** in a structured, searchable format
- **Analyze and synthesize** information across multiple sources
- **Generate professional reports** using pandoc (Word, PDF)

### Key Features

✅ Multi-format document conversion  
✅ Intelligent web scraping  
✅ Organized source management  
✅ Flexible research workflows  
✅ Professional report generation  
✅ Citation management  
✅ Version control integration  
✅ Batch processing support  

## Prerequisites

Before using this skill, you must install the following CLI tools:

### 1. Docling (Document Conversion)

```bash
pip install docling
```

**Verify installation:**
```bash
docling --version
```

### 2. Crawl4ai (Web Scraping)

```bash
pip install crawl4ai
```

**Verify installation:**
```bash
crwl --version
```

### 3. Pandoc (Report Generation)

**macOS:**
```bash
brew install pandoc
```

**Linux:**
```bash
apt-get install pandoc
```

**Windows:**
```bash
choco install pandoc
```

**Verify installation:**
```bash
pandoc --version
```

### System Requirements

- Python 3.8 or higher
- 2GB free disk space (for tool dependencies)
- Internet connection (for web scraping)

## Quick Start

### 1. Convert Your First Document

```
You: "Convert the Gartner API Management report to markdown"

Bob: I'll convert that PDF to markdown for you.
[Executes: docling gartner-report.pdf --output sources/Gartner/api-management-2024.md --no-images]
✓ Document converted successfully
✓ Saved to sources/Gartner/api-management-2024.md
```

### 2. Start a Research Project

```
You: "Start a new research project on API management trends"

Bob: I'll set up a new research project for you.
[Creates folder structure]
✓ Created research/api-management-trends/
✓ Initialized notes.md, analysis.md, report.md
✓ Project ready for research
```

### 3. Find Relevant Sources

```
You: "Find all sources about API gateways"

Bob: Searching across all sources...
Found 5 relevant documents:
- sources/Gartner/api-management-2024.md
- sources/Forrester/api-gateway-wave.md
- sources/Competitors/Kong/product-overview.md
- sources/Hyperscalers/AWS/api-gateway-docs.md
- sources/Hyperscalers/Azure/apim-overview.md
```

### 4. Generate a Report

```
You: "Create an executive summary report"

Bob: I'll synthesize the findings and generate a report.
[Analyzes sources, creates markdown report]
[Executes: pandoc report.md -o output/executive-summary.docx]
✓ Report generated: output/executive-summary.docx
```

## Workflows

### Document Conversion Workflow

**Use Case:** Convert research papers, whitepapers, and presentations to markdown

**Steps:**
1. Identify document type (PDF, DOCX, PPTX)
2. Determine target category (Gartner, Forrester, Competitors, etc.)
3. Execute conversion with docling
4. Organize in appropriate sources folder
5. Verify output quality

**Example:**
```
You: "Convert the AWS whitepaper on serverless architecture"

Bob: 
1. Converting PDF to markdown...
2. Organizing in sources/Hyperscalers/AWS/
3. ✓ Conversion complete
4. File: sources/Hyperscalers/AWS/serverless-whitepaper.md
```

See [Document Conversion Examples](examples/document-conversion/README.md) for detailed workflows.

### Web Scraping Workflow

**Use Case:** Extract content from competitor websites, documentation, and blogs

**Steps:**
1. Identify target URLs
2. Determine scraping strategy (single page vs. site crawl)
3. Execute crwl crawl with appropriate options
4. Clean and format output
5. Organize in sources folder

**Example:**
```
You: "Scrape the Kong API Gateway product page"

Bob:
1. Scraping https://konghq.com/products/api-gateway
2. Extracting main content...
3. Converting to markdown...
4. ✓ Saved to sources/Competitors/Kong/product-page.md
```

See [Web Scraping Examples](examples/web-scraping/README.md) for detailed workflows.

### Research Analysis Workflow

**Use Case:** Analyze sources and synthesize findings

**Analysis Types:**
- **Literature Review**: Synthesize multiple sources on a topic
- **Competitive Analysis**: Compare competitor capabilities
- **Trend Analysis**: Identify patterns across sources
- **Gap Analysis**: Find missing information or opportunities
- **Technical Deep Dive**: Detailed analysis of specific topics

**Example:**
```
You: "Compare AWS and Azure API management capabilities"

Bob:
1. Reading sources/Hyperscalers/AWS/api-gateway-docs.md
2. Reading sources/Hyperscalers/Azure/apim-overview.md
3. Analyzing features, pricing, and capabilities...
4. Creating comparison matrix...
5. ✓ Analysis saved to research/api-comparison/analysis.md
```

See [Research Analysis Examples](examples/research-analysis/README.md) for detailed workflows.

### Report Generation Workflow

**Use Case:** Create professional reports from research findings

**Report Types:**
- Executive Summary
- Technical Deep Dive
- Competitive Analysis
- Literature Review
- Research Report

**Example:**
```
You: "Generate a Word document from my research findings"

Bob:
1. Reading research/api-trends/report.md
2. Applying corporate template...
3. Converting to Word format...
4. ✓ Generated: output/api-trends-report.docx
```

See [Report Generation Examples](examples/report-generation/README.md) for detailed workflows.

## Examples

### Complete Workflow Example

**Scenario:** Research API management trends for an executive briefing

```
You: "I need to research API management trends and create an executive briefing"

Bob: I'll help you with that. Let's start by setting up the project.

[Step 1: Project Setup]
✓ Created research/api-management-trends/
✓ Initialized project files

You: "Convert these three Gartner reports on API management"

Bob: Converting documents...
✓ sources/Gartner/api-management-2024.md
✓ sources/Gartner/api-gateway-magic-quadrant.md
✓ sources/Gartner/integration-platforms-2024.md

You: "Also scrape the Kong and Boomi product pages"

Bob: Scraping competitor websites...
✓ sources/Competitors/Kong/product-overview.md
✓ sources/Competitors/Boomi/product-overview.md

You: "Find all sources mentioning 'microservices architecture'"

Bob: Searching...
Found 8 relevant documents across Gartner, Forrester, and Competitors folders.

You: "Analyze the key trends in API management"

Bob: Analyzing sources...
Key trends identified:
1. Shift to cloud-native API gateways
2. Increased focus on security and governance
3. Integration with service mesh architectures
4. AI-powered API analytics
5. Multi-cloud and hybrid deployment models

✓ Analysis saved to research/api-management-trends/analysis.md

You: "Create an executive summary report"

Bob: Generating report...
✓ Created research/api-management-trends/report.md
✓ Converted to output/api-management-executive-brief.docx
✓ Report ready for review
```

See [Complete Workflow Example](examples/user-interaction/example-complete-workflow.md) for more details.

### Document Conversion Examples

- [Example 1: Gartner Report Conversion](examples/document-conversion/example-1-gartner-report.md)
- [Example 2: AWS Whitepaper with Images](examples/document-conversion/example-2-aws-whitepaper-images.md)

### Web Scraping Examples

- [Example 1: Competitor Website](examples/web-scraping/example-1-competitor-website.md)
- [Example 2: Link Discovery](examples/web-scraping/example-2-link-discovery.md)

### Research Analysis Examples

- [Literature Review](examples/research-analysis/literature-review.md)
- [Competitive Analysis](examples/research-analysis/competitive-analysis.md)
- [Trend Analysis](examples/research-analysis/trend-analysis.md)
- [Gap Analysis](examples/research-analysis/gap-analysis.md)

## Troubleshooting

### Common Issues

#### Issue: Docling command not found

**Symptoms:**
```
bash: docling: command not found
```

**Solution:**
```bash
# Verify Python installation
python3 --version

# Install docling
pip install docling

# If using virtual environment
source venv/bin/activate
pip install docling
```

#### Issue: Crawl4ai fails to scrape dynamic content

**Symptoms:**
- Incomplete content extraction
- Missing JavaScript-rendered elements

**Solution:**
```bash
# For JavaScript-rendered content, use the Python API with browser options
# See examples/web-scraping/ for advanced scraping with JS rendering

# Basic scraping with crwl
crwl crawl https://example.com --output markdown --output-file sources/web/page.md
```

#### Issue: Pandoc conversion fails

**Symptoms:**
```
pandoc: command not found
```

**Solution:**
```bash
# macOS
brew install pandoc

# Verify installation
pandoc --version

# If pandoc is installed but not in PATH
export PATH="/usr/local/bin:$PATH"
```

#### Issue: Document conversion produces garbled text

**Symptoms:**
- Incorrect character encoding
- Missing special characters

**Solution:**
```bash
# Specify encoding explicitly
docling input.pdf --output output.md --encoding utf-8

# For non-English documents
docling input.pdf --output output.md --language es
```

#### Issue: Large PDF files fail to convert

**Symptoms:**
- Memory errors
- Timeout errors

**Solution:**
```bash
# Process in smaller chunks
docling large-file.pdf --output output.md --page-range 1-50
docling large-file.pdf --output output2.md --page-range 51-100

# Increase memory limit
docling large-file.pdf --output output.md --max-memory 4096
```

#### Issue: Web scraping blocked by website

**Symptoms:**
- 403 Forbidden errors
- CAPTCHA challenges

**Solution:**
```bash
# Use browser configuration for custom user agent and delays
# See crwl crawl --help for browser configuration options

# Basic approach: use the batch scraping script which includes delays
./scripts/batch-scrape-urls.sh urls.txt output-dir/

# For advanced options, use the Python API directly
# See examples/web-scraping/ for configuration examples
```

### Getting Help

If you encounter issues not covered here:

1. Check the [Error Handling Guide](examples/error-handling-patterns.md)
2. Review [Validation Checklists](examples/validation-checklists.md)
3. Consult tool-specific documentation:
   - [Docling Documentation](https://github.com/DS4SD/docling)
   - [Crawl4ai Documentation](https://github.com/unclecode/crawl4ai)
   - [Pandoc Documentation](https://pandoc.org/MANUAL.html)

## Advanced Usage

### Batch Operations

Process multiple documents efficiently:

```
You: "Convert all PDFs in the downloads folder"

Bob: Processing batch conversion...
[Executes batch operation]
✓ Converted 15 documents
✓ Organized in sources/processed/
```

See [Batch Operations Guide](guides/batch-operations.md) for details.

### Citation Management

Track and format citations automatically:

```
You: "Add citations to my research report"

Bob: Adding citations...
✓ Extracted citations from sources
✓ Formatted in APA style
✓ Added bibliography section
```

See [Citation Management Guide](guides/citation-management.md) for details.

### Version Control

Manage research iterations:

```
You: "Create a snapshot of my current research"

Bob: Creating version snapshot...
✓ Saved as research/api-trends/v1.0/
✓ Tagged with timestamp
✓ Previous versions preserved
```

See [Version Control Guide](guides/version-control.md) for details.

### Custom Templates

Use custom report templates:

```
You: "Generate report using the corporate template"

Bob: Applying corporate template...
[Executes: pandoc report.md --reference-doc=templates/corporate.docx -o output/report.docx]
✓ Report generated with corporate styling
```

Available templates:
- `templates/executive-summary.md`
- `templates/technical-deep-dive.md`
- `templates/competitive-analysis.md`
- `templates/literature-review.md`
- `templates/research-report.md`

### Source Organization Strategies

Organize sources by:
- **Vendor**: Gartner, Forrester, IDC
- **Company**: Competitors, Hyperscalers, Partners
- **Topic**: API Management, Integration, Security
- **Date**: 2024-Q1, 2024-Q2, etc.
- **Project**: Project-A, Project-B, etc.

See [Source Organization Guide](guides/source-organization.md) for best practices.

### Quality Assurance

Validate research quality:

```
You: "Check my research for completeness"

Bob: Running quality checks...
✓ All sources cited
✓ No broken links
✓ Consistent formatting
✓ Complete bibliography
⚠ Consider adding more recent sources (2024)
```

See [Quality Assurance Guide](guides/quality-assurance.md) for validation checklists.

## Project Structure

### Recommended Folder Organization

```
research-workspace/
├── sources/                    # Organized source materials
│   ├── Gartner/
│   │   ├── api-management-2024.md
│   │   └── images/            # Optional: exported images
│   ├── Forrester/
│   ├── IBM/
│   ├── Competitors/
│   │   ├── Kong/
│   │   ├── Boomi/
│   │   └── Workato/
│   └── Hyperscalers/
│       ├── AWS/
│       └── Microsoft/
├── research/                   # Individual research projects
│   ├── api-trends/
│   │   ├── notes.md
│   │   ├── analysis.md
│   │   └── report.md
│   ├── competitive-analysis/
│   └── market-research/
└── output/                     # Final deliverables
    ├── api-trends-report.docx
    └── competitive-analysis.pdf
```

### File Naming Conventions

**Source Files:**
- Use descriptive names: `api-management-trends-2024.md`
- Include date when relevant: `gartner-mq-2024-q2.md`
- Use lowercase with hyphens: `aws-api-gateway-overview.md`

**Research Projects:**
- Use topic-based names: `api-management-trends/`
- Keep names concise: `competitive-analysis/`
- Avoid spaces: `market-research/` not `market research/`

**Output Files:**
- Include project name: `api-trends-executive-brief.docx`
- Add version if needed: `report-v2.docx`
- Use appropriate extension: `.docx`, `.pdf`, `.html`

## Best Practices

### Document Conversion

✅ **DO:**
- Exclude images by default for cleaner markdown
- Organize by source category (Gartner, Forrester, etc.)
- Verify conversion quality before proceeding
- Keep original files as backup

❌ **DON'T:**
- Embed images as base64 in markdown
- Mix different source types in same folder
- Delete original documents after conversion
- Skip quality verification

### Web Scraping

✅ **DO:**
- Respect robots.txt and rate limits
- Add delays between requests
- Verify content completeness
- Save raw HTML as backup if needed

❌ **DON'T:**
- Scrape aggressively without delays
- Ignore website terms of service
- Skip content verification
- Overwrite existing scraped content without backup

### Research Analysis

✅ **DO:**
- Read all relevant sources before analyzing
- Document your methodology
- Track sources used in analysis
- Validate findings against multiple sources
- Keep notes organized and dated

❌ **DON'T:**
- Analyze without reading full sources
- Mix opinions with facts
- Forget to cite sources
- Skip validation steps
- Lose track of source materials

### Report Generation

✅ **DO:**
- Use appropriate templates for audience
- Include citations and references
- Proofread before finalizing
- Save multiple versions
- Apply consistent formatting

❌ **DON'T:**
- Skip proofreading
- Forget citations
- Use inconsistent formatting
- Overwrite previous versions
- Ignore template guidelines

### Source Management

✅ **DO:**
- Maintain consistent folder structure
- Create index files for large collections
- Tag sources with metadata
- Regular cleanup of outdated materials
- Backup important sources

❌ **DON'T:**
- Create ad-hoc folder structures
- Mix different source types
- Forget to update indexes
- Keep duplicate copies
- Ignore backup procedures

## Additional Resources

### Guides

- [Common Commands](guides/common-commands.md)
- [Conversation Flows](guides/conversation-flows.md)
- [Project Initialization](guides/project-initialization.md)
- [Source Organization](guides/source-organization.md)
- [Error Handling](guides/error-handling.md)
- [Quality Assurance](guides/quality-assurance.md)
- [Citation Management](guides/citation-management.md)
- [Version Control](guides/version-control.md)
- [Batch Operations](guides/batch-operations.md)

### Templates

- [Executive Summary](templates/executive-summary.md)
- [Technical Deep Dive](templates/technical-deep-dive.md)
- [Competitive Analysis](templates/competitive-analysis.md)
- [Literature Review](templates/literature-review.md)
- [Research Report](templates/research-report.md)

### Examples

- [Document Conversion](examples/document-conversion/)
- [Web Scraping](examples/web-scraping/)
- [Research Analysis](examples/research-analysis/)
- [Report Generation](examples/report-generation/)
- [Folder Management](examples/folder-management/)
- [User Interaction](examples/user-interaction/)

## Contributing

Found a bug or have a suggestion? Please:

1. Check existing issues and documentation
2. Create a detailed issue report
3. Include examples and steps to reproduce
4. Suggest improvements or solutions

## License

This skill is part of the Bob AI assistant framework.

---

**Version:** 1.0.0  
**Last Updated:** 2026-06-16  
**Maintained by:** Research Assistant Skill Team