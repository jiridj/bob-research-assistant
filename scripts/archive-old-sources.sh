#!/bin/bash
# Archive old or outdated sources
# Usage: ./archive-old-sources.sh [days-old] [sources-directory]

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

DAYS_OLD="${1:-180}"  # Default 180 days (6 months)
SOURCES_DIR="${2:-sources}"
ARCHIVE_DIR="${SOURCES_DIR}/archive"

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Source Archiver                                          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Sources directory: $SOURCES_DIR"
echo "Archive directory: $ARCHIVE_DIR"
echo "Archive threshold: $DAYS_OLD days"
echo ""

if [ ! -d "$SOURCES_DIR" ]; then
  echo -e "${YELLOW}Sources directory not found: $SOURCES_DIR${NC}"
  exit 1
fi

# Create archive directory
mkdir -p "$ARCHIVE_DIR"

# Find old files
echo "Searching for files older than $DAYS_OLD days..."
OLD_FILES=$(find "$SOURCES_DIR" -name "*.md" ! -path "*/archive/*" -type f -mtime +$DAYS_OLD)
OLD_COUNT=$(echo "$OLD_FILES" | grep -c . || echo "0")

if [ "$OLD_COUNT" -eq 0 ]; then
  echo -e "${GREEN}No files found older than $DAYS_OLD days${NC}"
  echo ""
  echo "All sources are relatively recent. No archiving needed."
  exit 0
fi

echo -e "${YELLOW}Found $OLD_COUNT file(s) to archive${NC}"
echo ""

# Show files to be archived
echo "Files to be archived:"
echo "$OLD_FILES" | while read file; do
  if [ -n "$file" ]; then
    rel_path=$(echo "$file" | sed "s|^$SOURCES_DIR/||")
    age_days=$(( ($(date +%s) - $(stat -f%m "$file" 2>/dev/null || stat -c%Y "$file")) / 86400 ))
    echo "  - $rel_path (${age_days} days old)"
  fi
done

echo ""
read -p "Proceed with archiving? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Archiving cancelled"
  exit 0
fi

# Archive files
ARCHIVED=0
echo ""
echo "Archiving files..."

echo "$OLD_FILES" | while read file; do
  if [ -n "$file" ] && [ -f "$file" ]; then
    # Get relative path
    rel_path=$(echo "$file" | sed "s|^$SOURCES_DIR/||")
    
    # Create archive subdirectory structure
    archive_subdir=$(dirname "$rel_path")
    mkdir -p "$ARCHIVE_DIR/$archive_subdir"
    
    # Move file to archive
    archive_path="$ARCHIVE_DIR/$rel_path"
    
    if mv "$file" "$archive_path"; then
      echo -e "${GREEN}  ✓ Archived: $rel_path${NC}"
    else
      echo -e "${YELLOW}  ⚠ Failed: $rel_path${NC}"
    fi
  fi
done

# Count archived files
ARCHIVED=$(find "$ARCHIVE_DIR" -name "*.md" -type f | wc -l | tr -d ' ')

# Create archive index
ARCHIVE_INDEX="$ARCHIVE_DIR/index.md"

cat > "$ARCHIVE_INDEX" << EOF
# Archived Sources

**Last Updated**: $(date +"%Y-%m-%d %H:%M:%S")
**Total Archived**: $ARCHIVED

These sources have been archived because they are older than $DAYS_OLD days.

---

## Archived Files

EOF

find "$ARCHIVE_DIR" -name "*.md" ! -name "index.md" -type f | sort | while read file; do
  rel_path=$(echo "$file" | sed "s|^$ARCHIVE_DIR/||")
  filename=$(basename "$file" .md)
  
  # Get archive date
  if [[ "$OSTYPE" == "darwin"* ]]; then
    archive_date=$(stat -f%Sm -t "%Y-%m-%d" "$file")
  else
    archive_date=$(stat -c%y "$file" | cut -d' ' -f1)
  fi
  
  echo "- **$filename** (\`$rel_path\`)" >> "$ARCHIVE_INDEX"
  echo "  - Archived: $archive_date" >> "$ARCHIVE_INDEX"
  echo "" >> "$ARCHIVE_INDEX"
done

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Archiving Complete                                       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Files archived:   $ARCHIVED"
echo "Archive location: $ARCHIVE_DIR"
echo "Archive index:    $ARCHIVE_INDEX"
echo ""
echo "Next steps:"
echo "  1. Review archived files: ls -la $ARCHIVE_DIR"
echo "  2. Update source indexes: ./scripts/update-source-index.sh"
echo "  3. Archived files can be restored if needed"
echo ""
echo "To restore a file:"
echo "  mv $ARCHIVE_DIR/path/to/file.md $SOURCES_DIR/path/to/file.md"
echo ""

# Made with Bob
