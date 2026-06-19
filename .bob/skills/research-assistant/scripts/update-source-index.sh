#!/bin/bash
# Update source index files with current source inventory
# Usage: ./update-source-index.sh [sources-directory]

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

SOURCES_DIR="${1:-sources}"

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Source Index Updater                                     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

if [ ! -d "$SOURCES_DIR" ]; then
  echo -e "${YELLOW}Sources directory not found: $SOURCES_DIR${NC}"
  exit 1
fi

echo "Updating indexes in: $SOURCES_DIR"
echo ""

UPDATED=0

# Function to update category index
update_category_index() {
  local category_dir=$1
  local category_name=$(basename "$category_dir")
  local index_file="$category_dir/index.md"
  
  echo -e "${BLUE}→${NC} Updating: $category_name"
  
  # Count files
  local file_count=$(find "$category_dir" -name "*.md" ! -name "index.md" -type f | wc -l | tr -d ' ')
  
  if [ "$file_count" -eq 0 ]; then
    echo -e "${YELLOW}  ⊘ No sources found${NC}"
    return
  fi
  
  # Create index
  cat > "$index_file" << EOF
# $category_name Sources Index

**Last Updated**: $(date +"%Y-%m-%d %H:%M:%S")
**Total Documents**: $file_count

## Documents

EOF
  
  # List all markdown files
  find "$category_dir" -name "*.md" ! -name "index.md" -type f | sort | while read file; do
    filename=$(basename "$file" .md)
    
    # Get file size and word count
    if [[ "$OSTYPE" == "darwin"* ]]; then
      size=$(stat -f%z "$file")
    else
      size=$(stat -c%s "$file")
    fi
    size_kb=$((size / 1024))
    words=$(wc -w < "$file" | tr -d ' ')
    
    # Get first heading as title
    title=$(grep "^# " "$file" | head -1 | sed 's/^# //' || echo "$filename")
    
    # Get date from filename if versioned (e.g., features-2024-06-17.md)
    if [[ "$filename" =~ -([0-9]{4}-[0-9]{2}-[0-9]{2})$ ]]; then
      date="${BASH_REMATCH[1]}"
      echo "- **$title** (\`$filename.md\`)" >> "$index_file"
      echo "  - Date: $date" >> "$index_file"
    else
      echo "- **$title** (\`$filename.md\`)" >> "$index_file"
    fi
    
    echo "  - Size: ${size_kb}KB, Words: $words" >> "$index_file"
    echo "" >> "$index_file"
  done
  
  echo -e "${GREEN}  ✓ Updated: $index_file${NC}"
  UPDATED=$((UPDATED + 1))
}

# Update master index
echo -e "${BLUE}→${NC} Updating master index"

MASTER_INDEX="$SOURCES_DIR/index.md"

cat > "$MASTER_INDEX" << EOF
# Sources Master Index

**Last Updated**: $(date +"%Y-%m-%d %H:%M:%S")

This index provides an overview of all research sources organized by category.

---

EOF

# Count total sources
TOTAL_SOURCES=$(find "$SOURCES_DIR" -name "*.md" ! -name "index.md" -type f | wc -l | tr -d ' ')

echo "## Summary" >> "$MASTER_INDEX"
echo "" >> "$MASTER_INDEX"
echo "- **Total Sources**: $TOTAL_SOURCES" >> "$MASTER_INDEX"
echo "- **Categories**: $(find "$SOURCES_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')" >> "$MASTER_INDEX"
echo "" >> "$MASTER_INDEX"

# List categories
echo "## Categories" >> "$MASTER_INDEX"
echo "" >> "$MASTER_INDEX"

for category_dir in "$SOURCES_DIR"/*/; do
  if [ -d "$category_dir" ]; then
    category_name=$(basename "$category_dir")
    file_count=$(find "$category_dir" -name "*.md" ! -name "index.md" -type f | wc -l | tr -d ' ')
    
    if [ "$file_count" -gt 0 ]; then
      echo "### $category_name" >> "$MASTER_INDEX"
      echo "" >> "$MASTER_INDEX"
      echo "- **Documents**: $file_count" >> "$MASTER_INDEX"
      echo "- **Index**: [\`$category_name/index.md\`]($category_name/index.md)" >> "$MASTER_INDEX"
      echo "" >> "$MASTER_INDEX"
      
      # Update category index
      update_category_index "$category_dir"
    fi
  fi
done

echo "" >> "$MASTER_INDEX"
echo "---" >> "$MASTER_INDEX"
echo "" >> "$MASTER_INDEX"
echo "*This index is automatically generated. Run \`./update-source-index.sh\` to update.*" >> "$MASTER_INDEX"

echo -e "${GREEN}  ✓ Updated: $MASTER_INDEX${NC}"
UPDATED=$((UPDATED + 1))

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Update Complete                                          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Indexes updated:  $UPDATED"
echo "Total sources:    $TOTAL_SOURCES"
echo ""
echo "Master index: $MASTER_INDEX"
echo ""
echo "Next steps:"
echo "  1. Review updated indexes"
echo "  2. Use indexes to navigate sources"
echo "  3. Run this script after adding new sources"
echo ""

# Made with Bob
