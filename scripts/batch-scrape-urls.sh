#!/bin/bash
# Batch scrape multiple URLs from a file
# Usage: ./batch-scrape-urls.sh URL_FILE [COMPANY] [DELAY]

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

URL_FILE="$1"
COMPANY="${2:-Web}"
DELAY="${3:-2}"  # Default 2 seconds delay between requests

if [ -z "$URL_FILE" ]; then
  echo "Usage: ./batch-scrape-urls.sh URL_FILE [COMPANY] [DELAY]"
  echo ""
  echo "Arguments:"
  echo "  URL_FILE - File containing URLs (one per line)"
  echo "  COMPANY  - Company/category name (default: Web)"
  echo "  DELAY    - Delay between requests in seconds (default: 2)"
  echo ""
  echo "URL file format:"
  echo "  https://example.com/page1"
  echo "  https://example.com/page2"
  echo "  https://example.com/page3"
  echo ""
  echo "Example:"
  echo "  ./batch-scrape-urls.sh urls.txt Kong 3"
  exit 1
fi

if [ ! -f "$URL_FILE" ]; then
  echo -e "${RED}Error: URL file not found: $URL_FILE${NC}"
  exit 1
fi

# Check if crwl (crawl4ai CLI) is installed
if ! command -v crwl &> /dev/null; then
  echo -e "${RED}Error: crawl4ai CLI (crwl) is not installed${NC}"
  echo "Install with: pip install crawl4ai"
  exit 1
fi

# Count URLs
URL_COUNT=$(grep -c "^http" "$URL_FILE" || echo "0")

if [ "$URL_COUNT" -eq 0 ]; then
  echo -e "${YELLOW}No URLs found in $URL_FILE${NC}"
  exit 0
fi

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Batch URL Scraping                                       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "URL file:  $URL_FILE"
echo "Company:   $COMPANY"
echo "URLs:      $URL_COUNT"
echo "Delay:     ${DELAY}s between requests"
echo ""

OUTPUT_DIR="sources/Competitors/${COMPANY}"
mkdir -p "$OUTPUT_DIR"

# Statistics
SCRAPED=0
FAILED=0
SKIPPED=0

# Process each URL
URL_NUM=0
while IFS= read -r url; do
  # Skip empty lines and comments
  if [ -z "$url" ] || [[ "$url" == \#* ]]; then
    continue
  fi
  
  URL_NUM=$((URL_NUM + 1))
  
  echo -e "${BLUE}[$URL_NUM/$URL_COUNT]${NC} Processing: $url"
  
  # Generate filename from URL
  # Extract path and convert to filename
  filename=$(echo "$url" | sed 's|https\?://||' | sed 's|/|-|g' | sed 's|[^a-zA-Z0-9-]||g')
  
  # Add date
  DATE=$(date +%Y-%m-%d)
  output_file="$OUTPUT_DIR/${filename}-${DATE}.md"
  
  # Check if already scraped today
  if [ -f "$output_file" ]; then
    echo -e "${YELLOW}  ⊘ Skipped: Already scraped today${NC}"
    SKIPPED=$((SKIPPED + 1))
    echo ""
    continue
  fi
  
  # Scrape URL
  if crwl crawl "$url" --output markdown --output-file "$output_file" 2>/dev/null; then
    echo -e "${GREEN}  ✓ Scraped: $output_file${NC}"
    SCRAPED=$((SCRAPED + 1))
    
    # Add metadata
    cat >> "$output_file" << EOF

---
metadata:
  url: $url
  scraped_date: $DATE
  company: $COMPANY
---
EOF
  else
    echo -e "${RED}  ✗ Failed to scrape${NC}"
    FAILED=$((FAILED + 1))
  fi
  
  # Delay before next request (except for last URL)
  if [ $URL_NUM -lt $URL_COUNT ]; then
    echo "  Waiting ${DELAY}s..."
    sleep "$DELAY"
  fi
  
  echo ""
done < "$URL_FILE"

# Summary
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Scraping Summary                                         ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Total URLs:          $URL_COUNT"
echo -e "${GREEN}Successfully scraped: $SCRAPED${NC}"
echo -e "${YELLOW}Skipped (existing):   $SKIPPED${NC}"
echo -e "${RED}Failed:               $FAILED${NC}"
echo ""

if [ $SCRAPED -gt 0 ]; then
  echo "Scraped files saved to:"
  echo "  $OUTPUT_DIR"
  echo ""
  echo "Files:"
  ls -1 "$OUTPUT_DIR"/*-${DATE}.md 2>/dev/null | head -10 | while read file; do
    echo "  - $(basename "$file")"
  done
  
  if [ $SCRAPED -gt 10 ]; then
    echo "  ... and $((SCRAPED - 10)) more"
  fi
  echo ""
fi

if [ $FAILED -gt 0 ]; then
  echo -e "${YELLOW}Note: Some URLs failed to scrape${NC}"
  echo "Common issues:"
  echo "  - URL not accessible"
  echo "  - Rate limiting"
  echo "  - Network issues"
  echo "  - JavaScript-heavy pages (try with --js-render)"
  echo ""
fi

echo "Next steps:"
echo "  1. Review scraped content"
echo "  2. Update source indexes: ./scripts/update-source-index.sh"
echo "  3. Use in research analysis"
echo ""

if [ $FAILED -gt 0 ]; then
  echo "To retry failed URLs:"
  echo "  1. Create a new file with failed URLs"
  echo "  2. Run this script again with increased delay"
  echo ""
fi

# Made with Bob
