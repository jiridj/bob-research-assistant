#!/bin/bash
# Generate reports from all research projects
# Usage: ./generate-all-reports.sh [template]

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

TEMPLATE="${1:-}"
OUTPUT_DIR="output"
RESEARCH_DIR="research"

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Batch Report Generation                                  ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
  echo -e "${RED}Error: pandoc is not installed${NC}"
  echo "Install with:"
  echo "  macOS:   brew install pandoc"
  echo "  Linux:   apt-get install pandoc"
  echo "  Windows: choco install pandoc"
  exit 1
fi

# Check if research directory exists
if [ ! -d "$RESEARCH_DIR" ]; then
  echo -e "${YELLOW}No research directory found${NC}"
  echo "Create a research project first:"
  echo "  ./init-research-project.sh project-name"
  exit 0
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Count projects
PROJECT_COUNT=$(find "$RESEARCH_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')

if [ "$PROJECT_COUNT" -eq 0 ]; then
  echo -e "${YELLOW}No research projects found in $RESEARCH_DIR${NC}"
  exit 0
fi

echo "Research directory: $RESEARCH_DIR"
echo "Output directory:   $OUTPUT_DIR"
if [ -n "$TEMPLATE" ]; then
  echo "Template:           $TEMPLATE"
fi
echo "Projects found:     $PROJECT_COUNT"
echo ""

# Statistics
GENERATED=0
SKIPPED=0
FAILED=0

# Process each project
for project in "$RESEARCH_DIR"/*/; do
  if [ -d "$project" ]; then
    project_name=$(basename "$project")
    
    echo -e "${BLUE}→${NC} Processing: $project_name"
    
    # Check for report.md
    if [ ! -f "$project/report.md" ]; then
      echo -e "${YELLOW}  ⊘ Skipped: No report.md found${NC}"
      SKIPPED=$((SKIPPED + 1))
      continue
    fi
    
    # Generate output filename
    output_file="$OUTPUT_DIR/${project_name}-report.docx"
    
    # Build pandoc command
    PANDOC_CMD="pandoc \"$project/report.md\" -o \"$output_file\""
    
    # Add table of contents
    PANDOC_CMD="$PANDOC_CMD --toc --toc-depth=3"
    
    # Add template if specified
    if [ -n "$TEMPLATE" ] && [ -f "$TEMPLATE" ]; then
      PANDOC_CMD="$PANDOC_CMD --reference-doc=\"$TEMPLATE\""
    fi
    
    # Execute pandoc
    if eval $PANDOC_CMD 2>/dev/null; then
      echo -e "${GREEN}  ✓ Generated: $output_file${NC}"
      GENERATED=$((GENERATED + 1))
      
      # Also generate PDF if possible
      pdf_output="$OUTPUT_DIR/${project_name}-report.pdf"
      if pandoc "$project/report.md" -o "$pdf_output" --toc --toc-depth=3 2>/dev/null; then
        echo -e "${GREEN}  ✓ Generated: $pdf_output${NC}"
      fi
    else
      echo -e "${RED}  ✗ Failed to generate report${NC}"
      FAILED=$((FAILED + 1))
    fi
    
    echo ""
  fi
done

# Summary
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Generation Summary                                       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Total projects:      $PROJECT_COUNT"
echo -e "${GREEN}Reports generated:   $GENERATED${NC}"
echo -e "${YELLOW}Projects skipped:    $SKIPPED${NC}"
echo -e "${RED}Generation failed:   $FAILED${NC}"
echo ""

if [ $GENERATED -gt 0 ]; then
  echo "Generated reports:"
  ls -lh "$OUTPUT_DIR"/*.docx 2>/dev/null | awk '{print "  - " $9 " (" $5 ")"}'
  echo ""
fi

if [ $SKIPPED -gt 0 ]; then
  echo -e "${YELLOW}Note: Some projects were skipped because they don't have report.md${NC}"
  echo "Create reports in your projects to include them in batch generation."
  echo ""
fi

if [ $FAILED -gt 0 ]; then
  echo -e "${RED}Note: Some reports failed to generate${NC}"
  echo "Common issues:"
  echo "  - Invalid markdown syntax"
  echo "  - Missing images or resources"
  echo "  - Pandoc configuration issues"
  echo ""
fi

echo "Next steps:"
echo "  1. Review generated reports in $OUTPUT_DIR"
echo "  2. Customize with templates: ./generate-all-reports.sh templates/corporate.docx"
echo "  3. Share reports with stakeholders"
echo ""

# Made with Bob
