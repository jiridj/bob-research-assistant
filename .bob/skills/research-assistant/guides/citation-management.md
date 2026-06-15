# Citation Management Guide

This guide explains how to track sources, format citations, and maintain bibliographies in your research projects.

## Overview

Proper citation management ensures:
- **Traceability**: Link findings back to original sources
- **Credibility**: Support claims with references
- **Reproducibility**: Others can verify your research
- **Organization**: Track which sources contributed what insights

## Citation Tracking

### During Source Gathering

When converting documents or scraping web content, capture metadata:

```bash
# Document conversion with metadata
docling sources/raw/gartner-report.pdf \
  --output sources/gartner/2024-magic-quadrant-api-management.md \
  --no-images

# Add citation metadata to converted file
cat >> sources/gartner/2024-magic-quadrant-api-management.md << 'EOF'

---
citation:
  id: gartner-mq-2024
  type: analyst_report
  author: "Mark O'Neill, Paolo Malinverno"
  title: "Magic Quadrant for API Management"
  publisher: Gartner, Inc.
  date: 2024-03-15
  url: https://www.gartner.com/doc/123456
  accessed: 2024-06-12
---
EOF
```

### During Analysis

Reference sources inline using citation IDs:

```markdown
# Analysis Notes

## Key Finding: API Gateway Performance

Kong demonstrates superior performance with 50K requests/second [gartner-mq-2024, p.12].
This is confirmed by Forrester's independent testing [forrester-wave-2024, p.8].

AWS API Gateway shows 30K req/s in standard configuration [aws-docs-2024].
```

## Citation Formats

### Inline Citations

**Numbered Style**:
```markdown
Kong's performance metrics [1] exceed industry averages by 40% [2].

References:
[1] Gartner Magic Quadrant 2024, p.12
[2] Forrester Wave 2024, p.8
```

**Author-Date Style**:
```markdown
Kong's performance metrics (Gartner, 2024, p.12) exceed industry 
averages by 40% (Forrester, 2024, p.8).
```

**Footnote Style**:
```markdown
Kong's performance metrics¹ exceed industry averages by 40%².

---
¹ Gartner. "Magic Quadrant for API Management." 2024, p.12.
² Forrester. "API Management Platforms Wave." 2024, p.8.
```

### Bibliography Formats

**Standard Format**:
```markdown
## References

### Analyst Reports

**[gartner-mq-2024]** Gartner, Inc.
- **Title**: Magic Quadrant for API Management
- **Authors**: Mark O'Neill, Paolo Malinverno
- **Date**: March 15, 2024
- **Pages**: 45
- **Source**: `sources/gartner/2024-magic-quadrant-api-management.md`

**[forrester-wave-2024]** Forrester Research
- **Title**: The Forrester Wave: API Management Solutions, Q1 2024
- **Authors**: Randy Heffner, Christopher Condo
- **Date**: February 20, 2024
- **Pages**: 38
- **Source**: `sources/forrester/2024-wave-api-management.md`

### Vendor Documentation

**[kong-docs-2024]** Kong Inc.
- **Title**: Kong Gateway Features Overview
- **URL**: https://konghq.com/products/kong-gateway/features
- **Accessed**: June 12, 2024
- **Source**: `sources/vendor-docs/kong/2024-06-12-features-overview.md`

**[aws-docs-2024]** Amazon Web Services
- **Title**: Amazon API Gateway Developer Guide
- **URL**: https://docs.aws.amazon.com/apigateway/
- **Accessed**: June 12, 2024
- **Source**: `sources/vendor-docs/aws/2024-06-12-api-gateway-overview.md`
```

**Compact Format**:
```markdown
## References

1. Gartner (2024). "Magic Quadrant for API Management." March 15, 2024.
2. Forrester (2024). "The Forrester Wave: API Management Solutions." Feb 20, 2024.
3. Kong Inc. (2024). "Kong Gateway Features." https://konghq.com/products/kong-gateway/features
4. AWS (2024). "API Gateway Developer Guide." https://docs.aws.amazon.com/apigateway/
```

## Automated Citation Generation

### Create Bibliography from Sources

```bash
#!/bin/bash
# generate-bibliography.sh

SOURCES_DIR="sources"
OUTPUT="bibliography.md"

echo "# Bibliography" > "$OUTPUT"
echo "" >> "$OUTPUT"
echo "**Generated**: $(date +%Y-%m-%d)" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Process analyst reports
echo "## Analyst Reports" >> "$OUTPUT"
echo "" >> "$OUTPUT"

for file in "$SOURCES_DIR"/gartner/*.md "$SOURCES_DIR"/forrester/*.md; do
  if [ -f "$file" ]; then
    # Extract metadata from YAML front matter
    title=$(grep "^title:" "$file" | cut -d'"' -f2)
    author=$(grep "^author:" "$file" | cut -d'"' -f2)
    date=$(grep "^published_date:" "$file" | cut -d' ' -f2)
    
    echo "- **$title**" >> "$OUTPUT"
    echo "  - Author: $author" >> "$OUTPUT"
    echo "  - Date: $date" >> "$OUTPUT"
    echo "  - Source: \`$file\`" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
  fi
done

# Process vendor documentation
echo "## Vendor Documentation" >> "$OUTPUT"
echo "" >> "$OUTPUT"

for file in "$SOURCES_DIR"/vendor-docs/*/*.md; do
  if [ -f "$file" ]; then
    title=$(grep "^# " "$file" | head -1 | sed 's/^# //')
    url=$(grep "^url:" "$file" | cut -d' ' -f2)
    accessed=$(basename "$file" | cut -d'-' -f1-3)
    
    echo "- **$title**" >> "$OUTPUT"
    echo "  - URL: $url" >> "$OUTPUT"
    echo "  - Accessed: $accessed" >> "$OUTPUT"
    echo "  - Source: \`$file\`" >> "$OUTPUT"
    echo "" >> "$OUTPUT"
  fi
done

echo "Bibliography generated: $OUTPUT"
```

### Extract Citations from Analysis

```bash
#!/bin/bash
# extract-citations.sh

ANALYSIS_FILE="$1"
OUTPUT="citations-used.md"

echo "# Citations Used" > "$OUTPUT"
echo "" >> "$OUTPUT"
echo "**From**: $ANALYSIS_FILE" >> "$OUTPUT"
echo "**Generated**: $(date +%Y-%m-%d)" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Extract citation IDs (format: [citation-id])
grep -o '\[[-a-z0-9]*-[0-9]*\]' "$ANALYSIS_FILE" | \
  sort -u | \
  while read citation; do
    id=$(echo "$citation" | tr -d '[]')
    echo "- $citation" >> "$OUTPUT"
    
    # Find source file with this citation ID
    source_file=$(grep -l "id: $id" sources/**/*.md 2>/dev/null | head -1)
    if [ -n "$source_file" ]; then
      echo "  - Source: \`$source_file\`" >> "$OUTPUT"
    fi
    echo "" >> "$OUTPUT"
  done

echo "Citations extracted: $OUTPUT"
```

## Citation Workflow

### 1. Initialize Project with Citation Tracking

```bash
# Create citation index
cat > research/api-management-trends-2024/citations.md << 'EOF'
# Citation Index

## Sources

| ID | Type | Title | Date | File |
|----|------|-------|------|------|
| gartner-mq-2024 | Report | Magic Quadrant API Management | 2024-03 | sources/gartner/... |
| forrester-wave-2024 | Report | Forrester Wave API Management | 2024-02 | sources/forrester/... |
| kong-docs-2024 | Docs | Kong Gateway Features | 2024-06-12 | sources/vendor-docs/kong/... |

## Usage Tracking

| Citation ID | Used In | Count |
|-------------|---------|-------|
| gartner-mq-2024 | analysis.md | 12 |
| forrester-wave-2024 | analysis.md | 8 |
| kong-docs-2024 | vendor-comparison.md | 5 |
EOF
```

### 2. Add Citations During Analysis

```markdown
# Competitive Analysis

## Performance Comparison

### Kong Gateway
- **Throughput**: 50,000 req/s [gartner-mq-2024, p.12]
- **Latency**: <10ms p99 [kong-docs-2024]
- **Scalability**: Linear to 100K req/s [forrester-wave-2024, p.15]

### Apigee
- **Throughput**: 35,000 req/s [gartner-mq-2024, p.18]
- **Latency**: <15ms p99 [apigee-docs-2024]
- **Scalability**: Managed auto-scaling [forrester-wave-2024, p.22]
```

### 3. Generate Bibliography

```bash
# Run bibliography generator
./generate-bibliography.sh

# Add to report
cat bibliography.md >> research/api-management-trends-2024/report.md
```

### 4. Validate Citations

```bash
# Check for broken citation links
./validate-citations.sh research/api-management-trends-2024/analysis.md
```

## Citation Validation

### Validation Script

```bash
#!/bin/bash
# validate-citations.sh

FILE="$1"

echo "Validating citations in: $FILE"
echo ""

# Extract all citation IDs
citations=$(grep -o '\[[-a-z0-9]*-[0-9]*\]' "$FILE" | tr -d '[]' | sort -u)

missing=0
found=0

for citation in $citations; do
  # Check if citation exists in any source file
  if grep -q "id: $citation" sources/**/*.md 2>/dev/null; then
    echo "✓ $citation - Found"
    ((found++))
  else
    echo "✗ $citation - Missing"
    ((missing++))
  fi
done

echo ""
echo "Summary:"
echo "  Found: $found"
echo "  Missing: $missing"

if [ $missing -gt 0 ]; then
  echo ""
  echo "⚠️  Some citations are missing source files"
  exit 1
else
  echo ""
  echo "✓ All citations validated"
  exit 0
fi
```

## Best Practices

### 1. Consistent Citation IDs

Use descriptive, consistent naming:
```
✓ gartner-mq-2024
✓ forrester-wave-api-2024
✓ kong-docs-features-2024-06

✗ source1
✗ doc
✗ report
```

### 2. Capture Metadata Early

Add citation metadata when converting/scraping:
```yaml
---
citation:
  id: unique-identifier
  type: report|documentation|article|whitepaper
  author: "Author Name"
  title: "Document Title"
  publisher: "Publisher Name"
  date: YYYY-MM-DD
  url: https://...
  accessed: YYYY-MM-DD
  pages: total_pages
---
```

### 3. Link Findings to Sources

Always cite claims:
```markdown
❌ Kong is the fastest API gateway.

✓ Kong demonstrates 50K req/s throughput [gartner-mq-2024, p.12], 
  making it the highest-performing solution tested.
```

### 4. Maintain Citation Index

Keep a master list of all citations:
```markdown
# Citation Index

| ID | Title | Type | Date | Status |
|----|-------|------|------|--------|
| gartner-mq-2024 | Magic Quadrant | Report | 2024-03 | ✓ Active |
| old-report-2022 | Old Analysis | Report | 2022-01 | ⚠️ Outdated |
```

### 5. Version Citations

When sources are updated:
```markdown
# Version History

## gartner-mq-2024
- v1: Initial report (2024-03-15)
- v2: Updated with Q2 data (2024-06-01)

## Usage
- Use v2 for current analysis
- v1 archived for historical reference
```

## Common Patterns

### Pattern 1: Multi-Source Claims

```markdown
Kong's performance advantage is well-documented across multiple sources:
- Gartner reports 50K req/s [gartner-mq-2024, p.12]
- Forrester confirms 48K req/s in independent testing [forrester-wave-2024, p.15]
- Kong's own documentation claims 50K+ req/s [kong-docs-2024]
```

### Pattern 2: Comparative Analysis

```markdown
| Vendor | Throughput | Source |
|--------|------------|--------|
| Kong | 50K req/s | [gartner-mq-2024, p.12] |
| Apigee | 35K req/s | [gartner-mq-2024, p.18] |
| AWS | 30K req/s | [aws-docs-2024] |
```

### Pattern 3: Conflicting Sources

```markdown
Performance metrics vary by source:
- Gartner: 50K req/s [gartner-mq-2024, p.12]
- Forrester: 48K req/s [forrester-wave-2024, p.15]
- Vendor claim: 50K+ req/s [kong-docs-2024]

**Analysis**: Variation likely due to different test configurations.
Using conservative estimate of 48K req/s for analysis.
```

## Integration with Reports

### In Executive Summary

```markdown
# Executive Summary

This analysis synthesizes findings from 5 analyst reports and 6 vendor 
documentation sources (see Bibliography for complete list).

Key findings:
- Kong leads in performance [gartner-mq-2024, forrester-wave-2024]
- Apigee offers most comprehensive features [gartner-mq-2024]
- AWS provides easiest deployment [aws-docs-2024]
```

### In Full Report

```markdown
# Detailed Analysis

## Performance Benchmarks

### Methodology
Performance data compiled from:
- Gartner Magic Quadrant testing [gartner-mq-2024]
- Forrester Wave independent benchmarks [forrester-wave-2024]
- Vendor-published specifications [kong-docs-2024, apigee-docs-2024, aws-docs-2024]

### Results
[Detailed analysis with inline citations]

## Bibliography
[Complete reference list]
```

## Tools and Scripts

All citation management scripts are available in:
```
.bob/skills/research-assistant/scripts/
├── generate-bibliography.sh
├── extract-citations.sh
├── validate-citations.sh
└── update-citation-index.sh
```

## Related Documentation

- [Source Organization Guide](source-organization.md) - Organizing source files
- [Report Generation Guide](../examples/report-generation/) - Creating reports with citations
- [Project Initialization Guide](project-initialization.md) - Setting up citation tracking

## Summary

Effective citation management:
- Tracks sources systematically
- Links findings to evidence
- Maintains credibility
- Enables verification
- Supports reproducibility

Use consistent citation IDs, capture metadata early, and validate citations before finalizing reports.