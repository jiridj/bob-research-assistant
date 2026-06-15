# Validation Checklist Examples

This document provides ready-to-use validation checklists for different research tasks.

## Document Conversion Checklist

### Pre-Conversion Checklist

```markdown
## Document Conversion - Pre-Flight Check

**Project**: [Project Name]
**Date**: [Date]
**Files to Convert**: [Number] files

### Environment Check
- [ ] Docling installed and updated (`pip show docling`)
- [ ] Sufficient disk space (check with `df -h`)
- [ ] Output directory exists and is writable
- [ ] Backup of source files created (if needed)

### File Verification
- [ ] All source files exist and are accessible
- [ ] File formats are supported (PDF, DOCX, PPTX)
- [ ] Files are not password-protected
- [ ] Files are not corrupted (test open in native app)
- [ ] File sizes are reasonable (not too large)

### Configuration
- [ ] Output format decided (markdown)
- [ ] Image handling strategy determined (export/skip)
- [ ] Output naming convention established
- [ ] Target directory structure created

### Ready to Proceed
- [ ] All checks passed
- [ ] Conversion command prepared
- [ ] Monitoring plan in place
```

### Post-Conversion Checklist

```markdown
## Document Conversion - Quality Check

**Project**: [Project Name]
**Date**: [Date]
**Files Converted**: [Number] files

### Output Verification
- [ ] All output files created
- [ ] File sizes are reasonable (not empty)
- [ ] File permissions are correct
- [ ] Files are in correct directories

### Content Quality
- [ ] Text extracted correctly (spot check)
- [ ] No garbled characters or encoding issues
- [ ] Headings preserved with proper hierarchy
- [ ] Paragraphs properly formatted
- [ ] Lists formatted correctly (bullets/numbers)
- [ ] Tables converted to markdown format
- [ ] Code blocks properly formatted (if any)

### Image Handling
- [ ] Images extracted (if requested)
- [ ] Image files are valid and viewable
- [ ] Image references in markdown are correct
- [ ] Image filenames are descriptive
- [ ] Images organized in proper directory

### Metadata
- [ ] Document title extracted
- [ ] Author information preserved (if available)
- [ ] Date information captured
- [ ] Source file reference included

### Issues Log
**Issues Found**:
- [ ] Issue 1: [Description]
- [ ] Issue 2: [Description]

**Resolution**:
- [ ] All issues resolved or documented
- [ ] Workarounds applied where needed

### Sign-off
- [ ] Conversion quality acceptable
- [ ] Ready for next phase
- [ ] Results documented
```

## Web Scraping Checklist

### Pre-Scraping Checklist

```markdown
## Web Scraping - Pre-Flight Check

**Project**: [Project Name]
**Date**: [Date]
**URLs to Scrape**: [Number] URLs

### Environment Check
- [ ] Crawl4ai installed and configured
- [ ] Network connection stable
- [ ] Output directory exists
- [ ] Sufficient disk space available

### URL Verification
- [ ] All URLs are valid and accessible
- [ ] URLs tested in browser
- [ ] No authentication required (or credentials ready)
- [ ] Sites allow scraping (robots.txt checked)
- [ ] Rate limiting requirements identified

### Configuration
- [ ] Scraping strategy determined
- [ ] Wait times configured (for dynamic content)
- [ ] User agent set appropriately
- [ ] Output format decided
- [ ] Naming convention established

### Legal & Ethical
- [ ] Terms of service reviewed
- [ ] Scraping is permitted
- [ ] Rate limits will be respected
- [ ] Attribution plan in place

### Ready to Proceed
- [ ] All checks passed
- [ ] Scraping commands prepared
- [ ] Monitoring plan in place
```

### Post-Scraping Checklist

```markdown
## Web Scraping - Quality Check

**Project**: [Project Name]
**Date**: [Date]
**URLs Scraped**: [Number] URLs

### Output Verification
- [ ] All output files created
- [ ] File sizes are reasonable
- [ ] Files are in correct directories
- [ ] Filenames are descriptive

### Content Quality
- [ ] Main content extracted (not just navigation/ads)
- [ ] Text is clean and readable
- [ ] No duplicate content
- [ ] Proper paragraph structure
- [ ] Links preserved and functional
- [ ] Code snippets formatted correctly (if any)

### Metadata
- [ ] Page title captured
- [ ] Author information extracted (if available)
- [ ] Publication date recorded
- [ ] Source URL documented
- [ ] Scraping timestamp included

### Completeness
- [ ] All requested pages scraped
- [ ] No missing sections
- [ ] Dynamic content captured (if applicable)
- [ ] Images downloaded (if requested)

### Issues Log
**Issues Found**:
- [ ] Issue 1: [Description]
- [ ] Issue 2: [Description]

**Resolution**:
- [ ] All issues resolved or documented
- [ ] Failed URLs logged for retry

### Sign-off
- [ ] Scraping quality acceptable
- [ ] Ready for analysis
- [ ] Results documented
```

## Research Analysis Checklist

### Pre-Analysis Checklist

```markdown
## Research Analysis - Pre-Flight Check

**Project**: [Project Name]
**Topic**: [Research Topic]
**Date**: [Date]

### Source Preparation
- [ ] All source materials collected
- [ ] Sources organized by category
- [ ] Source quality assessed
- [ ] Duplicate sources removed
- [ ] Source metadata documented

### Research Questions
- [ ] Research questions clearly defined
- [ ] Scope boundaries established
- [ ] Success criteria identified
- [ ] Timeline set

### Analysis Framework
- [ ] Analysis methodology chosen
- [ ] Key themes identified
- [ ] Comparison criteria established
- [ ] Citation format decided

### Tools & Resources
- [ ] Note-taking system ready
- [ ] Citation management set up
- [ ] Analysis templates prepared
- [ ] Collaboration tools configured (if team project)

### Ready to Proceed
- [ ] All sources accessible
- [ ] Analysis plan documented
- [ ] Time allocated for thorough review
```

### Post-Analysis Checklist

```markdown
## Research Analysis - Quality Check

**Project**: [Project Name]
**Topic**: [Research Topic]
**Date**: [Date]
**Sources Analyzed**: [Number] sources

### Source Coverage
- [ ] All relevant sources reviewed
- [ ] Key sources identified and prioritized
- [ ] Source diversity achieved (types, dates, perspectives)
- [ ] Gaps in coverage identified

### Citation Quality
- [ ] All claims have source citations
- [ ] Citations follow consistent format
- [ ] Source URLs are accessible
- [ ] Publication dates are included
- [ ] Authors are credited

### Evidence Quality
- [ ] Multiple sources support key findings
- [ ] Sources are credible and authoritative
- [ ] Primary sources used when available
- [ ] Data is current and relevant
- [ ] Contradictory evidence addressed

### Analysis Quality
- [ ] Arguments flow logically
- [ ] Conclusions supported by evidence
- [ ] No logical fallacies
- [ ] Counterarguments considered
- [ ] Limitations acknowledged
- [ ] Bias minimized

### Completeness
- [ ] All research questions answered
- [ ] Key topics covered thoroughly
- [ ] Gaps in knowledge identified
- [ ] Future research directions noted

### Documentation
- [ ] Findings clearly documented
- [ ] Key insights highlighted
- [ ] Methodology explained
- [ ] Sources properly referenced
- [ ] Analysis reproducible

### Sign-off
- [ ] Analysis quality acceptable
- [ ] Ready for report generation
- [ ] Peer review completed (if applicable)
```

## Report Generation Checklist

### Pre-Generation Checklist

```markdown
## Report Generation - Pre-Flight Check

**Project**: [Project Name]
**Report Type**: [Type]
**Date**: [Date]

### Content Preparation
- [ ] All content sections complete
- [ ] Citations properly formatted
- [ ] Images/figures ready and numbered
- [ ] Tables formatted correctly
- [ ] Appendices prepared (if needed)

### Tools & Templates
- [ ] Pandoc installed and configured
- [ ] Template file exists (if using custom)
- [ ] Output format decided (DOCX, PDF, HTML)
- [ ] Style guide available

### Structure
- [ ] Title page content ready
- [ ] Table of contents will be generated
- [ ] Section hierarchy established
- [ ] Page numbering plan set
- [ ] Headers/footers designed

### Quality Standards
- [ ] Citation style confirmed (APA, MLA, Chicago, etc.)
- [ ] Formatting requirements documented
- [ ] Review criteria established
- [ ] Approval process defined

### Ready to Proceed
- [ ] All content finalized
- [ ] Generation command prepared
- [ ] Output directory ready
```

### Post-Generation Checklist

```markdown
## Report Generation - Quality Check

**Project**: [Project Name]
**Report**: [Filename]
**Date**: [Date]
**Pages**: [Number] pages

### File Verification
- [ ] Output file created successfully
- [ ] File size is reasonable
- [ ] File opens without errors
- [ ] File is in correct location

### Structure Check
- [ ] Title page present and correct
- [ ] Table of contents generated
- [ ] All sections included
- [ ] Section order correct
- [ ] Page numbers correct
- [ ] Headers/footers applied

### Formatting Check
- [ ] Consistent font and sizing
- [ ] Proper heading hierarchy
- [ ] Lists formatted correctly
- [ ] Tables aligned properly
- [ ] Images positioned correctly
- [ ] Captions numbered sequentially
- [ ] Margins correct
- [ ] Line spacing consistent

### Content Quality
- [ ] No formatting artifacts
- [ ] No broken links
- [ ] All cross-references work
- [ ] All figures/tables referenced in text
- [ ] All references included
- [ ] Appendices attached
- [ ] Metadata correct (author, date, etc.)

### Citation Check
- [ ] All in-text citations present
- [ ] Reference list complete
- [ ] Citation format consistent
- [ ] No duplicate references
- [ ] All URLs accessible

### Final Review
- [ ] Spell check completed
- [ ] Grammar check completed
- [ ] Readability assessed
- [ ] Peer review completed (if applicable)
- [ ] Client/stakeholder review (if applicable)

### Sign-off
- [ ] Report quality acceptable
- [ ] Ready for distribution
- [ ] Archive copy saved
```

## Batch Operations Checklist

### Pre-Batch Checklist

```markdown
## Batch Operations - Pre-Flight Check

**Project**: [Project Name]
**Operation Type**: [Conversion/Scraping/Generation]
**Date**: [Date]
**Items to Process**: [Number] items

### Environment Check
- [ ] All required tools installed
- [ ] Sufficient disk space for all outputs
- [ ] Network stable (if needed)
- [ ] Backup of source files (if modifying)

### Input Verification
- [ ] All input files/URLs listed
- [ ] Input list validated
- [ ] No duplicates in list
- [ ] All inputs accessible

### Configuration
- [ ] Batch script prepared and tested
- [ ] Error handling configured
- [ ] Logging enabled
- [ ] Progress monitoring set up
- [ ] Delay between operations set (if needed)

### Risk Management
- [ ] Failure recovery plan in place
- [ ] Partial completion handling defined
- [ ] Rollback procedure documented
- [ ] Success criteria established

### Ready to Proceed
- [ ] Test run completed on sample
- [ ] All checks passed
- [ ] Time allocated for full batch
- [ ] Monitoring plan in place
```

### Post-Batch Checklist

```markdown
## Batch Operations - Quality Check

**Project**: [Project Name]
**Operation Type**: [Type]
**Date**: [Date]
**Items Processed**: [Number] items

### Completion Status
- [ ] All items processed
- [ ] Success count: [Number]
- [ ] Failure count: [Number]
- [ ] Partial completion count: [Number]

### Output Verification
- [ ] All output files created
- [ ] Files in correct locations
- [ ] File naming consistent
- [ ] File sizes reasonable

### Quality Sampling
- [ ] Random sample checked (10% minimum)
- [ ] Sample quality acceptable
- [ ] No systematic errors detected
- [ ] Edge cases handled correctly

### Error Analysis
- [ ] All errors logged
- [ ] Error patterns identified
- [ ] Failed items listed for retry
- [ ] Root causes documented

### Performance Metrics
- [ ] Total processing time: [Duration]
- [ ] Average time per item: [Duration]
- [ ] Success rate: [Percentage]
- [ ] Resource usage acceptable

### Follow-up Actions
- [ ] Failed items queued for retry
- [ ] Issues reported to relevant parties
- [ ] Process improvements identified
- [ ] Documentation updated

### Sign-off
- [ ] Batch operation acceptable
- [ ] Results documented
- [ ] Lessons learned recorded
```

## Project Completion Checklist

```markdown
## Research Project - Final Quality Check

**Project**: [Project Name]
**Date**: [Date]
**Duration**: [Start Date] to [End Date]

### Deliverables
- [ ] All required reports generated
- [ ] All supporting documents included
- [ ] All source materials organized
- [ ] All analysis documented

### Quality Standards
- [ ] All validation checklists completed
- [ ] All quality checks passed
- [ ] Peer review completed
- [ ] Client/stakeholder approval received

### Documentation
- [ ] Project summary created
- [ ] Methodology documented
- [ ] Sources catalogued
- [ ] Findings summarized
- [ ] Recommendations documented

### Archive & Handoff
- [ ] All files organized in final structure
- [ ] Archive copy created
- [ ] Backup verified
- [ ] Handoff documentation prepared
- [ ] Knowledge transfer completed (if applicable)

### Lessons Learned
- [ ] What went well documented
- [ ] Challenges documented
- [ ] Process improvements identified
- [ ] Best practices captured

### Sign-off
- [ ] Project complete
- [ ] All deliverables accepted
- [ ] Archive complete
- [ ] Project closed
```

## Using These Checklists

### Customization

1. **Copy the relevant checklist** to your project directory
2. **Customize** items based on your specific needs
3. **Add** project-specific checks
4. **Remove** items that don't apply
5. **Update** as you learn what works

### Integration

```bash
# Create checklist file
cp examples/validation-checklists.md research/my-project/checklist.md

# Track progress
# Mark items as complete: - [x]
# Add notes: - [ ] Item (Note: details here)
# Add new items as needed
```

### Best Practices

1. **Complete checklists in order**: Pre → During → Post
2. **Don't skip items**: Each check serves a purpose
3. **Document issues**: Note problems for future reference
4. **Update regularly**: Keep checklists current with your process
5. **Share learnings**: Help others avoid your mistakes

### Automation

Consider automating repetitive checks:

```bash
# Example: Automated file verification
#!/bin/bash
echo "Checking output files..."
for file in output/*.md; do
  if [ -f "$file" ] && [ -s "$file" ]; then
    echo "✓ $file"
  else
    echo "❌ $file (missing or empty)"
  fi
done
```

## Conclusion

These checklists help ensure consistent quality across all research operations. Adapt them to your needs and update them based on your experience. Quality assurance is an ongoing process of improvement.