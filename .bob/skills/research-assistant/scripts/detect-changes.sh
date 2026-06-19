#!/bin/bash
# Detect and analyze changes between versions of scraped content
# Usage: ./detect-changes.sh COMPANY PAGE

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

COMPANY=$1
PAGE=$2

if [ -z "$COMPANY" ] || [ -z "$PAGE" ]; then
  echo "Usage: ./detect-changes.sh COMPANY PAGE"
  echo ""
  echo "Arguments:"
  echo "  COMPANY - Company/category name (e.g., Kong, AWS)"
  echo "  PAGE    - Page identifier (e.g., features, pricing)"
  echo ""
  echo "Example:"
  echo "  ./detect-changes.sh Kong features"
  exit 1
fi

SOURCE_DIR="sources/Competitors/${COMPANY}"

if [ ! -d "$SOURCE_DIR" ]; then
  echo -e "${RED}Error: Directory not found: $SOURCE_DIR${NC}"
  echo ""
  echo "Available companies:"
  if [ -d "sources/Competitors" ]; then
    ls -1 sources/Competitors/
  else
    echo "  (none found)"
  fi
  exit 1
fi

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Change Detection                                         ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Company: $COMPANY"
echo "Page:    $PAGE"
echo ""

# Find all versions of this page
VERSIONS=$(find "$SOURCE_DIR" -name "${PAGE}-*.md" -type f | sort -r)
VERSION_COUNT=$(echo "$VERSIONS" | wc -l | tr -d ' ')

if [ "$VERSION_COUNT" -eq 0 ]; then
  echo -e "${RED}No versions found for page '$PAGE'${NC}"
  echo ""
  echo "Available pages in $SOURCE_DIR:"
  ls -1 "$SOURCE_DIR"/*.md 2>/dev/null | xargs -n1 basename | sed 's/-[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\.md$//' | sort -u
  exit 1
fi

if [ "$VERSION_COUNT" -eq 1 ]; then
  echo -e "${YELLOW}Only one version found - no comparison possible${NC}"
  echo ""
  SINGLE_VERSION=$(echo "$VERSIONS" | head -1)
  echo "Version: $(basename "$SINGLE_VERSION")"
  exit 0
fi

# Get latest two versions
LATEST=$(echo "$VERSIONS" | head -1)
PREVIOUS=$(echo "$VERSIONS" | head -2 | tail -1)

LATEST_DATE=$(basename "$LATEST" .md | cut -d'-' -f2-)
PREVIOUS_DATE=$(basename "$PREVIOUS" .md | cut -d'-' -f2-)

echo "Comparing versions:"
echo "  Previous: $PREVIOUS_DATE"
echo "  Latest:   $LATEST_DATE"
echo ""

# Calculate changes
LINES_ADDED=$(diff "$PREVIOUS" "$LATEST" 2>/dev/null | grep '^>' | wc -l | tr -d ' ')
LINES_REMOVED=$(diff "$PREVIOUS" "$LATEST" 2>/dev/null | grep '^<' | wc -l | tr -d ' ')
LINES_CHANGED=$((LINES_ADDED + LINES_REMOVED))

echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo ""

if [ $LINES_CHANGED -eq 0 ]; then
  echo -e "${GREEN}✓ No changes detected${NC}"
  echo ""
  echo "The content is identical between these versions."
else
  echo -e "${YELLOW}Changes detected:${NC}"
  echo "  Lines added:   $LINES_ADDED"
  echo "  Lines removed: $LINES_REMOVED"
  echo "  Total changes: $LINES_CHANGED"
  echo ""
  
  # Show changed sections (headings)
  echo -e "${BLUE}Changed sections:${NC}"
  CHANGED_SECTIONS=$(diff "$PREVIOUS" "$LATEST" 2>/dev/null | grep -E '^[<>].*##' | head -10)
  
  if [ -n "$CHANGED_SECTIONS" ]; then
    echo "$CHANGED_SECTIONS" | while read line; do
      if [[ "$line" == ">"* ]]; then
        echo -e "  ${GREEN}+ $(echo "$line" | sed 's/^> //')${NC}"
      else
        echo -e "  ${RED}- $(echo "$line" | sed 's/^< //')${NC}"
      fi
    done
  else
    echo "  (No section headings changed)"
  fi
  echo ""
  
  # Analyze type of changes
  echo -e "${BLUE}Change analysis:${NC}"
  
  # Check for pricing changes
  PRICING_CHANGES=$(diff "$PREVIOUS" "$LATEST" 2>/dev/null | grep -i -E '(price|pricing|\$|cost|fee)' | wc -l | tr -d ' ')
  if [ "$PRICING_CHANGES" -gt 0 ]; then
    echo -e "  ${YELLOW}⚠${NC} Pricing information may have changed ($PRICING_CHANGES lines)"
  fi
  
  # Check for feature changes
  FEATURE_CHANGES=$(diff "$PREVIOUS" "$LATEST" 2>/dev/null | grep -i -E '(feature|capability|support)' | wc -l | tr -d ' ')
  if [ "$FEATURE_CHANGES" -gt 0 ]; then
    echo -e "  ${YELLOW}⚠${NC} Feature information may have changed ($FEATURE_CHANGES lines)"
  fi
  
  # Check for new sections
  NEW_HEADINGS=$(diff "$PREVIOUS" "$LATEST" 2>/dev/null | grep '^>' | grep -c '^>.*##' || echo "0")
  if [ "$NEW_HEADINGS" -gt 0 ]; then
    echo -e "  ${GREEN}+${NC} New sections added: $NEW_HEADINGS"
  fi
  
  # Check for removed sections
  REMOVED_HEADINGS=$(diff "$PREVIOUS" "$LATEST" 2>/dev/null | grep '^<' | grep -c '^<.*##' || echo "0")
  if [ "$REMOVED_HEADINGS" -gt 0 ]; then
    echo -e "  ${RED}-${NC} Sections removed: $REMOVED_HEADINGS"
  fi
fi

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo ""

# Version history
echo -e "${BLUE}Version history:${NC}"
echo "$VERSIONS" | while read version; do
  date=$(basename "$version" .md | cut -d'-' -f2-)
  size=$(wc -w < "$version" | tr -d ' ')
  echo "  - $date ($size words)"
done

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Summary                                                  ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Total versions: $VERSION_COUNT"
echo "Latest version: $LATEST_DATE"
echo "Changes:        $LINES_CHANGED lines"
echo ""

if [ $LINES_CHANGED -gt 0 ]; then
  echo "Next steps:"
  echo "  1. Review detailed diff: diff $PREVIOUS $LATEST"
  echo "  2. Document significant changes in research notes"
  echo "  3. Update competitive analysis if needed"
  echo ""
  echo "Generate detailed diff report:"
  echo "  diff -u $PREVIOUS $LATEST > changes-${PREVIOUS_DATE}-to-${LATEST_DATE}.diff"
else
  echo "No action needed - content is unchanged."
fi
echo ""

# Made with Bob
