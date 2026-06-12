# Example 2: Convert AWS Whitepaper with Images

## Scenario
Converting an AWS technical whitepaper that contains important architecture diagrams and charts that should be preserved as separate image files.

## User Request
```
"Convert the AWS whitepaper and keep the architecture diagrams"
```

## Workflow Steps

### 1. Identify File Location
**Action**: Ask user for the file path
```
"Where is the AWS whitepaper PDF located?"
```

**User Response Example**:
```
"It's in ~/Documents/aws-serverless-architecture-whitepaper.pdf"
```

### 2. Determine Target Category
**Action**: Confirm appropriate category structure
```
"I'll save this to sources/Hyperscalers/AWS/. Is that correct?"
```

**Reasoning**: 
- Hyperscalers (AWS, Azure, GCP) should have dedicated folders
- Sub-categorize by cloud provider
- Maintains clear organizational hierarchy
- Easy to find all AWS-related materials

### 3. Clarify Image Handling
**Action**: Confirm image export requirement
```
"You mentioned keeping architecture diagrams. I'll export images to a separate folder. 
This will:
- Keep the markdown file clean and readable
- Store images as separate PNG/JPG files
- Reference images in the markdown with relative paths

Proceed with image export?"
```

**User Confirmation**: "Yes, please"

### 4. Execute Docling Conversion with Image Export
**Command**:
```bash
docling ~/Documents/aws-serverless-architecture-whitepaper.pdf \
  --output sources/Hyperscalers/AWS/serverless-architecture-whitepaper.md \
  --export-images sources/Hyperscalers/AWS/images/
```

**Key Flags**:
- `--output`: Specifies the target markdown file path
- `--export-images`: Exports images to specified directory (NOT embedded as base64)

**What Happens**:
1. Docling extracts text content to markdown
2. Identifies all images in the PDF
3. Exports each image as a separate file (PNG format)
4. Inserts markdown image references: `![diagram](images/figure-1.png)`
5. Preserves document structure and formatting

### 5. Verify Conversion and Image Export
**Verification Commands**:
```bash
# Check markdown file
ls -lh sources/Hyperscalers/AWS/serverless-architecture-whitepaper.md

# List exported images
ls -lh sources/Hyperscalers/AWS/images/

# Preview markdown content
head -n 30 sources/Hyperscalers/AWS/serverless-architecture-whitepaper.md

# Count images
ls sources/Hyperscalers/AWS/images/ | wc -l
```

**Expected Output**:
```
sources/Hyperscalers/AWS/
├── serverless-architecture-whitepaper.md (125 KB)
└── images/
    ├── figure-1-lambda-architecture.png
    ├── figure-2-api-gateway-flow.png
    ├── figure-3-dynamodb-design.png
    ├── figure-4-event-driven-pattern.png
    └── figure-5-cost-comparison.png
```

### 6. Report Success with Details
**Response to User**:
```
✅ Successfully converted AWS whitepaper with images

📄 Markdown file: sources/Hyperscalers/AWS/serverless-architecture-whitepaper.md
   Size: 125 KB
   Format: Markdown with image references

🖼️  Images exported: sources/Hyperscalers/AWS/images/
   Total images: 5
   - figure-1-lambda-architecture.png (architecture diagram)
   - figure-2-api-gateway-flow.png (flow diagram)
   - figure-3-dynamodb-design.png (database schema)
   - figure-4-event-driven-pattern.png (pattern diagram)
   - figure-5-cost-comparison.png (chart)

Images are referenced in the markdown but stored separately for:
- Better version control
- Easier image management
- Smaller markdown file size
- Ability to view/edit images independently

Would you like me to:
1. Create a summary of the serverless architecture patterns?
2. Extract key AWS service recommendations?
3. Compare this with Azure/GCP serverless approaches?
```

## Image Reference Format in Markdown

The generated markdown will contain image references like:

```markdown
## Lambda Architecture Overview

The following diagram illustrates the serverless architecture pattern:

![Lambda Architecture](images/figure-1-lambda-architecture.png)

As shown in the diagram, API Gateway receives requests and triggers Lambda functions...
```

**Benefits**:
- Images are NOT embedded as base64 blobs
- Clean, readable markdown
- Images can be viewed separately
- Easy to replace or update images
- Better for version control (Git)

## Alternative Scenarios

### If User Doesn't Want Images
**User Request**:
```
"Actually, I just need the text content, skip the images"
```

**Updated Command**:
```bash
docling ~/Documents/aws-serverless-architecture-whitepaper.pdf \
  --output sources/Hyperscalers/AWS/serverless-architecture-whitepaper.md \
  --no-images
```

**Response**:
```
✅ Converted without images

Output: sources/Hyperscalers/AWS/serverless-architecture-whitepaper.md
Size: 85 KB (smaller without image references)
Format: Text-only markdown
```

### If Images Folder Already Exists
**Handling**:
```
⚠️  Images folder already exists: sources/Hyperscalers/AWS/images/

Options:
1. Overwrite existing images
2. Create new folder with timestamp: images-2024-06-12/
3. Cancel and review existing images first

Which would you prefer?
```

### If Conversion Fails
**Error Handling**:
```
❌ Conversion failed: Unable to extract images from PDF

Possible causes:
1. PDF has encrypted/protected images
2. Images are embedded in a non-standard format
3. Insufficient disk space for image export

Suggestions:
1. Try converting without images first: --no-images
2. Check PDF properties for restrictions
3. Verify available disk space: df -h

Would you like to try without images?
```

## Best Practices Demonstrated

1. **Clarify image handling** before conversion
2. **Use hierarchical folder structure** (Hyperscalers/AWS)
3. **Export images separately** (never as base64)
4. **Use descriptive image filenames** when possible
5. **Verify both markdown and images** after conversion
6. **Provide detailed success report** with file locations
7. **Explain benefits** of separate image storage
8. **Handle edge cases** (existing folders, failures)
9. **Offer relevant next steps** based on content type

## When to Export Images

**Export images when**:
- Architecture diagrams are important for understanding
- Charts and graphs contain key data
- Visual elements are referenced in analysis
- Creating presentations or reports that need visuals
- Comparing visual designs across sources

**Skip images when**:
- Only text content is needed for analysis
- Images are decorative (logos, headers)
- Performing text-based research only
- Storage space is limited
- Faster processing is needed

## Related Examples
- [Example 1: Convert Gartner Report](example-1-gartner-report.md)
- [Batch Processing with Selective Image Export](example-3-batch-processing.md)
- [Managing Large Image Collections](example-4-image-management.md)