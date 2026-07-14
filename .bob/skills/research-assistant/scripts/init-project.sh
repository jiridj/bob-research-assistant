#!/bin/bash
# Initialize a new project (flat — deliverable-focused)
# Usage: ./init-project.sh project-name

set -e

GREEN='\033[0;32m'
NC='\033[0m'

PROJECT=$1

if [ -z "$PROJECT" ]; then
  echo "Usage: ./init-project.sh project-name"
  echo "Example: ./init-project.sh q3-competitive-brief"
  exit 1
fi

PROJECT_DIR="projects/$PROJECT"

if [ -d "$PROJECT_DIR" ]; then
  echo "Error: Project '$PROJECT' already exists at $PROJECT_DIR"
  exit 1
fi

mkdir -p "$PROJECT_DIR"

cat > "$PROJECT_DIR/brief.md" << EOF
# Project Brief: $PROJECT

**Created**: $(date +%Y-%m-%d)

## Deliverable
What are you creating? (e.g. executive brief, competitive comparison, slide deck)

## Audience
Who is this for?

## Source Materials
Which wiki pages, sources, or research topics will you draw from?

## Deadline / Context
Any timing or context constraints?
EOF

echo -e "${GREEN}✓${NC} Created project: $PROJECT_DIR"
echo ""
echo "  $PROJECT_DIR/"
echo "  └── brief.md"
echo ""
echo "Edit brief.md, then add flat files as the work grows (no subdirectories)."
echo ""
echo "Suggested commit:"
echo "  git add $PROJECT_DIR/"
echo "  git commit -m \"project: $PROJECT — initialize brief\""
