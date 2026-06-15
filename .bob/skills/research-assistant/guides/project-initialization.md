# Project Initialization Guide

This guide covers how to set up and initialize new research projects with proper folder structure, metadata, and organization.

## Overview

A well-organized research project makes it easier to:
- Track sources and findings
- Collaborate with others
- Generate reports
- Maintain research history
- Find information quickly

## Quick Start

### Basic Project Setup

```bash
# Create new research project
mkdir -p research/api-management-trends
cd research/api-management-trends

# Initialize project files
touch notes.md analysis.md report.md README.md

# Create source tracking
mkdir -p sources/
touch sources/index.md
```

### With Metadata Template

```bash
# Create project with full structure
mkdir -p research/cloud-security-2024/{sources,analysis,output}

# Initialize with metadata
cat > research/cloud-security-2024/README.md << 'EOF'
# Research Project: Cloud Security 2024

**Created**: 2024-06-12
**Status**: In Progress
**Lead Researcher**: [Your Name]

## Research Questions
1. What are the top cloud security threats in 2024?
2. How do major vendors compare in security features?
3. What are emerging security trends?

## Sources Used
- [ ] Gartner Cloud Security Report 2024
- [ ] AWS Security Whitepaper
- [ ] Azure Security Documentation

## Key Findings
[To be populated during research]

## Next Steps
- [ ] Convert source documents
- [ ] Analyze vendor capabilities
- [ ] Create comparison matrix
- [ ] Generate executive summary
EOF
```

## Project Structure

### Standard Layout

```
research/[project-name]/
├── README.md              # Project metadata and overview
├── notes.md              # Research notes and observations
├── analysis.md           # Detailed analysis and synthesis
├── report.md             # Final report content
├── sources/              # Source materials
│   ├── index.md         # Source catalog
│   ├── gartner/         # Organized by provider
│   ├── forrester/
│   └── web/
├── analysis/             # Analysis artifacts
│   ├── comparison-matrix.md
│   ├── trend-analysis.md
│   └── gap-analysis.md
└── output/               # Generated reports
    ├── executive-summary.docx
    └── full-report.docx
```

### Minimal Layout

For simple projects:

```
research/[project-name]/
├── README.md
├── notes.md
└── report.md
```

### Complex Layout

For large research initiatives:

```
research/[project-name]/
├── README.md
├── CHANGELOG.md
├── sources/
│   ├── index.md
│   ├── documents/
│   │   ├── gartner/
│   │   ├── forrester/
│   │   └── idc/
│   ├── web/
│   │   ├── vendor-sites/
│   │   └── documentation/
│   └── raw/              # Original files
├── analysis/
│   ├── literature-review.md
│   ├── competitive-analysis.md
│   ├── trend-analysis.md
│   └── gap-analysis.md
├── data/
│   ├── comparison-matrices/
│   ├── benchmarks/
│   └── statistics/
├── output/
│   ├── reports/
│   ├── presentations/
│   └── summaries/
└── archive/              # Completed work
```

## Project Metadata

### README.md Template

```markdown
# Research Project: [Project Name]

**Created**: [YYYY-MM-DD]
**Last Updated**: [YYYY-MM-DD]
**Status**: [In Progress | Under Review | Completed]
**Lead Researcher**: [Name]
**Stakeholders**: [List]

## Executive Summary

[Brief overview of the research project - 2-3 sentences]

## Research Questions

1. [Primary research question]
2. [Secondary research question]
3. [Additional questions]

## Scope

**In Scope**:
- [What is included]
- [Specific areas of focus]

**Out of Scope**:
- [What is excluded]
- [Limitations]

## Sources Used

### Primary Sources
- [ ] [Source 1 - Status]
- [ ] [Source 2 - Status]

### Secondary Sources
- [ ] [Source 3 - Status]
- [ ] [Source 4 - Status]

### Web Resources
- [ ] [URL 1 - Status]
- [ ] [URL 2 - Status]

## Methodology

[Brief description of research approach]

## Key Findings

### Finding 1: [Title]
[Description]

### Finding 2: [Title]
[Description]

## Recommendations

1. [Recommendation 1]
2. [Recommendation 2]

## Timeline

- **Week 1**: Source gathering and conversion
- **Week 2**: Analysis and synthesis
- **Week 3**: Report generation and review
- **Week 4**: Final delivery

## Deliverables

- [ ] Literature review
- [ ] Competitive analysis
- [ ] Executive summary
- [ ] Full research report

## Next Steps

- [ ] [Action item 1]
- [ ] [Action item 2]
- [ ] [Action item 3]

## Notes

[Additional context, observations, or considerations]
```

### CHANGELOG.md Template

```markdown
# Research Project Changelog

## [Unreleased]

### Added
- Initial project structure

## [0.1.0] - 2024-06-12

### Added
- Converted Gartner Magic Quadrant report
- Scraped AWS Lambda documentation
- Created initial comparison matrix

### Changed
- Updated research questions based on findings

### Notes
- Need to add Forrester report for completeness
```

## Initialization Scripts

### Basic Initialization

```bash
#!/bin/bash
# init-research-project.sh

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: ./init-research-project.sh project-name"
  exit 1
fi

PROJECT_DIR="research/$PROJECT_NAME"

# Create directory structure
mkdir -p "$PROJECT_DIR"/{sources,analysis,output}

# Create README with metadata
cat > "$PROJECT_DIR/README.md" << EOF
# Research Project: $PROJECT_NAME

**Created**: $(date +%Y-%m-%d)
**Status**: In Progress

## Research Questions
1. [Question 1]
2. [Question 2]

## Sources Used
- [ ] [Source 1]

## Key Findings
[To be populated]

## Next Steps
- [ ] Define research scope
- [ ] Gather sources
- [ ] Begin analysis
EOF

# Create working files
touch "$PROJECT_DIR/notes.md"
touch "$PROJECT_DIR/analysis.md"
touch "$PROJECT_DIR/report.md"

# Create source index
cat > "$PROJECT_DIR/sources/index.md" << EOF
# Sources Index

## Documents
[List converted documents here]

## Web Content
[List scraped web content here]

## Last Updated
$(date +%Y-%m-%d)
EOF

echo "✓ Created research project: $PROJECT_DIR"
```

**Usage**:
```bash
chmod +x init-research-project.sh
./init-research-project.sh api-management-trends
```

### Advanced Initialization

```bash
#!/bin/bash
# init-research-project-advanced.sh

PROJECT_NAME=$1
LEAD_RESEARCHER=$2

if [ -z "$PROJECT_NAME" ] || [ -z "$LEAD_RESEARCHER" ]; then
  echo "Usage: ./init-research-project-advanced.sh project-name 'Lead Researcher'"
  exit 1
fi

PROJECT_DIR="research/$PROJECT_NAME"

# Create comprehensive directory structure
mkdir -p "$PROJECT_DIR"/{sources/{documents/{gartner,forrester,idc},web,raw},analysis,data,output/{reports,summaries},archive}

# Create detailed README
cat > "$PROJECT_DIR/README.md" << EOF
# Research Project: $PROJECT_NAME

**Created**: $(date +%Y-%m-%d)
**Last Updated**: $(date +%Y-%m-%d)
**Status**: In Progress
**Lead Researcher**: $LEAD_RESEARCHER

## Executive Summary

[Brief overview - to be completed]

## Research Questions

1. [Primary question]
2. [Secondary question]
3. [Additional questions]

## Scope

**In Scope**:
- [Define scope]

**Out of Scope**:
- [Define limitations]

## Sources Used

### Primary Sources
- [ ] [Source 1]

### Secondary Sources
- [ ] [Source 2]

## Methodology

[Research approach]

## Key Findings

[To be populated during research]

## Recommendations

[To be developed]

## Timeline

- **Week 1**: Source gathering
- **Week 2**: Analysis
- **Week 3**: Report generation
- **Week 4**: Review and delivery

## Deliverables

- [ ] Literature review
- [ ] Analysis report
- [ ] Executive summary

## Next Steps

- [ ] Define detailed research questions
- [ ] Identify and gather sources
- [ ] Create analysis framework

## Notes

[Additional context]
EOF

# Create CHANGELOG
cat > "$PROJECT_DIR/CHANGELOG.md" << EOF
# Research Project Changelog

## [Unreleased]

### Added
- Initial project structure created on $(date +%Y-%m-%d)

## Notes
- Project initialized by $LEAD_RESEARCHER
EOF

# Create working files
touch "$PROJECT_DIR/notes.md"
touch "$PROJECT_DIR/analysis.md"
touch "$PROJECT_DIR/report.md"

# Create source index
cat > "$PROJECT_DIR/sources/index.md" << EOF
# Sources Index

## Documents

### Gartner
[List Gartner reports]

### Forrester
[List Forrester reports]

### IDC
[List IDC reports]

## Web Content
[List scraped content]

## Raw Files
[List original files]

## Statistics
- **Total Sources**: 0
- **Documents**: 0
- **Web Pages**: 0
- **Last Updated**: $(date +%Y-%m-%d)
EOF

# Create analysis templates
cat > "$PROJECT_DIR/analysis/literature-review.md" << EOF
# Literature Review: $PROJECT_NAME

## Overview
[Summary of literature reviewed]

## Key Themes
[Identified themes]

## Findings
[Detailed findings]

## Gaps
[Identified gaps]
EOF

cat > "$PROJECT_DIR/analysis/competitive-analysis.md" << EOF
# Competitive Analysis: $PROJECT_NAME

## Vendors Analyzed
[List vendors]

## Comparison Matrix
[Create comparison]

## Strengths and Weaknesses
[Analysis]

## Recommendations
[Strategic insights]
EOF

# Create .gitignore
cat > "$PROJECT_DIR/.gitignore" << EOF
# Ignore generated reports
output/*.docx
output/*.pdf

# Ignore raw source files
sources/raw/*

# Keep directory structure
!sources/raw/.gitkeep
!output/.gitkeep
EOF

# Create .gitkeep files
touch "$PROJECT_DIR/sources/raw/.gitkeep"
touch "$PROJECT_DIR/output/.gitkeep"
touch "$PROJECT_DIR/archive/.gitkeep"

echo "✓ Created advanced research project: $PROJECT_DIR"
echo "  - Comprehensive directory structure"
echo "  - Metadata templates"
echo "  - Analysis templates"
echo "  - Git configuration"
```

**Usage**:
```bash
chmod +x init-research-project-advanced.sh
./init-research-project-advanced.sh cloud-security-2024 "John Smith"
```

## Best Practices

### 1. Naming Conventions

**Project Names**:
- Use lowercase with hyphens: `api-management-trends`
- Include year if relevant: `cloud-security-2024`
- Be descriptive but concise: `vendor-comparison-q2`

**File Names**:
- Use descriptive names: `gartner-magic-quadrant-2024.md`
- Include dates for versions: `analysis-2024-06-12.md`
- Use consistent prefixes: `report-executive-summary.md`

### 2. Metadata Management

**Always Include**:
- Creation date
- Last updated date
- Status (In Progress, Under Review, Completed)
- Research questions
- Source list

**Update Regularly**:
- Status changes
- New sources added
- Key findings
- Next steps

### 3. Version Control

**Commit Strategy**:
```bash
# Initial commit
git add research/project-name/
git commit -m "Initialize research project: project-name"

# Source additions
git commit -m "Add Gartner report to project-name"

# Analysis updates
git commit -m "Update competitive analysis for project-name"

# Report generation
git commit -m "Generate executive summary for project-name"
```

**Branching** (for collaborative research):
```bash
# Create feature branch
git checkout -b research/project-name/analysis

# Work on analysis
git commit -m "Add trend analysis"

# Merge when complete
git checkout main
git merge research/project-name/analysis
```

### 4. Documentation

**Document As You Go**:
- Add notes immediately after reading sources
- Update findings in real-time
- Track questions and gaps
- Record decisions and rationale

**Use Consistent Formatting**:
```markdown
## Source: [Title]
**Date**: [YYYY-MM-DD]
**Type**: [Report/Article/Documentation]

### Key Points
- Point 1
- Point 2

### Relevant Quotes
> "Quote text"

### My Analysis
[Your thoughts]
```

### 5. Source Tracking

**Create Source Metadata**:
```markdown
# Source: Gartner Magic Quadrant for API Management 2024

**File**: sources/gartner/magic-quadrant-2024.md
**Original**: sources/raw/gartner-mq-2024.pdf
**Converted**: 2024-06-12
**Pages**: 45
**Relevance**: High

## Summary
[Brief summary]

## Key Sections
- Section 1: [Page numbers]
- Section 2: [Page numbers]

## Related Sources
- Forrester Wave API Management 2024
- IDC MarketScape 2024
```

## Common Workflows

### Workflow 1: Quick Project Start

```bash
# 1. Create project
mkdir -p research/quick-project
cd research/quick-project

# 2. Initialize files
touch README.md notes.md report.md

# 3. Add basic metadata
echo "# Research: Quick Project" > README.md
echo "**Created**: $(date +%Y-%m-%d)" >> README.md

# 4. Start working
# Edit notes.md with your research
```

### Workflow 2: Structured Project

```bash
# 1. Use initialization script
./init-research-project.sh structured-project

# 2. Customize README
# Edit research/structured-project/README.md

# 3. Add sources
mkdir -p research/structured-project/sources/gartner
# Convert and add source files

# 4. Begin analysis
# Edit research/structured-project/analysis.md
```

### Workflow 3: Collaborative Project

```bash
# 1. Initialize with advanced script
./init-research-project-advanced.sh collab-project "Team Lead"

# 2. Initialize git
cd research/collab-project
git init
git add .
git commit -m "Initialize collaborative research project"

# 3. Create remote repository
git remote add origin [repository-url]
git push -u origin main

# 4. Team members clone and contribute
git clone [repository-url]
git checkout -b feature/my-analysis
# Make changes
git commit -m "Add my analysis"
git push origin feature/my-analysis
# Create pull request
```

## Troubleshooting

### Issue: Project structure inconsistent

**Solution**: Use initialization scripts to ensure consistency
```bash
# Create template script and use it for all projects
./init-research-project.sh new-project
```

### Issue: Lost track of sources

**Solution**: Maintain sources/index.md
```markdown
# Sources Index

## Last Updated: 2024-06-12

### Documents (5)
1. gartner/magic-quadrant-2024.md
2. forrester/wave-2024.md
3. idc/marketscape-2024.md
4. aws/whitepaper-security.md
5. azure/security-docs.md

### Web Content (3)
1. web/kong-features.md
2. web/apigee-pricing.md
3. web/aws-lambda-docs.md
```

### Issue: Unclear project status

**Solution**: Update README.md status section regularly
```markdown
**Status**: In Progress (60% complete)
**Last Updated**: 2024-06-12

## Progress
- [x] Source gathering
- [x] Document conversion
- [-] Analysis (in progress)
- [ ] Report generation
- [ ] Review
```

## Related Documentation

- [Source Organization Guide](source-organization.md) - Managing source materials
- [Research Analysis Examples](../examples/research-analysis/) - Analysis methodologies
- [Report Generation Guide](../examples/report-generation/) - Creating reports
- [Main SKILL.md](../SKILL.md) - Complete skill documentation

## Tools and Scripts

### Recommended Tools

**Project Management**:
- Git for version control
- Markdown for documentation
- Shell scripts for automation

**File Organization**:
- Consistent naming conventions
- Directory structure templates
- Index files for navigation

**Collaboration**:
- Git branches for parallel work
- Pull requests for review
- Shared documentation standards

### Script Library

All initialization scripts should be stored in:
```
research/scripts/
├── init-research-project.sh
├── init-research-project-advanced.sh
└── update-source-index.sh
```

Make scripts executable:
```bash
chmod +x research/scripts/*.sh
```

## Summary

Proper project initialization:
- Creates consistent structure
- Tracks metadata and progress
- Facilitates collaboration
- Enables efficient research
- Supports report generation

Use initialization scripts to ensure consistency and save time on project setup.