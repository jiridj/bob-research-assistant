#!/bin/bash
# Batch scrape multiple URLs from a file with versioning and metadata
# Usage: ./batch-scrape-urls.sh URL_FILE [DELAY]

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

URL_FILE="$1"
DELAY="${2:-2}"  # Default 2 seconds delay between requests

if [ -z "$URL_FILE" ]; then
  echo "Usage: ./batch-scrape-urls.sh URL_FILE [DELAY]"
  echo ""
  echo "Arguments:"
  echo "  URL_FILE - File containing URLs (one per line)"
  echo "  DELAY    - Delay between requests in seconds (default: 2)"
  echo ""
  echo "URL file format:"
  echo "  https://example.com/page1"
  echo "  https://example.com/page2"
  echo "  https://example.com/page3"
  echo ""
  echo "Example:"
  echo "  ./batch-scrape-urls.sh urls.txt 3"
  echo ""
  echo "Note: This script automatically extracts COMPANY and PAGE from each URL"
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

# Function to extract company name from URL
extract_company() {
  local url="$1"
  local domain=$(echo "$url" | sed 's|https\?://||' | sed 's|/.*||' | sed 's|www\.||')
  
  # Special cases
  if [[ "$domain" == *"wikipedia.org"* ]]; then
    echo "Wikipedia"
  elif [[ "$domain" == *"konghq.com"* ]]; then
    echo "Kong"
  elif [[ "$domain" == *"aws.amazon.com"* ]] || [[ "$domain" == *"amazonaws.com"* ]]; then
    echo "AWS"
  elif [[ "$domain" == *"github.com"* ]]; then
    echo "GitHub"
  elif [[ "$domain" == *"stackoverflow.com"* ]]; then
    echo "StackOverflow"
  else
    # Extract main domain name (remove TLD)
    echo "$domain" | sed 's|\.[^.]*$||' | sed 's|\.|-|g' | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}'
  fi
}

# Function to extract page identifier from URL
extract_page() {
  local url="$1"
  local path=$(echo "$url" | sed 's|https\?://[^/]*/||' | sed 's|/$||')
  
  # Convert path to slug
  # Remove query parameters and anchors
  path=$(echo "$path" | sed 's|[?#].*||')
  
  # Convert to lowercase, replace slashes and special chars with hyphens
  local slug=$(echo "$path" | tr '[:upper:]' '[:lower:]' | sed 's|/|-|g' | sed 's|_|-|g' | sed 's|[^a-z0-9-]||g' | sed 's|--*|-|g' | sed 's|^-||' | sed 's|-$||')
  
  # If empty, use 'index'
  if [ -z "$slug" ]; then
    slug="index"
  fi
  
  echo "$slug"
}

# Count URLs
URL_COUNT=$(grep -c "^http" "$URL_FILE" || echo "0")

if [ "$URL_COUNT" -eq 0 ]; then
  echo -e "${YELLOW}No URLs found in $URL_FILE${NC}"
  exit 0
fi

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Batch URL Scraping with Versioning                       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "URL file:  $URL_FILE"
echo "URLs:      $URL_COUNT"
echo "Delay:     ${DELAY}s between requests"
echo ""

DATE=$(date +%Y-%m-%d)

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
  
  # Extract company and page from URL
  COMPANY=$(extract_company "$url")
  PAGE=$(extract_page "$url")
  
  echo "  Company: $COMPANY"
  echo "  Page:    $PAGE"
  
  # Set up output paths
  OUTPUT_DIR="sources/web/${COMPANY}"
  OUTPUT_FILE="${OUTPUT_DIR}/${PAGE}-${DATE}.md"
  METADATA_FILE="${OUTPUT_DIR}/${PAGE}-${DATE}.json"
  
  # Create output directory
  mkdir -p "$OUTPUT_DIR"
  
  # Check if already scraped today
  if [ -f "$OUTPUT_FILE" ]; then
    echo -e "${YELLOW}  ⊘ Skipped: Already scraped today${NC}"
    SKIPPED=$((SKIPPED + 1))
    echo ""
    continue
  fi
  
  # Scrape URL
  if crwl crawl "$url" --output markdown --output-file "$OUTPUT_FILE" 2>/dev/null; then
    echo -e "${GREEN}  ✓ Content scraped successfully${NC}"
    
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
  "url": "$url",
  "company": "$COMPANY",
  "page": "$PAGE",
  "date": "$DATE",
  "file_size_bytes": $FILE_SIZE,
  "word_count": $WORD_COUNT,
  "line_count": $LINE_COUNT,
  "content_hash": "$CONTENT_HASH"
}
EOF
    
    echo -e "${GREEN}  ✓ Metadata saved${NC}"
    echo "  File: $OUTPUT_FILE"
    
    SCRAPED=$((SCRAPED + 1))
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
  echo "Scraped files saved to sources/web/"
  echo ""
  echo "Files created:"
  find sources/web -name "*-${DATE}.md" -type f 2>/dev/null | head -10 | while read file; do
    dir=$(dirname "$file" | sed 's|sources/web/||')
    base=$(basename "$file")
    echo "  - $dir/$base"
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
  echo "  - JavaScript-heavy pages"
  echo ""
fi

echo "Next steps:"
echo "  1. Review scraped content"
echo "  2. Compare versions: ./scripts/detect-changes.sh COMPANY PAGE"
echo "  3. Use in research analysis"
echo ""

if [ $FAILED -gt 0 ]; then
  echo "To retry failed URLs:"
  echo "  1. Create a new file with failed URLs"
  echo "  2. Run this script again with increased delay"
  echo ""
fi

# Made with Bob
