# Error Handling Guide

This guide covers common errors, troubleshooting steps, and recovery strategies for the Research Assistant skill.

## Overview

Effective error handling ensures smooth research workflows even when issues arise. This guide provides systematic approaches to identifying, diagnosing, and resolving common problems.

## Error Handling Philosophy

### Principles

1. **Fail Gracefully**: Provide clear error messages with actionable solutions
2. **Preserve Work**: Never lose user data or progress
3. **Offer Alternatives**: Suggest workarounds when primary methods fail
4. **Learn and Adapt**: Document errors to prevent recurrence

### Error Response Template

```markdown
❌ **Error**: [Brief description]

**What happened**: [Detailed explanation]

**Possible causes**:
- Cause 1
- Cause 2
- Cause 3

**Solutions**:
1. [Primary solution]
2. [Alternative solution]
3. [Workaround]

**Prevention**: [How to avoid this error in the future]
```

## Document Conversion Errors

### Error: File Not Found

```markdown
❌ **Error**: Cannot find source file

**What happened**: The specified file path does not exist or is inaccessible

**Possible causes**:
- Incorrect file path
- File moved or deleted
- Insufficient permissions
- Typo in filename

**Solutions**:
1. Verify the file path:
   ```bash
   ls -la /path/to/file.pdf
   ```

2. Check current directory:
   ```bash
   pwd
   ls
   ```

3. Use absolute path instead of relative:
   ```bash
   docling /Users/username/Documents/file.pdf
   ```

4. Check file permissions:
   ```bash
   chmod 644 file.pdf
   ```

**Prevention**: 
- Use tab completion for file paths
- Verify file exists before conversion
- Use absolute paths for reliability
```

### Error: Conversion Failed

```markdown
❌ **Error**: Document conversion failed

**What happened**: Docling could not convert the document

**Possible causes**:
- Corrupted file
- Unsupported file format
- Password-protected document
- Insufficient memory
- Missing dependencies

**Solutions**:
1. Check file integrity:
   ```bash
   file document.pdf
   # Should show: PDF document, version X.X
   ```

2. Try opening file in native application to verify it's not corrupted

3. For password-protected PDFs:
   ```bash
   # Remove password first (if you have it)
   qpdf --decrypt --password=PASSWORD input.pdf output.pdf
   docling output.pdf
   ```

4. Check available memory:
   ```bash
   # macOS
   vm_stat
   
   # Linux
   free -h
   ```

5. Try alternative conversion:
   ```bash
   # Use different output format
   docling document.pdf --output-format json
   
   # Or use pandoc as fallback
   pandoc document.pdf -o document.md
   ```

6. Verify Docling installation:
   ```bash
   pip show docling
   docling --version
   ```

**Prevention**:
- Test files before batch conversion
- Keep Docling updated
- Monitor system resources
- Maintain file backups
```

### Error: Garbled Text Output

```markdown
❌ **Error**: Converted text contains garbled characters

**What happened**: Text encoding issues during conversion

**Possible causes**:
- Non-standard character encoding
- Special fonts not supported
- OCR errors (for scanned documents)
- Unicode handling issues

**Solutions**:
1. Specify encoding explicitly:
   ```bash
   docling document.pdf --encoding utf-8
   ```

2. For scanned documents, improve OCR:
   ```bash
   # Pre-process with OCR tool
   ocrmypdf input.pdf output.pdf
   docling output.pdf
   ```

3. Try different conversion settings:
   ```bash
   docling document.pdf --ocr-lang eng --preserve-layout
   ```

4. Manual cleanup:
   - Open output in text editor
   - Search and replace common issues
   - Use regex for pattern-based fixes

5. Alternative: Extract text differently:
   ```bash
   # Try pdftotext
   pdftotext -layout document.pdf output.txt
   ```

**Prevention**:
- Use standard fonts in source documents
- Ensure high-quality scans (300+ DPI)
- Test conversion on sample pages first
```

### Error: Missing Images

```markdown
❌ **Error**: Images not extracted from document

**What happened**: Image extraction failed or images not found

**Possible causes**:
- Images embedded in unsupported format
- Extraction directory not writable
- Images are vector graphics
- Insufficient disk space

**Solutions**:
1. Check extraction directory permissions:
   ```bash
   ls -la output_images/
   chmod 755 output_images/
   ```

2. Specify image output directory:
   ```bash
   docling document.pdf --image-dir ./images
   ```

3. Extract images manually:
   ```bash
   # macOS/Linux
   pdfimages -all document.pdf output_prefix
   
   # Or use ImageMagick
   convert -density 300 document.pdf output-%03d.png
   ```

4. Check disk space:
   ```bash
   df -h
   ```

5. For vector graphics, convert to raster:
   ```bash
   # Convert PDF pages to images first
   gs -dNOPAUSE -dBATCH -sDEVICE=png16m -r300 \
      -sOutputFile=page-%03d.png document.pdf
   ```

**Prevention**:
- Ensure sufficient disk space
- Set up proper output directories
- Test image extraction on sample documents
```

## Web Scraping Errors

### Error: Invalid URL

```markdown
❌ **Error**: Cannot access URL

**What happened**: The provided URL is invalid or unreachable

**Possible causes**:
- Typo in URL
- Website is down
- Network connectivity issues
- URL requires authentication
- Blocked by firewall/proxy

**Solutions**:
1. Verify URL format:
   ```bash
   # Test URL accessibility
   curl -I https://example.com
   ```

2. Check network connection:
   ```bash
   ping google.com
   ```

3. Try alternative URL formats:
   ```
   http://example.com  → https://example.com
   www.example.com     → example.com
   ```

4. Check if site is down:
   - Visit https://downforeveryoneorjustme.com
   - Try accessing in browser

5. For authentication-required sites:
   ```python
   # Add authentication to crwl
   crawler.crawl(url, headers={'Authorization': 'Bearer TOKEN'})
   ```

6. Check robots.txt:
   ```bash
   curl https://example.com/robots.txt
   ```

**Prevention**:
- Validate URLs before scraping
- Test URLs in browser first
- Keep list of working URLs
- Handle redirects properly
```

### Error: Incomplete Content Extraction

```markdown
❌ **Error**: Scraped content is incomplete or missing

**What happened**: Not all content was extracted from the webpage

**Possible causes**:
- JavaScript-rendered content
- Dynamic loading (infinite scroll)
- Content behind login/paywall
- Anti-scraping measures
- Incorrect CSS selectors

**Solutions**:
1. Enable JavaScript rendering:
   ```python
   from crawl4ai import WebCrawler
   
   crawler = WebCrawler(verbose=True)
   result = crawler.crawl(
       url,
       js_code="window.scrollTo(0, document.body.scrollHeight);",
       wait_for="css:.content-loaded"
   )
   ```

2. Add wait time for dynamic content:
   ```python
   result = crawler.crawl(url, delay_before_return_html=3.0)
   ```

3. Simulate user interaction:
   ```python
   js_code = """
   // Click "Load More" button
   document.querySelector('.load-more').click();
   // Wait for content
   await new Promise(r => setTimeout(r, 2000));
   """
   result = crawler.crawl(url, js_code=js_code)
   ```

4. Try different extraction strategy:
   ```python
   # Use different extraction strategy
   result = crawler.crawl(
       url,
       extraction_strategy=LLMExtractionStrategy()
   )
   ```

5. Manual browser inspection:
   - Open browser DevTools
   - Check Network tab for API calls
   - Identify data source
   - Scrape API directly if possible

**Prevention**:
- Test scraping on sample pages
- Inspect page structure before scraping
- Use appropriate wait times
- Monitor extraction completeness
```

### Error: Rate Limiting / Blocked

```markdown
❌ **Error**: Access denied or rate limited

**What happened**: Website blocked the scraping request

**Possible causes**:
- Too many requests too quickly
- IP address blocked
- User agent detected as bot
- CAPTCHA challenge
- Terms of service violation

**Solutions**:
1. Add delays between requests:
   ```python
   import time
   
   for url in urls:
       result = crawler.crawl(url)
       time.sleep(2)  # Wait 2 seconds between requests
   ```

2. Use realistic user agent:
   ```python
   headers = {
       'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) '
                    'AppleWebKit/537.36 (KHTML, like Gecko) '
                    'Chrome/91.0.4472.124 Safari/537.36'
   }
   result = crawler.crawl(url, headers=headers)
   ```

3. Rotate user agents:
   ```python
   user_agents = [
       'Mozilla/5.0...',
       'Mozilla/5.0...',
       'Mozilla/5.0...'
   ]
   
   for i, url in enumerate(urls):
       headers = {'User-Agent': user_agents[i % len(user_agents)]}
       result = crawler.crawl(url, headers=headers)
   ```

4. Use proxy rotation:
   ```python
   proxies = ['proxy1:port', 'proxy2:port']
   result = crawler.crawl(url, proxy=proxies[0])
   ```

5. Respect robots.txt:
   ```bash
   curl https://example.com/robots.txt
   # Check Crawl-delay directive
   ```

**Prevention**:
- Always add delays between requests
- Respect robots.txt
- Use reasonable request rates
- Consider API access if available
- Cache results to avoid re-scraping
```

## Research Analysis Errors

### Error: Insufficient Sources

```markdown
❌ **Error**: Not enough sources found for analysis

**What happened**: Search returned too few relevant sources

**Possible causes**:
- Search terms too specific
- Limited source availability
- Incorrect search strategy
- Narrow date range
- Language restrictions

**Solutions**:
1. Broaden search terms:
   ```
   Too specific: "machine learning in healthcare diagnostics 2024"
   Better: "AI healthcare applications"
   ```

2. Use multiple search strategies:
   - Academic databases (Google Scholar, PubMed)
   - Industry reports
   - News articles
   - Government publications
   - Expert blogs

3. Expand date range:
   ```
   Instead of: 2024 only
   Try: 2020-2024
   ```

4. Include related terms:
   ```
   Original: "artificial intelligence"
   Add: "machine learning", "deep learning", "neural networks"
   ```

5. Search in multiple languages:
   ```python
   # Use translation for international sources
   search_terms = ["AI education", "IA éducation", "KI Bildung"]
   ```

**Prevention**:
- Start with broad searches, then narrow
- Use multiple search engines/databases
- Keep list of reliable source repositories
- Build source library over time
```

### Error: Conflicting Information

```markdown
❌ **Error**: Sources contain contradictory information

**What happened**: Different sources provide conflicting data or conclusions

**Possible causes**:
- Different methodologies
- Varying time periods
- Biased sources
- Outdated information
- Different contexts

**Solutions**:
1. Analyze source credibility:
   ```markdown
   ## Source Comparison
   
   **Source A** (2024, Peer-reviewed)
   - Finding: X increases Y by 20%
   - Sample: 1000 participants
   - Method: RCT
   
   **Source B** (2022, Industry report)
   - Finding: X decreases Y by 10%
   - Sample: 50 participants
   - Method: Survey
   
   **Assessment**: Source A more reliable due to:
   - More recent
   - Larger sample
   - Rigorous methodology
   ```

2. Look for consensus:
   - Identify majority opinion
   - Weight by source quality
   - Note dissenting views

3. Examine methodology:
   - Compare research methods
   - Check for confounding variables
   - Assess statistical significance

4. Consider context:
   - Different populations
   - Different time periods
   - Different definitions

5. Present both sides:
   ```markdown
   ## Conflicting Evidence
   
   While most studies (15/20) show positive effects,
   some research (5/20) indicates negative outcomes.
   This discrepancy may be due to [explanation].
   
   Further research is needed to resolve this conflict.
   ```

**Prevention**:
- Use high-quality sources
- Check publication dates
- Compare methodologies
- Seek meta-analyses
- Consult expert reviews
```

### Error: Citation Format Issues

```markdown
❌ **Error**: Citations not properly formatted

**What happened**: References don't follow required citation style

**Possible causes**:
- Inconsistent citation style
- Missing citation elements
- Incorrect formatting
- Mixed citation styles

**Solutions**:
1. Use citation management tools:
   ```bash
   # Install pandoc-citeproc
   pip install pandoc-citeproc
   
   # Convert citations
   pandoc --citeproc --bibliography=refs.bib input.md -o output.docx
   ```

2. Create citation template:
   ```markdown
   ## APA Format Template
   
   Author, A. A. (Year). Title of work. Publisher.
   
   ## Example
   Smith, J. (2024). Research Methods. Academic Press.
   ```

3. Use online citation generators:
   - Zotero
   - Mendeley
   - Citation Machine

4. Batch format citations:
   ```python
   # Python script to standardize citations
   import re
   
   def format_apa(author, year, title, publisher):
       return f"{author} ({year}). {title}. {publisher}."
   ```

5. Validate citations:
   ```bash
   # Check citation format
   grep -E '\[.*\]\(.*\)' document.md
   ```

**Prevention**:
- Choose citation style early
- Use citation management from start
- Create citation templates
- Validate regularly
```

## Report Generation Errors

### Error: Pandoc Conversion Failed

```markdown
❌ **Error**: Cannot convert markdown to Word document

**What happened**: Pandoc failed to generate the output document

**Possible causes**:
- Pandoc not installed
- Invalid markdown syntax
- Missing template file
- Unsupported features
- File permission issues

**Solutions**:
1. Verify Pandoc installation:
   ```bash
   pandoc --version
   
   # If not installed:
   # macOS
   brew install pandoc
   
   # Linux
   sudo apt-get install pandoc
   ```

2. Check markdown syntax:
   ```bash
   # Validate markdown
   pandoc -f markdown -t html input.md -o test.html
   ```

3. Simplify conversion:
   ```bash
   # Basic conversion without template
   pandoc input.md -o output.docx
   ```

4. Check template file:
   ```bash
   # Verify template exists
   ls -la template.docx
   
   # Use default template
   pandoc input.md -o output.docx --reference-doc=default.docx
   ```

5. Debug with verbose output:
   ```bash
   pandoc input.md -o output.docx --verbose
   ```

6. Try alternative format:
   ```bash
   # Generate PDF instead
   pandoc input.md -o output.pdf
   
   # Or HTML
   pandoc input.md -o output.html
   ```

**Prevention**:
- Keep Pandoc updated
- Test conversions regularly
- Validate markdown before conversion
- Maintain working templates
```

### Error: Formatting Lost in Conversion

```markdown
❌ **Error**: Document formatting not preserved

**What happened**: Converted document lost formatting from markdown

**Possible causes**:
- Unsupported markdown features
- Template incompatibility
- Missing CSS/styles
- Complex formatting

**Solutions**:
1. Use reference document:
   ```bash
   pandoc input.md -o output.docx \
     --reference-doc=template.docx
   ```

2. Add explicit formatting:
   ```markdown
   # Use HTML for complex formatting
   <div style="color: blue; font-weight: bold;">
   Important text
   </div>
   ```

3. Use Pandoc extensions:
   ```bash
   pandoc input.md -o output.docx \
     --from markdown+pipe_tables+grid_tables
   ```

4. Create custom template:
   ```bash
   # Extract default template
   pandoc -o custom-template.docx --print-default-data-file reference.docx
   
   # Modify and use
   pandoc input.md -o output.docx --reference-doc=custom-template.docx
   ```

5. Post-process in Word:
   - Open generated document
   - Apply styles manually
   - Save as template for future use

**Prevention**:
- Use supported markdown features
- Test formatting early
- Maintain style templates
- Document formatting requirements
```

### Error: Missing Images in Report

```markdown
❌ **Error**: Images not appearing in generated document

**What happened**: Image references in markdown not converted to document

**Possible causes**:
- Incorrect image paths
- Images not in accessible location
- Unsupported image format
- Path resolution issues

**Solutions**:
1. Use relative paths:
   ```markdown
   # Instead of absolute paths
   ![Chart](./images/chart.png)
   
   # Not
   ![Chart](/Users/username/images/chart.png)
   ```

2. Verify image files exist:
   ```bash
   ls -la images/
   ```

3. Convert images to supported formats:
   ```bash
   # Convert to PNG
   convert image.svg image.png
   ```

4. Embed images as base64:
   ```bash
   # For small images
   pandoc input.md -o output.docx --embed-resources
   ```

5. Copy images to document directory:
   ```bash
   mkdir -p images
   cp /path/to/images/* images/
   ```

**Prevention**:
- Keep images in project directory
- Use relative paths
- Verify image paths before conversion
- Use standard image formats (PNG, JPG)
```

## System and Dependency Errors

### Error: Missing Dependencies

```markdown
❌ **Error**: Required tool not found

**What happened**: A required dependency is not installed

**Possible causes**:
- Tool not installed
- Tool not in PATH
- Wrong version installed
- Virtual environment not activated

**Solutions**:
1. Install missing tool:
   ```bash
   # Docling
   pip install docling
   
   # Crawl4ai
   pip install crawl4ai
   
   # Pandoc
   brew install pandoc  # macOS
   sudo apt-get install pandoc  # Linux
   ```

2. Check PATH:
   ```bash
   echo $PATH
   which python
   which pandoc
   ```

3. Activate virtual environment:
   ```bash
   source venv/bin/activate
   pip list
   ```

4. Verify versions:
   ```bash
   python --version
   pip show docling
   pandoc --version
   ```

5. Reinstall if needed:
   ```bash
   pip uninstall docling
   pip install docling
   ```

**Prevention**:
- Document all dependencies
- Use requirements.txt
- Test in clean environment
- Keep dependencies updated
```

### Error: Permission Denied

```markdown
❌ **Error**: Permission denied when accessing file/directory

**What happened**: Insufficient permissions to read/write files

**Possible causes**:
- File owned by different user
- Directory not writable
- Protected system location
- Incorrect file permissions

**Solutions**:
1. Check permissions:
   ```bash
   ls -la file.pdf
   ls -ld directory/
   ```

2. Change file permissions:
   ```bash
   chmod 644 file.pdf  # Read/write for owner
   chmod 755 directory/  # Execute for directory
   ```

3. Change ownership:
   ```bash
   sudo chown $USER:$USER file.pdf
   ```

4. Use different location:
   ```bash
   # Instead of system directory
   mkdir ~/research-output
   cd ~/research-output
   ```

5. Run with appropriate permissions:
   ```bash
   # Only if absolutely necessary
   sudo command
   ```

**Prevention**:
- Work in user directories
- Set proper permissions initially
- Avoid system directories
- Use appropriate user accounts
```

## Recovery Strategies

### Partial Failure Recovery

```markdown
## When Part of a Batch Operation Fails

1. **Identify successful operations**:
   ```bash
   ls -la output/
   # Check which files were created
   ```

2. **Create list of failed items**:
   ```bash
   # Compare input vs output
   comm -23 <(ls input/) <(ls output/)
   ```

3. **Retry failed items**:
   ```bash
   for file in failed_list.txt; do
       docling "$file" --output output/
   done
   ```

4. **Log failures**:
   ```bash
   echo "$(date): Failed to convert $file" >> errors.log
   ```
```

### Data Preservation

```markdown
## Protecting Work in Progress

1. **Auto-save intermediate results**:
   ```bash
   # Save after each major step
   cp research-notes.md research-notes.backup.md
   ```

2. **Use version control**:
   ```bash
   git add .
   git commit -m "Checkpoint: completed literature review"
   ```

3. **Create recovery points**:
   ```bash
   # Before risky operations
   tar -czf backup-$(date +%Y%m%d).tar.gz research/
   ```
```

### Graceful Degradation

```markdown
## When Primary Method Fails

1. **Try alternative tools**:
   - Docling fails → Try Pandoc
   - Crawl4ai fails → Try manual download
   - Pandoc fails → Export from Word

2. **Simplify requirements**:
   - Complex formatting → Basic formatting
   - All images → Essential images only
   - Perfect extraction → Good enough extraction

3. **Manual intervention**:
   - Automated fails → Semi-automated
   - Semi-automated fails → Manual with templates
   - Document manual steps for future automation
```

## Error Prevention Checklist

### Before Starting

```markdown
- [ ] All dependencies installed and updated
- [ ] Sufficient disk space available
- [ ] Network connection stable
- [ ] File permissions correct
- [ ] Backup of important data
- [ ] Test run on sample data
```

### During Execution

```markdown
- [ ] Monitor progress regularly
- [ ] Check intermediate outputs
- [ ] Log errors immediately
- [ ] Save work frequently
- [ ] Validate results incrementally
```

### After Completion

```markdown
- [ ] Verify all outputs created
- [ ] Check output quality
- [ ] Document any issues
- [ ] Update error log
- [ ] Archive successful workflows
```

## Conclusion

Effective error handling is about preparation, quick diagnosis, and systematic resolution. By following these guidelines and maintaining good documentation, you can minimize disruptions and maintain productive research workflows.

Remember: Every error is an opportunity to improve your processes and documentation.