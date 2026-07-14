# Folder Management Examples

This directory contains practical examples demonstrating how to initialize research projects and organize source materials effectively.

## Overview

Proper folder management is essential for:
- Efficient research workflows
- Easy source discovery
- Project tracking and maintenance
- Team collaboration
- Knowledge reuse

## Examples

### [Example 1: Creating a Research Topic and a Project](example-1-new-project.md)

**Scenario**: Starting a research topic on API management trends and a Q3 competitive brief project

**Demonstrates**:
- Research topic initialization (`research/[topic]/`)
- Project initialization (`projects/[name]/`)
- The difference between the two types
- How these differ from importing sources (wiki pipeline)

**Key Concepts**:
- Research topics grow organically from a single `goals.md`
- Projects are flat (no subdirectories) from a single `brief.md`
- Importing documents goes to `inbox/`, not `research/` or `projects/`

**When to Use**:
- Starting exploratory research (use a research topic)
- Creating a specific deliverable (use a project)

### [Example 2: Organizing Research Sources](example-2-organizing-sources.md)

**Scenario**: Organizing multiple sources from different providers

**Demonstrates**:
- Source directory structure
- Document conversion workflow
- Web scraping and organization
- Index creation and maintenance
- Metadata tracking
- Version control for web content

**Key Concepts**:
- Hierarchical organization by provider/type
- Comprehensive indexing at all levels
- Consistent naming conventions
- Date-based versioning for web content
- Master catalog with statistics

**When to Use**:
- Managing multiple source types
- Need systematic organization
- Tracking source updates
- Reusing sources across projects

## Quick Reference

### Project Initialization

**Start a research topic**:
```bash
mkdir -p research/[topic]
touch research/[topic]/goals.md
# or use the script:
./init-research-project.sh api-management
```

**Start a project**:
```bash
mkdir -p projects/[name]
touch projects/[name]/brief.md
# or use the script:
./init-project.sh q3-competitive-brief
```

### Source Organization

**Basic Structure**:
```bash
mkdir -p sources/{gartner,forrester,vendor-docs,web,raw}
touch sources/index.md
```

**Convert Documents**:
```bash
docling report.pdf --output sources/gartner/report-2024.md --no-images
```

**Scrape Web Content**:
```bash
crwl crawl https://example.com --output markdown --output-file sources/web/page-2024-06-12.md
```

**Create Indexes**:
```bash
# Master index
cat > sources/index.md << 'EOF'
# Sources Master Index
[Content]
EOF

# Category index
cat > sources/gartner/index.md << 'EOF'
# Gartner Sources Index
[Content]
EOF
```

## Directory Structures

### Minimal Project

```
research/project-name/
├── README.md
├── notes.md
└── report.md
```

**Best For**: Quick, simple projects

### Standard Project

```
research/project-name/
├── README.md
├── notes.md
├── analysis.md
├── report.md
├── sources/
│   └── index.md
├── analysis/
└── output/
```

**Best For**: Most research projects

### Complex Project

```
research/project-name/
├── README.md
├── CHANGELOG.md
├── sources/
│   ├── index.md
│   ├── documents/
│   ├── web/
│   └── raw/
├── analysis/
│   ├── literature-review.md
│   ├── competitive-analysis.md
│   └── trend-analysis.md
├── data/
├── output/
│   ├── reports/
│   └── presentations/
└── archive/
```

**Best For**: Large, long-term research initiatives

### Source Organization

```
sources/
├── index.md
├── gartner/
│   ├── index.md
│   └── *.md
├── forrester/
│   ├── index.md
│   └── *.md
├── vendor-docs/
│   ├── index.md
│   ├── kong/
│   ├── apigee/
│   └── aws/
├── web/
│   ├── index.md
│   └── *.md
└── raw/
    └── *.pdf
```

**Best For**: Systematic source management

## Naming Conventions

### Projects
```
✓ 2024-api-management-trends
✓ 2024-q2-vendor-comparison
✓ 2024-cloud-security-analysis

✗ API Management Trends
✗ VendorComp
✗ project1
```

**Note**: Year prefix enables chronological sorting

### Documents
```
✓ 2024-gartner-magic-quadrant-api-management.md
✓ 2024-forrester-wave-integration-platforms.md
✓ 2024-aws-whitepaper-security-best-practices.md

✗ Gartner_MQ_2024.md
✗ report.md
✗ doc1.md
```

**Note**: Year prefix enables chronological sorting

### Web Content
```
✓ 2024-06-12-kong-features-overview.md
✓ 2024-06-12-aws-lambda-documentation.md
✓ 2024-06-12-apigee-pricing.md

✗ kong.md
✗ page1.md
✗ content-2024.md
```

**Note**: Date prefix (YYYY-MM-DD) enables chronological sorting

## Metadata Templates

### Project README

```markdown
# Research Project: [Name]

**Created**: [YYYY-MM-DD]
**Status**: [In Progress | Under Review | Completed]
**Lead Researcher**: [Name]

## Research Questions
1. [Question 1]
2. [Question 2]

## Sources Used
- [ ] [Source 1]
- [ ] [Source 2]

## Key Findings
[To be populated]

## Deliverables
- [ ] [Deliverable 1]
- [ ] [Deliverable 2]

## Next Steps
- [ ] [Action 1]
- [ ] [Action 2]
```

### Source Index

```markdown
# Sources Index

**Last Updated**: [YYYY-MM-DD]
**Total Sources**: [Number]

## Categories

### [Category 1]
- [Source 1] - [Description]
- [Source 2] - [Description]

### [Category 2]
- [Source 3] - [Description]

## Recent Additions
- [Date]: [Source]

## Statistics
- **Total**: [Number]
- **By Type**: [Breakdown]
```

### Document Metadata

```markdown
---
title: "[Title]"
source_type: [analyst_report | whitepaper | documentation]
provider: [Provider]
published_date: [YYYY-MM-DD]
converted_date: [YYYY-MM-DD]
relevance: [high | medium | low]
topics:
  - [Topic 1]
  - [Topic 2]
status: [current | archived]
---

# [Document Title]

## Document Information
[Details]

## Key Sections
[List]

## Key Findings
[Summary]
```

## Common Workflows

### Workflow 1: Start New Project

1. Create project directory structure
2. Initialize README with metadata
3. Create working files (notes, analysis, report)
4. Set up source tracking
5. Define deliverables

**Tools**: `mkdir`, `touch`, text editor

### Workflow 2: Add Sources

1. Convert documents or scrape web content
2. Add metadata to converted files
3. Update category index
4. Update master index
5. Link to research project

**Tools**: `docling`, `crawl4ai`, text editor

### Workflow 3: Maintain Organization

1. Review and update indexes regularly
2. Refresh web content periodically
3. Archive old sources as needed
4. Update metadata as needed
5. Track usage statistics

**Tools**: Shell scripts, `find`, `grep`

## Best Practices

### 1. Consistent Structure

- Use same directory layout across projects
- Follow naming conventions
- Maintain indexes at all levels
- Document organization strategy

### 2. Comprehensive Metadata

- Include all relevant information
- Use YAML front matter for documents
- Track dates and versions
- Note relevance and status

### 3. Regular Maintenance

- Update indexes frequently
- Refresh web content periodically
- Archive old materials
- Review organization regularly

### 4. Clear Documentation

- Document project goals and scope
- Explain organization strategy
- Provide usage examples
- Include troubleshooting tips

### 5. Version Control

- Use Git for tracking changes
- Commit regularly with clear messages
- Tag important milestones
- Maintain changelog

## Automation Scripts

### Project Initialization

```bash
#!/bin/bash
# init-research-project.sh

PROJECT_NAME=$1
mkdir -p "research/$PROJECT_NAME"/{sources,analysis,output}
touch "research/$PROJECT_NAME"/{README.md,notes.md,analysis.md,report.md}
# Add metadata templates
```

### Source Index Update

```bash
#!/bin/bash
# update-source-index.sh

SOURCES_DIR="sources"
TOTAL=$(find "$SOURCES_DIR" -name "*.md" -type f | wc -l)
# Update index with current statistics
```

### Archive Old Sources

```bash
#!/bin/bash
# archive-old-sources.sh

ARCHIVE_YEAR=2022
mkdir -p "sources/archive/$ARCHIVE_YEAR"
find sources/ -name "*-$ARCHIVE_YEAR.md" -exec mv {} "sources/archive/$ARCHIVE_YEAR/" \;
```

## Troubleshooting

### Issue: Inconsistent structure

**Solution**: Use initialization scripts
```bash
./init-research-project.sh new-project
```

### Issue: Can't find sources

**Solution**: Use comprehensive search
```bash
grep -r "search term" sources/ --include="*.md"
find sources/ -name "*keyword*"
```

### Issue: Outdated indexes

**Solution**: Run update script
```bash
./update-source-index.sh
```

### Issue: Duplicate sources

**Solution**: Review and consolidate
```bash
find sources/ -name "*.md" | sort | uniq -d
```

## Integration with Workflow

### Complete Research Flow

1. **Initialize Project** (Example 1)
   - Create directory structure
   - Set up metadata
   - Define scope and deliverables

2. **Organize Sources** (Example 2)
   - Convert documents
   - Scrape web content
   - Create indexes
   - Add metadata

3. **Conduct Analysis** (Research Analysis Examples)
   - Read and extract from sources
   - Synthesize findings
   - Identify patterns

4. **Generate Reports** (Report Generation Examples)
   - Use templates
   - Create reports
   - Export to Word/PDF

## Related Documentation

### Guides
- [Project Initialization Guide](../../guides/project-initialization.md) - Detailed project setup
- [Source Organization Guide](../../guides/source-organization.md) - Source management

### Other Examples
- [Document Conversion Examples](../document-conversion/) - Converting sources
- [Web Scraping Examples](../web-scraping/) - Gathering web content
- [Research Analysis Examples](../research-analysis/) - Analysis methodologies
- [Report Generation Examples](../report-generation/) - Creating reports

### Main Documentation
- [Main SKILL.md](../../SKILL.md) - Complete skill documentation

## Tools Required

**Essential**:
- Shell (bash/zsh) for scripts
- Text editor for markdown
- Git for version control

**Optional**:
- `docling` for document conversion
- `crawl4ai` for web scraping
- `pandoc` for report generation

## Summary

Effective folder management:
- Creates consistent project structure
- Organizes sources systematically
- Maintains comprehensive indexes
- Enables efficient workflows
- Supports collaboration
- Facilitates knowledge reuse

Use these examples as templates for your own research projects and adapt them to your specific needs.