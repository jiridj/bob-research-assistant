# Example 2: Scrape with Link Discovery

## Scenario
Scraping AWS Lambda documentation with intelligent link discovery to build a comprehensive knowledge base about the service.

## User Request
```
"Scrape the AWS Lambda documentation page"
```

## Workflow Steps

### 1. Validate URL
**Action**: Confirm the documentation URL
```
"I'll scrape the AWS Lambda documentation. Which page would you like to start with?"
```

**User Response**:
```
"Start with the welcome/introduction page"
```

**URL**: `https://docs.aws.amazon.com/lambda/latest/dg/welcome.html`

### 2. Determine Target Category
**Action**: Confirm hierarchical organization
```
"I'll save this to sources/Hyperscalers/AWS/Lambda/. Is that correct?"
```

**Reasoning**: 
- Hyperscalers (AWS, Azure, GCP) get top-level folders
- Sub-organize by service (Lambda, S3, EC2, etc.)
- Maintains scalable structure for cloud documentation
- Easy to find all Lambda-related materials

### 3. Execute Crawl4ai
**Command**:
```bash
crwl crawl https://docs.aws.amazon.com/lambda/latest/dg/welcome.html --output markdown \
  --output sources/Hyperscalers/AWS/Lambda/introduction.md
```

**Initial Scrape Result**:
```
✅ Page scraped successfully

📄 Output: sources/Hyperscalers/AWS/Lambda/introduction.md
   Size: 12 KB
   
Content includes:
- What is AWS Lambda
- Key features and benefits
- Use cases
- Getting started overview
```

### 4. Extract Relevant Links from Content

**Link Extraction Process**:

The scraped markdown contains references to related documentation pages. Analyze these to find the most relevant follow-up pages.

**Example Links Found in Content**:
```markdown
# From the scraped introduction.md:

- [Getting Started with Lambda](getting-started.html)
- [Lambda Function Configuration](lambda-configuration.html)
- [Best Practices](best-practices.html)
- [Pricing](https://aws.amazon.com/lambda/pricing/)
- [Lambda Runtimes](lambda-runtimes.html)
- [Event Source Mappings](invocation-eventsourcemapping.html)
- [Lambda Layers](configuration-layers.html)
- [Monitoring and Troubleshooting](lambda-monitoring.html)
- [Security Best Practices](lambda-security.html)
- [Lambda API Reference](API_Reference.html)
```

**Link Analysis**:
```bash
# Extract all AWS Lambda doc links
grep -o 'https://docs.aws.amazon.com/lambda[^)]*' \
  sources/Hyperscalers/AWS/Lambda/introduction.md

# Or extract relative links
grep -o '\[.*\]([^)]*\.html)' \
  sources/Hyperscalers/AWS/Lambda/introduction.md
```

### 5. Categorize and Rank Links

**Categorization Logic**:

**High Priority** (Core Documentation):
- Getting started guides
- Configuration and setup
- Best practices
- Security

**Medium Priority** (Advanced Topics):
- Event source mappings
- Lambda layers
- Monitoring and troubleshooting
- Performance optimization

**Low Priority** (Reference):
- API reference
- CLI reference
- Pricing (external link)
- Release notes

### 6. Present Discovered Links to User

**Response**:
```
✅ Successfully scraped AWS Lambda introduction page

📄 Output: sources/Hyperscalers/AWS/Lambda/introduction.md

🔗 I found 10 related documentation pages. Here are the most relevant:

**Essential Documentation** (Recommended):
1. Getting Started with Lambda
   → getting-started.html
   Learn how to create and deploy your first Lambda function

2. Lambda Function Configuration
   → lambda-configuration.html
   Configure memory, timeout, environment variables, and more

3. Best Practices
   → best-practices.html
   AWS recommendations for Lambda development

4. Security Best Practices
   → lambda-security.html
   IAM roles, VPC configuration, and security guidelines

**Advanced Topics**:
5. Lambda Runtimes
   → lambda-runtimes.html
   Supported languages and runtime environments

6. Event Source Mappings
   → invocation-eventsourcemapping.html
   Connect Lambda to event sources (SQS, Kinesis, DynamoDB)

7. Lambda Layers
   → configuration-layers.html
   Share code and dependencies across functions

8. Monitoring and Troubleshooting
   → lambda-monitoring.html
   CloudWatch logs, metrics, and debugging

Would you like me to:
A) Scrape all essential documentation (1-4)
B) Scrape specific pages (tell me which numbers)
C) Scrape everything (1-8)
D) Just keep the introduction for now
```

### 7. Handle User Response

#### Scenario A: Scrape Essential Documentation
```
User: "Scrape all essential documentation"

Actions:
1. Create list of essential URLs
2. Batch scrape with proper naming
3. Report results with summary
```

**Implementation**:
```bash
# Base URL for AWS Lambda docs
BASE_URL="https://docs.aws.amazon.com/lambda/latest/dg"

# Essential pages
declare -A pages=(
  ["getting-started"]="getting-started.html"
  ["configuration"]="lambda-configuration.html"
  ["best-practices"]="best-practices.html"
  ["security"]="lambda-security.html"
)

# Scrape each page
for name in "${!pages[@]}"; do
  crwl crawl "$BASE_URL/${pages[$name]}" --output markdown \
    --output "sources/Hyperscalers/AWS/Lambda/$name.md"
  echo "✓ Scraped $name"
done
```

**Result Report**:
```
✅ Scraped 5 AWS Lambda documentation pages:

Essential Documentation:
1. introduction.md (12 KB) - Overview and key concepts
2. getting-started.md (28 KB) - Step-by-step tutorial
3. configuration.md (45 KB) - Function configuration options
4. best-practices.md (32 KB) - AWS recommendations
5. security.md (38 KB) - Security guidelines and IAM

Total: 155 KB of Lambda documentation

📊 Content Summary:
- 5 comprehensive guides
- 23 code examples found
- 47 configuration parameters documented
- 15 security best practices listed

🔗 Additional links discovered:
- 12 more advanced topics available
- 8 integration guides
- 5 troubleshooting guides

Would you like me to:
1. Create a summary of Lambda best practices?
2. Extract all configuration parameters into a reference?
3. Continue scraping advanced topics?
4. Start analyzing the content for a technical report?
```

#### Scenario B: Scrape Specific Pages
```
User: "Just scrape 1, 3, and 7"

Actions:
1. Scrape getting-started.html
2. Scrape best-practices.html
3. Scrape configuration-layers.html
4. Report results
```

**Implementation**:
```bash
BASE_URL="https://docs.aws.amazon.com/lambda/latest/dg"

# Scrape selected pages
crwl crawl "$BASE_URL/getting-started.html" --output markdown \
  --output sources/Hyperscalers/AWS/Lambda/getting-started.md

crwl crawl "$BASE_URL/best-practices.html" --output markdown \
  --output sources/Hyperscalers/AWS/Lambda/best-practices.md

crwl crawl "$BASE_URL/configuration-layers.html" --output markdown \
  --output sources/Hyperscalers/AWS/Lambda/layers.md
```

**Result Report**:
```
✅ Scraped 3 selected pages:

1. getting-started.md (28 KB)
   - Creating your first function
   - Deployment guide
   - Testing and invocation

2. best-practices.md (32 KB)
   - Performance optimization
   - Cost management
   - Error handling patterns

3. layers.md (22 KB)
   - Creating and using layers
   - Sharing dependencies
   - Layer versioning

All files saved to: sources/Hyperscalers/AWS/Lambda/

Ready for analysis!
```

#### Scenario C: Scrape Everything
```
User: "Scrape everything, I want comprehensive coverage"

Actions:
1. Create complete URL list
2. Batch scrape all pages
3. Organize by category
4. Generate index file
```

**Implementation**:
```bash
# Create comprehensive URL list
cat > lambda-docs-urls.txt << EOF
getting-started.html
lambda-configuration.html
best-practices.html
lambda-security.html
lambda-runtimes.html
invocation-eventsourcemapping.html
configuration-layers.html
lambda-monitoring.html
lambda-permissions.html
lambda-vpc.html
EOF

# Batch scrape
BASE_URL="https://docs.aws.amazon.com/lambda/latest/dg"
while read page; do
  filename=$(echo $page | sed 's/\.html/.md/')
  crwl crawl "$BASE_URL/$page" --output markdown \
    --output "sources/Hyperscalers/AWS/Lambda/$filename"
  echo "✓ Scraped $filename"
  sleep 1  # Be respectful to the server
done < lambda-docs-urls.txt
```

**Result Report**:
```
✅ Comprehensive Lambda documentation scraped!

📚 Total: 11 documentation pages (287 KB)

**Core Concepts** (4 files):
- introduction.md
- getting-started.md
- lambda-configuration.md
- lambda-runtimes.md

**Best Practices** (3 files):
- best-practices.md
- lambda-security.md
- lambda-permissions.md

**Advanced Features** (4 files):
- invocation-eventsourcemapping.md
- configuration-layers.md
- lambda-monitoring.md
- lambda-vpc.md

📊 Content Analysis:
- 67 code examples
- 124 configuration parameters
- 28 best practices
- 15 security guidelines
- 12 troubleshooting scenarios

Created index: sources/Hyperscalers/AWS/Lambda/INDEX.md

This comprehensive collection is ready for:
- Technical deep-dive analysis
- Best practices extraction
- Configuration reference guide
- Training material development
```

### 8. Create Documentation Index

When scraping multiple related pages, automatically create an index file:

**INDEX.md**:
```markdown
# AWS Lambda Documentation Index

Last Updated: 2024-06-12

## Overview
Comprehensive AWS Lambda documentation scraped from official AWS docs.

## Core Documentation

### Getting Started
- **introduction.md** - What is Lambda, key concepts, use cases
- **getting-started.md** - Step-by-step tutorial for first function
- **lambda-runtimes.md** - Supported languages and runtime environments

### Configuration
- **lambda-configuration.md** - Memory, timeout, environment variables
- **lambda-permissions.md** - IAM roles and resource policies
- **lambda-vpc.md** - VPC configuration and networking

### Best Practices
- **best-practices.md** - AWS recommendations for development
- **lambda-security.md** - Security guidelines and IAM best practices

### Advanced Features
- **invocation-eventsourcemapping.md** - Event sources (SQS, Kinesis, DynamoDB)
- **configuration-layers.md** - Sharing code and dependencies
- **lambda-monitoring.md** - CloudWatch logs, metrics, debugging

## Quick Reference

### Key Concepts
- Execution environment
- Cold starts vs warm starts
- Concurrency and scaling
- Event-driven architecture

### Common Use Cases
- API backends (with API Gateway)
- Data processing (S3, Kinesis)
- Scheduled tasks (EventBridge)
- Stream processing (DynamoDB Streams)

### Configuration Limits
- Memory: 128 MB - 10,240 MB
- Timeout: 1 second - 15 minutes
- Deployment package: 50 MB (zipped), 250 MB (unzipped)
- /tmp storage: 512 MB - 10,240 MB

## Related Documentation
- [AWS Lambda Pricing](https://aws.amazon.com/lambda/pricing/)
- [AWS Lambda API Reference](https://docs.aws.amazon.com/lambda/latest/dg/API_Reference.html)
- [AWS SAM Documentation](https://docs.aws.amazon.com/serverless-application-model/)

## Analysis Ready
This documentation set is ready for:
- Technical analysis and comparison
- Best practices extraction
- Training material development
- Architecture decision support
```

## Link Discovery Intelligence

### Smart Link Filtering

**Include Links That**:
- Are in the same documentation section
- Have descriptive anchor text
- Lead to related concepts
- Provide deeper technical details
- Offer practical examples

**Exclude Links That**:
- Point to external sites (unless AWS services)
- Are navigation elements
- Lead to generic pages (home, search)
- Are duplicate content
- Point to deprecated features

### Context-Aware Suggestions

Analyze the content to understand what the user might need next:

```
If introduction page mentions "getting started" → Suggest getting-started guide
If page discusses security → Suggest security best practices
If page mentions layers → Suggest layers documentation
If page shows code examples → Suggest API reference
```

## Best Practices Demonstrated

1. **Start with overview page** to discover structure
2. **Analyze links intelligently** based on content
3. **Categorize by priority** (essential vs advanced)
4. **Present clear options** to user
5. **Support flexible scraping** (all, some, or specific)
6. **Respect rate limits** (add delays in batch operations)
7. **Create index files** for navigation
8. **Provide content summaries** after scraping
9. **Suggest next steps** for analysis
10. **Maintain organized structure** by service/topic

## Integration with Research Workflow

### After Scraping Documentation:

1. **Immediate Use**:
   - Reference during development
   - Answer specific technical questions
   - Verify configuration options

2. **Analysis**:
   - Extract best practices
   - Create configuration checklists
   - Identify common patterns

3. **Comparison**:
   - Compare with Azure Functions
   - Compare with Google Cloud Functions
   - Identify unique features

4. **Report Generation**:
   - Technical deep-dive reports
   - Migration guides
   - Training materials

## Related Examples
- [Example 1: Scrape Competitor Website](example-1-competitor-website.md)
- [Batch Scraping Documentation Sites](example-3-batch-scraping.md)
- [Research Analysis Examples](../research-analysis/)