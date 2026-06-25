#!/bin/bash
# Smart search across all research sources with context
# Usage: ./search-sources.sh 'search term' [context_lines]

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

SOURCES_DIR="${1:-sources}"
QUERY=$2
CONTEXT=${3:-3}  # Default 3 lines of context

if [ -z "$QUERY" ]; then
  echo "Usage: ./search-sources.sh <sources_directory> 'search term' [context_lines]"
  echo ""
  echo "Arguments:"
  echo "  sources_directory - Directory to search (default: sources)"
  echo "  search term       - Text to search for (required)"
  echo "  context_lines     - Number of context lines to show (default: 3)"
  echo ""
  echo "Examples:"
  echo "  ./search-sources.sh sources 'API Gateway'"
  echo "  ./search-sources.sh sources 'microservices' 5"
  echo "  ./search-sources.sh sources/Competitors 'Kong' 3"
  exit 1
fi

if [ ! -d "$SOURCES_DIR" ]; then
  echo -e "${RED}Error: Directory '$SOURCES_DIR' not found${NC}"
  exit 1
fi

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Source Search                                            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Search query:    '$QUERY'"
echo "Context lines:   $CONTEXT"
echo "Search directory: $SOURCES_DIR"
echo ""

# Count total markdown files
TOTAL_FILES=$(find "$SOURCES_DIR" -name "*.md" -type f | wc -l | tr -d ' ')
echo "Searching $TOTAL_FILES markdown files..."
echo ""

# Perform search with context and color
RESULTS=$(grep -r -i -l "$QUERY" "$SOURCES_DIR" --include="*.md" 2>/dev/null || true)

if [ -z "$RESULTS" ]; then
  echo -e "${YELLOW}No results found for '$QUERY'${NC}"
  echo ""
  echo "Tips:"
  echo "  - Check spelling"
  echo "  - Try different keywords"
  echo "  - Use broader search terms"
  echo "  - Search in specific subdirectories"
  exit 0
fi

# Count matching files
MATCH_COUNT=$(echo "$RESULTS" | wc -l | tr -d ' ')

echo -e "${GREEN}Found matches in $MATCH_COUNT file(s)${NC}"
echo ""
echo "═══════════════════════════════════════════════════════════════"
echo ""

# Display results with context
FILE_NUM=0
for file in $RESULTS; do
  FILE_NUM=$((FILE_NUM + 1))
  
  # Get relative path
  REL_PATH=$(echo "$file" | sed "s|^$SOURCES_DIR/||")
  
  # Count matches in this file
  MATCHES_IN_FILE=$(grep -i -c "$QUERY" "$file" 2>/dev/null || echo "0")
  
  echo -e "${BLUE}[$FILE_NUM/$MATCH_COUNT]${NC} ${GREEN}$REL_PATH${NC} (${MATCHES_IN_FILE} matches)"
  echo ""
  
  # Show matches with context
  grep -i -n -C "$CONTEXT" --color=always "$QUERY" "$file" 2>/dev/null | head -20
  
  echo ""
  echo "───────────────────────────────────────────────────────────────"
  echo ""
done

# Summary
echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Search Summary                                           ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Query:          '$QUERY'"
echo "Files searched: $TOTAL_FILES"
echo "Files matched:  $MATCH_COUNT"
echo ""

# Show file list for easy reference
echo "Matched files:"
for file in $RESULTS; do
  REL_PATH=$(echo "$file" | sed "s|^$SOURCES_DIR/||")
  echo "  - $REL_PATH"
done

echo ""
echo "Next steps:"
echo "  1. Review matches above"
echo "  2. Open specific files for detailed analysis"
echo "  3. Refine search if needed"
echo ""

# Made with Bob
