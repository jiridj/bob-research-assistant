# Document Conversion Examples

This directory contains practical examples of converting various document types to markdown using the docling CLI tool.

## Overview

Document conversion is the first step in the research workflow, transforming PDFs, DOCX, and other formats into markdown for analysis. These examples demonstrate best practices for different scenarios.

## Key Principles

### 1. Images Excluded by Default
- Most research documents don't need embedded images
- Text-only conversion is faster and produces cleaner markdown
- Use `--no-images` flag explicitly

### 2. Optional Image Export
- When diagrams/charts are important, export as separate files
- Use `--export-images` to save images to a dedicated folder
- Images are referenced in markdown, NOT embedded as base64

### 3. Never Embed Images
- ❌ Don't use base64 encoding
- ❌ Don't embed binary data in markdown
- ✅ Store images as separate PNG/JPG files
- ✅ Use relative paths in markdown references

### 4. Preserve Structure
- Maintain document hierarchy (headings, sections)
- Keep formatting (bold, italic, lists)
- Preserve tables and code blocks

## Examples

### [Example 1: Convert Gartner Report](example-1-gartner-report.md)
**Scenario**: Converting analyst reports for competitive intelligence

**Key Features**:
- Text-only conversion (no images needed)
- Organized by source type (Gartner folder)
- Descriptive output filenames
- Error handling and verification

**Use Case**: When you need to analyze text content from industry reports, market research, or analyst publications.

**Command Pattern**:
```bash
docling input.pdf --output sources/Gartner/report-name.md --no-images
```

### [Example 2: Convert AWS Whitepaper with Images](example-2-aws-whitepaper-images.md)
**Scenario**: Converting technical documentation with architecture diagrams

**Key Features**:
- Image export to separate folder
- Hierarchical organization (Hyperscalers/AWS)
- Image reference management
- Detailed verification steps

**Use Case**: When architecture diagrams, flowcharts, or technical illustrations are essential for understanding the content.

**Command Pattern**:
```bash
docling input.pdf \
  --output sources/Category/document.md \
  --export-images sources/Category/images/
```

## Common Workflows

### Basic Conversion (No Images)
```bash
docling document.pdf --output sources/category/document.md --no-images
```

**When to use**:
- Text-focused research
- Analyst reports
- Academic papers (text only)
- News articles
- Blog posts

### Conversion with Images
```bash
docling document.pdf \
  --output sources/category/document.md \
  --export-images sources/category/images/
```

**When to use**:
- Technical whitepapers
- Architecture documentation
- Product documentation with diagrams
- Research with charts/graphs
- Presentations converted to documents

### Batch Processing
```bash
for file in sources/raw/*.pdf; do
  docling "$file" \
    --output "sources/processed/$(basename "$file" .pdf).md" \
    --no-images
done
```

**When to use**:
- Multiple documents from same source
- Bulk import of research materials
- Periodic updates (quarterly reports)
- Conference proceedings

## Folder Organization

### Recommended Structure
```
sources/
├── Gartner/                    # Analyst reports
│   ├── magic-quadrant-2024.md
│   └── market-guide-2024.md
├── Forrester/                  # Analyst reports
│   └── wave-report-2024.md
├── Hyperscalers/              # Cloud providers
│   ├── AWS/
│   │   ├── whitepaper.md
│   │   └── images/
│   ├── Azure/
│   └── GCP/
├── Competitors/               # Competitive intelligence
│   ├── Kong/
│   ├── Apigee/
│   └── MuleSoft/
└── Academic/                  # Research papers
    └── papers/
```

### Category Guidelines

**By Source Type**:
- `Gartner/`, `Forrester/`, `IDC/` - Analyst firms
- `Hyperscalers/` - AWS, Azure, GCP materials
- `Competitors/` - Competitive products/companies
- `Academic/` - Research papers, journals

**By Topic**:
- `API-Management/`
- `Microservices/`
- `Cloud-Native/`
- `Security/`

**By Project**:
- `Project-Alpha/sources/`
- `Q4-Analysis/sources/`

Choose the structure that best fits your research needs.

## Verification Checklist

After each conversion, verify:

- [ ] Output file exists and is not empty
- [ ] File size is reasonable (not 0 bytes)
- [ ] Markdown formatting is correct
- [ ] Headings and structure preserved
- [ ] Tables rendered properly (if applicable)
- [ ] Images exported to correct folder (if using --export-images)
- [ ] Image references work in markdown
- [ ] No base64 encoded images in markdown
- [ ] File saved to correct category folder
- [ ] Filename is descriptive and includes version/date

## Troubleshooting

### File Not Found
```bash
# List available PDFs
ls ~/Downloads/*.pdf
ls ~/Documents/*.pdf

# Check current directory
pwd
ls -la
```

### Permission Denied
```bash
# Check file permissions
ls -l document.pdf

# Make readable
chmod +r document.pdf
```

### Conversion Failed
```bash
# Check docling installation
docling --version

# Try with verbose output
docling document.pdf --output output.md --verbose

# Check PDF is not corrupted
file document.pdf
```

### Images Not Exporting
```bash
# Verify images folder exists or can be created
mkdir -p sources/category/images/

# Check disk space
df -h

# Try without images first
docling document.pdf --output output.md --no-images
```

## Best Practices

1. **Always specify output path** - Don't rely on defaults
2. **Use descriptive filenames** - Include version, date, or topic
3. **Organize by category** - Maintain consistent folder structure
4. **Default to no images** - Only export when needed
5. **Verify after conversion** - Check output before proceeding
6. **Handle errors gracefully** - Provide helpful error messages
7. **Document your sources** - Keep track of original files
8. **Use batch processing** - For multiple similar documents
9. **Test with one file first** - Before batch processing
10. **Keep originals** - Don't delete source PDFs

## Next Steps

After converting documents:

1. **Verify conversion quality** - Review the markdown output
2. **Create metadata** - Document source, date, author
3. **Index the content** - Add to category index file
4. **Begin analysis** - Extract key information
5. **Synthesize findings** - Combine with other sources
6. **Generate reports** - Use pandoc for final output

## Related Documentation

- [SKILL.md](../../SKILL.md) - Complete skill documentation
- [Web Scraping Examples](../web-scraping/) - Extracting content from websites
- [Research Analysis Examples](../research-analysis/) - Analyzing converted documents
- [Report Generation Examples](../report-generation/) - Creating final reports

## Tools Required

- **docling** - Document conversion CLI tool
  - Installation: `pip install docling`
  - Documentation: [docling docs](https://github.com/DS4SD/docling)

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review the example workflows
3. Consult the main SKILL.md documentation
4. Verify docling installation and version