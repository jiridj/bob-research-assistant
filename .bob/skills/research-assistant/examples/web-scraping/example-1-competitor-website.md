# Example 1: Scrape Competitor Website

## Scenario
Scraping a competitor's product features page to gather competitive intelligence for analysis.

## User Request
```
"Scrape the Kong API Gateway features page"
```

## Workflow Steps

### 1. Validate URL
**Action**: Confirm the URL is accessible and valid
```
"I'll scrape the Kong API Gateway features page. Let me verify the URL first."
```

**URL Validation**:
```bash
# Check if URL is accessible
curl -I https://konghq.com/products/api-gateway
```

**Expected Response**: HTTP 200 OK

### 2. Determine Target Category
**Action**: Confirm appropriate category structure
```
"I'll save this to sources/Competitors/Kong/. Is that correct?"
```

**Reasoning**: 
- Competitor information should be organized by company
- Maintains clear competitive intelligence structure
- Easy to find all Kong-related materials
- Supports comparative analysis across competitors

### 3. Execute Crawl4ai
**Command**:
```bash
crawl4ai https://konghq.com/products/api-gateway \
  --output sources/Competitors/Kong/features.md
```

**What Happens**:
1. Crawl4ai fetches the page content
2. Extracts main content (removes navigation, ads, etc.)
3. Converts HTML to clean markdown
4. Preserves structure (headings, lists, tables)
5. Saves to specified output file

### 4. Verify Content Extraction
**Verification Commands**:
```bash
# Check file was created
ls -lh sources/Competitors/Kong/features.md

# Preview content
head -n 50 sources/Competitors/Kong/features.md

# Check for key sections
grep -i "features\|capabilities\|pricing" sources/Competitors/Kong/features.md
```

**Quality Checks**:
- File size is reasonable (not empty, not too small)
- Content includes expected sections
- Markdown formatting is correct
- No HTML artifacts or broken formatting

### 5. Analyze Content for Relevant Links
**Action**: Extract and analyze links from the scraped content

**Link Analysis Process**:
```bash
# Extract all links from the markdown
grep -o 'http[s]*://[^)]*' sources/Competitors/Kong/features.md

# Filter for relevant Kong pages
grep -o 'http[s]*://konghq.com[^)]*' sources/Competitors/Kong/features.md | \
  grep -v 'login\|signup\|contact'
```

**Discovered Links** (example):
- https://konghq.com/products/api-gateway/pricing
- https://konghq.com/products/api-gateway/documentation
- https://konghq.com/products/api-gateway/use-cases
- https://konghq.com/products/api-gateway/enterprise
- https://konghq.com/products/api-gateway/integrations

### 6. Present Discovered Links
**Response to User**:
```
✅ Successfully scraped Kong API Gateway features page

📄 Output: sources/Competitors/Kong/features.md
   Size: 45 KB
   Sections found:
   - Core Features
   - Performance & Scalability
   - Security Capabilities
   - Plugin Ecosystem
   - Deployment Options

🔗 I found these related pages that might be useful:

1. Pricing Information
   https://konghq.com/products/api-gateway/pricing
   
2. Technical Documentation
   https://konghq.com/products/api-gateway/documentation
   
3. Use Cases & Examples
   https://konghq.com/products/api-gateway/use-cases
   
4. Enterprise Features
   https://konghq.com/products/api-gateway/enterprise
   
5. Integration Partners
   https://konghq.com/products/api-gateway/integrations

Would you like me to scrape any of these as well?
```

### 7. Handle User Response

#### Option A: User Wants Specific Pages
```
User: "Yes, scrape the pricing and documentation pages"

Actions:
1. Scrape pricing page
2. Scrape documentation page
3. Report all scraped files
```

**Commands**:
```bash
# Scrape pricing
crawl4ai https://konghq.com/products/api-gateway/pricing \
  --output sources/Competitors/Kong/pricing.md

# Scrape documentation
crawl4ai https://konghq.com/products/api-gateway/documentation \
  --output sources/Competitors/Kong/documentation.md
```

**Final Report**:
```
✅ Scraped 3 Kong pages:

1. sources/Competitors/Kong/features.md (45 KB)
2. sources/Competitors/Kong/pricing.md (28 KB)
3. sources/Competitors/Kong/documentation.md (156 KB)

All files are ready for analysis. Would you like me to:
- Create a competitive analysis comparing Kong with other API gateways?
- Extract key features and pricing information?
- Summarize Kong's unique selling points?
```

#### Option B: User Wants All Pages
```
User: "Scrape all of them"

Actions:
1. Create URL list file
2. Batch scrape all pages
3. Report results
```

**Commands**:
```bash
# Create URL list
cat > kong-urls.txt << EOF
https://konghq.com/products/api-gateway/pricing
https://konghq.com/products/api-gateway/documentation
https://konghq.com/products/api-gateway/use-cases
https://konghq.com/products/api-gateway/enterprise
https://konghq.com/products/api-gateway/integrations
EOF

# Batch scrape
for url in $(cat kong-urls.txt); do
  filename=$(echo $url | sed 's|.*/||').md
  crawl4ai "$url" --output "sources/Competitors/Kong/$filename"
done
```

#### Option C: User Declines
```
User: "No, just the features page is enough for now"

Response:
"Understood. The features page is saved and ready for analysis. 
Let me know when you'd like to analyze the content or scrape additional pages."
```

## Link Discovery Best Practices

### What Makes a Link Relevant?

**Include**:
- Product documentation and guides
- Pricing and plans information
- Use cases and case studies
- Technical specifications
- Integration information
- Enterprise/advanced features
- API references

**Exclude**:
- Login/signup pages
- Contact forms
- General company info (about, careers)
- Blog posts (unless specifically relevant)
- Legal pages (terms, privacy)
- Navigation/footer links
- Social media links

### Link Filtering Logic

```python
# Pseudo-code for link relevance
def is_relevant_link(url, base_url):
    # Must be same domain
    if not url.startswith(base_url):
        return False
    
    # Exclude patterns
    exclude_patterns = [
        '/login', '/signup', '/contact',
        '/about', '/careers', '/blog',
        '/terms', '/privacy', '/legal'
    ]
    
    if any(pattern in url for pattern in exclude_patterns):
        return False
    
    # Include patterns (high relevance)
    include_patterns = [
        '/pricing', '/documentation', '/docs',
        '/features', '/use-cases', '/enterprise',
        '/api', '/integration', '/guide'
    ]
    
    if any(pattern in url for pattern in include_patterns):
        return True
    
    return False
```

## Alternative Scenarios

### If URL is Invalid
**Error Handling**:
```
❌ Unable to access URL: https://konghq.com/products/api-gateway

Error: HTTP 404 Not Found

Possible causes:
1. URL has changed or page was removed
2. Temporary server issue
3. URL typo

Suggestions:
1. Check Kong's main website for updated URL
2. Try the main products page: https://konghq.com/products
3. Search for "Kong API Gateway features" to find current page

Would you like me to try the main products page instead?
```

### If Content Extraction Fails
**Error Handling**:
```
⚠️  Page scraped but content extraction was incomplete

Possible issues:
1. Page uses heavy JavaScript (content loaded dynamically)
2. Anti-scraping measures in place
3. Unusual page structure

Options:
1. Try with JavaScript rendering: crawl4ai --js-render
2. Use specific content selector: crawl4ai --selector "main.content"
3. Manual review of the page structure

Would you like me to try with JavaScript rendering?
```

### If No Relevant Links Found
**Response**:
```
✅ Successfully scraped Kong API Gateway features page

📄 Output: sources/Competitors/Kong/features.md

ℹ️  No additional relevant links found in the content.
This might be a standalone page or all links point to external resources.

The scraped content is ready for analysis.
```

## Best Practices Demonstrated

1. **Validate URLs** before scraping
2. **Organize by competitor** for clear structure
3. **Analyze content for links** automatically
4. **Filter links intelligently** (exclude navigation, include relevant pages)
5. **Present top 3-5 links** (not overwhelming)
6. **Ask user preference** before scraping more
7. **Support batch operations** for multiple pages
8. **Verify content quality** after scraping
9. **Handle errors gracefully** with helpful suggestions
10. **Offer next steps** for analysis

## Integration with Research Workflow

After scraping competitor pages:

1. **Immediate Analysis**:
   - Extract key features
   - Identify pricing tiers
   - Note unique capabilities

2. **Comparative Research**:
   - Scrape similar pages from other competitors
   - Create comparison matrix
   - Identify market gaps

3. **Report Generation**:
   - Use scraped content in competitive analysis
   - Reference specific features in reports
   - Include pricing comparisons

## Related Examples
- [Example 2: Scrape with Link Discovery](example-2-link-discovery.md)
- [Batch Scraping Multiple Competitors](example-3-batch-scraping.md)
- [Document Conversion Examples](../document-conversion/)