# Web Scraping Versioning Strategy

## Overview

When tracking competitor messaging, pricing changes, or documentation updates over time, maintain versioned snapshots using **date-based filenames**. This enables historical analysis, change detection, and trend identification.

## Standard Approach: Date-Based Filenames

**Format**: `{page-name}-{YYYY-MM-DD}.md`

**Example Structure**:
```
sources/Competitors/Kong/
├── features-2024-06-12.md
├── features-2024-06-12.json          # metadata
├── features-2024-09-15.md
├── features-2024-09-15.json
├── features-2024-12-01.md
├── features-2024-12-01.json
├── pricing-2024-06-12.md
├── pricing-2024-06-12.json
├── pricing-2024-09-15.md
└── pricing-2024-09-15.json
```

**Why This Approach?**
- ✅ Simple and universal (works with or without Git)
- ✅ Clear chronological ordering
- ✅ Easy to identify latest version
- ✅ Simple to compare versions
- ✅ Works well with all file systems
- ✅ Easy to script and automate
- ✅ Natural sorting by date

## Implementation

### Basic Scraping with Date

```bash
# Scrape with date in filename
DATE=$(date +%Y-%m-%d)
crawl4ai https://konghq.com/products/api-gateway \
  --output "sources/Competitors/Kong/features-${DATE}.md"
```

### Scraping with Metadata

**Recommended**: Always create a metadata file alongside the content

```bash
#!/bin/bash
# scrape-with-version.sh

URL=$1
COMPANY=$2
PAGE=$3
DATE=$(date +%Y-%m-%d)

OUTPUT_DIR="sources/Competitors/${COMPANY}"
OUTPUT_FILE="${OUTPUT_DIR}/${PAGE}-${DATE}.md"
METADATA_FILE="${OUTPUT_DIR}/${PAGE}-${DATE}.json"

mkdir -p "$OUTPUT_DIR"

# Scrape content
echo "Scraping ${COMPANY} ${PAGE}..."
crawl4ai "$URL" --output "$OUTPUT_FILE"

# Create metadata
cat > "$METADATA_FILE" << EOF
{
  "scraped_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "url": "$URL",
  "company": "$COMPANY",
  "page": "$PAGE",
  "file_size_bytes": $(stat -f%z "$OUTPUT_FILE" 2>/dev/null || stat -c%s "$OUTPUT_FILE"),
  "word_count": $(wc -w < "$OUTPUT_FILE"),
  "content_hash": "$(shasum -a 256 "$OUTPUT_FILE" | cut -d' ' -f1)"
}
EOF

echo "✓ Scraped: $OUTPUT_FILE"
echo "✓ Metadata: $METADATA_FILE"
```

**Usage**:
```bash
./scrape-with-version.sh \
  "https://konghq.com/products/api-gateway" \
  "Kong" \
  "features"
```

## Metadata Format

### Essential Metadata

Every scraped version should include a `.json` file with:

```json
{
  "scraped_at": "2024-06-12T14:30:00Z",
  "url": "https://konghq.com/products/api-gateway",
  "company": "Kong",
  "page": "features",
  "file_size_bytes": 45678,
  "word_count": 3421,
  "content_hash": "sha256:abc123..."
}
```

### Extended Metadata (Optional)

For advanced tracking:

```json
{
  "scraped_at": "2024-06-12T14:30:00Z",
  "url": "https://konghq.com/products/api-gateway",
  "company": "Kong",
  "page": "features",
  "file_size_bytes": 45678,
  "word_count": 3421,
  "content_hash": "sha256:abc123...",
  "previous_version": "2024-09-15",
  "changes_detected": true,
  "change_summary": "Added 3 new features, updated pricing section",
  "tags": ["api-gateway", "enterprise", "pricing-update"]
}
```

## Finding Versions

### Get Latest Version

```bash
# Find latest version of a page
LATEST=$(ls -t sources/Competitors/Kong/features-*.md | head -1)
echo "Latest: $LATEST"
```

### Get Previous Version

```bash
# Find previous version for comparison
PREVIOUS=$(ls -t sources/Competitors/Kong/features-*.md | head -2 | tail -1)
echo "Previous: $PREVIOUS"
```

### List All Versions

```bash
# List all versions chronologically
ls -t sources/Competitors/Kong/features-*.md

# Or in ascending order
ls sources/Competitors/Kong/features-*.md | sort
```

### Get Version by Date

```bash
# Get specific date version
DATE="2024-09-15"
FILE="sources/Competitors/Kong/features-${DATE}.md"
if [ -f "$FILE" ]; then
  echo "Found: $FILE"
else
  echo "No version from $DATE"
fi
```

## Change Detection

### Compare Two Versions

```bash
# Simple diff
diff sources/Competitors/Kong/features-2024-06-12.md \
     sources/Competitors/Kong/features-2024-09-15.md

# Side-by-side comparison
diff -y sources/Competitors/Kong/features-2024-06-12.md \
        sources/Competitors/Kong/features-2024-09-15.md | less

# Unified diff with context
diff -u sources/Competitors/Kong/features-2024-06-12.md \
        sources/Competitors/Kong/features-2024-09-15.md > changes.diff
```

### Automated Change Detection

```bash
#!/bin/bash
# detect-changes.sh

COMPANY=$1
PAGE=$2

# Get latest two versions
LATEST=$(ls -t sources/Competitors/${COMPANY}/${PAGE}-*.md | head -1)
PREVIOUS=$(ls -t sources/Competitors/${COMPANY}/${PAGE}-*.md | head -2 | tail -1)

if [ -z "$PREVIOUS" ]; then
  echo "No previous version found for comparison"
  exit 0
fi

echo "Comparing versions:"
echo "  Previous: $(basename $PREVIOUS)"
echo "  Latest:   $(basename $LATEST)"
echo ""

# Calculate changes
LINES_ADDED=$(diff "$PREVIOUS" "$LATEST" | grep '^>' | wc -l)
LINES_REMOVED=$(diff "$PREVIOUS" "$LATEST" | grep '^<' | wc -l)
LINES_CHANGED=$((LINES_ADDED + LINES_REMOVED))

echo "Changes detected:"
echo "  Lines added:   $LINES_ADDED"
echo "  Lines removed: $LINES_REMOVED"
echo "  Total changes: $LINES_CHANGED"

if [ $LINES_CHANGED -gt 0 ]; then
  echo ""
  echo "Significant sections changed:"
  diff "$PREVIOUS" "$LATEST" | grep -E '^[<>].*##' | head -10
fi
```

**Usage**:
```bash
./detect-changes.sh Kong features
```

### Extract Key Changes

```bash
#!/bin/bash
# analyze-changes.sh

COMPANY=$1
PAGE=$2
LATEST=$(ls -t sources/Competitors/${COMPANY}/${PAGE}-*.md | head -1)
PREVIOUS=$(ls -t sources/Competitors/${COMPANY}/${PAGE}-*.md | head -2 | tail -1)

echo "# Change Analysis Report"
echo "Company: $COMPANY"
echo "Page: $PAGE"
echo "Generated: $(date)"
echo ""

# Pricing changes
echo "## Pricing Changes"
diff "$PREVIOUS" "$LATEST" | grep -i 'price\|pricing\|cost\|\$' | head -10
echo ""

# Feature changes
echo "## Feature Changes"
diff "$PREVIOUS" "$LATEST" | grep -i 'feature\|capability\|support' | head -10
echo ""

# New sections
echo "## New Sections"
diff "$PREVIOUS" "$LATEST" | grep '^>' | grep '##' | sed 's/^> //'
echo ""

# Removed sections
echo "## Removed Sections"
diff "$PREVIOUS" "$LATEST" | grep '^<' | grep '##' | sed 's/^< //'
```

## Workflow Examples

### Example 1: Monthly Competitive Monitoring

**Scenario**: Track Kong's features page monthly to detect messaging changes

```bash
#!/bin/bash
# monthly-scrape.sh

COMPANY="Kong"
PAGE="features"
URL="https://konghq.com/products/api-gateway"
DATE=$(date +%Y-%m-%d)
OUTPUT_DIR="sources/Competitors/${COMPANY}"
OUTPUT_FILE="${OUTPUT_DIR}/${PAGE}-${DATE}.md"
METADATA_FILE="${OUTPUT_DIR}/${PAGE}-${DATE}.json"

mkdir -p "$OUTPUT_DIR"

# Scrape current version
echo "Scraping ${COMPANY} ${PAGE} page..."
crawl4ai "$URL" --output "$OUTPUT_FILE"

# Create metadata
cat > "$METADATA_FILE" << EOF
{
  "scraped_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "url": "$URL",
  "company": "$COMPANY",
  "page": "$PAGE",
  "scrape_frequency": "monthly"
}
EOF

# Detect changes
PREVIOUS=$(ls -t ${OUTPUT_DIR}/${PAGE}-*.md | head -2 | tail -1)
if [ -n "$PREVIOUS" ] && [ "$PREVIOUS" != "$OUTPUT_FILE" ]; then
  echo ""
  echo "Comparing with previous version: $(basename $PREVIOUS)"
  
  CHANGES=$(diff "$PREVIOUS" "$OUTPUT_FILE" | wc -l)
  echo "Total changes: $CHANGES lines"
  
  if [ $CHANGES -gt 50 ]; then
    echo "⚠️  Significant changes detected!"
    diff -u "$PREVIOUS" "$OUTPUT_FILE" > "${OUTPUT_DIR}/changes-${DATE}.diff"
    echo "Saved diff to: ${OUTPUT_DIR}/changes-${DATE}.diff"
  fi
fi

echo "✓ Scrape complete: $OUTPUT_FILE"
```

**Schedule with cron**:
```cron
# Run on the 1st of each month at 9 AM
0 9 1 * * /path/to/monthly-scrape.sh
```

### Example 2: Pricing Change Tracking

**Scenario**: Monitor competitor pricing pages weekly

```bash
#!/bin/bash
# track-pricing.sh

COMPETITORS=("Kong" "Apigee" "MuleSoft")
DATE=$(date +%Y-%m-%d)

# Company URLs (in practice, use a config file)
declare -A URLS=(
  ["Kong"]="https://konghq.com/pricing"
  ["Apigee"]="https://cloud.google.com/apigee/pricing"
  ["MuleSoft"]="https://www.mulesoft.com/platform/pricing"
)

for COMPANY in "${COMPETITORS[@]}"; do
  echo "Tracking ${COMPANY} pricing..."
  
  URL="${URLS[$COMPANY]}"
  OUTPUT_DIR="sources/Competitors/${COMPANY}"
  OUTPUT_FILE="${OUTPUT_DIR}/pricing-${DATE}.md"
  
  mkdir -p "$OUTPUT_DIR"
  
  # Scrape
  crawl4ai "$URL" --output "$OUTPUT_FILE"
  
  # Extract pricing information
  grep -i '\$\|price\|tier\|plan' "$OUTPUT_FILE" > "${OUTPUT_DIR}/pricing-extract-${DATE}.txt"
  
  # Compare with previous
  PREVIOUS=$(ls -t ${OUTPUT_DIR}/pricing-*.md | head -2 | tail -1)
  if [ -n "$PREVIOUS" ] && [ "$PREVIOUS" != "$OUTPUT_FILE" ]; then
    diff "$PREVIOUS" "$OUTPUT_FILE" | grep -i '\$\|price' > "${OUTPUT_DIR}/pricing-changes-${DATE}.txt"
    
    if [ -s "${OUTPUT_DIR}/pricing-changes-${DATE}.txt" ]; then
      echo "⚠️  ${COMPANY} pricing changes detected!"
      cat "${OUTPUT_DIR}/pricing-changes-${DATE}.txt"
    fi
  fi
done

echo "✓ Pricing tracking complete"
```

### Example 3: Documentation Version Tracking

**Scenario**: Track AWS Lambda documentation updates

```bash
#!/bin/bash
# track-docs.sh

SERVICE="Lambda"
PROVIDER="AWS"
DATE=$(date +%Y-%m-%d)
BASE_DIR="sources/Hyperscalers/${PROVIDER}/${SERVICE}"

# Key documentation pages
declare -A PAGES=(
  ["introduction"]="https://docs.aws.amazon.com/lambda/latest/dg/welcome.html"
  ["best-practices"]="https://docs.aws.amazon.com/lambda/latest/dg/best-practices.html"
  ["pricing"]="https://aws.amazon.com/lambda/pricing/"
)

mkdir -p "$BASE_DIR"

for PAGE in "${!PAGES[@]}"; do
  URL="${PAGES[$PAGE]}"
  OUTPUT_FILE="${BASE_DIR}/${PAGE}-${DATE}.md"
  
  echo "Scraping ${PAGE}..."
  crawl4ai "$URL" --output "$OUTPUT_FILE"
  
  # Check for changes
  PREVIOUS=$(ls -t ${BASE_DIR}/${PAGE}-*.md 2>/dev/null | head -2 | tail -1)
  if [ -n "$PREVIOUS" ] && [ "$PREVIOUS" != "$OUTPUT_FILE" ]; then
    CHANGES=$(diff "$PREVIOUS" "$OUTPUT_FILE" | wc -l)
    if [ $CHANGES -gt 10 ]; then
      echo "  ⚠️  ${CHANGES} lines changed in ${PAGE}"
      diff -u "$PREVIOUS" "$OUTPUT_FILE" > "${BASE_DIR}/${PAGE}-changes-${DATE}.diff"
    else
      echo "  ✓ No significant changes"
    fi
  fi
done

echo "✓ Documentation tracking complete"
```

## Analysis Workflows

### Trend Analysis

**Identify Messaging Evolution**:
```bash
# Extract all feature headings over time
for file in sources/Competitors/Kong/features-*.md; do
  DATE=$(basename "$file" | grep -o '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}')
  echo "=== $DATE ==="
  grep '^##' "$file"
  echo ""
done > kong-features-evolution.txt
```

### Pricing History

**Track Pricing Changes Over Time**:
```bash
# Extract pricing information over time
for file in sources/Competitors/*/pricing-*.md; do
  COMPANY=$(echo "$file" | cut -d'/' -f3)
  DATE=$(basename "$file" | grep -o '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}')
  echo "=== $COMPANY - $DATE ==="
  grep -i '\$[0-9]' "$file" | head -5
  echo ""
done > pricing-history.txt
```

### Competitive Comparison

**Compare Latest Versions Across Competitors**:
```bash
# Compare latest versions
DATE=$(date +%Y-%m-%d)
echo "# Competitive Feature Comparison - $DATE" > comparison.md
echo "" >> comparison.md

for COMPANY in Kong Apigee MuleSoft; do
  LATEST=$(ls -t sources/Competitors/${COMPANY}/features-*.md | head -1)
  if [ -f "$LATEST" ]; then
    echo "## $COMPANY" >> comparison.md
    grep '^###' "$LATEST" >> comparison.md
    echo "" >> comparison.md
  fi
done
```

### Generate Timeline Report

```bash
#!/bin/bash
# timeline-report.sh

COMPANY=$1
PAGE=$2

echo "# ${COMPANY} ${PAGE} Timeline"
echo ""
echo "| Date | File Size | Word Count | Changes |"
echo "|------|-----------|------------|---------|"

PREV_FILE=""
for file in $(ls sources/Competitors/${COMPANY}/${PAGE}-*.md | sort); do
  DATE=$(basename "$file" | grep -o '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}')
  SIZE=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file")
  WORDS=$(wc -w < "$file")
  
  if [ -n "$PREV_FILE" ]; then
    CHANGES=$(diff "$PREV_FILE" "$file" | wc -l)
  else
    CHANGES="Initial"
  fi
  
  echo "| $DATE | $SIZE bytes | $WORDS | $CHANGES |"
  PREV_FILE="$file"
done
```

## Best Practices

### 1. Consistent Naming
- Always use ISO 8601 date format (YYYY-MM-DD)
- Include page/category in filename
- Use lowercase with hyphens
- Be descriptive but concise

### 2. Always Create Metadata
- Create `.json` file alongside `.md` file
- Include scrape timestamp (UTC)
- Track source URL
- Record content hash for change detection

### 3. Regular Cadence
- Define scraping frequency (daily, weekly, monthly)
- Stick to schedule for consistent tracking
- Adjust frequency based on change rate
- Document scraping schedule in metadata

### 4. Automate Change Detection
- Compare with previous version automatically
- Alert on significant changes (threshold: 50+ lines)
- Extract key changes (pricing, features)
- Generate change reports

### 5. Storage Management
- Keep all versions (disk space is cheap)
- Compress old versions if needed (gzip)
- Keep metadata even if content is compressed
- Define retention policy if necessary

### 6. Documentation
- Document scraping schedule
- Note any manual interventions
- Track URL changes
- Record analysis findings

## File Organization Tips

### Group by Company
```
sources/Competitors/
├── Kong/
│   ├── features-2024-06-12.md
│   ├── features-2024-06-12.json
│   ├── pricing-2024-06-12.md
│   └── pricing-2024-06-12.json
├── Apigee/
└── MuleSoft/
```

### Group by Topic
```
sources/
├── Features/
│   ├── kong-2024-06-12.md
│   ├── apigee-2024-06-12.md
│   └── mulesoft-2024-06-12.md
└── Pricing/
    ├── kong-2024-06-12.md
    ├── apigee-2024-06-12.md
    └── mulesoft-2024-06-12.md
```

**Recommendation**: Group by company (first structure) for easier management and clearer organization.

## Related Documentation

- [Example 1: Competitor Website Scraping](example-1-competitor-website.md)
- [Example 2: Link Discovery](example-2-link-discovery.md)
- [Web Scraping README](README.md)
- [Research Analysis Examples](../research-analysis/)