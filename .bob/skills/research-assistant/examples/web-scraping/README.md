# Web Scraping Examples

This directory contains practical examples of web scraping using the crawl4ai CLI tool, with emphasis on intelligent link discovery and content organization.

## Overview

Web scraping enables you to extract content from websites and convert it to markdown for research and analysis. These examples demonstrate best practices for different scraping scenarios, including the unique feature of discovering and suggesting relevant links.

## Key Features

### 1. Clean Content Extraction
- Removes navigation, ads, and clutter
- Preserves main content structure
- Converts HTML to clean markdown
- Maintains formatting (headings, lists, tables)

### 2. Intelligent Link Discovery
- **Automatically analyzes** scraped content for relevant links
- **Filters intelligently** (excludes navigation, includes content)
- **Categorizes by priority** (essential vs advanced)
- **Suggests top 3-5 links** to user
- **Supports batch scraping** of related pages

### 3. Organized Output
- Hierarchical folder structure
- Descriptive filenames
- Metadata tracking
- Index file generation

## Examples

### [Example 1: Scrape Competitor Website](example-1-competitor-website.md)
**Scenario**: Competitive intelligence gathering from Kong API Gateway

**Key Features**:
- URL validation and verification
- Competitor-focused organization
- Link discovery and filtering
- Multiple response handling (scrape all, some, or none)
- Error handling and recovery

**Use Case**: When you need to gather competitive intelligence, product features, or market positioning information.

**Link Discovery Highlights**:
- Discovers pricing, documentation, and use case pages
- Filters out login/signup and navigation links
- Presents 3-5 most relevant links
- Supports selective or batch scraping

**Command Pattern**:
```bash
crwl crawl https://competitor.com/product --output markdown \
  --output sources/Competitors/Company/page.md
```

### [Example 2: Scrape with Link Discovery](example-2-link-discovery.md)
**Scenario**: Building comprehensive AWS Lambda documentation knowledge base

**Key Features**:
- Documentation-focused scraping
- Advanced link categorization (essential vs advanced)
- Batch scraping workflows
- Index file generation
- Content analysis and summaries

**Use Case**: When you need to build a comprehensive knowledge base from documentation sites with interconnected pages.

**Link Discovery Highlights**:
- Categorizes links by priority (essential, advanced, reference)
- Provides context for each discovered link
- Supports flexible scraping options (all, specific, or essential only)
- Creates index files for navigation
- Analyzes content to suggest next steps

**Command Pattern**:
```bash
crwl crawl https://docs.example.com/service/intro --output markdown \
  --output sources/Category/Service/intro.md
```

## Link Discovery Feature

### How It Works

1. **Scrape Initial Page**
   ```bash
   crwl crawl https://example.com/page --output markdown --output-file sources/page.md
   ```

2. **Analyze Content**
   - Extract all links from scraped markdown
   - Filter by relevance (content vs navigation)
   - Categorize by type (docs, pricing, features, etc.)
   - Rank by importance

3. **Present to User**
   ```
   🔗 Found 8 related pages:
   
   Essential (recommended):
   1. Getting Started Guide
   2. Configuration Options
   3. Best Practices
   
   Advanced:
   4. API Reference
   5. Integration Examples
   
   Would you like me to scrape any of these?
   ```

4. **Handle Response**
   - Scrape selected pages
   - Batch process if needed
   - Generate index file
   - Report results

### Link Filtering Logic

**Include Links**:
- ✅ Documentation and guides
- ✅ Pricing and plans
- ✅ Use cases and examples
- ✅ Technical specifications
- ✅ Integration information
- ✅ Best practices
- ✅ API references

**Exclude Links**:
- ❌ Login/signup pages
- ❌ Contact forms
- ❌ General company info
- ❌ Blog posts (unless relevant)
- ❌ Legal pages
- ❌ Navigation/footer links
- ❌ Social media links

### Categorization Examples

**Essential Documentation**:
- Getting started guides
- Core concepts
- Configuration basics
- Security fundamentals

**Advanced Topics**:
- Performance optimization
- Advanced configurations
- Integration patterns
- Troubleshooting guides

**Reference Material**:
- API documentation
- CLI reference
- Configuration parameters
- Release notes

## Common Workflows

### Single Page Scraping
```bash
# Basic scrape
crwl crawl https://example.com/page --output markdown --output-file sources/category/page.md

# With content selector
crwl crawl https://example.com/page --output markdown \
  --selector "article.main-content" \
  --output sources/category/page.md
```

**When to use**:
- Specific article or page
- Product feature page
- Documentation page
- Blog post or article

### Batch Scraping from List
```bash
# Create URL list
cat > urls.txt << EOF
https://example.com/page1
https://example.com/page2
https://example.com/page3
EOF

# Scrape all URLs
./scripts/batch-scrape-urls.sh urls.txt sources/category/
```

**When to use**:
- Multiple known URLs
- Sitemap-based scraping
- Predefined page list
- Periodic updates

### Link Discovery Workflow
```bash
# 1. Scrape initial page
crwl crawl https://example.com/intro --output markdown --output-file sources/intro.md

# 2. Analyze for links (manual or automated)
grep -o 'https://example.com[^)]*' sources/intro.md

# 3. Scrape discovered links
for url in $(cat discovered-urls.txt); do
  filename=$(echo $url | sed 's|.*/||').md
  crwl crawl "$url" --output markdown --output-file "sources/$filename"
done
```

**When to use**:
- Exploring new documentation
- Building knowledge base
- Comprehensive coverage needed
- Interconnected content

## Folder Organization

### By Source Type
```
sources/
├── Competitors/
│   ├── Kong/
│   │   ├── features.md
│   │   ├── pricing.md
│   │   └── documentation.md
│   ├── Apigee/
│   └── MuleSoft/
├── Hyperscalers/
│   ├── AWS/
│   │   ├── Lambda/
│   │   │   ├── introduction.md
│   │   │   ├── getting-started.md
│   │   │   └── INDEX.md
│   │   └── S3/
│   ├── Azure/
│   └── GCP/
└── Documentation/
    ├── Technical/
    └── Guides/
```

### By Project
```
research/
├── api-management-comparison/
│   └── sources/
│       ├── kong-features.md
│       ├── apigee-features.md
│       └── mulesoft-features.md
└── serverless-analysis/
    └── sources/
        ├── aws-lambda.md
        ├── azure-functions.md
        └── gcp-cloud-functions.md
```

## Verification Checklist

After each scraping operation:

- [ ] Output file exists and is not empty
- [ ] File size is reasonable (not 0 bytes)
- [ ] Markdown formatting is correct
- [ ] Main content extracted (not just navigation)
- [ ] Links preserved in markdown format
- [ ] No HTML artifacts or broken formatting
- [ ] File saved to correct category folder
- [ ] Filename is descriptive
- [ ] Relevant links identified (if applicable)
- [ ] Index file updated (for multi-page scrapes)

## Troubleshooting

### URL Not Accessible
```bash
# Test URL accessibility
curl -I https://example.com/page

# Check for redirects
curl -L -I https://example.com/page

# Verify DNS resolution
nslookup example.com
```

**Solutions**:
- Check for typos in URL
- Verify site is online
- Check for geo-restrictions
- Try alternative URL format

### Content Not Extracted
```bash
# Try with JavaScript rendering
# For JS rendering, use Python API - see examples
  --output sources/page.md

# Use specific selector
crwl crawl https://example.com/page --output markdown \
  --output sources/page.md

# Increase timeout
crwl crawl https://example.com/page --output markdown \
  --output sources/page.md
```

**Common Causes**:
- JavaScript-heavy site
- Dynamic content loading
- Anti-scraping measures
- Unusual page structure

### Rate Limiting
```bash
# Add delays between requests
for url in $(cat urls.txt); do
  crwl crawl "$url" --output markdown --output-file "sources/$(basename $url).md"
  sleep 2  # Wait 2 seconds between requests
done
```

**Best Practices**:
- Respect robots.txt
- Add delays (1-2 seconds minimum)
- Limit concurrent requests
- Use appropriate user agent

### No Relevant Links Found

**Possible Reasons**:
- Page is standalone (no related content)
- Links point to external sites
- Content is behind authentication
- Links are dynamically loaded

**Solutions**:
- Check page manually for links
- Try with JavaScript rendering
- Look for sitemap or navigation
- Scrape parent/index page first

## Best Practices

### 1. URL Validation
- Always verify URL before scraping
- Check for redirects
- Confirm page accessibility
- Handle HTTPS properly

### 2. Content Organization
- Use hierarchical folder structure
- Descriptive filenames with context
- Maintain consistent naming
- Create index files for collections

### 3. Link Discovery
- Analyze content for relevant links
- Filter intelligently (content vs navigation)
- Present top 3-5 most relevant
- Categorize by priority
- Ask user before batch scraping

### 4. Respectful Scraping
- Check robots.txt
- Add delays between requests
- Use appropriate user agent
- Limit concurrent connections
- Cache results to avoid re-scraping

### 5. Error Handling
- Validate URLs before scraping
- Handle network errors gracefully
- Provide helpful error messages
- Suggest alternatives
- Log failures for review

### 6. Quality Verification
- Check output file size
- Verify content extraction
- Review markdown formatting
- Confirm link preservation
- Test with sample content

### 7. Metadata Tracking
- Document source URL
- Record scrape date
- Note any issues
- Track related pages
- Maintain index files

### 8. Batch Operations
- Group related pages
- Use URL lists
- Add appropriate delays
- Handle failures gracefully
- Report progress

### 9. Content Analysis
- Extract key information
- Identify patterns
- Note important sections
- Flag for review
- Suggest next steps

### 10. Integration
- Link to research workflow
- Support analysis phase
- Enable report generation
- Facilitate comparisons
- Maintain traceability

## Link Discovery Strategies

### Documentation Sites
1. Start with introduction/overview page
2. Discover getting started guides
3. Find configuration documentation
4. Locate best practices
5. Identify API references

### Competitor Sites
1. Start with product features page
2. Discover pricing information
3. Find use cases and examples
4. Locate technical specifications
5. Identify integration options

### Blog/Article Sites
1. Start with main article
2. Discover related articles
3. Find author's other posts
4. Locate series/category pages
5. Identify referenced resources

## Next Steps

After scraping web content:

1. **Verify Quality**
   - Review scraped content
   - Check for completeness
   - Verify formatting

2. **Organize Content**
   - Move to appropriate folders
   - Create index files
   - Add metadata

3. **Analyze Content**
   - Extract key information
   - Identify patterns
   - Note important findings

4. **Integrate with Research**
   - Combine with other sources
   - Cross-reference information
   - Build comprehensive view

5. **Generate Reports**
   - Use in competitive analysis
   - Include in documentation
   - Reference in reports

## Related Documentation

- [SKILL.md](../../SKILL.md) - Complete skill documentation
- [Document Conversion Examples](../document-conversion/) - Converting PDFs and documents
- [Research Analysis Examples](../research-analysis/) - Analyzing scraped content
- [Report Generation Examples](../report-generation/) - Creating final reports

## Tools Required

- **crwl** - Web scraping CLI tool (from crawl4ai package)
  - Installation: `pip install crawl4ai`
  - Documentation: [crawl4ai docs](https://github.com/unclecode/crawl4ai)

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review the example workflows
3. Consult the main SKILL.md documentation
4. Verify crwl installation and version
5. Test with simple URL first

## Advanced Topics

### Custom Selectors
Use CSS selectors to target specific content:
```bash
crwl crawl https://example.com/blog/post --output markdown
```

### JavaScript Rendering
For dynamic content:
```bash
# For JS rendering, use Python API - see examples
```

### Batch Processing with Error Handling
```bash
while read url; do
  filename=$(echo $url | md5sum | cut -d' ' -f1).md
  if crwl crawl "$url" --output markdown --output-file "sources/$filename" 2>/dev/null; then
    echo "✓ $url"
  else
    echo "✗ $url" >> failed-urls.txt
  fi
  sleep 2
done < urls.txt
```

### Link Analysis Automation
```bash
# Extract and analyze links
extract_links() {
  local file=$1
  grep -o 'https://[^)]*' "$file" | \
    grep -v 'login\|signup\|contact' | \
    sort -u
}

# Use in workflow
extract_links sources/page.md > discovered-links.txt