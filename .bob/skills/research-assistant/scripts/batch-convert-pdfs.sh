#!/bin/bash
# Batch convert multiple PDFs to markdown with smart categorization
# Usage: ./batch-convert-pdfs.sh [source-directory] [output-base-directory]

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SOURCE_DIR="${1:-sources/raw}"
OUTPUT_BASE="${2:-sources}"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo -e "${RED}Error: Source directory '$SOURCE_DIR' does not exist${NC}"
  echo "Usage: ./batch-convert-pdfs.sh [source-directory] [output-base-directory]"
  echo "Example: ./batch-convert-pdfs.sh sources/raw sources"
  exit 1
fi

# Check if docling is installed
if ! command -v docling &> /dev/null; then
  echo -e "${RED}Error: docling is not installed${NC}"
  echo "Install with: pip install docling"
  exit 1
fi

# Count PDFs
PDF_COUNT=$(find "$SOURCE_DIR" -name "*.pdf" -type f | wc -l | tr -d ' ')

if [ "$PDF_COUNT" -eq 0 ]; then
  echo -e "${YELLOW}No PDF files found in $SOURCE_DIR${NC}"
  exit 0
fi

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Batch PDF Conversion                                     ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Source directory: $SOURCE_DIR"
echo "Output directory: $OUTPUT_BASE"
echo "PDFs to convert: $PDF_COUNT"
echo ""

# Function to determine category from filename
determine_category() {
  local filename=$(basename "$1" .pdf | tr '[:upper:]' '[:lower:]')
  
  if [[ "$filename" == *"gartner"* ]]; then
    echo "Gartner"
  elif [[ "$filename" == *"forrester"* ]]; then
    echo "Forrester"
  elif [[ "$filename" == *"idc"* ]]; then
    echo "IDC"
  elif [[ "$filename" == *"aws"* ]] || [[ "$filename" == *"amazon"* ]]; then
    echo "Hyperscalers/AWS"
  elif [[ "$filename" == *"azure"* ]] || [[ "$filename" == *"microsoft"* ]]; then
    echo "Hyperscalers/Azure"
  elif [[ "$filename" == *"gcp"* ]] || [[ "$filename" == *"google"* ]]; then
    echo "Hyperscalers/GCP"
  elif [[ "$filename" == *"kong"* ]]; then
    echo "Competitors/Kong"
  elif [[ "$filename" == *"apigee"* ]]; then
    echo "Competitors/Apigee"
  elif [[ "$filename" == *"mulesoft"* ]]; then
    echo "Competitors/MuleSoft"
  else
    echo "Other"
  fi
}

# Statistics
CONVERTED=0
FAILED=0
SKIPPED=0

# Convert all PDFs
for pdf in "$SOURCE_DIR"/*.pdf; do
  if [ -f "$pdf" ]; then
    filename=$(basename "$pdf" .pdf)
    category=$(determine_category "$pdf")
    
    # Create output directory
    output_dir="$OUTPUT_BASE/$category"
    mkdir -p "$output_dir"

    output_file="$output_dir/$filename.md"

    # Check if already converted
    if [ -f "$output_file" ]; then
      echo -e "${YELLOW}⊘${NC} Skipping (already exists): $filename → $category/"
      SKIPPED=$((SKIPPED + 1))
      continue
    fi

    # Clean up stale directory left by a previous failed docling run
    if [ -d "$output_file" ]; then
      echo -e "${YELLOW}⚠${NC} Removing stale directory: $output_file"
      rm -rf "$output_file"
    fi

    # Convert with docling — pass the output directory; docling places <filename>.md inside it
    echo -e "${BLUE}→${NC} Converting: $filename → $category/"

    if docling "$pdf" --output "$output_dir" --image-export-mode placeholder 2>/dev/null; then
      # docling may produce <filename>.md or <filename>/<filename>.md depending on version
      if [ -f "$output_file" ]; then
        generated_file="$output_file"
      elif [ -f "$output_dir/$filename/$filename.md" ]; then
        # flatten: move the nested file up
        mv "$output_dir/$filename/$filename.md" "$output_file"
        rm -rf "$output_dir/$filename"
        generated_file="$output_file"
      else
        generated_file=$(find "$output_dir" -name "$filename.md" | head -1)
      fi

      if [ -n "$generated_file" ]; then
        echo -e "${GREEN}✓${NC} Converted: $filename"
        CONVERTED=$((CONVERTED + 1))

        # Add metadata to the file
        cat >> "$generated_file" << EOF

---
metadata:
  source_file: $pdf
  converted_date: $(date +%Y-%m-%d)
  category: $category
---
EOF
      else
        echo -e "${RED}✗${NC} Failed (output not found): $filename"
        FAILED=$((FAILED + 1))
      fi
    else
      echo -e "${RED}✗${NC} Failed: $filename"
      FAILED=$((FAILED + 1))
    fi
    
    echo ""
  fi
done

# Print summary
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Conversion Summary                                       ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Total PDFs found:    $PDF_COUNT"
echo -e "${GREEN}Successfully converted: $CONVERTED${NC}"
echo -e "${YELLOW}Skipped (existing):     $SKIPPED${NC}"
echo -e "${RED}Failed:                 $FAILED${NC}"
echo ""

if [ $CONVERTED -gt 0 ]; then
  echo "Converted files are organized in:"
  find "$OUTPUT_BASE" -name "*.md" -type f -newer "$SOURCE_DIR" 2>/dev/null | head -10 | while read file; do
    echo "  - $file"
  done
  
  if [ $CONVERTED -gt 10 ]; then
    echo "  ... and $((CONVERTED - 10)) more"
  fi
  echo ""
fi

if [ $FAILED -gt 0 ]; then
  echo -e "${YELLOW}Note: Some conversions failed. Check the error messages above.${NC}"
  echo "Common issues:"
  echo "  - Corrupted PDF files"
  echo "  - Password-protected PDFs"
  echo "  - Insufficient memory for large files"
  echo ""
fi

echo "Next steps:"
echo "  1. Review converted files in $OUTPUT_BASE"
echo "  2. Update source indexes with: ./update-source-index.sh"
echo "  3. Start your research analysis"
echo ""

# Made with Bob
