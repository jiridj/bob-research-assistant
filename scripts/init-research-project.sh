#!/bin/bash
# Initialize a new research project with proper structure
# Usage: ./init-research-project.sh project-name

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: ./init-research-project.sh project-name"
  echo "Example: ./init-research-project.sh api-management-trends"
  exit 1
fi

PROJECT_DIR="research/$PROJECT_NAME"

# Check if project already exists
if [ -d "$PROJECT_DIR" ]; then
  echo "Error: Project '$PROJECT_NAME' already exists at $PROJECT_DIR"
  exit 1
fi

echo -e "${BLUE}Creating research project: ${PROJECT_NAME}${NC}"

# Create directory structure
mkdir -p "$PROJECT_DIR"/{sources,analysis,output}

# Create README with metadata
cat > "$PROJECT_DIR/README.md" << EOF
# Research Project: $PROJECT_NAME

**Created**: $(date +%Y-%m-%d)
**Status**: In Progress
**Last Updated**: $(date +%Y-%m-%d)

## Research Questions

1. [Define your research questions here]
2. [Add more as needed]

## Objectives

- [ ] Define research scope
- [ ] Gather sources
- [ ] Analyze findings
- [ ] Generate report

## Sources Used

### Documents
- [ ] [List converted documents]

### Web Content
- [ ] [List scraped web pages]

### Other Sources
- [ ] [List other sources]

## Key Findings

[Document key findings as research progresses]

## Methodology

[Describe research approach and methodology]

## Timeline

- **Start Date**: $(date +%Y-%m-%d)
- **Target Completion**: [Set target date]

## Next Steps

- [ ] Define research questions
- [ ] Identify source materials
- [ ] Begin document conversion
- [ ] Start analysis
- [ ] Draft report

## Notes

[Add research notes and observations]
EOF

# Create working files
touch "$PROJECT_DIR/notes.md"
cat > "$PROJECT_DIR/notes.md" << EOF
# Research Notes: $PROJECT_NAME

**Date**: $(date +%Y-%m-%d)

## Daily Notes

### $(date +%Y-%m-%d)
- Project initialized
- [Add notes as you work]

## Ideas and Observations

[Capture ideas and insights]

## Questions to Investigate

- [List questions that arise during research]

## References to Follow Up

- [Track sources to investigate further]
EOF

touch "$PROJECT_DIR/analysis.md"
cat > "$PROJECT_DIR/analysis.md" << EOF
# Analysis: $PROJECT_NAME

**Date**: $(date +%Y-%m-%d)

## Executive Summary

[High-level overview of findings]

## Detailed Analysis

### Theme 1: [Theme Name]

[Analysis content]

### Theme 2: [Theme Name]

[Analysis content]

## Conclusions

[Key conclusions and insights]

## Recommendations

[Actionable recommendations based on findings]
EOF

touch "$PROJECT_DIR/report.md"
cat > "$PROJECT_DIR/report.md" << EOF
# Research Report: $PROJECT_NAME

**Author**: [Your Name]
**Date**: $(date +%Y-%m-%d)

## Executive Summary

[Brief overview of research and key findings]

## Introduction

### Background
[Context and background information]

### Research Questions
1. [Question 1]
2. [Question 2]

### Methodology
[Research approach and methods used]

## Findings

### Finding 1: [Title]
[Detailed findings]

### Finding 2: [Title]
[Detailed findings]

## Analysis

[In-depth analysis of findings]

## Conclusions

[Key conclusions drawn from research]

## Recommendations

[Actionable recommendations]

## References

[List of sources and citations]

## Appendices

[Supporting materials and data]
EOF

# Create source index
cat > "$PROJECT_DIR/sources/index.md" << EOF
# Sources Index: $PROJECT_NAME

**Last Updated**: $(date +%Y-%m-%d)

## Documents

### Analyst Reports
[List Gartner, Forrester, IDC reports]

### Whitepapers
[List vendor whitepapers and technical documents]

### Academic Papers
[List research papers and academic sources]

## Web Content

### Vendor Documentation
[List scraped vendor documentation]

### Blog Posts and Articles
[List relevant blog posts and articles]

### News and Press Releases
[List news articles and press releases]

## Data Sources

[List any datasets or data sources used]

## Total Sources

- Documents: 0
- Web Pages: 0
- Total: 0

## Source Quality Notes

[Track source credibility and quality]
EOF

# Create output directory structure
mkdir -p "$PROJECT_DIR/output"/{reports,presentations,data}

# Create .gitignore for output directory
cat > "$PROJECT_DIR/output/.gitignore" << EOF
# Ignore generated reports (optional)
*.docx
*.pdf
*.pptx

# Keep this file
!.gitignore
EOF

echo -e "${GREEN}✓${NC} Created research project: $PROJECT_DIR"
echo ""
echo "Project structure:"
echo "  $PROJECT_DIR/"
echo "  ├── README.md          # Project overview and metadata"
echo "  ├── notes.md           # Research notes and observations"
echo "  ├── analysis.md        # Detailed analysis"
echo "  ├── report.md          # Final report"
echo "  ├── sources/"
echo "  │   └── index.md       # Source tracking"
echo "  ├── analysis/          # Analysis files"
echo "  └── output/            # Generated reports"
echo "      ├── reports/"
echo "      ├── presentations/"
echo "      └── data/"
echo ""
echo "Next steps:"
echo "  1. Edit $PROJECT_DIR/README.md to define research questions"
echo "  2. Start gathering sources in $PROJECT_DIR/sources/"
echo "  3. Use Bob to convert documents and scrape web content"
echo "  4. Document findings in $PROJECT_DIR/analysis.md"
echo ""

# Made with Bob
