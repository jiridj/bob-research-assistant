#!/bin/bash
# Initialize a new research topic
# Usage: ./init-research-project.sh topic-name

set -e

GREEN='\033[0;32m'
NC='\033[0m'

TOPIC=$1

if [ -z "$TOPIC" ]; then
  echo "Usage: ./init-research-project.sh topic-name"
  echo "Example: ./init-research-project.sh api-management"
  exit 1
fi

TOPIC_DIR="research/$TOPIC"

if [ -d "$TOPIC_DIR" ]; then
  echo "Error: Research topic '$TOPIC' already exists at $TOPIC_DIR"
  exit 1
fi

mkdir -p "$TOPIC_DIR"

cat > "$TOPIC_DIR/goals.md" << EOF
# Research Goals: $TOPIC

**Created**: $(date +%Y-%m-%d)

## Topic
What area are you exploring?

## Objectives
What are you trying to learn or understand?

## Key Questions
1.
2.
3.

## Decisions This Informs
What will this research be used for?

## Scope
What's in and out of scope?
EOF

echo -e "${GREEN}✓${NC} Created research topic: $TOPIC_DIR"
echo ""
echo "  $TOPIC_DIR/"
echo "  └── goals.md"
echo ""
echo "Edit goals.md, then add notes, analysis, and sub-folders as the work grows."
echo ""
echo "Suggested commit:"
echo "  git add $TOPIC_DIR/"
echo "  git commit -m \"research: $TOPIC — initialize goals\""
