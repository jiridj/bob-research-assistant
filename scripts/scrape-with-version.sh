#!/bin/bash
# Scrape web content with automatic versioning and metadata tracking
# Usage: ./scrape-with-version.sh URL COMPANY PAGE

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

URL=$1
COMPANY=$2
PAGE=$3

if [ -z "$URL" ] || [ -z "$COMPANY" ] || [ -z "$PAGE" ]; then
  echo "Usage: ./scrape-with-version.sh URL COMPANY PAGE"
  echo ""
  echo "Arguments:"
  echo "  URL     - The URL to scrape"
  echo "  COMPANY - Company/category name (e.g., Kong, AWS, Gartner)"
  echo "  PAGE    - Page identifier (e.g., features, pricing, docs)"
  echo ""
  echo "Example:"
  echo "  ./scrape-with-version.sh \\"
  echo "    'https://konghq.com/products/api-gateway' \\"
  echo "    'Kong' \\"
  echo "    'features'"
  exit 1
fi

# Check if crwl (crawl4ai CLI) is installed
if ! command -v crwl &> /dev/null; then
  echo -e "${RED}Error: crawl4ai CLI (crwl) is not installed${NC}"
  echo "Install with: pip install crawl4ai"
  exit 1
fi

DATE=$(date +%Y-%m-%d)
OUTPUT_DIR="sources/Competitors/${COMPANY}"
OUTPUT_FILE="${OUTPUT_DIR}/${PAGE}-${DATE}.md"
METADATA_FILE="${OUTPUT_DIR}/${PAGE}-${DATE}.json"

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Web Scraping with Versioning                             ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "URL:     $URL"
echo "Company: $COMPANY"
echo "Page:    $PAGE"
echo "Date:    $DATE"
echo ""

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Check if already scraped today
if [ -f "$OUTPUT_FILE" ]; then
  echo -e "${RED}Warning: This page was already scraped today${NC}"
  echo "File: $OUTPUT_FILE"
  read -p "Overwrite? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Scraping cancelled"
    exit 0
  fi
fi

# Scrape content
echo -e "${BLUE}→${NC} Scraping ${COMPANY} ${PAGE}..."

if crwl crawl "$URL" --output markdown --output-file "$OUTPUT_FILE" 2>/dev/null; then
  echo -e "${GREEN}✓${NC} Content scraped successfully"
else
  echo -e "${RED}✗${NC} Failed to scrape content"
  exit 1
fi

# Get file statistics
if [[ "$OSTYPE" == "darwin"* ]]; then
  FILE_SIZE=$(stat -f%z "$OUTPUT_FILE")
else
  FILE_SIZE=$(stat -c%s "$OUTPUT_FILE")
fi

WORD_COUNT=$(wc -w < "$OUTPUT_FILE" | tr -d ' ')
LINE_COUNT=$(wc -l < "$OUTPUT_FILE" | tr -d ' ')
CONTENT_HASH=$(shasum -a 256 "$OUTPUT_FILE" | cut -d' ' -f1)

# Create metadata file
cat > "$METADATA_FILE" << EOF
{
  "scraped_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "url": "$URL",
  "company": "$COMPANY",
  "page": "$PAGE",
  "date": "$DATE",
  "file_size_bytes": $FILE_SIZE,
  "word_count": $WORD_COUNT,
  "line_count": $LINE_COUNT,
  "content_hash": "$CONTENT_HASH"
}
EOF

echo -e "${GREEN}✓${NC} Metadata saved"

# Check for previous versions
PREVIOUS_VERSIONS=$(find "$OUTPUT_DIR" -name "${PAGE}-*.md" ! -name "${PAGE}-${DATE}.md" | wc -l | tr -d ' ')

if [ "$PREVIOUS_VERSIONS" -gt 0 ]; then
  echo ""
  echo -e "${BLUE}Previous versions found: $PREVIOUS_VERSIONS${NC}"
  
  # Get most recent previous version
  LATEST_PREVIOUS=$(find "$OUTPUT_DIR" -name "${PAGE}-*.md" ! -name "${PAGE}-${DATE}.md" -type f | sort -r | head -1)
  
  if [ -n "$LATEST_PREVIOUS" ]; then
    PREV_DATE=$(basename "$LATEST_PREVIOUS" .md | cut -d'-' -f2-)
    echo "Latest previous: $PREV_DATE"
    
    # Compare with previous version
    LINES_ADDED=$(diff "$LATEST_PREVIOUS" "$OUTPUT_FILE" 2>/dev/null | grep '^>' | wc -l | tr -d ' ')
    LINES_REMOVED=$(diff "$LATEST_PREVIOUS" "$OUTPUT_FILE" 2>/dev/null | grep '^<' | wc -l | tr -d ' ')
    LINES_CHANGED=$((LINES_ADDED + LINES_REMOVED))
    
    if [ $LINES_CHANGED -eq 0 ]; then
      echo -e "${GREEN}No changes detected${NC} since $PREV_DATE"
    else
      echo -e "${BLUE}Changes detected:${NC}"
      echo "  Lines added:   $LINES_ADDED"
      echo "  Lines removed: $LINES_REMOVED"
      echo "  Total changes: $LINES_CHANGED"
      
      # Show changed sections
      if [ $LINES_CHANGED -gt 0 ] && [ $LINES_CHANGED -lt 50 ]; then
        echo ""
        echo "Changed sections:"
        diff "$LATEST_PREVIOUS" "$OUTPUT_FILE" 2>/dev/null | grep -E '^[<>].*##' | head -5
      fi
    fi
  fi
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Scraping Complete                                        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Content saved to:"
echo "  $OUTPUT_FILE"
echo "Metadata saved to:"
echo "  $METADATA_FILE"
echo ""
echo "Statistics:"
echo "  File size:  $(numfmt --to=iec-i --suffix=B $FILE_SIZE 2>/dev/null || echo "${FILE_SIZE} bytes")"
echo "  Words:      $WORD_COUNT"
echo "  Lines:      $LINE_COUNT"
echo ""
echo "Version history:"
echo "  Total versions: $((PREVIOUS_VERSIONS + 1))"
echo "  View all: ls -lt $OUTPUT_DIR/${PAGE}-*.md"
echo ""
echo "Next steps:"
echo "  1. Review scraped content: cat $OUTPUT_FILE"
echo "  2. Compare versions: ./scripts/detect-changes.sh $COMPANY $PAGE"
echo "  3. Use in research analysis"
echo ""

# Made with Bob
