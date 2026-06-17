#!/bin/bash
# Extract citations from analysis documents
# Usage: ./extract-citations.sh ANALYSIS_FILE [OUTPUT_FILE]

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

ANALYSIS_FILE="$1"
OUTPUT="${2:-citations-used.md}"

if [ -z "$ANALYSIS_FILE" ]; then
  echo "Usage: ./extract-citations.sh ANALYSIS_FILE [OUTPUT_FILE]"
  echo ""
  echo "Example:"
  echo "  ./extract-citations.sh research/api-trends/analysis.md"
  exit 1
fi

if [ ! -f "$ANALYSIS_FILE" ]; then
  echo "Error: File not found: $ANALYSIS_FILE"
  exit 1
fi

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Citation Extractor                                       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Analysis file: $ANALYSIS_FILE"
echo "Output file:   $OUTPUT"
echo ""

# Extract markdown links [text](url)
CITATIONS=$(grep -o '\[.*\]([^)]*)' "$ANALYSIS_FILE" | sort -u)
CITATION_COUNT=$(echo "$CITATIONS" | grep -c . || echo "0")

# Extract citation IDs [source-id]
CITATION_IDS=$(grep -o '\[.*\]' "$ANALYSIS_FILE" | grep -v '(' | sort -u)
ID_COUNT=$(echo "$CITATION_IDS" | grep -c . || echo "0")

echo "Found:"
echo "  Markdown links: $CITATION_COUNT"
echo "  Citation IDs:   $ID_COUNT"
echo ""

# Create output file
cat > "$OUTPUT" << EOF
# Citations Used

**Source**: $ANALYSIS_FILE
**Generated**: $(date +"%Y-%m-%d %H:%M:%S")

---

EOF

if [ "$CITATION_COUNT" -gt 0 ]; then
  echo "## Referenced Sources" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
  
  echo "$CITATIONS" | while read citation; do
    if [ -n "$citation" ]; then
      # Extract text and URL
      text=$(echo "$citation" | sed 's/\[\(.*\)\](.*/\1/')
      url=$(echo "$citation" | sed 's/.*](\(.*\))/\1/')
      
      echo "- **$text**" >> "$OUTPUT"
      echo "  - URL: $url" >> "$OUTPUT"
      echo "" >> "$OUTPUT"
    fi
  done
fi

if [ "$ID_COUNT" -gt 0 ]; then
  echo "## Citation IDs" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
  echo "$CITATION_IDS" | while read id; do
    if [ -n "$id" ]; then
      echo "- $id" >> "$OUTPUT"
    fi
  done
  echo "" >> "$OUTPUT"
fi

# Count citations per section
echo "## Citation Density" >> "$OUTPUT"
echo "" >> "$OUTPUT"

TOTAL_WORDS=$(wc -w < "$ANALYSIS_FILE" | tr -d ' ')
TOTAL_CITATIONS=$((CITATION_COUNT + ID_COUNT))

if [ "$TOTAL_WORDS" -gt 0 ]; then
  DENSITY=$((TOTAL_CITATIONS * 1000 / TOTAL_WORDS))
  echo "- **Total words**: $TOTAL_WORDS" >> "$OUTPUT"
  echo "- **Total citations**: $TOTAL_CITATIONS" >> "$OUTPUT"
  echo "- **Citations per 1000 words**: $DENSITY" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
fi

# Check for uncited sections
echo "## Quality Check" >> "$OUTPUT"
echo "" >> "$OUTPUT"

SECTIONS=$(grep -n "^## " "$ANALYSIS_FILE" | wc -l | tr -d ' ')
echo "- **Total sections**: $SECTIONS" >> "$OUTPUT"

if [ "$TOTAL_CITATIONS" -eq 0 ]; then
  echo "- **Warning**: No citations found" >> "$OUTPUT"
elif [ "$DENSITY" -lt 5 ]; then
  echo "- **Warning**: Low citation density (< 5 per 1000 words)" >> "$OUTPUT"
else
  echo "- **Status**: Good citation coverage" >> "$OUTPUT"
fi

echo "" >> "$OUTPUT"

echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Extraction Complete                                      ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Citations extracted: $TOTAL_CITATIONS"
echo "  Markdown links:    $CITATION_COUNT"
echo "  Citation IDs:      $ID_COUNT"
echo ""
echo "Citation density:    $DENSITY per 1000 words"
echo ""
echo "Output saved to: $OUTPUT"
echo ""
echo "Next steps:"
echo "  1. Review extracted citations"
echo "  2. Verify all sources are properly cited"
echo "  3. Add missing citations if needed"
echo ""

# Made with Bob
