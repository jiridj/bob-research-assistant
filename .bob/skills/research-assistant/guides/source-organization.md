# Source Organization Guide

This guide covers best practices for organizing, cataloging, and managing research source materials.

## Overview

Effective source organization enables:
- Quick source discovery
- Efficient research workflows
- Proper attribution and citation
- Knowledge reuse across projects
- Team collaboration

## Source Directory Structure

Sources are stored in a **single top-level `sources/` folder**, shared across all research projects. Original files are kept separately in `originals/` and never modified. Projects reference sources by path rather than duplicating them.

### Structure

```
sources/                    # Shared across all projects
├── IBM/                   # Organised by vendor/entity
│   └── *.md               # Converted documents with YAML frontmatter
├── Forrester/
├── Gartner/
└── web/                   # Scraped content (scrape-with-version.sh output)
    └── COMPANY/
        └── PAGE-YYYY-MM-DD.md

originals/                  # Immutable originals — never modified by Bob
├── IBM/                   # Mirrors sources/ vendor structure
│   └── *.pdf
├── Forrester/
└── Gartner/
```

Each converted markdown file has YAML frontmatter linking back to its original:
```yaml
---
source: originals/Gartner/mq-api-management-2025.pdf
vendor: Gartner
converted: 2025-07-10
---
```

### Wiki Sources (shared, not per-project)

In addition to raw sources, the shared `wiki/sources/` folder contains **Bob-authored summaries** of ingested sources — distinct from the raw converted files:

```
wiki/sources/
└── [source-slug].md        # Bob's summary: key claims, entities, concepts, date
```

Raw `sources/` files are the source of truth. Wiki source pages are the compiled interpretation.

## Naming Conventions

### File Names

**Documents**:
```
[year]-[provider]-[type]-[topic].md

Examples:
- 2024-gartner-magic-quadrant-api-management.md
- 2024-forrester-wave-integration-platforms.md
- 2024-aws-whitepaper-security-best-practices.md
```

**Web Content**:
```
[date]-[domain]-[page-name].md

Examples:
- 2024-06-12-kong-features-overview.md
- 2024-06-12-aws-lambda-documentation.md
- 2024-06-12-apigee-pricing.md
```

**Raw Files**:
```
[year]-[original-name].[extension]

Examples:
- 2024-gartner-mq-api.pdf
- 2024-forrester-wave.pdf
- 2024-aws-security-whitepaper.pdf
```

**Note**: Date/year prefixes enable chronological sorting and make it easy to identify the most recent versions.

### Directory Names

**Use lowercase with hyphens**:
- `analyst-reports` not `Analyst Reports`
- `vendor-docs` not `VendorDocs`
- `case-studies` not `case_studies`

**Be descriptive**:
- `gartner` not `g`
- `whitepapers` not `wp`
- `technical-docs` not `docs`

**Group logically**:
- By provider: `gartner/`, `forrester/`
- By type: `whitepapers/`, `case-studies/`
- By topic: `security/`, `performance/`

## Index Files

### Master Index (sources/index.md)

```markdown
# Sources Master Index

**Last Updated**: 2024-06-12
**Total Sources**: 47

## Quick Stats
- **Documents**: 25
- **Web Pages**: 18
- **Data Files**: 4

## Categories

### Analyst Reports (15)
- [Gartner Reports](gartner/index.md) - 8 reports
- [Forrester Reports](forrester/index.md) - 5 reports
- [IDC Reports](idc/index.md) - 2 reports

### Vendor Documentation (12)
- [AWS Documentation](vendor-docs/aws/index.md) - 5 docs
- [Azure Documentation](vendor-docs/azure/index.md) - 4 docs
- [GCP Documentation](vendor-docs/gcp/index.md) - 3 docs

### Web Content (18)
- [Vendor Websites](web/vendor-sites/index.md) - 10 pages
- [Technical Blogs](web/blogs/index.md) - 8 articles

### Data Sources (4)
- [Benchmarks](data/benchmarks/index.md) - 2 datasets
- [Surveys](data/surveys/index.md) - 2 reports

## Recent Additions
- 2024-06-12: Gartner Magic Quadrant API Management 2024
- 2024-06-11: AWS Lambda Documentation
- 2024-06-10: Kong Features Overview

## Most Referenced
1. Gartner Magic Quadrant API Management 2024 (12 references)
2. Forrester Wave Integration Platforms 2024 (8 references)
3. AWS Security Best Practices (6 references)

## Maintenance Notes
- Need to update Forrester reports
- AWS documentation needs refresh
- Archive sources older than 2 years
```

### Category Index (sources/gartner/index.md)

```markdown
# Gartner Sources Index

**Last Updated**: 2024-06-12
**Total Documents**: 8

## Magic Quadrants

### API Management
- `magic-quadrant-api-management-2024.md` (45 pages)
  - **Published**: March 2024
  - **Converted**: 2024-06-12
  - **Status**: Current
  - **Key Topics**: API gateways, management platforms, vendor comparison

### Integration Platforms
- `magic-quadrant-integration-platforms-2024.md` (52 pages)
  - **Published**: February 2024
  - **Converted**: 2024-06-10
  - **Status**: Current

## Market Guides

### API Security
- `market-guide-api-security-2024.md` (28 pages)
  - **Published**: April 2024
  - **Converted**: 2024-06-11
  - **Status**: Current

## Hype Cycles

### Cloud Computing
- `hype-cycle-cloud-computing-2024.md` (35 pages)
  - **Published**: May 2024
  - **Converted**: 2024-06-12
  - **Status**: Current

## Research Notes

### Critical Capabilities
- `critical-capabilities-api-management-2024.md` (40 pages)
  - **Published**: March 2024
  - **Converted**: 2024-06-12
  - **Status**: Current

## Archive

### 2023 Reports
- `magic-quadrant-api-management-2023.md` (Archived)
- `market-guide-api-security-2023.md` (Archived)

## Usage Statistics
- **Most Referenced**: Magic Quadrant API Management 2024 (12 times)
- **Recent Additions**: 3 in last 7 days
- **Pending Conversion**: 2 PDFs in raw/

## Related Categories
- [Forrester Reports](../forrester/index.md)
- [IDC Reports](../idc/index.md)
- [Vendor Documentation](../vendor-docs/index.md)
```

## Source Metadata

### Document Metadata Template

```markdown
---
title: "Gartner Magic Quadrant for API Management 2024"
source_type: analyst_report
provider: Gartner
published_date: 2024-03-15
converted_date: 2024-06-12
original_file: sources/raw/gartner-mq-api-2024.pdf
pages: 45
relevance: high
topics:
  - API Management
  - API Gateways
  - Vendor Comparison
status: current
---

# Gartner Magic Quadrant for API Management 2024

## Document Information
- **Publisher**: Gartner, Inc.
- **Authors**: Mark O'Neill, Paolo Malinverno
- **Publication Date**: March 15, 2024
- **Document ID**: G00123456
- **Pages**: 45

## Executive Summary
[Brief summary of the document]

## Key Sections
1. Market Definition (Pages 1-5)
2. Magic Quadrant Analysis (Pages 6-15)
3. Vendor Strengths and Cautions (Pages 16-40)
4. Market Trends (Pages 41-45)

## Key Findings
- Finding 1
- Finding 2
- Finding 3

## Vendors Analyzed
- Kong
- Apigee (Google Cloud)
- AWS API Gateway
- Azure API Management
- MuleSoft
- [etc.]

## Relevant Quotes
> "Quote 1 with context"

> "Quote 2 with context"

## My Analysis
[Your thoughts and observations]

## Related Sources
- Forrester Wave API Management 2024
- IDC MarketScape API Management 2024
- AWS API Gateway Documentation

## Usage in Projects
- [Project 1: API Management Trends](../../research/api-management-trends/)
- [Project 2: Vendor Comparison](../../research/vendor-comparison/)

## Tags
#api-management #gartner #magic-quadrant #vendor-analysis #2024
```

### Web Content Metadata Template

```markdown
---
title: "Kong Gateway Features Overview"
source_type: web_content
url: https://konghq.com/products/kong-gateway/features
scraped_date: 2024-06-12
last_updated: 2024-06-01
relevance: high
topics:
  - Kong
  - API Gateway
  - Features
status: current
---

# Kong Gateway Features Overview

## Source Information
- **URL**: https://konghq.com/products/kong-gateway/features
- **Scraped**: 2024-06-12
- **Last Updated**: 2024-06-01 (per website)
- **Content Type**: Product documentation

## Summary
[Brief summary of the content]

## Key Features
1. Feature 1
2. Feature 2
3. Feature 3

## Technical Details
[Relevant technical information]

## Pricing Information
[If available]

## Related Pages
- [Kong Pricing](kong-pricing-2024-06-12.md)
- [Kong Documentation](kong-docs-2024-06-12.md)

## Usage in Projects
- [Vendor Comparison](../../research/vendor-comparison/)

## Tags
#kong #api-gateway #features #vendor-docs
```

## Organization Strategies

### Strategy 1: By Provider

Best for: Tracking specific vendors or analysts

```
sources/
├── gartner/
│   ├── api-management/
│   ├── integration/
│   └── security/
├── forrester/
│   ├── api-management/
│   └── integration/
└── vendor-docs/
    ├── kong/
    ├── apigee/
    └── aws/
```

### Strategy 2: By Topic

Best for: Topic-focused research

```
sources/
├── api-management/
│   ├── gartner/
│   ├── forrester/
│   └── vendor-docs/
├── security/
│   ├── analyst-reports/
│   └── whitepapers/
└── integration/
    ├── analyst-reports/
    └── case-studies/
```

### Strategy 3: By Document Type

Best for: Large, diverse source collections

```
sources/
├── analyst-reports/
│   ├── gartner/
│   ├── forrester/
│   └── idc/
├── whitepapers/
│   ├── vendor/
│   └── academic/
├── case-studies/
├── documentation/
└── web-content/
```

### Strategy 4: Hybrid Approach

Best for: Complex research needs

```
sources/
├── primary/              # Most important sources
│   ├── analyst-reports/
│   └── vendor-docs/
├── secondary/            # Supporting sources
│   ├── blogs/
│   └── news/
├── by-topic/            # Topic-based organization
│   ├── api-management/
│   └── security/
└── archive/             # Historical sources
    └── 2023/
```

## Source Discovery

### Search Commands

**Find by keyword**:
```bash
# Search all sources
grep -r "API Gateway" sources/ --include="*.md"

# Search with context
grep -r -C 3 "microservices" sources/

# Case-insensitive search
grep -ri "kubernetes" sources/
```

**Find by date**:
```bash
# Files modified in last 7 days
find sources/ -name "*.md" -mtime -7

# Files modified in specific date range
find sources/ -name "*.md" -newermt "2024-06-01" ! -newermt "2024-06-12"
```

**Find by type**:
```bash
# All Gartner reports
find sources/gartner/ -name "*.md" -type f

# All web content
find sources/web/ -name "*.md" -type f

# All PDFs
find sources/raw/ -name "*.pdf" -type f
```

### Search Script

```bash
#!/bin/bash
# search-sources.sh

QUERY=$1
CONTEXT=${2:-3}  # Default 3 lines of context

if [ -z "$QUERY" ]; then
  echo "Usage: ./search-sources.sh 'search term' [context_lines]"
  exit 1
fi

echo "Searching for: $QUERY"
echo "Context lines: $CONTEXT"
echo ""

# Search with context and color
grep -r -i -C "$CONTEXT" --color=always "$QUERY" sources/ --include="*.md" | less -R
```

**Usage**:
```bash
./search-sources.sh "API Gateway" 5
```

## Maintenance Tasks

### Regular Maintenance

**Weekly**:
- Update index files with new sources
- Check for broken links in web content
- Archive outdated sources
- Update usage statistics

**Monthly**:
- Review and update metadata
- Consolidate duplicate sources
- Update category indexes
- Generate source reports

**Quarterly**:
- Archive sources older than 2 years
- Review organization structure
- Update naming conventions
- Audit source quality

### Maintenance Scripts

**Update Index Script**:
```bash
#!/bin/bash
# update-source-index.sh

SOURCES_DIR="sources"
INDEX_FILE="$SOURCES_DIR/index.md"

# Count sources
TOTAL_DOCS=$(find "$SOURCES_DIR" -name "*.md" -type f | wc -l)
TOTAL_PDFS=$(find "$SOURCES_DIR/raw" -name "*.pdf" -type f 2>/dev/null | wc -l)

# Update index
cat > "$INDEX_FILE" << EOF
# Sources Master Index

**Last Updated**: $(date +%Y-%m-%d)
**Total Sources**: $TOTAL_DOCS

## Quick Stats
- **Markdown Documents**: $TOTAL_DOCS
- **Raw PDFs**: $TOTAL_PDFS

## Categories
[Auto-generated category list]

## Recent Additions
$(find "$SOURCES_DIR" -name "*.md" -type f -mtime -7 | head -5)

## Maintenance Notes
- Last index update: $(date +%Y-%m-%d)
EOF

echo "✓ Updated source index"
```

**Archive Old Sources**:
```bash
#!/bin/bash
# archive-old-sources.sh

ARCHIVE_YEAR=2022
SOURCES_DIR="sources"
ARCHIVE_DIR="$SOURCES_DIR/archive/$ARCHIVE_YEAR"

mkdir -p "$ARCHIVE_DIR"

# Find and move old sources
find "$SOURCES_DIR" -name "*-$ARCHIVE_YEAR.md" -type f -exec mv {} "$ARCHIVE_DIR/" \;

echo "✓ Archived sources from $ARCHIVE_YEAR to $ARCHIVE_DIR"
```

## Best Practices

### 1. Consistent Naming

**Always use**:
- Lowercase with hyphens
- Descriptive names
- Date suffixes for versions
- Provider prefixes

**Example**:
```
✓ gartner-magic-quadrant-api-management-2024.md
✗ Gartner_MQ_API_2024.md
✗ mq.md
```

### 2. Comprehensive Metadata

**Include**:
- Source information
- Publication/scrape dates
- Topics and tags
- Relevance rating
- Related sources

### 3. Regular Updates

**Keep current**:
- Update indexes weekly
- Refresh web content monthly
- Archive old sources quarterly
- Review organization annually

### 4. Clear Documentation

**Document**:
- Organization strategy
- Naming conventions
- Maintenance procedures
- Search techniques

### 5. Version Control

**Track changes**:
```bash
# Commit new sources
git add sources/
git commit -m "Add Gartner Magic Quadrant 2024"

# Tag major updates
git tag sources-update-2024-06
```

## Common Workflows

### Workflow 1: Add New Document

```bash
# 1. Convert document
docling report.pdf --output sources/gartner/magic-quadrant-2024.md

# 2. Add metadata
# Edit sources/gartner/magic-quadrant-2024.md
# Add YAML front matter and document info

# 3. Update category index
# Edit sources/gartner/index.md
# Add entry for new document

# 4. Update master index
./update-source-index.sh

# 5. Commit
git add sources/
git commit -m "Add Gartner Magic Quadrant 2024"
```

### Workflow 2: Add Web Content

```bash
# 1. Scrape content
crwl crawl https://example.com --output markdown --output-file sources/web/example-2024-06-12.md

# 2. Add metadata
# Edit sources/web/example-2024-06-12.md
# Add YAML front matter

# 3. Update web index
# Edit sources/web/index.md

# 4. Update master index
./update-source-index.sh

# 5. Commit
git add sources/
git commit -m "Add web content from example.com"
```

### Workflow 3: Archive Old Sources

```bash
# 1. Identify old sources
find sources/ -name "*-2022.md" -type f

# 2. Create archive directory
mkdir -p sources/archive/2022

# 3. Move old sources
./archive-old-sources.sh

# 4. Update indexes
./update-source-index.sh

# 5. Commit
git add sources/
git commit -m "Archive 2022 sources"
```

## Troubleshooting

### Issue: Can't find specific source

**Solution**: Use comprehensive search
```bash
# Search by title
grep -r "Magic Quadrant" sources/ --include="*.md"

# Search by topic
grep -r "API Management" sources/ --include="*.md"

# Search by date
find sources/ -name "*-2024-06-12.md"
```

### Issue: Duplicate sources

**Solution**: Implement deduplication
```bash
# Find potential duplicates by name
find sources/ -name "*.md" -type f | sort | uniq -d

# Compare file contents
diff sources/gartner/report-v1.md sources/gartner/report-v2.md
```

### Issue: Broken organization

**Solution**: Reorganize systematically
```bash
# 1. Backup current structure
cp -r sources/ sources-backup/

# 2. Create new structure
mkdir -p sources-new/{gartner,forrester,web}

# 3. Move files to new structure
# Use scripts or manual organization

# 4. Update all indexes

# 5. Verify and commit
```

## Related Documentation

- [Project Initialization Guide](project-initialization.md) - Setting up research projects
- [Document Conversion Examples](../examples/document-conversion/) - Converting sources
- [Web Scraping Examples](../examples/web-scraping/) - Gathering web content
- [Main SKILL.md](../SKILL.md) - Complete skill documentation

## Summary

Effective source organization:
- Uses consistent naming conventions
- Maintains comprehensive indexes
- Implements regular maintenance
- Enables quick discovery
- Supports research workflows
- Facilitates collaboration

Choose an organization strategy that fits your research needs and maintain it consistently.