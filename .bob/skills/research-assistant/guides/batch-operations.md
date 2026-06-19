# Batch Operations Guide

This guide explains how to perform bulk operations efficiently: converting multiple documents, scraping multiple URLs, generating multiple reports, and updating multiple projects.

## Overview

Batch operations enable you to:
- **Save Time**: Process multiple items at once
- **Ensure Consistency**: Apply same operations uniformly
- **Automate Workflows**: Reduce manual repetition
- **Scale Research**: Handle large volumes of sources

## Batch Document Conversion

### Convert Multiple PDFs

```bash
#!/bin/bash
# batch-convert-pdfs.sh

SOURCE_DIR="sources/raw"
OUTPUT_BASE="sources"

# Convert all PDFs in raw directory
for pdf in "$SOURCE_DIR"/*.pdf; do
  if [ -f "$pdf" ]; then
    filename=$(basename "$pdf" .pdf)
    
    # Determine category from filename
    if [[ "$filename" == *"gartner"* ]]; then
      category="gartner"
    elif [[ "$filename" == *"forrester"* ]]; then
      category="forrester"
    elif [[ "$filename" == *"idc"* ]]; then
      category="idc"
    else
      category="other"
    fi
    
    # Create output directory
    mkdir -p "$OUTPUT_BASE/$category"
    
    # Convert with docling
    echo "Converting: $filename → $category/"
    docling "$pdf" \
      --output "$OUTPUT_BASE/$category/$filename.md" \
      --no-images
    
    if [ $? -eq 0 ]; then
      echo "✓ Converted: $filename"
    else
      echo "✗ Failed: $filename"
    fi
  fi
done

echo ""
echo "Batch conversion complete"
```

### Convert with Metadata

```bash
#!/bin/bash
# batch-convert-with-metadata.sh

SOURCE_DIR="sources/raw"
OUTPUT_BASE="sources"
METADATA_FILE="source-metadata.csv"

# Read metadata from CSV
# Format: filename,category,author,title,date
while IFS=',' read -r filename category author title date; do
  # Skip header
  if [ "$filename" = "filename" ]; then
    continue
  fi
  
  pdf_path="$SOURCE_DIR/$filename.pdf"
  
  if [ -f "$pdf_path" ]; then
    mkdir -p "$OUTPUT_BASE/$category"
    output_file="$OUTPUT_BASE/$category/$filename.md"
    
    # Convert document
    echo "Converting: $filename"
    docling "$pdf_path" --output "$output_file" --no-images
    
    # Add metadata
    cat >> "$output_file" << EOF

---
citation:
  id: $(echo "$filename" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
  type: analyst_report
  author: "$author"
  title: "$title"
  date: $date
  source: $pdf_path
---
EOF
    
    echo "✓ Converted with metadata: $filename"
  else
    echo "✗ File not found: $pdf_path"
  fi
done < "$METADATA_FILE"

echo ""
echo "Batch conversion with metadata complete"
```

### Parallel Conversion

```bash
#!/bin/bash
# parallel-convert.sh

SOURCE_DIR="sources/raw"
OUTPUT_BASE="sources"
MAX_PARALLEL=4

# Function to convert single PDF
convert_pdf() {
  pdf="$1"
  filename=$(basename "$pdf" .pdf)
  category=$(determine_category "$filename")
  
  mkdir -p "$OUTPUT_BASE/$category"
  
  docling "$pdf" \
    --output "$OUTPUT_BASE/$category/$filename.md" \
    --no-images
  
  echo "✓ Converted: $filename"
}

export -f convert_pdf
export OUTPUT_BASE

# Convert in parallel
find "$SOURCE_DIR" -name "*.pdf" | \
  xargs -P "$MAX_PARALLEL" -I {} bash -c 'convert_pdf "{}"'

echo "Parallel conversion complete"
```

## Batch Web Scraping

### Scrape Multiple URLs

```bash
#!/bin/bash
# batch-scrape-urls.sh

URL_FILE="urls-to-scrape.txt"
OUTPUT_DIR="sources/web"
DATE=$(date +%Y-%m-%d)

mkdir -p "$OUTPUT_DIR"

# Read URLs from file
while IFS= read -r url; do
  # Skip empty lines and comments
  if [ -z "$url" ] || [[ "$url" == \#* ]]; then
    continue
  fi
  
  # Generate filename from URL
  filename=$(echo "$url" | \
    sed 's|https\?://||' | \
    sed 's|/|-|g' | \
    sed 's|[^a-zA-Z0-9-]||g')
  
  output_file="$OUTPUT_DIR/${DATE}-${filename}.md"
  
  echo "Scraping: $url"
  crwl crawl "$url" --output markdown --output-file "$output_file"
  
  if [ $? -eq 0 ]; then
    echo "✓ Scraped: $filename"
  else
    echo "✗ Failed: $url"
  fi
  
  # Rate limiting
  sleep 2
done < "$URL_FILE"

echo ""
echo "Batch scraping complete"
```

### Scrape with Categories

```bash
#!/bin/bash
# batch-scrape-categorized.sh

# URLs organized by category
declare -A URLS

URLS[kong]="
https://konghq.com/products/kong-gateway/features
https://konghq.com/products/kong-gateway/architecture
https://konghq.com/pricing
"

URLS[apigee]="
https://cloud.google.com/apigee/docs/api-platform/get-started/overview
https://cloud.google.com/apigee/docs/api-platform/fundamentals/capabilities
https://cloud.google.com/apigee/pricing
"

URLS[aws]="
https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html
https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-basic-concept.html
https://aws.amazon.com/api-gateway/pricing/
"

DATE=$(date +%Y-%m-%d)

# Scrape each category
for category in "${!URLS[@]}"; do
  echo "Scraping category: $category"
  mkdir -p "sources/vendor-docs/$category"
  
  for url in ${URLS[$category]}; do
    # Generate filename
    page=$(echo "$url" | sed 's|.*/||' | sed 's|\.html||')
    output_file="sources/vendor-docs/$category/${DATE}-${page}.md"
    
    echo "  Scraping: $url"
    crwl crawl "$url" --output markdown --output-file "$output_file"
    
    if [ $? -eq 0 ]; then
      echo "  ✓ Scraped: $page"
    else
      echo "  ✗ Failed: $url"
    fi
    
    sleep 2
  done
  
  echo ""
done

echo "Categorized scraping complete"
```

### Scrape with Link Discovery

```bash
#!/bin/bash
# batch-scrape-with-discovery.sh

SEED_URL="$1"
OUTPUT_DIR="sources/web"
MAX_DEPTH=2
VISITED_FILE=".visited_urls"

mkdir -p "$OUTPUT_DIR"
touch "$VISITED_FILE"

scrape_recursive() {
  local url="$1"
  local depth="$2"
  
  # Check if already visited
  if grep -q "^$url$" "$VISITED_FILE"; then
    return
  fi
  
  # Check depth limit
  if [ "$depth" -gt "$MAX_DEPTH" ]; then
    return
  fi
  
  echo "Scraping (depth $depth): $url"
  
  # Generate filename
  filename=$(echo "$url" | sed 's|https\?://||' | sed 's|/|-|g' | sed 's|[^a-zA-Z0-9-]||g')
  output_file="$OUTPUT_DIR/$(date +%Y-%m-%d)-${filename}.md"
  
  # Scrape page
  crwl crawl "$url" --output markdown --output-file "$output_file"
  
  # Mark as visited
  echo "$url" >> "$VISITED_FILE"
  
  # Extract links and scrape them
  if [ -f "$output_file" ]; then
    grep -o 'https\?://[^"]*' "$output_file" | \
      grep "$(echo "$url" | sed 's|/.*||')" | \
      head -5 | \
      while read -r link; do
        sleep 2
        scrape_recursive "$link" $((depth + 1))
      done
  fi
}

# Start recursive scraping
scrape_recursive "$SEED_URL" 0

echo ""
echo "Recursive scraping complete"
rm "$VISITED_FILE"
```

## Batch Report Generation

### Generate Multiple Report Formats

```bash
#!/bin/bash
# batch-generate-reports.sh

SOURCE_FILE="research/api-management-trends-2024/report.md"
OUTPUT_DIR="research/api-management-trends-2024/output"

mkdir -p "$OUTPUT_DIR"

# Generate Word document
echo "Generating Word document..."
pandoc "$SOURCE_FILE" \
  -o "$OUTPUT_DIR/report.docx" \
  --reference-doc=templates/report-template.docx

# Generate PDF
echo "Generating PDF..."
pandoc "$SOURCE_FILE" \
  -o "$OUTPUT_DIR/report.pdf" \
  --pdf-engine=xelatex \
  -V geometry:margin=1in

# Generate HTML
echo "Generating HTML..."
pandoc "$SOURCE_FILE" \
  -o "$OUTPUT_DIR/report.html" \
  --standalone \
  --css=templates/report-style.css

# Generate presentation
echo "Generating presentation..."
pandoc "$SOURCE_FILE" \
  -o "$OUTPUT_DIR/presentation.pptx" \
  --reference-doc=templates/presentation-template.pptx

echo ""
echo "✓ All formats generated in $OUTPUT_DIR"
```

### Generate Reports for Multiple Projects

```bash
#!/bin/bash
# batch-generate-project-reports.sh

PROJECTS_DIR="research"
OUTPUT_BASE="output"

# Find all projects with report.md
find "$PROJECTS_DIR" -name "report.md" | while read -r report; do
  project_dir=$(dirname "$report")
  project_name=$(basename "$project_dir")
  output_dir="$OUTPUT_BASE/$project_name"
  
  mkdir -p "$output_dir"
  
  echo "Generating reports for: $project_name"
  
  # Generate Word
  pandoc "$report" -o "$output_dir/report.docx"
  
  # Generate PDF
  pandoc "$report" -o "$output_dir/report.pdf" --pdf-engine=xelatex
  
  echo "✓ Generated: $project_name"
done

echo ""
echo "All project reports generated"
```

## Batch Project Updates

### Update Source Indexes

```bash
#!/bin/bash
# batch-update-indexes.sh

PROJECTS_DIR="research"

# Update index for each project
find "$PROJECTS_DIR" -type d -name "sources" | while read -r sources_dir; do
  project_dir=$(dirname "$sources_dir")
  project_name=$(basename "$project_dir")
  
  echo "Updating index for: $project_name"
  
  # Count sources
  total=$(find "$sources_dir" -name "*.md" -type f | wc -l)
  
  # Update index
  cat > "$sources_dir/index.md" << EOF
# Sources Index - $project_name

**Last Updated**: $(date +%Y-%m-%d)
**Total Sources**: $total

## Sources by Category

EOF
  
  # List sources by category
  for category_dir in "$sources_dir"/*; do
    if [ -d "$category_dir" ]; then
      category=$(basename "$category_dir")
      count=$(find "$category_dir" -name "*.md" -type f | wc -l)
      
      echo "### $category ($count)" >> "$sources_dir/index.md"
      echo "" >> "$sources_dir/index.md"
      
      find "$category_dir" -name "*.md" -type f | while read -r file; do
        filename=$(basename "$file")
        echo "- [$filename]($category/$filename)" >> "$sources_dir/index.md"
      done
      
      echo "" >> "$sources_dir/index.md"
    fi
  done
  
  echo "✓ Updated: $project_name"
done

echo ""
echo "All indexes updated"
```

### Refresh Web Content

```bash
#!/bin/bash
# batch-refresh-web-content.sh

SOURCES_DIR="sources/web"
REFRESH_AGE=30  # Days

# Find web content older than REFRESH_AGE days
find "$SOURCES_DIR" -name "*.md" -type f -mtime +$REFRESH_AGE | while read -r file; do
  # Extract URL from file metadata
  url=$(grep "^url:" "$file" | cut -d' ' -f2)
  
  if [ -n "$url" ]; then
    echo "Refreshing: $url"
    
    # Backup old version
    mv "$file" "${file}.old"
    
    # Scrape fresh content
    crwl crawl "$url" --output markdown --output-file "$file"
    
    if [ $? -eq 0 ]; then
      echo "✓ Refreshed: $(basename "$file")"
      rm "${file}.old"
    else
      echo "✗ Failed, restoring old version"
      mv "${file}.old" "$file"
    fi
    
    sleep 2
  fi
done

echo ""
echo "Web content refresh complete"
```

## Batch Validation

### Validate Multiple Projects

```bash
#!/bin/bash
# batch-validate-projects.sh

PROJECTS_DIR="research"

echo "# Project Validation Report"
echo "**Generated**: $(date +%Y-%m-%d)"
echo ""

find "$PROJECTS_DIR" -type d -maxdepth 1 -mindepth 1 | while read -r project_dir; do
  project_name=$(basename "$project_dir")
  
  echo "## $project_name"
  echo ""
  
  # Check required files
  if [ -f "$project_dir/README.md" ]; then
    echo "✓ README.md exists"
  else
    echo "✗ README.md missing"
  fi
  
  if [ -d "$project_dir/sources" ]; then
    source_count=$(find "$project_dir/sources" -name "*.md" -type f | wc -l)
    echo "✓ Sources directory exists ($source_count files)"
  else
    echo "✗ Sources directory missing"
  fi
  
  if [ -f "$project_dir/report.md" ]; then
    echo "✓ Report exists"
  else
    echo "⚠ Report not yet created"
  fi
  
  echo ""
done
```

### Validate Citations

```bash
#!/bin/bash
# batch-validate-citations.sh

PROJECTS_DIR="research"

find "$PROJECTS_DIR" -name "*.md" -type f | while read -r file; do
  # Extract citation IDs
  citations=$(grep -o '\[[-a-z0-9]*-[0-9]*\]' "$file" | tr -d '[]' | sort -u)
  
  if [ -n "$citations" ]; then
    echo "Validating: $file"
    
    missing=0
    for citation in $citations; do
      # Check if citation exists in sources
      if ! grep -q "id: $citation" sources/**/*.md 2>/dev/null; then
        echo "  ✗ Missing citation: $citation"
        ((missing++))
      fi
    done
    
    if [ $missing -eq 0 ]; then
      echo "  ✓ All citations valid"
    fi
  fi
done
```

## Advanced Batch Operations

### Parallel Processing

```bash
#!/bin/bash
# parallel-batch-process.sh

MAX_PARALLEL=4

# Function to process single item
process_item() {
  item="$1"
  echo "Processing: $item"
  # Do work...
  sleep 1
  echo "✓ Completed: $item"
}

export -f process_item

# Process items in parallel
cat items.txt | xargs -P "$MAX_PARALLEL" -I {} bash -c 'process_item "{}"'
```

### Conditional Batch Operations

```bash
#!/bin/bash
# conditional-batch-convert.sh

SOURCE_DIR="sources/raw"
OUTPUT_DIR="sources/converted"

for pdf in "$SOURCE_DIR"/*.pdf; do
  filename=$(basename "$pdf" .pdf)
  output_file="$OUTPUT_DIR/$filename.md"
  
  # Only convert if output doesn't exist or is older than source
  if [ ! -f "$output_file" ] || [ "$pdf" -nt "$output_file" ]; then
    echo "Converting: $filename (new or updated)"
    docling "$pdf" --output "$output_file" --no-images
  else
    echo "Skipping: $filename (already converted)"
  fi
done
```

### Batch with Progress Tracking

```bash
#!/bin/bash
# batch-with-progress.sh

ITEMS=("item1" "item2" "item3" "item4" "item5")
TOTAL=${#ITEMS[@]}
CURRENT=0

for item in "${ITEMS[@]}"; do
  ((CURRENT++))
  PERCENT=$((CURRENT * 100 / TOTAL))
  
  echo "[$CURRENT/$TOTAL - $PERCENT%] Processing: $item"
  
  # Do work...
  sleep 1
  
  echo "✓ Completed: $item"
done

echo ""
echo "✓ All items processed"
```

## Batch Operation Templates

### Template: Batch Conversion

```bash
#!/bin/bash
# template-batch-convert.sh

SOURCE_DIR="path/to/sources"
OUTPUT_DIR="path/to/output"
FILE_PATTERN="*.pdf"

mkdir -p "$OUTPUT_DIR"

for file in "$SOURCE_DIR"/$FILE_PATTERN; do
  if [ -f "$file" ]; then
    filename=$(basename "$file" .pdf)
    output_file="$OUTPUT_DIR/$filename.md"
    
    echo "Converting: $filename"
    # Add conversion command here
    
    if [ $? -eq 0 ]; then
      echo "✓ Success: $filename"
    else
      echo "✗ Failed: $filename"
    fi
  fi
done

echo "Batch conversion complete"
```

### Template: Batch Scraping

```bash
#!/bin/bash
# template-batch-scrape.sh

URL_FILE="urls.txt"
OUTPUT_DIR="output"
RATE_LIMIT=2  # seconds between requests

mkdir -p "$OUTPUT_DIR"

while IFS= read -r url; do
  if [ -n "$url" ] && [[ ! "$url" == \#* ]]; then
    filename=$(echo "$url" | sed 's|https\?://||' | sed 's|/|-|g')
    output_file="$OUTPUT_DIR/$filename.md"
    
    echo "Scraping: $url"
    # Add scraping command here
    
    sleep "$RATE_LIMIT"
  fi
done < "$URL_FILE"

echo "Batch scraping complete"
```

## Best Practices

### 1. Error Handling

```bash
# Check for errors and continue
for file in *.pdf; do
  if docling "$file" --output "${file%.pdf}.md"; then
    echo "✓ $file"
  else
    echo "✗ $file" >> errors.log
  fi
done
```

### 2. Progress Tracking

```bash
# Show progress
total=$(ls *.pdf | wc -l)
current=0

for file in *.pdf; do
  ((current++))
  echo "[$current/$total] Processing: $file"
  # Process file...
done
```

### 3. Rate Limiting

```bash
# Respect rate limits when scraping
for url in "${urls[@]}"; do
  crwl crawl "$url" --output markdown --output-file "output.md"
  sleep 2  # Wait between requests
done
```

### 4. Logging

```bash
# Log all operations
LOG_FILE="batch-operations.log"

{
  echo "=== Batch Operation Started: $(date) ==="
  for file in *.pdf; do
    echo "Processing: $file"
    # Process file...
  done
  echo "=== Batch Operation Completed: $(date) ==="
} | tee -a "$LOG_FILE"
```

### 5. Dry Run Mode

```bash
# Test before executing
DRY_RUN=true

for file in *.pdf; do
  if [ "$DRY_RUN" = true ]; then
    echo "Would convert: $file"
  else
    docling "$file" --output "${file%.pdf}.md"
  fi
done
```

## Related Documentation

- [Common Commands Guide](common-commands.md) - Individual command patterns
- [Source Organization Guide](source-organization.md) - Organizing batch results
- [Project Initialization Guide](project-initialization.md) - Setting up batch workflows

## Summary

Effective batch operations:
- Process multiple items efficiently
- Maintain consistency across operations
- Include error handling and logging
- Respect rate limits and resources
- Provide progress feedback

Use batch operations to scale your research workflows and handle large volumes of sources systematically.