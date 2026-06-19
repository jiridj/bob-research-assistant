#!/bin/bash
# Generate bibliography from all research sources
# Usage: ./generate-bibliography.sh [output-file]

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

SOURCES_DIR="${1:-sources}"
OUTPUT="${2:-bibliography.md}"

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Bibliography Generator                                   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Sources directory: $SOURCES_DIR"
echo "Output file: $OUTPUT"
echo ""

if [ ! -d "$SOURCES_DIR" ]; then
  echo -e "${YELLOW}Warning: Sources directory '$SOURCES_DIR' not found${NC}"
  exit 1
fi

# Initialize output file
cat > "$OUTPUT" << EOF
# Bibliography

**Generated**: $(date +"%Y-%m-%d %H:%M:%S")
**Sources Directory**: $SOURCES_DIR

---

EOF

# Count sources
TOTAL_SOURCES=0

# Function to extract metadata from markdown files
extract_metadata() {
  local file=$1
  local field=$2
  
  # Try to extract from YAML front matter
  if grep -q "^---$" "$file"; then
    awk "/^---$/,/^---$/ {if (\$1 == \"$field:\") print \$0}" "$file" | cut -d':' -f2- | sed 's/^[[:space:]]*//' | tr -d '"'
  fi
}

# Process Analyst Reports
echo -e "${BLUE}→${NC} Processing analyst reports..."
ANALYST_COUNT=0

echo "## Analyst Reports" >> "$OUTPUT"
echo "" >> "$OUTPUT"

for category in Gartner Forrester IDC; do
  if [ -d "$SOURCES_DIR/$category" ]; then
    for file in "$SOURCES_DIR/$category"/*.md; do
      if [ -f "$file" ]; then
        filename=$(basename "$file" .md)
        
        # Extract metadata
        title=$(extract_metadata "$file" "title")
        author=$(extract_metadata "$file" "author")
        date=$(extract_metadata "$file" "date")
        
        # Use filename as fallback for title
        if [ -z "$title" ]; then
          title=$(grep "^# " "$file" | head -1 | sed 's/^# //' || echo "$filename")
        fi
        
        echo "### $title" >> "$OUTPUT"
        echo "" >> "$OUTPUT"
        [ -n "$author" ] && echo "- **Author**: $author" >> "$OUTPUT"
        [ -n "$date" ] && echo "- **Date**: $date" >> "$OUTPUT"
        echo "- **Publisher**: $category" >> "$OUTPUT"
        echo "- **Source File**: \`$file\`" >> "$OUTPUT"
        echo "" >> "$OUTPUT"
        
        ANALYST_COUNT=$((ANALYST_COUNT + 1))
      fi
    done
  fi
done

if [ $ANALYST_COUNT -eq 0 ]; then
  echo "*No analyst reports found*" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
fi

TOTAL_SOURCES=$((TOTAL_SOURCES + ANALYST_COUNT))

# Process Vendor Documentation
echo -e "${BLUE}→${NC} Processing vendor documentation..."
VENDOR_COUNT=0

echo "## Vendor Documentation" >> "$OUTPUT"
echo "" >> "$OUTPUT"

if [ -d "$SOURCES_DIR/Hyperscalers" ]; then
  for vendor_dir in "$SOURCES_DIR/Hyperscalers"/*; do
    if [ -d "$vendor_dir" ]; then
      vendor=$(basename "$vendor_dir")
      
      for file in "$vendor_dir"/*.md; do
        if [ -f "$file" ]; then
          filename=$(basename "$file" .md)
          title=$(grep "^# " "$file" | head -1 | sed 's/^# //' || echo "$filename")
          url=$(extract_metadata "$file" "url")
          
          echo "### $title" >> "$OUTPUT"
          echo "" >> "$OUTPUT"
          echo "- **Vendor**: $vendor" >> "$OUTPUT"
          [ -n "$url" ] && echo "- **URL**: $url" >> "$OUTPUT"
          echo "- **Source File**: \`$file\`" >> "$OUTPUT"
          echo "" >> "$OUTPUT"
          
          VENDOR_COUNT=$((VENDOR_COUNT + 1))
        fi
      done
    fi
  done
fi

if [ $VENDOR_COUNT -eq 0 ]; then
  echo "*No vendor documentation found*" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
fi

TOTAL_SOURCES=$((TOTAL_SOURCES + VENDOR_COUNT))

# Process Competitor Information
echo -e "${BLUE}→${NC} Processing competitor information..."
COMPETITOR_COUNT=0

echo "## Competitor Information" >> "$OUTPUT"
echo "" >> "$OUTPUT"

if [ -d "$SOURCES_DIR/Competitors" ]; then
  for comp_dir in "$SOURCES_DIR/Competitors"/*; do
    if [ -d "$comp_dir" ]; then
      competitor=$(basename "$comp_dir")
      
      for file in "$comp_dir"/*.md; do
        if [ -f "$file" ]; then
          filename=$(basename "$file" .md)
          title=$(grep "^# " "$file" | head -1 | sed 's/^# //' || echo "$filename")
          url=$(extract_metadata "$file" "url")
          
          # Extract date from versioned filename (e.g., features-2024-06-17.md)
          if [[ "$filename" =~ -([0-9]{4}-[0-9]{2}-[0-9]{2})$ ]]; then
            accessed="${BASH_REMATCH[1]}"
          else
            accessed=$(date -r "$file" +%Y-%m-%d 2>/dev/null || stat -c %y "$file" 2>/dev/null | cut -d' ' -f1)
          fi
          
          echo "### $title" >> "$OUTPUT"
          echo "" >> "$OUTPUT"
          echo "- **Company**: $competitor" >> "$OUTPUT"
          [ -n "$url" ] && echo "- **URL**: $url" >> "$OUTPUT"
          [ -n "$accessed" ] && echo "- **Accessed**: $accessed" >> "$OUTPUT"
          echo "- **Source File**: \`$file\`" >> "$OUTPUT"
          echo "" >> "$OUTPUT"
          
          COMPETITOR_COUNT=$((COMPETITOR_COUNT + 1))
        fi
      done
    fi
  done
fi

if [ $COMPETITOR_COUNT -eq 0 ]; then
  echo "*No competitor information found*" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
fi

TOTAL_SOURCES=$((TOTAL_SOURCES + COMPETITOR_COUNT))

# Process Web Content
echo -e "${BLUE}→${NC} Processing web content..."
WEB_COUNT=0

echo "## Web Content" >> "$OUTPUT"
echo "" >> "$OUTPUT"

if [ -d "$SOURCES_DIR/web" ]; then
  for file in "$SOURCES_DIR/web"/*.md; do
    if [ -f "$file" ]; then
      filename=$(basename "$file" .md)
      title=$(grep "^# " "$file" | head -1 | sed 's/^# //' || echo "$filename")
      url=$(extract_metadata "$file" "url")
      accessed=$(date -r "$file" +%Y-%m-%d 2>/dev/null || stat -c %y "$file" 2>/dev/null | cut -d' ' -f1)
      
      echo "### $title" >> "$OUTPUT"
      echo "" >> "$OUTPUT"
      [ -n "$url" ] && echo "- **URL**: $url" >> "$OUTPUT"
      [ -n "$accessed" ] && echo "- **Accessed**: $accessed" >> "$OUTPUT"
      echo "- **Source File**: \`$file\`" >> "$OUTPUT"
      echo "" >> "$OUTPUT"
      
      WEB_COUNT=$((WEB_COUNT + 1))
    fi
  done
fi

if [ $WEB_COUNT -eq 0 ]; then
  echo "*No web content found*" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
fi

TOTAL_SOURCES=$((TOTAL_SOURCES + WEB_COUNT))

# Add summary
cat >> "$OUTPUT" << EOF
---

## Summary

- **Analyst Reports**: $ANALYST_COUNT
- **Vendor Documentation**: $VENDOR_COUNT
- **Competitor Information**: $COMPETITOR_COUNT
- **Web Content**: $WEB_COUNT
- **Total Sources**: $TOTAL_SOURCES

**Last Updated**: $(date +"%Y-%m-%d %H:%M:%S")
EOF

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Bibliography Generated                                   ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Output file: $OUTPUT"
echo ""
echo "Summary:"
echo "  Analyst Reports:        $ANALYST_COUNT"
echo "  Vendor Documentation:   $VENDOR_COUNT"
echo "  Competitor Information: $COMPETITOR_COUNT"
echo "  Web Content:            $WEB_COUNT"
echo "  ─────────────────────────────────"
echo "  Total Sources:          $TOTAL_SOURCES"
echo ""
echo "Next steps:"
echo "  1. Review bibliography: cat $OUTPUT"
echo "  2. Include in research reports"
echo "  3. Update as new sources are added"
echo ""

# Made with Bob
