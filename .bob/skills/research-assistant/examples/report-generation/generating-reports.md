# Report Generation with Pandoc

## Overview

This guide demonstrates how to generate professional reports from markdown using Pandoc, converting research findings into polished Word documents or PDFs.

## Prerequisites

**Required Tools**:
- Pandoc installed (`pandoc --version` to check)
- Markdown source files
- Optional: Reference Word template for styling

**Installation**:
```bash
# macOS
brew install pandoc

# Linux
sudo apt-get install pandoc

# Windows
# Download from https://pandoc.org/installing.html
```

## Basic Report Generation

### Example 1: Simple Markdown to Word

**Source**: `research/api-trends/analysis.md`

**Command**:
```bash
pandoc research/api-trends/analysis.md -o output/api-trends-report.docx
```

**What This Does**:
- Converts markdown to Word format
- Preserves headings, lists, tables
- Uses default Word styling
- Creates single output file

### Example 2: With Table of Contents

**Command**:
```bash
pandoc research/api-trends/analysis.md \
  --toc \
  --toc-depth=3 \
  -o output/api-trends-report.docx
```

**Options Explained**:
- `--toc`: Generates table of contents
- `--toc-depth=3`: Includes headings up to level 3 (###)
- Automatically numbers sections

**Result**: Report with clickable TOC at the beginning

### Example 3: Multiple Input Files

**Scenario**: Combine multiple markdown files into one report

**Command**:
```bash
pandoc \
  research/api-trends/executive-summary.md \
  research/api-trends/findings.md \
  research/api-trends/recommendations.md \
  -o output/complete-report.docx
```

**File Order Matters**: Files are combined in the order specified

**Best Practice**: Create separate files for each major section

## Using Templates

### Example 4: Corporate Template

**Scenario**: Apply corporate branding and styling

**Step 1**: Create or obtain reference template
- Use existing corporate Word template
- Or create one with desired styles

**Step 2**: Convert with template
```bash
pandoc research/api-trends/analysis.md \
  --reference-doc=templates/corporate-template.docx \
  --toc \
  -o output/api-trends-report.docx
```

**What Gets Applied**:
- Fonts and colors
- Heading styles
- Page layout
- Headers and footers
- Company logo (if in template)

### Creating a Reference Template

**Method 1**: Start from Pandoc default
```bash
# Generate default reference
pandoc --print-default-data-file reference.docx > my-template.docx

# Open in Word and customize:
# - Modify styles (Heading 1, Heading 2, etc.)
# - Set fonts and colors
# - Add header/footer
# - Save as new template
```

**Method 2**: Use existing corporate template
- Open corporate template in Word
- Ensure it has standard style names
- Save as reference template

## Advanced Report Generation

### Example 5: Literature Review Report

**Scenario**: Generate formatted literature review from template

**Source Files**:
- `research/api-management/literature-review.md` (populated template)

**Command**:
```bash
pandoc research/api-management/literature-review.md \
  --toc \
  --toc-depth=2 \
  --reference-doc=templates/academic-template.docx \
  -o output/literature-review-final.docx
```

**Workflow**:
1. Copy template: `cp templates/literature-review.md research/api-management/`
2. Fill in template with research findings
3. Generate report with pandoc
4. Review and refine in Word if needed

### Example 6: Competitive Analysis Report

**Scenario**: Multi-file competitive analysis with tables

**Source Files**:
```
research/vendor-comparison/
├── executive-summary.md
├── vendor-profiles.md
├── feature-comparison.md
├── pricing-analysis.md
└── recommendations.md
```

**Command**:
```bash
pandoc \
  research/vendor-comparison/executive-summary.md \
  research/vendor-comparison/vendor-profiles.md \
  research/vendor-comparison/feature-comparison.md \
  research/vendor-comparison/pricing-analysis.md \
  research/vendor-comparison/recommendations.md \
  --toc \
  --toc-depth=2 \
  --reference-doc=templates/business-template.docx \
  -o output/vendor-comparison-report.docx
```

**Table Handling**:
- Markdown tables convert to Word tables
- Formatting preserved
- Can be further styled in Word

### Example 7: Executive Summary

**Scenario**: Quick 2-3 page executive brief

**Source**: `research/api-trends/executive-summary.md`

**Command**:
```bash
pandoc research/api-trends/executive-summary.md \
  --reference-doc=templates/executive-template.docx \
  -o output/executive-brief.docx
```

**Tips for Executive Summaries**:
- Keep to 2-4 pages
- Use bullet points
- Include key metrics in tables
- Lead with recommendations
- No TOC needed (too short)

## PDF Generation

### Example 8: Generate PDF

**Basic PDF**:
```bash
pandoc research/api-trends/analysis.md \
  --toc \
  -o output/api-trends-report.pdf
```

**With Custom Styling**:
```bash
pandoc research/api-trends/analysis.md \
  --toc \
  --pdf-engine=xelatex \
  -V geometry:margin=1in \
  -V fontsize=11pt \
  -o output/api-trends-report.pdf
```

**PDF Options**:
- `--pdf-engine`: Specify LaTeX engine (xelatex, pdflatex)
- `-V geometry:margin=1in`: Set margins
- `-V fontsize=11pt`: Set font size
- `-V documentclass=report`: Set document class

## Metadata and Front Matter

### Example 9: With Metadata

**In Markdown File**:
```markdown
---
title: "API Management Trends 2024"
author: "Research Team"
date: "June 12, 2024"
---

# Introduction
[Content...]
```

**Command**:
```bash
pandoc research/api-trends/analysis.md \
  --toc \
  --reference-doc=templates/corporate-template.docx \
  -o output/api-trends-report.docx
```

**Result**: Title page with metadata automatically formatted

### Example 10: Separate Metadata File

**metadata.yaml**:
```yaml
---
title: "Competitive Analysis: API Gateways"
subtitle: "Kong vs Apigee vs MuleSoft"
author:
  - name: "John Doe"
    affiliation: "Research Team"
date: "June 2024"
abstract: |
  This report provides a comprehensive comparison of three leading
  API gateway solutions...
---
```

**Command**:
```bash
pandoc metadata.yaml research/vendor-comparison/*.md \
  --toc \
  --reference-doc=templates/corporate-template.docx \
  -o output/vendor-comparison-report.docx
```

## Automation Scripts

### Script 1: Generate All Reports

**generate-reports.sh**:
```bash
#!/bin/bash

# Configuration
TEMPLATE="templates/corporate-template.docx"
OUTPUT_DIR="output"
RESEARCH_DIR="research"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Generate literature review
echo "Generating literature review..."
pandoc "$RESEARCH_DIR/api-management/literature-review.md" \
  --toc --toc-depth=2 \
  --reference-doc="$TEMPLATE" \
  -o "$OUTPUT_DIR/literature-review.docx"

# Generate competitive analysis
echo "Generating competitive analysis..."
pandoc "$RESEARCH_DIR/vendor-comparison"/*.md \
  --toc --toc-depth=2 \
  --reference-doc="$TEMPLATE" \
  -o "$OUTPUT_DIR/competitive-analysis.docx"

# Generate executive summary
echo "Generating executive summary..."
pandoc "$RESEARCH_DIR/executive-summary.md" \
  --reference-doc="templates/executive-template.docx" \
  -o "$OUTPUT_DIR/executive-summary.docx"

echo "✓ All reports generated in $OUTPUT_DIR/"
```

**Usage**:
```bash
chmod +x generate-reports.sh
./generate-reports.sh
```

### Script 2: Watch and Auto-Generate

**watch-and-generate.sh**:
```bash
#!/bin/bash

# Watch for changes and regenerate
SOURCE="research/api-trends/analysis.md"
OUTPUT="output/api-trends-report.docx"
TEMPLATE="templates/corporate-template.docx"

echo "Watching $SOURCE for changes..."

while true; do
  if [ "$SOURCE" -nt "$OUTPUT" ]; then
    echo "Changes detected, regenerating..."
    pandoc "$SOURCE" \
      --toc \
      --reference-doc="$TEMPLATE" \
      -o "$OUTPUT"
    echo "✓ Report updated: $OUTPUT"
  fi
  sleep 5
done
```

## Best Practices

### 1. File Organization

**Recommended Structure**:
```
project/
├── research/
│   ├── topic-1/
│   │   ├── notes.md
│   │   ├── analysis.md
│   │   └── report.md
│   └── topic-2/
├── templates/
│   ├── literature-review.md
│   ├── competitive-analysis.md
│   ├── executive-summary.md
│   ├── corporate-template.docx
│   └── executive-template.docx
└── output/
    ├── literature-review.docx
    └── competitive-analysis.docx
```

### 2. Template Management

**Version Control Templates**:
```bash
# Keep templates in version control
git add templates/*.md templates/*.docx
git commit -m "Update report templates"
```

**Template Naming**:
- `literature-review.md` - Content template
- `corporate-template.docx` - Style template
- Use descriptive names

### 3. Quality Checks

**Before Generating**:
- [ ] Spell check markdown files
- [ ] Verify all links work
- [ ] Check table formatting
- [ ] Ensure metadata is complete
- [ ] Review for placeholder text

**After Generating**:
- [ ] Open in Word and review
- [ ] Check TOC is correct
- [ ] Verify tables formatted properly
- [ ] Check page breaks
- [ ] Review headers/footers

### 4. Version Control

**Track Generated Reports**:
```bash
# Option 1: Don't commit generated files
echo "output/*.docx" >> .gitignore
echo "output/*.pdf" >> .gitignore

# Option 2: Commit with version tags
git add output/report-v1.0.docx
git commit -m "Release report v1.0"
git tag report-v1.0
```

### 5. Naming Conventions

**Output Files**:
- Include date: `api-trends-2024-06-12.docx`
- Include version: `vendor-comparison-v2.docx`
- Be descriptive: `executive-summary-q2-2024.docx`

## Troubleshooting

### Issue: Tables Not Formatting Correctly

**Problem**: Markdown tables look wrong in Word

**Solution**:
```bash
# Use pipe tables (most compatible)
| Column 1 | Column 2 |
|----------|----------|
| Data 1   | Data 2   |

# Or use grid tables for complex layouts
+----------+----------+
| Column 1 | Column 2 |
+==========+==========+
| Data 1   | Data 2   |
+----------+----------+
```

### Issue: Images Not Appearing

**Problem**: Images referenced in markdown don't show in output

**Solution**:
```markdown
# Use relative paths
![Diagram](images/architecture.png)

# Or absolute paths
![Diagram](/full/path/to/image.png)
```

**Ensure images exist** before generating report

### Issue: Template Not Applied

**Problem**: Reference template styles not showing

**Solution**:
1. Verify template file exists
2. Check template has standard style names
3. Use `--reference-doc` not `--template`
4. Regenerate template if needed

### Issue: TOC Not Generating

**Problem**: Table of contents is empty

**Solution**:
```bash
# Ensure headings use # syntax
# Not this:
Heading
=======

# But this:
# Heading

# Check TOC depth matches heading levels
pandoc file.md --toc --toc-depth=3 -o output.docx
```

## Related Documentation

- [Report Templates](../../templates/) - All available templates
- [Research Analysis Examples](../research-analysis/) - Creating content for reports
- [Main SKILL.md](../../SKILL.md) - Complete skill documentation

## Tools Reference

**Pandoc Documentation**: https://pandoc.org/MANUAL.html

**Key Options**:
- `--toc`: Generate table of contents
- `--toc-depth=N`: TOC depth (1-6)
- `--reference-doc=FILE`: Style template
- `-o FILE`: Output file
- `--pdf-engine=ENGINE`: PDF generation engine
- `-V KEY=VALUE`: Set variables

**Supported Formats**:
- Input: markdown, docx, html, latex, etc.
- Output: docx, pdf, html, latex, etc.