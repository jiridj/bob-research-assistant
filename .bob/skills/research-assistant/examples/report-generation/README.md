# Report Generation Examples

This directory contains practical examples and guides for generating professional reports from markdown using Pandoc.

## Overview

Report generation is the final step in the research workflow, transforming markdown analysis into polished Word documents or PDFs suitable for distribution to stakeholders.

## Quick Start

### Basic Report Generation

```bash
# Simple conversion
pandoc research/analysis.md -o output/report.docx

# With table of contents
pandoc research/analysis.md --toc -o output/report.docx

# With corporate template
pandoc research/analysis.md \
  --reference-doc=templates/corporate-template.docx \
  --toc \
  -o output/report.docx
```

## Available Templates

### Content Templates (Markdown)

Located in `templates/` directory:

1. **[literature-review.md](../../templates/literature-review.md)**
   - Academic-style literature review
   - Multi-source synthesis
   - Theme identification
   - 315 lines, comprehensive structure

2. **[competitive-analysis.md](../../templates/competitive-analysis.md)**
   - Business intelligence format
   - Vendor comparison matrices
   - Decision frameworks
   - 425 lines, detailed comparison

3. **[executive-summary.md](../../templates/executive-summary.md)**
   - Leadership brief (2-4 pages)
   - Action-oriented
   - Financial impact focus
   - 245 lines, concise format

4. **[research-report.md](../../templates/research-report.md)**
   - Comprehensive research document
   - Full methodology section
   - Implementation plan
   - 485 lines, complete structure

5. **[technical-deep-dive.md](../../templates/technical-deep-dive.md)**
   - Detailed technical analysis
   - Architecture diagrams
   - Performance benchmarks
   - 565 lines, technical focus

### Style Templates (Word)

Create your own `.docx` reference templates with:
- Corporate fonts and colors
- Heading styles
- Page layout
- Headers and footers
- Company logo

## Examples

### [Generating Reports Guide](generating-reports.md)

Comprehensive guide covering:
- Basic report generation
- Using templates
- Advanced options
- Automation scripts
- Best practices
- Troubleshooting

**Key Examples**:
1. Simple markdown to Word
2. With table of contents
3. Multiple input files
4. Corporate template application
5. Literature review generation
6. Competitive analysis with tables
7. Executive summary
8. PDF generation
9. Metadata handling
10. Automation scripts

## Common Workflows

### Workflow 1: Literature Review

```bash
# 1. Copy template
cp templates/literature-review.md research/api-trends/

# 2. Fill in with research findings
# Edit research/api-trends/literature-review.md

# 3. Generate report
pandoc research/api-trends/literature-review.md \
  --toc --toc-depth=2 \
  --reference-doc=templates/academic-template.docx \
  -o output/api-trends-literature-review.docx
```

### Workflow 2: Competitive Analysis

```bash
# 1. Create analysis sections
research/vendor-comparison/
├── executive-summary.md
├── vendor-profiles.md
├── feature-comparison.md
├── pricing-analysis.md
└── recommendations.md

# 2. Generate combined report
pandoc research/vendor-comparison/*.md \
  --toc --toc-depth=2 \
  --reference-doc=templates/business-template.docx \
  -o output/vendor-comparison-report.docx
```

### Workflow 3: Executive Brief

```bash
# 1. Use executive summary template
cp templates/executive-summary.md research/q2-results/

# 2. Fill in key findings and recommendations

# 3. Generate brief (no TOC for short docs)
pandoc research/q2-results/executive-summary.md \
  --reference-doc=templates/executive-template.docx \
  -o output/q2-executive-brief.docx
```

## Pandoc Command Reference

### Essential Options

```bash
# Input and output
pandoc input.md -o output.docx

# Table of contents
--toc                    # Generate TOC
--toc-depth=3           # TOC depth (1-6)

# Styling
--reference-doc=FILE    # Word template for styling

# Multiple inputs
pandoc file1.md file2.md file3.md -o output.docx

# PDF generation
pandoc input.md -o output.pdf
--pdf-engine=xelatex    # Specify PDF engine

# Metadata
# Add YAML front matter to markdown:
---
title: "Report Title"
author: "Author Name"
date: "2024-06-12"
---
```

### Advanced Options

```bash
# Custom variables
-V geometry:margin=1in
-V fontsize=11pt
-V documentclass=report

# Filters and extensions
--filter=pandoc-crossref
--lua-filter=custom.lua

# Standalone document
--standalone

# Number sections
--number-sections
```

## Template Usage

### Using Content Templates

**Step 1**: Copy template to research directory
```bash
cp templates/competitive-analysis.md research/my-project/
```

**Step 2**: Fill in template sections
- Replace `[placeholders]` with actual content
- Remove sections not needed
- Add additional sections if required

**Step 3**: Generate report
```bash
pandoc research/my-project/competitive-analysis.md \
  --toc \
  --reference-doc=templates/corporate-template.docx \
  -o output/my-analysis.docx
```

### Creating Style Templates

**Method 1**: From Pandoc default
```bash
# Generate default reference
pandoc --print-default-data-file reference.docx > my-template.docx

# Open in Word and customize:
# - Modify styles (Heading 1, Heading 2, Normal, etc.)
# - Set fonts and colors
# - Configure page layout
# - Add header/footer with logo
# - Save as reference template
```

**Method 2**: From existing corporate template
1. Open corporate Word template
2. Ensure it has standard style names:
   - Heading 1, Heading 2, Heading 3, etc.
   - Normal (body text)
   - Title, Subtitle, Author, Date
3. Save as reference template

**Style Names That Matter**:
- `Title` - Document title
- `Author` - Author name
- `Date` - Document date
- `Heading 1` through `Heading 6` - Section headings
- `Normal` - Body text
- `First Paragraph` - First paragraph after heading
- `Table` - Table formatting
- `Image Caption` - Image captions

## Automation

### Batch Generation Script

```bash
#!/bin/bash
# generate-all-reports.sh

TEMPLATE="templates/corporate-template.docx"
OUTPUT_DIR="output"

mkdir -p "$OUTPUT_DIR"

# Generate each report type
for project in research/*/; do
  project_name=$(basename "$project")
  
  if [ -f "$project/report.md" ]; then
    echo "Generating report for $project_name..."
    pandoc "$project/report.md" \
      --toc \
      --reference-doc="$TEMPLATE" \
      -o "$OUTPUT_DIR/${project_name}-report.docx"
  fi
done

echo "✓ All reports generated"
```

### Makefile for Reports

```makefile
# Makefile

PANDOC = pandoc
TEMPLATE = templates/corporate-template.docx
OUTPUT_DIR = output

# Default target
all: literature-review competitive-analysis executive-summary

# Literature review
literature-review:
	$(PANDOC) research/api-trends/literature-review.md \
		--toc --toc-depth=2 \
		--reference-doc=$(TEMPLATE) \
		-o $(OUTPUT_DIR)/literature-review.docx

# Competitive analysis
competitive-analysis:
	$(PANDOC) research/vendor-comparison/*.md \
		--toc --toc-depth=2 \
		--reference-doc=$(TEMPLATE) \
		-o $(OUTPUT_DIR)/competitive-analysis.docx

# Executive summary
executive-summary:
	$(PANDOC) research/executive-summary.md \
		--reference-doc=templates/executive-template.docx \
		-o $(OUTPUT_DIR)/executive-summary.docx

# Clean output
clean:
	rm -f $(OUTPUT_DIR)/*.docx

.PHONY: all literature-review competitive-analysis executive-summary clean
```

**Usage**:
```bash
make                    # Generate all reports
make literature-review  # Generate specific report
make clean             # Remove generated files
```

## Best Practices

### 1. File Organization

```
project/
├── research/
│   ├── topic-1/
│   │   ├── notes.md
│   │   ├── analysis.md
│   │   └── report.md
│   └── topic-2/
├── templates/
│   ├── *.md (content templates)
│   └── *.docx (style templates)
├── output/
│   └── *.docx (generated reports)
└── scripts/
    └── generate-reports.sh
```

### 2. Markdown Best Practices

**Headings**:
```markdown
# Level 1 (Document title)
## Level 2 (Major sections)
### Level 3 (Subsections)
#### Level 4 (Details)
```

**Tables**:
```markdown
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Data 1   | Data 2   | Data 3   |
```

**Lists**:
```markdown
- Bullet point
- Another point
  - Nested point

1. Numbered item
2. Another item
```

**Emphasis**:
```markdown
*italic* or _italic_
**bold** or __bold__
***bold italic***
```

### 3. Quality Checks

**Before Generation**:
- [ ] Spell check markdown
- [ ] Verify all placeholders filled
- [ ] Check table formatting
- [ ] Ensure images exist
- [ ] Review metadata

**After Generation**:
- [ ] Open in Word and review
- [ ] Check TOC accuracy
- [ ] Verify tables formatted correctly
- [ ] Check page breaks
- [ ] Review headers/footers
- [ ] Test all hyperlinks

### 4. Version Control

**Recommended Approach**:
```bash
# Don't commit generated files
echo "output/*.docx" >> .gitignore
echo "output/*.pdf" >> .gitignore

# Commit source markdown and templates
git add research/ templates/
git commit -m "Update research analysis"

# Tag releases
git tag report-v1.0
```

### 5. Naming Conventions

**Output Files**:
- Include date: `report-2024-06-12.docx`
- Include version: `analysis-v2.docx`
- Be descriptive: `api-trends-q2-2024.docx`

**Template Files**:
- Content: `literature-review.md`
- Style: `corporate-template.docx`
- Purpose-specific: `executive-template.docx`

## Troubleshooting

### Common Issues

**Issue**: Tables not formatting correctly
- **Solution**: Use pipe tables, ensure alignment row present

**Issue**: Images not appearing
- **Solution**: Use relative paths, verify images exist

**Issue**: Template not applied
- **Solution**: Check `--reference-doc` path, verify template has standard styles

**Issue**: TOC empty
- **Solution**: Use `#` syntax for headings, check `--toc-depth`

**Issue**: Metadata not showing
- **Solution**: Add YAML front matter, ensure proper formatting

### Getting Help

1. Check [Generating Reports Guide](generating-reports.md)
2. Review [Pandoc Manual](https://pandoc.org/MANUAL.html)
3. Verify Pandoc version: `pandoc --version`
4. Test with simple example first

## Integration with Workflow

### Complete Research-to-Report Flow

```bash
# 1. Convert sources
docling report.pdf --output sources/report.md

# 2. Scrape web content
crwl crawl https://example.com --output markdown --output-file sources/web-content.md

# 3. Analyze (using research-analysis examples)
# Create analysis in research/my-project/analysis.md

# 4. Generate report
pandoc research/my-project/analysis.md \
  --toc \
  --reference-doc=templates/corporate-template.docx \
  -o output/final-report.docx
```

## Related Documentation

- [Report Templates](../../templates/) - All available templates
- [Research Analysis Examples](../research-analysis/) - Creating analysis content
- [Document Conversion Examples](../document-conversion/) - Converting sources
- [Web Scraping Examples](../web-scraping/) - Gathering web content
- [Main SKILL.md](../../SKILL.md) - Complete skill documentation

## Tools Required

**Pandoc**:
- Installation: `brew install pandoc` (macOS) or see [pandoc.org](https://pandoc.org/installing.html)
- Version: 2.0+ recommended
- Documentation: [pandoc.org/MANUAL.html](https://pandoc.org/MANUAL.html)

**Optional**:
- LaTeX (for PDF generation): `brew install basictex`
- Word processor (for template creation): Microsoft Word, LibreOffice

## Template Summary

| Template | Type | Length | Best For |
|----------|------|--------|----------|
| Literature Review | Content | 315 lines | Academic synthesis |
| Competitive Analysis | Content | 425 lines | Vendor comparison |
| Executive Summary | Content | 245 lines | Leadership brief |
| Research Report | Content | 485 lines | Comprehensive research |
| Technical Deep Dive | Content | 565 lines | Technical analysis |

All templates include:
- Structured sections
- Placeholder text
- Usage notes
- Pandoc conversion commands