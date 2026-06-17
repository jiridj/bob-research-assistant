#!/bin/bash
# Validate document conversion quality
# Usage: ./validate-conversion.sh INPUT_FILE OUTPUT_FILE

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

INPUT_FILE="$1"
OUTPUT_FILE="$2"

if [ -z "$INPUT_FILE" ] || [ -z "$OUTPUT_FILE" ]; then
  echo "Usage: ./validate-conversion.sh INPUT_FILE OUTPUT_FILE"
  echo ""
  echo "Example:"
  echo "  ./validate-conversion.sh document.pdf sources/Gartner/document.md"
  exit 1
fi

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Conversion Validation                                    ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Input:  $INPUT_FILE"
echo "Output: $OUTPUT_FILE"
echo ""

ERRORS=0
WARNINGS=0

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
  echo -e "${RED}✗${NC} Input file not found"
  exit 1
fi
echo -e "${GREEN}✓${NC} Input file exists"

# Check if output file exists
if [ ! -f "$OUTPUT_FILE" ]; then
  echo -e "${RED}✗${NC} Output file not found"
  ERRORS=$((ERRORS + 1))
else
  echo -e "${GREEN}✓${NC} Output file exists"
fi

# Check file size
if [ -f "$OUTPUT_FILE" ]; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
    SIZE=$(stat -f%z "$OUTPUT_FILE")
  else
    SIZE=$(stat -c%s "$OUTPUT_FILE")
  fi
  
  if [ "$SIZE" -lt 100 ]; then
    echo -e "${RED}✗${NC} Output file too small ($SIZE bytes) - possible conversion failure"
    ERRORS=$((ERRORS + 1))
  else
    SIZE_KB=$((SIZE / 1024))
    echo -e "${GREEN}✓${NC} Output file size: ${SIZE_KB}KB"
  fi
fi

# Check for markdown headings
if [ -f "$OUTPUT_FILE" ]; then
  HEADING_COUNT=$(grep -c "^#" "$OUTPUT_FILE" || echo "0")
  
  if [ "$HEADING_COUNT" -eq 0 ]; then
    echo -e "${YELLOW}⚠${NC} Warning: No headings found"
    WARNINGS=$((WARNINGS + 1))
  else
    echo -e "${GREEN}✓${NC} Found $HEADING_COUNT headings"
  fi
fi

# Check for images
if [ -f "$OUTPUT_FILE" ]; then
  IMAGE_COUNT=$(grep -c "!\[.*\](" "$OUTPUT_FILE" || echo "0")
  
  if [ "$IMAGE_COUNT" -eq 0 ]; then
    echo -e "${BLUE}ℹ${NC} No image references found (expected if --no-images was used)"
  else
    echo -e "${GREEN}✓${NC} Found $IMAGE_COUNT image references"
  fi
fi

# Check for tables
if [ -f "$OUTPUT_FILE" ]; then
  TABLE_ROWS=$(grep -c "^|" "$OUTPUT_FILE" || echo "0")
  
  if [ "$TABLE_ROWS" -eq 0 ]; then
    echo -e "${BLUE}ℹ${NC} No tables found"
  else
    echo -e "${GREEN}✓${NC} Found $TABLE_ROWS table rows"
  fi
fi

# Check for links
if [ -f "$OUTPUT_FILE" ]; then
  LINK_COUNT=$(grep -o "\[.*\](.*)" "$OUTPUT_FILE" | wc -l | tr -d ' ')
  
  if [ "$LINK_COUNT" -eq 0 ]; then
    echo -e "${BLUE}ℹ${NC} No links found"
  else
    echo -e "${GREEN}✓${NC} Found $LINK_COUNT links"
  fi
fi

# Check for common conversion artifacts
if [ -f "$OUTPUT_FILE" ]; then
  # Check for garbled text (excessive special characters)
  SPECIAL_CHAR_RATIO=$(grep -o "[^a-zA-Z0-9 ]" "$OUTPUT_FILE" | wc -l | tr -d ' ')
  TOTAL_CHARS=$(wc -c < "$OUTPUT_FILE" | tr -d ' ')
  
  if [ "$TOTAL_CHARS" -gt 0 ]; then
    RATIO=$((SPECIAL_CHAR_RATIO * 100 / TOTAL_CHARS))
    
    if [ "$RATIO" -gt 30 ]; then
      echo -e "${YELLOW}⚠${NC} Warning: High ratio of special characters ($RATIO%) - possible encoding issues"
      WARNINGS=$((WARNINGS + 1))
    else
      echo -e "${GREEN}✓${NC} Text encoding appears normal"
    fi
  fi
fi

# Check word count
if [ -f "$OUTPUT_FILE" ]; then
  WORD_COUNT=$(wc -w < "$OUTPUT_FILE" | tr -d ' ')
  
  if [ "$WORD_COUNT" -lt 50 ]; then
    echo -e "${YELLOW}⚠${NC} Warning: Very low word count ($WORD_COUNT) - conversion may be incomplete"
    WARNINGS=$((WARNINGS + 1))
  else
    echo -e "${GREEN}✓${NC} Word count: $WORD_COUNT"
  fi
fi

# Check line count
if [ -f "$OUTPUT_FILE" ]; then
  LINE_COUNT=$(wc -l < "$OUTPUT_FILE" | tr -d ' ')
  echo -e "${GREEN}✓${NC} Line count: $LINE_COUNT"
fi

# Summary
echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Validation Summary                                       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
  echo -e "${GREEN}✓ Validation passed with no issues${NC}"
  echo ""
  echo "The conversion appears successful. The output file:"
  echo "  - Exists and has reasonable size"
  echo "  - Contains proper markdown structure"
  echo "  - Has no obvious conversion artifacts"
  exit 0
elif [ $ERRORS -eq 0 ]; then
  echo -e "${YELLOW}⚠ Validation passed with $WARNINGS warning(s)${NC}"
  echo ""
  echo "The conversion completed but has minor issues:"
  echo "  - Review the warnings above"
  echo "  - Check the output file manually"
  echo "  - Consider re-converting if quality is poor"
  exit 0
else
  echo -e "${RED}✗ Validation failed with $ERRORS error(s) and $WARNINGS warning(s)${NC}"
  echo ""
  echo "The conversion has significant issues:"
  echo "  - Review the errors above"
  echo "  - Check input file integrity"
  echo "  - Try converting again"
  echo "  - Consider alternative conversion methods"
  exit 1
fi

# Made with Bob
