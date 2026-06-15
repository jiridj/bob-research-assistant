# Example 2: Organizing Research Sources

This example demonstrates how to organize and catalog research sources effectively.

## Scenario

You have multiple sources from different providers (Gartner, Forrester, vendor docs, web content) and need to organize them systematically for easy discovery and reference.

## Conversation Flow

### User Request
```
User: "I have PDFs from Gartner and Forrester, plus I need to scrape some vendor websites. 
How should I organize all these sources?"
```

### Bob's Response

**Step 1: Assess Current Situation**
```
Bob: "Let me help you set up a proper source organization system. 
First, let me understand what you have:

1. How many sources do you have?
2. What types? (PDFs, web pages, documents)
3. Are they for a specific project or general research library?
4. Do you need to track versions or updates?"
```

### User Clarification
```
User: "I have:
- 3 Gartner reports (PDFs)
- 2 Forrester reports (PDFs)
- Need to scrape Kong, Apigee, and AWS documentation
- This is for my API management trends project
- Yes, I'll need to track updates for web content"
```

### Bob's Actions

**Step 2: Create Source Directory Structure**
```bash
# Create organized source structure
mkdir -p sources/{gartner,forrester,vendor-docs/{kong,apigee,aws},web,raw}

# Create index files
touch sources/index.md
touch sources/gartner/index.md
touch sources/forrester/index.md
touch sources/vendor-docs/index.md
touch sources/web/index.md
```

**Step 3: Convert Gartner Reports**
```bash
# Convert first Gartner report
docling sources/raw/gartner-mq-api-2024.pdf \
  --output sources/gartner/magic-quadrant-api-management-2024.md \
  --no-images

# Add metadata to converted file
cat > sources/gartner/magic-quadrant-api-management-2024.md << 'EOF'
---
title: "Gartner Magic Quadrant for API Management 2024"
source_type: analyst_report
provider: Gartner
published_date: 2024-03-15
converted_date: 2024-06-12
original_file: sources/raw/gartner-mq-api-2024.pdf
pages: 45
relevance: high
topics:
  - API Management
  - API Gateways
  - Vendor Comparison
status: current
---

# Gartner Magic Quadrant for API Management 2024

## Document Information
- **Publisher**: Gartner, Inc.
- **Authors**: Mark O'Neill, Paolo Malinverno
- **Publication Date**: March 15, 2024
- **Document ID**: G00123456
- **Pages**: 45

[Rest of converted content...]
EOF

# Convert remaining Gartner reports
docling sources/raw/gartner-market-guide-2024.pdf \
  --output sources/gartner/market-guide-api-management-2024.md \
  --no-images

docling sources/raw/gartner-critical-capabilities-2024.pdf \
  --output sources/gartner/critical-capabilities-api-management-2024.md \
  --no-images
```

**Step 4: Convert Forrester Reports**
```bash
# Convert Forrester reports
docling sources/raw/forrester-wave-api-2024.pdf \
  --output sources/forrester/wave-api-management-2024.md \
  --no-images

docling sources/raw/forrester-predictions-2024.pdf \
  --output sources/forrester/predictions-api-management-2024.md \
  --no-images
```

**Step 5: Scrape Vendor Documentation**
```bash
# Scrape Kong documentation
crawl4ai https://konghq.com/products/kong-gateway/features \
  --output sources/vendor-docs/kong/features-overview-2024-06-12.md

crawl4ai https://konghq.com/products/kong-gateway/architecture \
  --output sources/vendor-docs/kong/architecture-2024-06-12.md

# Scrape Apigee documentation
crawl4ai https://cloud.google.com/apigee/docs/api-platform/get-started/overview \
  --output sources/vendor-docs/apigee/overview-2024-06-12.md

crawl4ai https://cloud.google.com/apigee/docs/api-platform/fundamentals/capabilities \
  --output sources/vendor-docs/apigee/capabilities-2024-06-12.md

# Scrape AWS documentation
crawl4ai https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html \
  --output sources/vendor-docs/aws/api-gateway-overview-2024-06-12.md

crawl4ai https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-basic-concept.html \
  --output sources/vendor-docs/aws/basic-concepts-2024-06-12.md
```

**Step 6: Create Master Index**
```bash
cat > sources/index.md << 'EOF'
# Sources Master Index

**Last Updated**: 2024-06-12
**Total Sources**: 11

## Quick Stats
- **Analyst Reports**: 5 (3 Gartner, 2 Forrester)
- **Vendor Documentation**: 6 (2 Kong, 2 Apigee, 2 AWS)
- **Web Content**: 0
- **Raw Files**: 5 PDFs

## Categories

### Analyst Reports (5)
- [Gartner Reports](gartner/index.md) - 3 reports
- [Forrester Reports](forrester/index.md) - 2 reports

### Vendor Documentation (6)
- [Kong Documentation](vendor-docs/kong/index.md) - 2 docs
- [Apigee Documentation](vendor-docs/apigee/index.md) - 2 docs
- [AWS Documentation](vendor-docs/aws/index.md) - 2 docs

## Recent Additions
- 2024-06-12: Gartner Magic Quadrant API Management 2024
- 2024-06-12: Gartner Market Guide API Management 2024
- 2024-06-12: Gartner Critical Capabilities API Management 2024
- 2024-06-12: Forrester Wave API Management 2024
- 2024-06-12: Forrester Predictions 2024
- 2024-06-12: Kong Features Overview
- 2024-06-12: Kong Architecture
- 2024-06-12: Apigee Overview
- 2024-06-12: Apigee Capabilities
- 2024-06-12: AWS API Gateway Overview
- 2024-06-12: AWS Basic Concepts

## By Topic

### API Management Platforms
- Gartner Magic Quadrant API Management 2024
- Forrester Wave API Management 2024
- Gartner Critical Capabilities API Management 2024

### Vendor Capabilities
- Kong Features Overview
- Apigee Capabilities
- AWS API Gateway Overview

### Market Analysis
- Gartner Market Guide API Management 2024
- Forrester Predictions 2024

## Maintenance Notes
- All sources current as of 2024-06-12
- Web content should be refreshed monthly
- Next update scheduled: 2024-07-12
EOF
```

**Step 7: Create Category Indexes**
```bash
# Gartner index
cat > sources/gartner/index.md << 'EOF'
# Gartner Sources Index

**Last Updated**: 2024-06-12
**Total Documents**: 3

## Magic Quadrants

### API Management
- `magic-quadrant-api-management-2024.md` (45 pages)
  - **Published**: March 2024
  - **Converted**: 2024-06-12
  - **Status**: Current
  - **Key Topics**: API gateways, management platforms, vendor comparison
  - **Vendors Covered**: Kong, Apigee, AWS, Azure, MuleSoft, IBM, others

## Market Guides

### API Management
- `market-guide-api-management-2024.md` (28 pages)
  - **Published**: April 2024
  - **Converted**: 2024-06-12
  - **Status**: Current
  - **Key Topics**: Market overview, vendor landscape, selection criteria

## Critical Capabilities

### API Management
- `critical-capabilities-api-management-2024.md` (40 pages)
  - **Published**: March 2024
  - **Converted**: 2024-06-12
  - **Status**: Current
  - **Key Topics**: Use cases, capability scoring, vendor ratings

## Usage Statistics
- **Most Referenced**: Magic Quadrant API Management 2024
- **Recent Additions**: 3 in last 24 hours
- **Pending Conversion**: 0

## Related Categories
- [Forrester Reports](../forrester/index.md)
- [Vendor Documentation](../vendor-docs/index.md)
EOF

# Forrester index
cat > sources/forrester/index.md << 'EOF'
# Forrester Sources Index

**Last Updated**: 2024-06-12
**Total Documents**: 2

## Waves

### API Management Solutions
- `wave-api-management-2024.md` (38 pages)
  - **Published**: February 2024
  - **Converted**: 2024-06-12
  - **Status**: Current
  - **Key Topics**: Vendor evaluation, market analysis, recommendations
  - **Vendors Covered**: Kong, Apigee, AWS, Azure, MuleSoft, others

## Predictions

### API Management
- `predictions-api-management-2024.md` (25 pages)
  - **Published**: January 2024
  - **Converted**: 2024-06-12
  - **Status**: Current
  - **Key Topics**: Market trends, future directions, technology evolution

## Usage Statistics
- **Most Referenced**: Wave API Management 2024
- **Recent Additions**: 2 in last 24 hours
- **Pending Conversion**: 0

## Related Categories
- [Gartner Reports](../gartner/index.md)
- [Vendor Documentation](../vendor-docs/index.md)
EOF

# Vendor docs index
cat > sources/vendor-docs/index.md << 'EOF'
# Vendor Documentation Index

**Last Updated**: 2024-06-12
**Total Documents**: 6

## Kong (2 documents)

### Features Overview
- `kong/features-overview-2024-06-12.md`
  - **Scraped**: 2024-06-12
  - **URL**: https://konghq.com/products/kong-gateway/features
  - **Topics**: Gateway features, plugins, capabilities

### Architecture
- `kong/architecture-2024-06-12.md`
  - **Scraped**: 2024-06-12
  - **URL**: https://konghq.com/products/kong-gateway/architecture
  - **Topics**: System architecture, deployment patterns

## Apigee (2 documents)

### Overview
- `apigee/overview-2024-06-12.md`
  - **Scraped**: 2024-06-12
  - **URL**: https://cloud.google.com/apigee/docs/api-platform/get-started/overview
  - **Topics**: Platform overview, key concepts

### Capabilities
- `apigee/capabilities-2024-06-12.md`
  - **Scraped**: 2024-06-12
  - **URL**: https://cloud.google.com/apigee/docs/api-platform/fundamentals/capabilities
  - **Topics**: Core capabilities, features

## AWS (2 documents)

### API Gateway Overview
- `aws/api-gateway-overview-2024-06-12.md`
  - **Scraped**: 2024-06-12
  - **URL**: https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html
  - **Topics**: Service overview, use cases

### Basic Concepts
- `aws/basic-concepts-2024-06-12.md`
  - **Scraped**: 2024-06-12
  - **URL**: https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-basic-concept.html
  - **Topics**: Core concepts, terminology

## Refresh Schedule
- **Kong**: Monthly (next: 2024-07-12)
- **Apigee**: Monthly (next: 2024-07-12)
- **AWS**: Monthly (next: 2024-07-12)

## Related Categories
- [Gartner Reports](../gartner/index.md)
- [Forrester Reports](../forrester/index.md)
EOF
```

**Step 8: Link to Research Project**
```bash
# Update project's source index
cat > research/api-management-trends-2024/sources/index.md << 'EOF'
# Sources Index - API Management Trends 2024

**Last Updated**: 2024-06-12
**Total Sources**: 11

## Analyst Reports

### Gartner (3)
- [Magic Quadrant API Management 2024](../../../sources/gartner/magic-quadrant-api-management-2024.md) ✓
- [Market Guide API Management 2024](../../../sources/gartner/market-guide-api-management-2024.md) ✓
- [Critical Capabilities API Management 2024](../../../sources/gartner/critical-capabilities-api-management-2024.md) ✓

### Forrester (2)
- [Wave API Management 2024](../../../sources/forrester/wave-api-management-2024.md) ✓
- [Predictions 2024](../../../sources/forrester/predictions-api-management-2024.md) ✓

## Vendor Documentation

### Kong (2)
- [Features Overview](../../../sources/vendor-docs/kong/features-overview-2024-06-12.md) ✓
- [Architecture](../../../sources/vendor-docs/kong/architecture-2024-06-12.md) ✓

### Apigee (2)
- [Overview](../../../sources/vendor-docs/apigee/overview-2024-06-12.md) ✓
- [Capabilities](../../../sources/vendor-docs/apigee/capabilities-2024-06-12.md) ✓

### AWS (2)
- [API Gateway Overview](../../../sources/vendor-docs/aws/api-gateway-overview-2024-06-12.md) ✓
- [Basic Concepts](../../../sources/vendor-docs/aws/basic-concepts-2024-06-12.md) ✓

## Statistics
- **Total Sources**: 11
- **Converted**: 11
- **Pending**: 0
- **Last Updated**: 2024-06-12

## Next Steps
- [ ] Read and extract key points from each source
- [ ] Create comparison matrix
- [ ] Identify trends across sources
EOF
```

### Bob's Confirmation

```
Bob: "✓ Organized all sources successfully

Source structure:
sources/
├── index.md (master catalog)
├── gartner/ (3 reports)
│   ├── index.md
│   ├── magic-quadrant-api-management-2024.md
│   ├── market-guide-api-management-2024.md
│   └── critical-capabilities-api-management-2024.md
├── forrester/ (2 reports)
│   ├── index.md
│   ├── wave-api-management-2024.md
│   └── predictions-api-management-2024.md
├── vendor-docs/
│   ├── index.md
│   ├── kong/ (2 docs)
│   ├── apigee/ (2 docs)
│   └── aws/ (2 docs)
└── raw/ (5 original PDFs)

Summary:
- Converted 5 analyst reports from PDF to markdown
- Scraped 6 vendor documentation pages
- Created comprehensive indexes at all levels
- Linked sources to your research project
- Set up monthly refresh schedule for web content

All sources are now organized and ready for analysis. 
Would you like me to start analyzing these sources?"
```

## Key Takeaways

### Organization Strategy

1. **Hierarchical Structure**: Sources organized by provider/type
2. **Comprehensive Indexing**: Master index + category indexes
3. **Metadata Rich**: Each source has detailed metadata
4. **Version Tracking**: Date-based naming for web content
5. **Project Linking**: Sources linked to research projects

### Best Practices Demonstrated

1. **Consistent Naming**: Used descriptive, date-based names
2. **Complete Conversion**: Converted all PDFs to markdown
3. **Index Maintenance**: Created indexes at every level
4. **Metadata Tracking**: Added YAML front matter to sources
5. **Refresh Planning**: Scheduled updates for web content

### Benefits

1. **Easy Discovery**: Can find sources quickly via indexes
2. **Clear Organization**: Logical structure by provider
3. **Version Control**: Track updates to web content
4. **Reusability**: Sources can be used across projects
5. **Collaboration**: Others can navigate structure easily

## Search Examples

### Find Specific Source
```bash
# By title
grep -r "Magic Quadrant" sources/ --include="*.md"

# By vendor
grep -r "Kong" sources/ --include="*.md"

# By topic
grep -r "API Gateway" sources/ --include="*.md"
```

### List Sources by Category
```bash
# All Gartner reports
ls sources/gartner/*.md

# All vendor docs
find sources/vendor-docs/ -name "*.md" -type f

# Recent additions
find sources/ -name "*.md" -mtime -1
```

## Maintenance Tasks

### Weekly
- Update master index with new sources
- Check for broken links in web content
- Review source usage statistics

### Monthly
- Refresh web content (vendor docs)
- Update category indexes
- Archive old versions

### Quarterly
- Review organization structure
- Consolidate duplicate sources
- Update metadata standards

## Related Examples

- [Example 1: Creating a New Project](example-1-new-project.md) - Project initialization
- [Example 3: Project Maintenance](example-3-project-maintenance.md) - Ongoing maintenance

## Related Documentation

- [Source Organization Guide](../../guides/source-organization.md) - Detailed guide
- [Project Initialization Guide](../../guides/project-initialization.md) - Project setup
- [Document Conversion Examples](../document-conversion/) - Converting sources
- [Web Scraping Examples](../web-scraping/) - Gathering web content