# Quality Assurance Guide

This guide covers validation checks and quality assurance practices for the Research Assistant skill.

## Overview

Quality assurance ensures that all research operations produce reliable, accurate, and well-formatted outputs. This guide provides checklists and validation procedures for different types of research tasks.

## Document Conversion Validation

### Pre-Conversion Checks

Before converting documents, verify:

```markdown
✓ Source file exists and is accessible
✓ File format is supported (PDF, DOCX, PPTX, etc.)
✓ File is not corrupted or password-protected
✓ Sufficient disk space for output
✓ Docling is properly installed
```

### Post-Conversion Validation

After conversion, check:

**File Output**:
- ✓ Output markdown file was created
- ✓ File size is reasonable (not empty or corrupted)
- ✓ File permissions allow reading

**Content Quality**:
- ✓ Text extracted correctly (no garbled characters)
- ✓ Headings preserved with proper hierarchy
- ✓ Lists formatted correctly (bullets, numbers)
- ✓ Tables converted to markdown format
- ✓ Code blocks properly formatted

**Image Handling**:
- ✓ Images extracted to designated folder
- ✓ Image references in markdown are correct
- ✓ Image files are valid and viewable
- ✓ Alt text or captions preserved

**Metadata**:
- ✓ Document title extracted
- ✓ Author information preserved (if available)
- ✓ Page numbers or sections maintained

### Validation Example

```markdown
## Conversion Validation Report

**Source**: research-paper.pdf
**Output**: research-paper.md
**Date**: 2024-01-15

### Checks Performed:
- [x] File created successfully
- [x] Content extracted (45 pages)
- [x] 12 images extracted
- [x] 3 tables converted
- [x] Bibliography preserved
- [x] Formatting validated

### Issues Found:
- [ ] Table 2 formatting needs manual adjustment
- [ ] Figure 7 caption incomplete

### Actions Taken:
- Manually reformatted Table 2
- Added missing caption to Figure 7
```

## Web Scraping Validation

### Pre-Scraping Checks

```markdown
✓ URL is valid and accessible
✓ Website allows scraping (check robots.txt)
✓ Network connection is stable
✓ Crawl4ai is properly configured
✓ Output directory exists
```

### Post-Scraping Validation

**Content Extraction**:
- ✓ Main content extracted (not just navigation/ads)
- ✓ Text is clean and readable
- ✓ Links preserved and functional
- ✓ Metadata captured (title, author, date)

**Quality Checks**:
- ✓ No duplicate content
- ✓ No broken or incomplete sentences
- ✓ Proper paragraph structure
- ✓ Code snippets formatted correctly
- ✓ Images downloaded (if requested)

**Data Integrity**:
- ✓ All requested pages scraped
- ✓ No missing sections
- ✓ Timestamps recorded
- ✓ Source URLs documented

### Validation Example

```markdown
## Web Scraping Validation

**URL**: https://example.com/article
**Date**: 2024-01-15
**Method**: Crawl4ai

### Content Quality:
- [x] Title extracted: "Advanced Research Methods"
- [x] Author: Dr. Jane Smith
- [x] Publication date: 2024-01-10
- [x] Main content: 3,500 words
- [x] 5 images downloaded
- [x] 15 internal links preserved

### Issues:
- [ ] One image failed to download (404 error)
- [ ] Footer content included (needs removal)

### Resolution:
- Manually downloaded missing image
- Removed footer content from markdown
```

## Research Analysis Validation

### Source Verification

**Citation Checks**:
- ✓ All claims have source citations
- ✓ Citations follow consistent format
- ✓ Source URLs are accessible
- ✓ Publication dates are recent/relevant
- ✓ Authors are credible

**Evidence Quality**:
- ✓ Multiple sources support key findings
- ✓ Sources are diverse (not all from one site)
- ✓ Primary sources used when available
- ✓ Data is current and relevant
- ✓ No contradictory evidence ignored

### Analysis Quality

**Logical Consistency**:
- ✓ Arguments flow logically
- ✓ Conclusions supported by evidence
- ✓ No logical fallacies
- ✓ Counterarguments addressed
- ✓ Limitations acknowledged

**Completeness**:
- ✓ All research questions answered
- ✓ Key topics covered thoroughly
- ✓ Gaps in knowledge identified
- ✓ Future research directions noted

### Validation Checklist

```markdown
## Research Analysis Quality Check

**Topic**: Impact of AI on Education
**Date**: 2024-01-15
**Sources**: 25 documents

### Source Quality:
- [x] 15 peer-reviewed papers
- [x] 5 industry reports
- [x] 3 government studies
- [x] 2 expert interviews
- [x] All sources from 2020-2024

### Analysis Quality:
- [x] 5 key findings identified
- [x] Each finding has 3+ supporting sources
- [x] Contradictory evidence discussed
- [x] Limitations section included
- [x] Practical implications outlined

### Completeness:
- [x] All research questions addressed
- [x] Literature review comprehensive
- [x] Methodology clearly explained
- [x] Results properly interpreted
- [x] Conclusions justified

### Issues:
- [ ] Need more recent data on K-12 education
- [ ] Add more international perspectives

### Next Steps:
- Search for 2024 K-12 AI studies
- Include European and Asian research
```

## Report Generation Validation

### Pre-Generation Checks

```markdown
✓ All content sections complete
✓ Citations properly formatted
✓ Images/figures ready
✓ Pandoc installed and configured
✓ Template file exists (if using custom)
```

### Post-Generation Validation

**Document Structure**:
- ✓ Title page present
- ✓ Table of contents generated
- ✓ All sections included
- ✓ Page numbers correct
- ✓ Headers/footers applied

**Formatting**:
- ✓ Consistent font and sizing
- ✓ Proper heading hierarchy
- ✓ Lists formatted correctly
- ✓ Tables aligned properly
- ✓ Images positioned correctly
- ✓ Captions numbered sequentially

**Content Quality**:
- ✓ No formatting artifacts
- ✓ No broken links
- ✓ All references included
- ✓ Appendices attached
- ✓ Metadata correct (author, date, etc.)

### Validation Example

```markdown
## Report Generation Validation

**Report**: AI-Education-Impact-Report.docx
**Date**: 2024-01-15
**Pages**: 45

### Structure Check:
- [x] Title page
- [x] Executive summary (2 pages)
- [x] Table of contents
- [x] Introduction (3 pages)
- [x] Literature review (15 pages)
- [x] Methodology (5 pages)
- [x] Findings (12 pages)
- [x] Discussion (5 pages)
- [x] Conclusions (2 pages)
- [x] References (3 pages)

### Formatting Check:
- [x] Consistent fonts (Times New Roman 12pt)
- [x] Proper margins (1 inch)
- [x] Page numbers (bottom center)
- [x] 15 figures properly captioned
- [x] 8 tables formatted correctly
- [x] 125 references in APA format

### Quality Issues:
- [ ] Figure 7 resolution low
- [ ] Table 4 spans page break awkwardly

### Resolution:
- Replace Figure 7 with higher resolution version
- Adjust Table 4 to start on new page
```

## Automated Validation Scripts

### Document Conversion Check

```bash
#!/bin/bash
# validate-conversion.sh

INPUT_FILE="$1"
OUTPUT_FILE="$2"

echo "Validating conversion: $INPUT_FILE -> $OUTPUT_FILE"

# Check output exists
if [ ! -f "$OUTPUT_FILE" ]; then
    echo "❌ Output file not found"
    exit 1
fi

# Check file size
SIZE=$(stat -f%z "$OUTPUT_FILE" 2>/dev/null || stat -c%s "$OUTPUT_FILE" 2>/dev/null)
if [ "$SIZE" -lt 100 ]; then
    echo "❌ Output file too small (possible conversion failure)"
    exit 1
fi

# Check for common markdown elements
if ! grep -q "^#" "$OUTPUT_FILE"; then
    echo "⚠️  Warning: No headings found"
fi

# Check for images
IMAGE_COUNT=$(grep -c "!\[.*\](" "$OUTPUT_FILE" || echo "0")
echo "✓ Found $IMAGE_COUNT image references"

# Check for tables
TABLE_COUNT=$(grep -c "^|" "$OUTPUT_FILE" || echo "0")
echo "✓ Found $TABLE_COUNT table rows"

echo "✓ Validation complete"
```

### Citation Validation

```python
#!/usr/bin/env python3
# validate-citations.py

import re
import sys

def validate_citations(markdown_file):
    """Validate citations in markdown file"""
    
    with open(markdown_file, 'r') as f:
        content = f.read()
    
    # Find all citations
    citations = re.findall(r'\[([^\]]+)\]\(([^)]+)\)', content)
    
    print(f"Found {len(citations)} citations")
    
    # Check for broken links
    broken = []
    for text, url in citations:
        if url.startswith('http'):
            # Could add actual URL checking here
            pass
        elif not url.startswith('#'):
            # Local file reference
            if not os.path.exists(url):
                broken.append(url)
    
    if broken:
        print(f"❌ {len(broken)} broken references found:")
        for url in broken:
            print(f"  - {url}")
        return False
    
    print("✓ All citations valid")
    return True

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: validate-citations.py <markdown-file>")
        sys.exit(1)
    
    success = validate_citations(sys.argv[1])
    sys.exit(0 if success else 1)
```

## Quality Metrics

### Document Conversion

- **Success Rate**: % of documents converted without errors
- **Content Accuracy**: % of content correctly extracted
- **Format Preservation**: % of formatting maintained
- **Image Extraction**: % of images successfully extracted

### Research Analysis

- **Source Quality**: Average credibility score of sources
- **Citation Density**: Citations per 1000 words
- **Evidence Support**: % of claims with supporting evidence
- **Completeness**: % of research questions answered

### Report Generation

- **Format Compliance**: % of formatting rules followed
- **Structure Completeness**: % of required sections present
- **Reference Accuracy**: % of references correctly formatted
- **Visual Quality**: % of figures/tables properly formatted

## Best Practices

### 1. Validate Early and Often

- Check outputs immediately after generation
- Don't wait until the end of a project
- Fix issues as they arise

### 2. Use Checklists

- Create custom checklists for your projects
- Review checklists before finalizing outputs
- Update checklists based on lessons learned

### 3. Automate Where Possible

- Use scripts for repetitive checks
- Integrate validation into workflows
- Set up pre-commit hooks for quality checks

### 4. Document Issues

- Keep a log of common problems
- Note solutions that worked
- Share knowledge with team members

### 5. Continuous Improvement

- Review validation results regularly
- Identify patterns in errors
- Update processes to prevent recurring issues

## Common Quality Issues

### Document Conversion

**Issue**: Garbled text in converted documents
**Cause**: Encoding problems or unsupported fonts
**Solution**: Try different conversion settings, check source file encoding

**Issue**: Missing images
**Cause**: Images embedded in unsupported format
**Solution**: Extract images manually, convert to supported format

**Issue**: Broken table formatting
**Cause**: Complex table structures
**Solution**: Manually reformat tables in markdown

### Web Scraping

**Issue**: Incomplete content extraction
**Cause**: Dynamic content loaded by JavaScript
**Solution**: Use browser-based scraping, wait for content to load

**Issue**: Duplicate content
**Cause**: Multiple scraping passes or pagination issues
**Solution**: Deduplicate content, check scraping logic

### Research Analysis

**Issue**: Insufficient source diversity
**Cause**: Over-reliance on single source type
**Solution**: Actively seek diverse sources, set diversity targets

**Issue**: Weak evidence support
**Cause**: Claims without proper citations
**Solution**: Add citations, find supporting evidence

### Report Generation

**Issue**: Inconsistent formatting
**Cause**: Mixed markdown styles or template issues
**Solution**: Use consistent markdown syntax, validate template

**Issue**: Broken cross-references
**Cause**: Section renaming or deletion
**Solution**: Update all references, use automated link checking

## Quality Assurance Workflow

```markdown
1. **Pre-Task Planning**
   - Define quality criteria
   - Create validation checklist
   - Set up validation tools

2. **During Task Execution**
   - Perform incremental validation
   - Document issues immediately
   - Apply fixes promptly

3. **Post-Task Review**
   - Complete full validation checklist
   - Generate quality report
   - Archive validation results

4. **Continuous Improvement**
   - Review quality metrics
   - Update validation procedures
   - Share lessons learned
```

## Conclusion

Quality assurance is essential for producing reliable research outputs. By following these validation procedures and best practices, you can ensure that your research assistant skill delivers high-quality, accurate, and well-formatted results consistently.

Remember: Quality is not an afterthought—it should be integrated into every step of your research workflow.