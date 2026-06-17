# Research Assistant Utility Scripts

This directory contains utility scripts that enhance the Research Assistant skill with automation and batch processing capabilities.

## 📋 Available Scripts

### Essential Scripts

#### 1. `init-research-project.sh`
Initialize a new research project with proper structure.

```bash
./scripts/init-research-project.sh project-name
```

**Creates:**
- Project directory structure
- README with metadata
- Working files (notes.md, analysis.md, report.md)
- Source index

**Example:**
```bash
./scripts/init-research-project.sh api-management-trends
```

---

#### 2. `batch-convert-pdfs.sh`
Convert multiple PDFs to markdown with smart categorization.

```bash
./scripts/batch-convert-pdfs.sh [source-dir] [output-dir]
```

**Features:**
- Automatic category detection from filenames
- Batch processing with progress tracking
- Metadata addition
- Error handling and reporting

**Example:**
```bash
./scripts/batch-convert-pdfs.sh sources/raw sources
```

---

#### 3. `scrape-with-version.sh`
Scrape web content with automatic versioning and metadata.

```bash
./scripts/scrape-with-version.sh URL COMPANY PAGE
```

**Features:**
- Date-based versioning
- Metadata tracking (hash, word count, size)
- Change detection vs previous versions
- Automatic comparison

**Example:**
```bash
./scripts/scrape-with-version.sh \
  "https://konghq.com/products/api-gateway" \
  "Kong" \
  "features"
```

---

#### 4. `generate-bibliography.sh`
Auto-generate bibliography from all research sources.

```bash
./scripts/generate-bibliography.sh [sources-dir] [output-file]
```

**Features:**
- Extracts metadata from sources
- Organizes by category
- Generates formatted bibliography
- Includes statistics

**Example:**
```bash
./scripts/generate-bibliography.sh sources bibliography.md
```

---

#### 5. `search-sources.sh`
Smart search across all research sources with context.

```bash
./scripts/search-sources.sh 'search term' [context_lines] [sources_dir]
```

**Features:**
- Full-text search with context
- Color-coded results
- Match statistics
- File listing

**Example:**
```bash
./scripts/search-sources.sh "API Gateway" 5
```

---

### Utility Scripts

#### 6. `validate-conversion.sh`
Verify document conversion quality.

```bash
./scripts/validate-conversion.sh INPUT_FILE OUTPUT_FILE
```

**Checks:**
- File existence and size
- Markdown structure (headings, tables, links)
- Text encoding quality
- Word and line counts

**Example:**
```bash
./scripts/validate-conversion.sh document.pdf sources/Gartner/document.md
```

---

#### 7. `detect-changes.sh`
Detect and analyze changes between versions.

```bash
./scripts/detect-changes.sh COMPANY PAGE
```

**Features:**
- Line-by-line comparison
- Section change detection
- Pricing/feature change analysis
- Version history

**Example:**
```bash
./scripts/detect-changes.sh Kong features
```

---

#### 8. `generate-all-reports.sh`
Batch generate reports from all research projects.

```bash
./scripts/generate-all-reports.sh [template]
```

**Features:**
- Processes all projects in research/
- Generates DOCX and PDF
- Uses custom templates
- Progress tracking

**Example:**
```bash
./scripts/generate-all-reports.sh templates/corporate.docx
```

---

#### 9. `update-source-index.sh`
Update source index files with current inventory.

```bash
./scripts/update-source-index.sh [sources-dir]
```

**Features:**
- Updates master index
- Updates category indexes
- Includes file statistics
- Automatic organization

**Example:**
```bash
./scripts/update-source-index.sh sources
```

---

### Advanced Scripts

#### 10. `extract-citations.sh`
Extract citations from analysis documents.

```bash
./scripts/extract-citations.sh ANALYSIS_FILE [OUTPUT_FILE]
```

**Features:**
- Extracts markdown links and citation IDs
- Calculates citation density
- Quality checks
- Generates citation report

**Example:**
```bash
./scripts/extract-citations.sh research/api-trends/analysis.md
```

---

#### 11. `archive-old-sources.sh`
Archive old or outdated sources.

```bash
./scripts/archive-old-sources.sh [days-old] [sources-dir]
```

**Features:**
- Finds files older than threshold
- Interactive confirmation
- Preserves directory structure
- Creates archive index

**Example:**
```bash
./scripts/archive-old-sources.sh 180 sources
```

---

#### 12. `batch-scrape-urls.sh`
Scrape multiple URLs from a file.

```bash
./scripts/batch-scrape-urls.sh URL_FILE [COMPANY] [DELAY]
```

**Features:**
- Batch processing from URL list
- Rate limiting with delays
- Progress tracking
- Error handling

**Example:**
```bash
# Create urls.txt with one URL per line
./scripts/batch-scrape-urls.sh urls.txt Kong 3
```

---

## 🚀 Quick Start

### 1. Start a New Research Project
```bash
./scripts/init-research-project.sh my-research
cd research/my-research
```

### 2. Convert Documents
```bash
# Single PDF
docling document.pdf --output sources/category/document.md --no-images

# Batch convert
./scripts/batch-convert-pdfs.sh sources/raw sources
```

### 3. Scrape Web Content
```bash
# Single page with versioning
./scripts/scrape-with-version.sh "https://example.com" "Company" "page"

# Multiple URLs
./scripts/batch-scrape-urls.sh urls.txt Company 2
```

### 4. Search and Analyze
```bash
# Search sources
./scripts/search-sources.sh "keyword" 3

# Detect changes
./scripts/detect-changes.sh Company page
```

### 5. Generate Reports
```bash
# Single project
cd research/my-project
pandoc report.md -o output/report.docx --toc

# All projects
./scripts/generate-all-reports.sh
```

---

## 📊 Workflow Examples

### Complete Research Workflow

```bash
# 1. Initialize project
./scripts/init-research-project.sh api-gateway-comparison

# 2. Convert analyst reports
./scripts/batch-convert-pdfs.sh sources/raw sources

# 3. Scrape competitor websites
./scripts/scrape-with-version.sh "https://konghq.com/products" "Kong" "features"
./scripts/scrape-with-version.sh "https://apigee.com/products" "Apigee" "features"

# 4. Update indexes
./scripts/update-source-index.sh sources

# 5. Search for specific topics
./scripts/search-sources.sh "rate limiting" 5

# 6. Generate bibliography
./scripts/generate-bibliography.sh sources bibliography.md

# 7. Generate final report
./scripts/generate-all-reports.sh
```

### Competitive Intelligence Workflow

```bash
# 1. Create URL list for competitor pages
cat > competitor-urls.txt << EOF
https://competitor1.com/pricing
https://competitor2.com/pricing
https://competitor3.com/pricing
EOF

# 2. Scrape all pages
./scripts/batch-scrape-urls.sh competitor-urls.txt Competitors 3

# 3. Detect changes over time
./scripts/detect-changes.sh Competitor1 pricing
./scripts/detect-changes.sh Competitor2 pricing

# 4. Search for pricing changes
./scripts/search-sources.sh "pricing" 5 sources/Competitors
```

---

## 🔧 Configuration

### Environment Variables

Scripts respect these environment variables:

- `SOURCES_DIR` - Default sources directory (default: `sources`)
- `RESEARCH_DIR` - Default research directory (default: `research`)
- `OUTPUT_DIR` - Default output directory (default: `output`)

### Customization

Edit scripts to customize:
- Category detection logic in `batch-convert-pdfs.sh`
- Search patterns in `search-sources.sh`
- Archive thresholds in `archive-old-sources.sh`
- Report templates in `generate-all-reports.sh`

---

## 🐛 Troubleshooting

### Script Not Executable
```bash
chmod +x scripts/*.sh
```

### Command Not Found
Ensure dependencies are installed:
```bash
pip install docling crawl4ai
brew install pandoc  # or apt-get/choco
```

### Permission Denied
Check file permissions:
```bash
ls -la sources/
chmod 644 sources/**/*.md
```

---

## 📚 Additional Resources

- **Main Documentation**: [.bob/skills/research-assistant/README.md](../.bob/skills/research-assistant/README.md)
- **Skill Definition**: [.bob/skills/research-assistant/SKILL.md](../.bob/skills/research-assistant/SKILL.md)
- **Examples**: [.bob/skills/research-assistant/examples/](../.bob/skills/research-assistant/examples/)
- **Guides**: [.bob/skills/research-assistant/guides/](../.bob/skills/research-assistant/guides/)

---

## 🤝 Contributing

To add new scripts:

1. Create script in `scripts/` directory
2. Make it executable: `chmod +x scripts/new-script.sh`
3. Follow naming convention: `action-target.sh`
4. Include usage instructions in header
5. Add colored output for better UX
6. Update this README

---

**Last Updated**: 2026-06-17