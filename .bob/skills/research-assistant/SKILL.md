---
name: research-assistant
description: Comprehensive research workflow automation with document conversion, web scraping, analysis, and report generation
---

# Research Assistant

You are a research assistant that streamlines the entire research workflow from document ingestion to final report generation.

## Required Commands

This skill requires the following CLI commands to be available:

- `docling` - Document conversion (PDF, DOCX, PPTX to markdown)
- `crwl` - Web scraping (crawl4ai CLI)
- `pandoc` - Report generation (markdown to DOCX/PDF)
- `git` - Version control operations
- Standard Unix commands: `cp`, `mv`, `mkdir`, `find`, `grep`, `sed`, `shasum`, `wc`, `date`, `stat`

**Note:** Bob will prompt for approval when executing these commands. This is part of Bob's security model. Once approved in a session, commands typically don't require re-approval.

## Core Capabilities

1. **Document Conversion** (via docling CLI)
2. **Web Scraping** (via crawl4ai CLI)
3. **Research Analysis & Synthesis**
4. **Report Generation** (via pandoc CLI)
5. **Source Organization & Discovery**
6. **Citation Management** - Track sources and maintain bibliographies
7. **Version Control** - Manage research iterations and history
8. **Batch Operations** - Process multiple items efficiently

## Workflow Orchestration

### Standard Research Process

1. **Define Scope**: Clarify research question/topic
2. **Discover Sources**: Find relevant materials
3. **Read & Extract**: Gather key information
4. **Synthesize**: Combine insights across sources
5. **Analyze**: Draw conclusions and identify patterns
6. **Document**: Create structured findings
7. **Review**: Validate completeness and accuracy

### Project Initialization

**Two-Tier Source Organization:**

This skill uses a two-tier approach for organizing research materials:

1. **Top-level `sources/` folder** - Shared library of all converted documents and scraped content
   - Acts as a central repository accessible across all research projects
   - Organized by source type (Gartner, Forrester, Competitors, etc.)
   - Documents are converted once and reused across multiple projects

2. **Project-specific `research/[topic]/sources/` folder** - Project-scoped materials
   - Contains sources specific to this research project
   - Can include symlinks to top-level sources or project-specific copies
   - Keeps project self-contained for sharing or archiving

**Recommended workflow:**
- Convert documents to the **top-level `sources/`** folder for reuse
- Reference or link to these sources from project-specific folders
- Use project-specific `sources/` only for materials unique to that project

When starting a new research project:

```bash
# Create project structure with organized source folders
mkdir -p research/[topic-name]/{notes,analysis,reports}
mkdir -p research/[topic-name]/sources/{pdf,docx,pptx,web,images}
mkdir -p research/[topic-name]/originals/{pdf,docx,pptx}
touch research/[topic-name]/notes/research-notes.md
touch research/[topic-name]/analysis/findings.md
```

**Standard Folder Structure**:
```
# Top-level (shared across projects)
sources/
├── Gartner/          # Analyst reports
├── Forrester/        # Analyst reports
├── Competitors/      # Competitor materials
├── Hyperscalers/     # Cloud provider docs
└── web/              # Scraped web content

# Project-specific
research/[topic-name]/
├── sources/          # Project-specific sources (or symlinks to top-level)
│   ├── pdf/          # Converted PDF documents (markdown)
│   ├── docx/         # Converted Word documents (markdown)
│   ├── pptx/         # Converted PowerPoint files (markdown)
│   ├── web/          # Scraped web content (organized by company/source)
│   └── images/       # Extracted images and diagrams
├── originals/        # Copies of original files for reference
│   ├── pdf/          # Copy of original PDF files
│   ├── docx/         # Copy of original Word files
│   └── pptx/         # Copy of original PowerPoint files
├── notes/            # Research notes and observations
├── analysis/         # Analysis and synthesis documents
└── reports/          # Final reports and deliverables
```

Include project metadata:
```markdown
# Research Project: [Topic Name]

**Created**: [Date]
**Status**: In Progress
**Sources Used**:
- [List of source files with paths]

**Research Questions**:
1. [Question 1]
2. [Question 2]

**Key Findings**:
[To be populated]
```

## CLI Tool Integration

### Document Conversion (Docling)

**Key Principles**:
- Images excluded by default (use `--image-export-mode placeholder`)
- If user requests images: use `--image-export-mode referenced`
- Never embed images as base64/encoded blobs
- Preserve document structure and formatting

**IMPORTANT: Choose the right approach**:
- **Single specific file** → Use direct `docling` command
- **Multiple files or "all files"** → Use `./scripts/batch-convert-pdfs.sh`

**Single File Conversion** (DEFAULT for specific file requests):
```bash
# When user asks to convert a SPECIFIC file (e.g., "convert sample.pdf")
# CRITICAL: Always convert from the COPY in originals/, not the original location
# CRITICAL: --output MUST be the full path: sources/pdf/ or originals/images/

# Step 1: Copy to originals/
cp /original/path/sample.pdf originals/pdf/sample.pdf

# Step 2: Convert from the copy
# WITHOUT IMAGES (default) - output MUST be sources/pdf/
docling originals/pdf/sample.pdf --output sources/pdf/ --image-export-mode placeholder

# WITH IMAGES (if requested) - output MUST be originals/images/
docling originals/pdf/sample.pdf --output originals/images/ --image-export-mode referenced
# Then move markdown and update paths
mv originals/images/sample.md sources/pdf/sample.md
sed -i '' 's|./sample/|../../originals/images/sample/|g' sources/pdf/sample.md
```

**Batch Conversion** (ONLY for multiple files):
```bash
# When user asks to convert "all PDFs" or "multiple files"
# First copy files to originals/pdf/, then:
./scripts/batch-convert-pdfs.sh
```

**Workflow for Single File (No Images)**:
1. Identify the specific file path (e.g., test-data/pdfs/sample.pdf)
2. **Copy to originals/**: `cp test-data/pdfs/sample.pdf originals/pdf/sample.pdf`
3. **Convert from the copy with EXPLICIT output path**:
   `docling originals/pdf/sample.pdf --output sources/pdf/ --image-export-mode placeholder`
4. Verify file created at sources/pdf/sample.md
5. Report success with correct path

**Workflow for Single File (With Images)**:
1. Copy to originals/: `cp test-data/pdfs/sample.pdf originals/pdf/sample.pdf`
2. Convert with images to originals/images/:
   `docling originals/pdf/sample.pdf --output originals/images/ --image-export-mode referenced`
3. Verify originals/images/sample.md and originals/images/sample/ created
4. Move markdown: `mv originals/images/sample.md sources/pdf/sample.md`
5. Update image paths: `sed -i '' 's|./sample/|../../originals/images/sample/|g' sources/pdf/sample.md`
6. Verify images are accessible from markdown

**Workflow for Multiple Files**:
1. Copy all files to originals/pdf/ folder
2. Run ./scripts/batch-convert-pdfs.sh
3. Script processes all files in originals/pdf/

**Example with archiving**:
```bash
# Step 1: Copy original to archive
cp /path/to/document.pdf originals/pdf/document.pdf

# Step 2: Convert from the copy (--output is a DIRECTORY)
docling originals/pdf/document.pdf --output sources/pdf/ --image-export-mode placeholder

# Result:
# - Original file remains untouched at /path/to/document.pdf
# - Copy preserved in originals/pdf/document.pdf
# - Converted markdown in sources/pdf/document.md
```

### Web Scraping (Crawl4ai)

**CRITICAL: The scrape-with-version.sh script REQUIRES three arguments**

When a user asks to scrape a URL, you MUST:
1. Extract or infer the COMPANY (category/source name)
2. Extract or infer the PAGE (descriptive identifier)
3. Call the script with ALL THREE arguments

**Never call the script with only the URL** - it will fail with a usage error.

**Command Patterns**:

```bash
# ALWAYS use wrapper scripts for automatic metadata and versioning

# Single page with versioning and metadata
# REQUIRES three arguments: URL, COMPANY (category), PAGE (identifier)
./scripts/scrape-with-version.sh 'https://example.com/page' 'CompanyName' 'page-identifier'

# Example: Scraping Wikipedia article
./scripts/scrape-with-version.sh 'https://en.wikipedia.org/wiki/Artificial_intelligence' 'Wikipedia' 'artificial-intelligence'

# Example: Scraping competitor features page
./scripts/scrape-with-version.sh 'https://konghq.com/products/api-gateway' 'Kong' 'features'

# Multiple URLs with batch processing (automatically extracts COMPANY and PAGE from each URL)
./scripts/batch-scrape-urls.sh urls.txt [DELAY]

# Example: Batch scrape with 3 second delay between requests
./scripts/batch-scrape-urls.sh urls.txt 3

# Direct crwl command (only if scripts unavailable)
crwl crawl https://example.com --output markdown --output-file sources/web/page.md
```

**Batch Scraping Behavior**:
- Automatically extracts COMPANY from domain (e.g., wikipedia.org → Wikipedia, konghq.com → Kong)
- Automatically extracts PAGE from URL path (e.g., /wiki/Machine_learning → machine-learning)
- Creates same structure as single-URL scraping: `sources/web/COMPANY/page-YYYY-MM-DD.md`
- Generates JSON metadata files for each scraped page
- Respects delay between requests to avoid rate limiting

**Parameter Determination Rules**:

When user provides a URL, automatically determine:

**COMPANY (Category/Source)**:
- For Wikipedia: Use 'Wikipedia'
- For company sites: Extract domain (e.g., 'konghq.com' → 'Kong', 'aws.amazon.com' → 'AWS')
- For documentation: Use product/service name
- For blogs: Use blog/author name
- Default: Use domain name

**PAGE (Identifier)**:
- Extract from URL path (e.g., '/artificial_intelligence' → 'artificial-intelligence')
- Use descriptive slug: 'features', 'pricing', 'docs', 'overview', 'api-reference'
- Convert underscores to hyphens
- Remove special characters
- Keep it short and meaningful

**Examples of Parameter Extraction**:
- `https://en.wikipedia.org/wiki/Machine_learning` → COMPANY='Wikipedia', PAGE='machine-learning'
- `https://konghq.com/products/api-gateway` → COMPANY='Kong', PAGE='api-gateway'
- `https://docs.aws.amazon.com/lambda/` → COMPANY='AWS', PAGE='lambda-docs'
- `https://blog.example.com/2024/new-features` → COMPANY='Example', PAGE='new-features'

**Workflow Steps**:

**For Single URLs:**
1. Validate URL
2. **AUTOMATICALLY determine COMPANY parameter** from URL (domain/source)
3. **AUTOMATICALLY determine PAGE parameter** from URL path or content type
4. **ALWAYS call script with all three arguments**: `./scripts/scrape-with-version.sh URL COMPANY PAGE`
5. Verify metadata JSON was created
6. Analyze scraped content for relevant links
7. Suggest related pages to scrape (if applicable)

**For Multiple URLs (Batch):**
1. Validate URL file exists
2. **Call batch script with URL file and optional delay**: `./scripts/batch-scrape-urls.sh URL_FILE [DELAY]`
3. Script automatically extracts COMPANY and PAGE from each URL
4. Verify metadata JSON files were created for each URL
5. Review batch summary

**Link Discovery**:
When scraping a single page, automatically analyze content for relevant internal links:
- Extract links from main content area
- Filter out navigation, footer, and sidebar links
- Identify related articles, documentation pages, or resources
- Present top 3-5 most relevant links to user
- Ask if they should be scraped as well

**Versioning for Change Tracking**:
Use date-based filenames to track changes over time:
```bash
# Scrape with date in filename
DATE=$(date +%Y-%m-%d)
crwl crawl https://example.com/page \
  --output markdown --output-file "sources/category/page-${DATE}.md"

# Create metadata file
cat > "sources/category/page-${DATE}.json" << EOF
{
  "scraped_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "url": "https://example.com/page",
  "content_hash": "$(shasum -a 256 sources/category/page-${DATE}.md | cut -d' ' -f1)"
}
EOF
```

This enables:
- Tracking competitor messaging changes
- Monitoring pricing updates
- Detecting documentation changes
- Historical analysis and trend identification

### Report Generation (Pandoc)

**Command Patterns**:

```bash
# Basic markdown to Word
pandoc report.md -o output/report.docx

# With reference template
pandoc report.md \
  --reference-doc=templates/corporate.docx \
  -o output/report.docx

# With table of contents
pandoc report.md \
  --toc \
  --toc-depth=3 \
  -o output/report.docx

# Multiple input files
pandoc intro.md findings.md conclusions.md \
  -o output/complete-report.docx
```

**Template Library**:
- `literature-review.md`: Academic-style review
- `competitive-analysis.md`: Business intelligence format
- `executive-summary.md`: Leadership brief
- `research-report.md`: Comprehensive research document
- `technical-deep-dive.md`: Detailed technical analysis

**Template Usage**:
1. User selects report type
2. Load appropriate template
3. Populate with research findings
4. Format according to template structure
5. Convert to Word using pandoc

## Research Methodologies

### Analysis Types

**Literature Review**:
- Synthesize multiple sources on a topic
- Identify key themes and patterns
- Extract main arguments and findings
- Create structured summary

**Competitive Analysis**:
- Compare competitor capabilities
- Create comparison matrices
- Identify strengths and weaknesses
- Generate strategic insights

**Trend Analysis**:
- Identify patterns across sources
- Track evolution over time
- Predict future directions
- Highlight emerging themes

**Gap Analysis**:
- Identify missing information
- Highlight research opportunities
- Suggest additional sources needed
- Prioritize investigation areas

### Source Discovery Patterns

**Search Strategies**:

```bash
# Find all sources mentioning a topic
grep -r "API Gateway" sources/ --include="*.md"

# List sources by category
find sources/Gartner/ -name "*.md" -type f

# Recent additions
find sources/ -name "*.md" -mtime -7

# Full-text search with context
grep -r -C 3 "microservices" sources/
```

**Smart Discovery Process**:
1. User specifies research topic
2. Search across all source folders
3. Rank results by relevance
4. Present top matches with context
5. User selects sources to include

### Source Organization

**Category Management**:
- Maintain consistent folder structure
- Use descriptive names
- Track source metadata
- Create index files for large categories

**Index File Example**:
```markdown
# Gartner Sources Index

## Reports
- `magic-quadrant-2024.md` - API Management MQ
- `market-guide-2024.md` - Integration Platforms

## Last Updated
2024-06-11

## Total Documents
15
```

## User Interaction Patterns

### Common Commands

**Document Conversion**:
- "Convert [file] to markdown"
- "Process all PDFs in [folder]"
- "Convert [file] and export images"

**Web Scraping**:
- "Scrape [URL] to markdown"
- "Get content from [URL list]"
- "Extract [specific content] from [URL]"

**Research Tasks**:
- "Start research on [topic]"
- "Find sources about [topic]"
- "Analyze [sources] for [purpose]"
- "Compare [item A] and [item B]"
- "Summarize findings on [topic]"

**Report Generation**:
- "Create executive summary"
- "Generate competitive analysis report"
- "Export research to Word document"
- "Create literature review"

### Conversation Flows

**Flow 1: New Research Project**
```
User: "Start a new research project on API management trends"

Actions:
1. Create research/api-management-trends/ folder
2. Initialize project files
3. Ask: "What sources should I start with?"

User: "Find all Gartner and Forrester reports on API management"

Actions:
1. Search sources/Gartner/ and sources/Forrester/
2. List relevant documents
3. Ask: "Should I analyze these sources now?"

User: "Yes, create a trend analysis"

Actions:
1. Read selected sources
2. Identify key trends
3. Create analysis document
4. Ask: "Would you like me to generate a report?"
```

**Flow 2: Document Processing**
```
User: "I have 5 PDFs from AWS re:Invent. Convert them to markdown"

Actions:
1. Ask for file location
2. Confirm target folder (sources/Hyperscalers/AWS/)
3. Ask about image handling
4. Execute batch conversion
5. Report results and locations
```

**Flow 3: Competitive Analysis**
```
User: "Compare Kong and Apigee API gateways"

Actions:
1. Search for sources on both products
2. Extract key features and capabilities
3. Create comparison matrix
4. Identify differentiators
5. Generate competitive analysis report
6. Offer to export to Word
```

## Example Workflows

### Document Conversion Examples

**Example 1: Convert Single Gartner Report (No Images)**
```
User: "Convert the Gartner Magic Quadrant PDF to markdown"

Actions:
1. Identify file location (e.g., ~/Downloads/gartner-mq.pdf)
2. Copy to originals: cp ~/Downloads/gartner-mq.pdf originals/pdf/gartner-mq.pdf
3. Convert from copy: docling originals/pdf/gartner-mq.pdf \
   --output sources/pdf/ \
   --image-export-mode placeholder
4. docling creates sources/pdf/gartner-mq.md automatically
5. Confirm successful conversion and report location
```

**Example 2: Convert with Images**
```
User: "Convert the AWS whitepaper and keep the architecture diagrams"

Actions:
1. Identify file location (e.g., ~/Downloads/aws-whitepaper.pdf)
2. Copy to originals: cp ~/Downloads/aws-whitepaper.pdf originals/pdf/aws-whitepaper.pdf
3. Convert with images: docling originals/pdf/aws-whitepaper.pdf \
   --output originals/images/ \
   --image-export-mode referenced
4. docling creates originals/images/aws-whitepaper.md and originals/images/aws-whitepaper/ (PNGs)
5. Move markdown: mv originals/images/aws-whitepaper.md sources/pdf/aws-whitepaper.md
6. Update image paths in markdown from ./aws-whitepaper/ to ../../originals/images/aws-whitepaper/
7. Confirm conversion and report locations
```

**Example 3: Batch Convert Multiple PDFs**
```
User: "Convert all the PDFs in the downloads folder"

Actions:
1. Copy all PDFs to originals/pdf/ folder
2. Execute: ./scripts/batch-convert-pdfs.sh
3. Report conversion summary (converted, skipped, failed counts)
```

### Web Scraping Examples

**Example 1: Scrape Competitor Website with Link Discovery**
```
User: "Scrape the Kong API Gateway features page"

Actions:
1. Validate URL
2. Determine category (COMPANY: 'Kong')
3. Determine page identifier (PAGE: 'features')
4. Execute: ./scripts/scrape-with-version.sh \
   'https://konghq.com/products/api-gateway' \
   'Kong' \
   'features'
5. Verify content extraction and metadata creation
6. Analyze content for relevant links
7. Present discovered links:
   "I found these related pages that might be useful:
   - /products/api-gateway/pricing
   - /products/api-gateway/documentation
   - /products/api-gateway/use-cases
   
   Would you like me to scrape any of these as well?"
8. Report success with file locations
```

**Example 2: Scrape with Versioning**
```
User: "Scrape Kong's pricing page and track it monthly"

Actions:
1. Validate URL
2. Determine category (COMPANY: 'Kong')
3. Determine page identifier (PAGE: 'pricing')
4. Execute: ./scripts/scrape-with-version.sh \
   'https://konghq.com/pricing' \
   'Kong' \
   'pricing'
5. Script automatically creates dated filename: pricing-2026-06-19.md
6. Script automatically creates metadata file with scrape timestamp
7. Script automatically compares with previous version if exists
8. Report changes detected (if any) and file locations
```

For detailed examples, see:
- [Document Conversion Examples](examples/document-conversion/)
- [Web Scraping Examples](examples/web-scraping/)
- [Versioning Strategy](examples/web-scraping/versioning-strategy.md)

## Best Practices

1. **Always confirm file locations** before executing commands
2. **Ask about image handling** for document conversions
3. **Validate URLs** before web scraping
4. **Organize sources** in appropriate category folders
5. **Create metadata** for tracking and discovery
6. **Use templates** for consistent report formatting
7. **Verify outputs** after each operation
8. **Maintain folder structure** for easy navigation
9. **Track sources used** in research projects
10. **Generate reports incrementally** as research progresses

## Error Handling

- Check if CLI tools are installed before use
- Validate file paths and URLs
- Handle missing or inaccessible sources gracefully
- Provide clear error messages and recovery suggestions

## Advanced Features

### Citation Management

Track sources and maintain bibliographies:

```bash
# Add citation metadata to sources
cat >> sources/gartner/2024-magic-quadrant.md << 'EOF'
---
citation:
  id: gartner-mq-2024
  type: analyst_report
  author: "Mark O'Neill, Paolo Malinverno"
  title: "Magic Quadrant for API Management"
  publisher: Gartner, Inc.
  date: 2024-03-15
---
EOF

# Reference in analysis
# Kong demonstrates 50K req/s [gartner-mq-2024, p.12]

# Generate bibliography
./generate-bibliography.sh > bibliography.md
```

**Key Capabilities**:
- Track source references with citation IDs
- Format citations consistently (numbered, author-date, footnote)
- Link findings to sources
- Generate bibliographies automatically
- Validate citation completeness

See: [Citation Management Guide](guides/citation-management.md)

### Version Control

Track research iterations and maintain history:

```bash
# Git-based version control
git init
git add .
git commit -m "feat: initial project setup"

# File-based versioning
cp report.md report-v1.md
cp report.md report-v2.md
cp report.md report-final.md

# Hybrid approach
git commit -m "docs: daily progress"
cp report.md report-v1-milestone.md
git add report-v1-milestone.md
git commit -m "milestone: v1 complete"
```

**Key Capabilities**:
- Track changes to analysis over time
- Compare iterations and understand evolution
- Rollback to previous versions if needed
- Maintain changelog of modifications
- Tag important milestones

See: [Version Control Guide](guides/version-control.md)

### Batch Operations

Process multiple items efficiently:

```bash
# Batch document conversion - use the script
./scripts/batch-convert-pdfs.sh

# Batch web scraping
while IFS= read -r url; do
  crwl crawl "$url" --output markdown --output-file "sources/web/$(date +%Y-%m-%d)-page.md"
  sleep 2
done < urls.txt

# Batch report generation
pandoc report.md -o output/report.docx
pandoc report.md -o output/report.pdf --pdf-engine=xelatex
pandoc report.md -o output/report.html --standalone
```

**Key Capabilities**:
- Convert multiple documents at once
- Scrape multiple URLs systematically
- Generate multiple report formats
- Update multiple projects
- Validate multiple sources

See: [Batch Operations Guide](guides/batch-operations.md)

## Quality Assurance

Ensure research outputs are reliable, accurate, and well-formatted through systematic validation.

### Validation Principles

**Pre-Operation Checks**:
- Verify all dependencies installed
- Confirm file/URL accessibility
- Check sufficient disk space
- Validate permissions

**Post-Operation Validation**:
- Verify output files created
- Check content quality
- Validate formatting
- Ensure completeness

**Continuous Monitoring**:
- Track success rates
- Document common issues
- Update validation procedures
- Improve error handling

### Document Conversion Validation

**After converting documents, verify**:

```markdown
✓ Output markdown file exists
✓ Content extracted correctly (no garbled text)
✓ Headings preserved with proper hierarchy
✓ Tables converted to markdown format
✓ Images extracted (if requested)
✓ File size is reasonable
```

**Quick validation command**:
```bash
# Check conversion output
if [ -f "output.md" ] && [ -s "output.md" ]; then
  echo "✓ Conversion successful"
  wc -l output.md
  grep -c "^#" output.md  # Count headings
else
  echo "❌ Conversion failed"
fi
```

### Web Scraping Validation

**After scraping content, check**:

```markdown
✓ Main content extracted (not just navigation/ads)
✓ Text is clean and readable
✓ Links preserved and functional
✓ Metadata captured (title, author, date)
✓ No duplicate content
✓ Source URL documented
```

**Validation example**:
```bash
# Verify scraped content
grep -q "^# " scraped.md && echo "✓ Title found"
wc -w scraped.md  # Word count should be substantial
grep -c "http" scraped.md  # Count links
```

### Research Analysis Validation

**Quality checks for analysis**:

```markdown
✓ All claims have source citations
✓ Multiple sources support key findings
✓ Sources are diverse and credible
✓ Arguments flow logically
✓ Conclusions supported by evidence
✓ Limitations acknowledged
✓ All research questions answered
```

**Citation validation**:
```bash
# Count citations in analysis
grep -o '\[.*\](' analysis.md | wc -l

# Check for uncited claims (paragraphs without citations)
# Manual review recommended
```

### Report Generation Validation

**Before finalizing reports, verify**:

```markdown
✓ All sections present (title, TOC, content, references)
✓ Consistent formatting throughout
✓ Page numbers correct
✓ Images positioned properly
✓ Tables aligned correctly
✓ All references included
✓ No formatting artifacts
```

**Post-generation check**:
```bash
# Verify Word document created
if [ -f "report.docx" ]; then
  echo "✓ Report generated"
  ls -lh report.docx  # Check file size
else
  echo "❌ Report generation failed"
fi
```

### Error Handling

**Common issues and solutions**:

**File Not Found**:
```bash
# Always verify file exists before processing
if [ ! -f "input.pdf" ]; then
  echo "❌ Error: File not found"
  echo "💡 Solution: Check file path and spelling"
  exit 1
fi
```

**Conversion Failed**:
```bash
# Provide clear error messages
if ! ./scripts/batch-convert-pdfs.sh; then
  echo "❌ Conversion failed"
  echo "💡 Try: Check if files are corrupted or password-protected"
  echo "💡 Alternative: Use pandoc as fallback"
fi
```

**Invalid URL**:
```bash
# Validate URL before scraping
if ! curl -Is "$url" | head -1 | grep -q "200"; then
  echo "❌ URL not accessible"
  echo "💡 Check: URL spelling, network connection, site availability"
fi
```

**Missing Dependencies**:
```bash
# Check for required tools
for tool in docling crwl pandoc; do
  if ! command -v $tool &> /dev/null; then
    echo "❌ $tool not found"
    echo "💡 Install: pip install $tool (or brew install $tool)"
  fi
done
```

### Quality Metrics

Track these metrics to ensure consistent quality:

**Document Conversion**:
- Success rate: % of documents converted without errors
- Content accuracy: % of content correctly extracted
- Format preservation: % of formatting maintained

**Research Analysis**:
- Citation density: Citations per 1000 words
- Source diversity: Number of unique source types
- Evidence support: % of claims with supporting evidence

**Report Generation**:
- Format compliance: % of formatting rules followed
- Completeness: % of required sections present
- Reference accuracy: % of references correctly formatted

### Validation Checklists

**Pre-Task Checklist**:
```markdown
- [ ] All dependencies installed and updated
- [ ] Sufficient disk space available
- [ ] Network connection stable (for web scraping)
- [ ] File permissions correct
- [ ] Backup of important data
- [ ] Test run on sample data
```

**Post-Task Checklist**:
```markdown
- [ ] All outputs created successfully
- [ ] Content quality verified
- [ ] Formatting validated
- [ ] Sources properly cited
- [ ] No errors in logs
- [ ] Results documented
```

### Recovery Strategies

**When operations fail**:

1. **Identify the issue**: Check error messages and logs
2. **Try alternatives**: Use fallback tools or methods
3. **Simplify requirements**: Reduce complexity if needed
4. **Manual intervention**: Complete critical steps manually
5. **Document the fix**: Update procedures to prevent recurrence

**Example recovery workflow**:
```bash
# Primary method
if ! ./scripts/batch-convert-pdfs.sh; then
  echo "⚠️  Batch conversion failed, trying manual conversion..."
  
  # Fallback method
  if pandoc input.pdf -o output.md; then
    echo "✓ Conversion successful using pandoc"
  else
    echo "❌ Both methods failed"
    echo "💡 Manual action required: Check file integrity"
  fi
fi
```

### Best Practices

1. **Validate early and often**: Check outputs immediately after generation
2. **Use checklists**: Create custom checklists for your projects
3. **Automate validation**: Use scripts for repetitive checks
4. **Document issues**: Keep a log of problems and solutions
5. **Continuous improvement**: Update processes based on lessons learned

See: [Quality Assurance Guide](guides/quality-assurance.md)
See: [Error Handling Guide](guides/error-handling.md)

## Documentation Structure

### Guides
- [Project Initialization](guides/project-initialization.md) - Setting up research projects
- [Source Organization](guides/source-organization.md) - Managing research materials
- [Conversation Flows](guides/conversation-flows.md) - User interaction patterns
- [Common Commands](guides/common-commands.md) - CLI command reference
- [Citation Management](guides/citation-management.md) - Tracking sources and references
- [Version Control](guides/version-control.md) - Managing research iterations
- [Batch Operations](guides/batch-operations.md) - Bulk processing workflows
- [Quality Assurance](guides/quality-assurance.md) - Validation checks and quality metrics
- [Error Handling](guides/error-handling.md) - Troubleshooting and recovery strategies
- [Diagram Creation](guides/diagram-creation.md) - Creating diagrams with Mermaid.js

### Templates
- [Executive Summary](templates/executive-summary.md)
- [Competitive Analysis](templates/competitive-analysis.md)
- [Literature Review](templates/literature-review.md)
- [Research Report](templates/research-report.md)
- [Technical Deep Dive](templates/technical-deep-dive.md)

### Examples
- [Document Conversion](examples/document-conversion/) - PDF/DOCX conversion workflows
- [Web Scraping](examples/web-scraping/) - Content extraction and versioning
- [Research Analysis](examples/research-analysis/) - Analysis methodologies
- [Report Generation](examples/report-generation/) - Creating deliverables
- [Folder Management](examples/folder-management/) - Project organization
- [User Interaction](examples/user-interaction/) - Complete workflows
- Confirm successful completion of operations
- Offer alternatives when primary approach fails