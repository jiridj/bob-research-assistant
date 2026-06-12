# Example 1: Convert Gartner Report

## Scenario
Converting a Gartner Magic Quadrant PDF to markdown format for research analysis.

## User Request
```
"Convert the Gartner Magic Quadrant PDF to markdown"
```

## Workflow Steps

### 1. Identify File Location
**Action**: Ask user for the file path
```
"Where is the Gartner Magic Quadrant PDF located?"
```

**User Response Example**:
```
"It's in ~/Downloads/gartner-mq-api-management-2024.pdf"
```

### 2. Determine Target Category
**Action**: Confirm or suggest appropriate category folder
```
"I'll save this to sources/Gartner/. Is that correct?"
```

**Reasoning**: 
- Gartner reports should be organized in a dedicated Gartner folder
- Maintains consistent source organization
- Easy to find and reference later

### 3. Execute Docling Conversion
**Command**:
```bash
docling ~/Downloads/gartner-mq-api-management-2024.pdf \
  --output sources/Gartner/magic-quadrant-api-management-2024.md \
  --no-images
```

**Key Flags**:
- `--output`: Specifies the target markdown file path
- `--no-images`: Excludes images by default (Gartner reports often have charts/diagrams that aren't needed for text analysis)

### 4. Verify Conversion
**Actions**:
- Check that the output file was created
- Verify file size is reasonable (not empty)
- Optionally preview first few lines to confirm content

**Verification Command**:
```bash
ls -lh sources/Gartner/magic-quadrant-api-management-2024.md
head -n 20 sources/Gartner/magic-quadrant-api-management-2024.md
```

### 5. Report Success
**Response to User**:
```
✅ Successfully converted Gartner Magic Quadrant PDF to markdown

Output file: sources/Gartner/magic-quadrant-api-management-2024.md
File size: 45 KB
Format: Markdown (no images)

The document is now ready for analysis. Would you like me to:
1. Create a summary of the key findings?
2. Extract the vendor positioning information?
3. Start a competitive analysis using this report?
```

## Alternative Scenarios

### If Images Are Needed
**User Request**:
```
"Actually, I need the quadrant diagram. Can you include images?"
```

**Updated Command**:
```bash
docling ~/Downloads/gartner-mq-api-management-2024.pdf \
  --output sources/Gartner/magic-quadrant-api-management-2024.md \
  --export-images sources/Gartner/images/
```

**Response**:
```
✅ Re-converted with images exported

Markdown file: sources/Gartner/magic-quadrant-api-management-2024.md
Images folder: sources/Gartner/images/
- quadrant-diagram.png
- vendor-comparison-chart.png

Images are referenced in the markdown file but stored separately.
```

### If File Not Found
**Error Handling**:
```
❌ File not found: ~/Downloads/gartner-mq-api-management-2024.pdf

Please check:
1. Is the file path correct?
2. Does the file exist in that location?
3. Do you have read permissions?

You can use: ls ~/Downloads/*.pdf to list available PDF files.
```

## Best Practices Demonstrated

1. **Confirm file location** before executing commands
2. **Use descriptive output filenames** that include year/version
3. **Organize by source type** (Gartner folder)
4. **Default to no images** for text-focused analysis
5. **Verify successful conversion** before reporting
6. **Offer next steps** to continue the workflow
7. **Handle errors gracefully** with helpful suggestions

## Related Examples
- [Example 2: Convert with Image References](example-2-aws-whitepaper-images.md)
- [Batch Processing Multiple PDFs](example-3-batch-processing.md)