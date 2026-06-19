# Error Handling Patterns

This document provides reusable error handling patterns for common research assistant operations.

## Pattern Categories

1. **Defensive Programming**: Prevent errors before they occur
2. **Graceful Degradation**: Provide fallbacks when primary methods fail
3. **Clear Communication**: Give users actionable error messages
4. **Recovery Strategies**: Help users recover from failures
5. **Logging & Monitoring**: Track issues for improvement

## Document Conversion Patterns

### Pattern 1: Pre-Flight Validation

**Purpose**: Catch issues before attempting conversion

```bash
#!/bin/bash
# validate-before-convert.sh

convert_document() {
    local input_file="$1"
    local output_file="$2"
    
    # Check if input file exists
    if [ ! -f "$input_file" ]; then
        echo "❌ Error: Input file not found: $input_file"
        echo "💡 Solution: Check the file path and spelling"
        return 1
    fi
    
    # Check if file is readable
    if [ ! -r "$input_file" ]; then
        echo "❌ Error: Cannot read file: $input_file"
        echo "💡 Solution: Check file permissions"
        echo "   Run: chmod 644 $input_file"
        return 1
    fi
    
    # Check file size (warn if too large)
    local size=$(stat -f%z "$input_file" 2>/dev/null || stat -c%s "$input_file" 2>/dev/null)
    if [ "$size" -gt 104857600 ]; then  # 100MB
        echo "⚠️  Warning: Large file ($((size/1048576))MB)"
        echo "   This may take a while or fail due to memory constraints"
        read -p "   Continue? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            return 1
        fi
    fi
    
    # Check if output directory exists
    local output_dir=$(dirname "$output_file")
    if [ ! -d "$output_dir" ]; then
        echo "⚠️  Output directory doesn't exist: $output_dir"
        echo "   Creating directory..."
        mkdir -p "$output_dir" || {
            echo "❌ Error: Cannot create directory"
            return 1
        }
    fi
    
    # Check if output file already exists
    if [ -f "$output_file" ]; then
        echo "⚠️  Output file already exists: $output_file"
        read -p "   Overwrite? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "   Conversion cancelled"
            return 1
        fi
    fi
    
    # All checks passed
    echo "✓ Pre-flight checks passed"
    return 0
}

# Usage
if convert_document "input.pdf" "output.md"; then
    echo "Proceeding with conversion..."
    docling "input.pdf" --output "output.md"
else
    echo "Conversion aborted due to validation errors"
fi
```

### Pattern 2: Fallback Chain

**Purpose**: Try multiple conversion methods

```bash
#!/bin/bash
# convert-with-fallback.sh

convert_with_fallback() {
    local input_file="$1"
    local output_file="$2"
    
    echo "Attempting conversion: $input_file → $output_file"
    
    # Method 1: Docling (primary)
    echo "Method 1: Trying docling..."
    if docling "$input_file" --output "$output_file" 2>/dev/null; then
        echo "✓ Conversion successful using docling"
        return 0
    fi
    echo "⚠️  Docling failed, trying alternative..."
    
    # Method 2: Pandoc (fallback)
    echo "Method 2: Trying pandoc..."
    if pandoc "$input_file" -o "$output_file" 2>/dev/null; then
        echo "✓ Conversion successful using pandoc"
        echo "ℹ️  Note: Formatting may differ from docling output"
        return 0
    fi
    echo "⚠️  Pandoc failed, trying final method..."
    
    # Method 3: pdftotext (last resort for PDFs)
    if [[ "$input_file" == *.pdf ]]; then
        echo "Method 3: Trying pdftotext..."
        if pdftotext -layout "$input_file" "${output_file%.md}.txt" 2>/dev/null; then
            # Convert txt to md
            echo "# $(basename "$input_file" .pdf)" > "$output_file"
            echo "" >> "$output_file"
            cat "${output_file%.md}.txt" >> "$output_file"
            rm "${output_file%.md}.txt"
            echo "✓ Text extraction successful using pdftotext"
            echo "⚠️  Warning: Minimal formatting preserved"
            return 0
        fi
    fi
    
    # All methods failed
    echo "❌ All conversion methods failed"
    echo ""
    echo "💡 Troubleshooting steps:"
    echo "   1. Check if file is corrupted: Try opening in native app"
    echo "   2. Check if file is password-protected"
    echo "   3. Try converting a single page first"
    echo "   4. Check available memory: vm_stat (macOS) or free -h (Linux)"
    echo "   5. Update tools: pip install --upgrade docling"
    echo ""
    echo "💡 Manual alternatives:"
    echo "   1. Open file and copy/paste content"
    echo "   2. Export as different format first (e.g., PDF → DOCX → MD)"
    echo "   3. Use online conversion service"
    
    return 1
}

# Usage
convert_with_fallback "document.pdf" "output.md"
```

### Pattern 3: Batch with Error Recovery

**Purpose**: Continue batch operations despite individual failures

```bash
#!/bin/bash
# batch-convert-resilient.sh

batch_convert() {
    local input_dir="$1"
    local output_dir="$2"
    
    # Initialize counters
    local total=0
    local success=0
    local failed=0
    
    # Create output directory
    mkdir -p "$output_dir"
    
    # Create error log
    local error_log="$output_dir/conversion-errors.log"
    echo "Conversion Error Log - $(date)" > "$error_log"
    echo "================================" >> "$error_log"
    echo "" >> "$error_log"
    
    # Process each file
    for input_file in "$input_dir"/*.pdf; do
        [ -f "$input_file" ] || continue
        
        total=$((total + 1))
        local filename=$(basename "$input_file" .pdf)
        local output_file="$output_dir/${filename}.md"
        
        echo "[$total] Processing: $filename"
        
        # Try conversion with timeout
        if timeout 300 docling "$input_file" --output "$output_file" 2>&1 | tee -a "$error_log"; then
            if [ -f "$output_file" ] && [ -s "$output_file" ]; then
                echo "  ✓ Success"
                success=$((success + 1))
            else
                echo "  ❌ Failed: Output file empty or missing"
                failed=$((failed + 1))
                echo "FAILED: $input_file (empty output)" >> "$error_log"
            fi
        else
            echo "  ❌ Failed: Conversion error or timeout"
            failed=$((failed + 1))
            echo "FAILED: $input_file (error or timeout)" >> "$error_log"
        fi
        
        echo ""
    done
    
    # Summary
    echo "================================"
    echo "Batch Conversion Summary"
    echo "================================"
    echo "Total files:    $total"
    echo "Successful:     $success"
    echo "Failed:         $failed"
    echo "Success rate:   $((success * 100 / total))%"
    echo ""
    echo "Error log saved to: $error_log"
    
    # Offer to retry failed conversions
    if [ $failed -gt 0 ]; then
        echo ""
        echo "💡 To retry failed conversions:"
        echo "   1. Review error log: cat $error_log"
        echo "   2. Fix issues (e.g., remove corrupted files)"
        echo "   3. Run script again on failed files only"
    fi
}

# Usage
batch_convert "sources/raw" "sources/processed"
```

## Web Scraping Patterns

### Pattern 4: URL Validation

**Purpose**: Verify URLs before scraping

```bash
#!/bin/bash
# validate-url.sh

validate_url() {
    local url="$1"
    
    # Check URL format
    if [[ ! "$url" =~ ^https?:// ]]; then
        echo "❌ Error: Invalid URL format: $url"
        echo "💡 Solution: URL must start with http:// or https://"
        return 1
    fi
    
    # Check if URL is accessible
    echo "Checking URL accessibility..."
    local http_code=$(curl -o /dev/null -s -w "%{http_code}" -L "$url")
    
    case $http_code in
        200)
            echo "✓ URL is accessible (HTTP $http_code)"
            return 0
            ;;
        301|302|303|307|308)
            echo "⚠️  URL redirects (HTTP $http_code)"
            local final_url=$(curl -Ls -o /dev/null -w %{url_effective} "$url")
            echo "   Final URL: $final_url"
            read -p "   Continue with redirect? (y/n) " -n 1 -r
            echo
            [[ $REPLY =~ ^[Yy]$ ]] && return 0 || return 1
            ;;
        401|403)
            echo "❌ Error: Access denied (HTTP $http_code)"
            echo "💡 Solution: URL requires authentication or is forbidden"
            return 1
            ;;
        404)
            echo "❌ Error: Page not found (HTTP $http_code)"
            echo "💡 Solution: Check URL spelling and availability"
            return 1
            ;;
        500|502|503|504)
            echo "❌ Error: Server error (HTTP $http_code)"
            echo "💡 Solution: Try again later or contact site administrator"
            return 1
            ;;
        000)
            echo "❌ Error: Cannot connect to server"
            echo "💡 Possible causes:"
            echo "   - No internet connection"
            echo "   - DNS resolution failed"
            echo "   - Firewall blocking connection"
            return 1
            ;;
        *)
            echo "⚠️  Unexpected HTTP code: $http_code"
            read -p "   Attempt scraping anyway? (y/n) " -n 1 -r
            echo
            [[ $REPLY =~ ^[Yy]$ ]] && return 0 || return 1
            ;;
    esac
}

# Usage
if validate_url "https://example.com/article"; then
    echo "Proceeding with scraping..."
    crwl crawl "https://example.com/article" --output markdown
else
    echo "Scraping aborted"
fi
```

### Pattern 5: Rate-Limited Scraping

**Purpose**: Respect rate limits and handle blocking

```bash
#!/bin/bash
# rate-limited-scraping.sh

scrape_with_rate_limit() {
    local url_file="$1"
    local output_dir="$2"
    local delay="${3:-2}"  # Default 2 seconds between requests
    
    mkdir -p "$output_dir"
    
    local count=0
    local failed=0
    
    while IFS= read -r url; do
        [ -z "$url" ] && continue
        
        count=$((count + 1))
        echo "[$count] Scraping: $url"
        
        # Generate output filename
        local filename=$(echo "$url" | sed 's|https\?://||' | sed 's|[^a-zA-Z0-9]|-|g')
        local output_file="$output_dir/${filename}.md"
        
        # Attempt scraping with retry logic
        local attempts=0
        local max_attempts=3
        local success=false
        
        while [ $attempts -lt $max_attempts ]; do
            attempts=$((attempts + 1))
            
            if crwl crawl "$url" --output markdown --output-file "$output_file" 2>&1; then
                if [ -f "$output_file" ] && [ -s "$output_file" ]; then
                    echo "  ✓ Success"
                    success=true
                    break
                fi
            fi
            
            # Check if we were rate limited or blocked
            if grep -q "429\|rate limit\|too many requests" "$output_file" 2>/dev/null; then
                echo "  ⚠️  Rate limited (attempt $attempts/$max_attempts)"
                local backoff=$((delay * attempts * 2))
                echo "  Waiting ${backoff}s before retry..."
                sleep $backoff
            elif grep -q "403\|blocked\|forbidden" "$output_file" 2>/dev/null; then
                echo "  ❌ Blocked by server"
                failed=$((failed + 1))
                break
            else
                echo "  ⚠️  Failed (attempt $attempts/$max_attempts)"
                sleep $delay
            fi
        done
        
        if [ "$success" = false ]; then
            echo "  ❌ Failed after $max_attempts attempts"
            failed=$((failed + 1))
            echo "$url" >> "$output_dir/failed-urls.txt"
        fi
        
        # Delay before next request
        if [ $count -lt $(wc -l < "$url_file") ]; then
            echo "  Waiting ${delay}s before next request..."
            sleep $delay
        fi
        
    done < "$url_file"
    
    # Summary
    echo ""
    echo "Scraping complete: $((count - failed))/$count successful"
    
    if [ $failed -gt 0 ]; then
        echo "Failed URLs saved to: $output_dir/failed-urls.txt"
        echo ""
        echo "💡 To retry failed URLs:"
        echo "   1. Review failed URLs"
        echo "   2. Increase delay: scrape_with_rate_limit urls.txt output/ 5"
        echo "   3. Try different user agent or proxy"
    fi
}

# Usage
scrape_with_rate_limit "urls.txt" "scraped-content" 2
```

### Pattern 6: Content Validation

**Purpose**: Verify scraped content quality

```bash
#!/bin/bash
# validate-scraped-content.sh

validate_scraped_content() {
    local output_file="$1"
    local min_words="${2:-100}"  # Minimum expected word count
    
    if [ ! -f "$output_file" ]; then
        echo "❌ Error: Output file not found"
        return 1
    fi
    
    # Check file size
    local size=$(stat -f%z "$output_file" 2>/dev/null || stat -c%s "$output_file" 2>/dev/null)
    if [ "$size" -lt 100 ]; then
        echo "❌ Error: Output file too small (${size} bytes)"
        echo "💡 Possible causes:"
        echo "   - Scraping failed"
        echo "   - Page requires JavaScript"
        echo "   - Content behind login"
        return 1
    fi
    
    # Check word count
    local word_count=$(wc -w < "$output_file")
    if [ "$word_count" -lt "$min_words" ]; then
        echo "⚠️  Warning: Low word count ($word_count words)"
        echo "   Expected at least $min_words words"
        echo "💡 Possible issues:"
        echo "   - Incomplete content extraction"
        echo "   - Page mostly navigation/ads"
        echo "   - Dynamic content not loaded"
    fi
    
    # Check for common scraping issues
    if grep -q "Access Denied\|403 Forbidden\|404 Not Found" "$output_file"; then
        echo "❌ Error: Access denied or page not found"
        return 1
    fi
    
    if grep -q "Please enable JavaScript\|JavaScript is required" "$output_file"; then
        echo "⚠️  Warning: Page requires JavaScript"
        echo "💡 Solution: Use browser-based scraping with JS enabled"
    fi
    
    # Check for actual content (not just navigation)
    if ! grep -q "^# " "$output_file"; then
        echo "⚠️  Warning: No headings found"
        echo "   Content may be incomplete"
    fi
    
    # Check for links (indicates proper extraction)
    local link_count=$(grep -c "http" "$output_file" || echo "0")
    if [ "$link_count" -eq 0 ]; then
        echo "⚠️  Warning: No links found"
        echo "   Content extraction may be incomplete"
    fi
    
    echo "✓ Content validation complete"
    echo "  File size: ${size} bytes"
    echo "  Word count: $word_count words"
    echo "  Links found: $link_count"
    
    return 0
}

# Usage
if validate_scraped_content "output.md" 200; then
    echo "Content quality acceptable"
else
    echo "Content quality issues detected"
fi
```

## Research Analysis Patterns

### Pattern 7: Citation Validation

**Purpose**: Ensure all claims are properly cited

```python
#!/usr/bin/env python3
# validate-citations.py

import re
import sys
from pathlib import Path

def validate_citations(markdown_file, min_citations=5):
    """Validate citations in research document"""
    
    try:
        content = Path(markdown_file).read_text()
    except FileNotFoundError:
        print(f"❌ Error: File not found: {markdown_file}")
        return False
    except Exception as e:
        print(f"❌ Error reading file: {e}")
        return False
    
    # Find all citations [text](url)
    citations = re.findall(r'\[([^\]]+)\]\(([^)]+)\)', content)
    
    print(f"Found {len(citations)} citations")
    
    if len(citations) < min_citations:
        print(f"⚠️  Warning: Low citation count (expected at least {min_citations})")
        print("💡 Consider adding more sources to support your claims")
    
    # Check for broken references
    broken = []
    for text, url in citations:
        if url.startswith('http'):
            # External link - could validate with requests
            pass
        elif url.startswith('#'):
            # Internal anchor - check if exists
            anchor = url[1:]
            if not re.search(f'#{anchor}', content):
                broken.append(url)
        else:
            # Local file reference
            ref_path = Path(markdown_file).parent / url
            if not ref_path.exists():
                broken.append(url)
    
    if broken:
        print(f"❌ Found {len(broken)} broken references:")
        for url in broken:
            print(f"   - {url}")
        print("💡 Fix broken references or remove them")
        return False
    
    # Check for uncited paragraphs
    paragraphs = [p for p in content.split('\n\n') if len(p.strip()) > 50]
    uncited = []
    
    for para in paragraphs:
        # Skip headings, code blocks, lists
        if para.startswith('#') or para.startswith('```') or para.startswith('-'):
            continue
        # Check if paragraph has citation
        if not re.search(r'\[([^\]]+)\]\(([^)]+)\)', para):
            uncited.append(para[:100] + '...')
    
    if uncited:
        print(f"⚠️  Found {len(uncited)} paragraphs without citations:")
        for i, para in enumerate(uncited[:5], 1):  # Show first 5
            print(f"   {i}. {para}")
        if len(uncited) > 5:
            print(f"   ... and {len(uncited) - 5} more")
        print("💡 Consider adding citations to support claims")
    
    print("✓ Citation validation complete")
    return True

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: validate-citations.py <markdown-file> [min-citations]")
        sys.exit(1)
    
    markdown_file = sys.argv[1]
    min_citations = int(sys.argv[2]) if len(sys.argv) > 2 else 5
    
    success = validate_citations(markdown_file, min_citations)
    sys.exit(0 if success else 1)
```

## Report Generation Patterns

### Pattern 8: Pre-Generation Validation

**Purpose**: Catch issues before generating final report

```bash
#!/bin/bash
# validate-before-report.sh

validate_report_ready() {
    local markdown_file="$1"
    local issues=0
    
    echo "Validating report readiness..."
    echo ""
    
    # Check file exists
    if [ ! -f "$markdown_file" ]; then
        echo "❌ Markdown file not found: $markdown_file"
        return 1
    fi
    
    # Check file size
    local size=$(stat -f%z "$markdown_file" 2>/dev/null || stat -c%s "$markdown_file" 2>/dev/null)
    if [ "$size" -lt 1000 ]; then
        echo "❌ File too small (${size} bytes) - likely incomplete"
        issues=$((issues + 1))
    else
        echo "✓ File size acceptable (${size} bytes)"
    fi
    
    # Check for required sections
    local required_sections=("# " "## Introduction" "## Conclusion" "## References")
    for section in "${required_sections[@]}"; do
        if grep -q "$section" "$markdown_file"; then
            echo "✓ Found: $section"
        else
            echo "❌ Missing: $section"
            issues=$((issues + 1))
        fi
    done
    
    # Check for images
    local image_count=$(grep -c "!\[.*\](" "$markdown_file" || echo "0")
    if [ "$image_count" -gt 0 ]; then
        echo "✓ Found $image_count image references"
        
        # Verify image files exist
        local missing_images=0
        while IFS= read -r image_path; do
            local img_file=$(echo "$image_path" | sed 's/.*(\(.*\))/\1/')
            if [ ! -f "$img_file" ]; then
                echo "  ⚠️  Image not found: $img_file"
                missing_images=$((missing_images + 1))
            fi
        done < <(grep "!\[.*\](" "$markdown_file")
        
        if [ $missing_images -gt 0 ]; then
            echo "❌ $missing_images image(s) missing"
            issues=$((issues + 1))
        fi
    fi
    
    # Check for tables
    local table_count=$(grep -c "^|" "$markdown_file" || echo "0")
    if [ "$table_count" -gt 0 ]; then
        echo "✓ Found tables ($table_count rows)"
    fi
    
    # Check for citations
    local citation_count=$(grep -o '\[.*\](' "$markdown_file" | wc -l)
    if [ "$citation_count" -lt 5 ]; then
        echo "⚠️  Low citation count ($citation_count)"
        echo "   Consider adding more sources"
    else
        echo "✓ Found $citation_count citations"
    fi
    
    # Summary
    echo ""
    if [ $issues -eq 0 ]; then
        echo "✓ Report ready for generation"
        return 0
    else
        echo "❌ Found $issues issue(s) - fix before generating report"
        echo ""
        echo "💡 Recommendations:"
        echo "   1. Add missing sections"
        echo "   2. Verify all image files exist"
        echo "   3. Ensure sufficient content and citations"
        return 1
    fi
}

# Usage
if validate_report_ready "report.md"; then
    echo "Generating report..."
    pandoc report.md -o report.docx
else
    echo "Please fix issues before generating report"
fi
```

### Pattern 9: Post-Generation Verification

**Purpose**: Verify generated report quality

```bash
#!/bin/bash
# verify-generated-report.sh

verify_report() {
    local report_file="$1"
    
    echo "Verifying generated report..."
    echo ""
    
    # Check file exists
    if [ ! -f "$report_file" ]; then
        echo "❌ Report file not found: $report_file"
        return 1
    fi
    
    # Check file size
    local size=$(stat -f%z "$report_file" 2>/dev/null || stat -c%s "$report_file" 2>/dev/null)
    local size_mb=$((size / 1048576))
    
    if [ "$size" -lt 10000 ]; then
        echo "❌ Report file too small (${size} bytes)"
        echo "💡 Generation likely failed - check error messages"
        return 1
    elif [ "$size_mb" -gt 50 ]; then
        echo "⚠️  Report file very large (${size_mb}MB)"
        echo "   May have issues with embedded images"
    else
        echo "✓ File size acceptable (${size_mb}MB)"
    fi
    
    # Try to open file (basic validation)
    case "$report_file" in
        *.docx)
            if command -v unzip &> /dev/null; then
                if unzip -t "$report_file" &> /dev/null; then
                    echo "✓ DOCX file structure valid"
                else
                    echo "❌ DOCX file corrupted"
                    return 1
                fi
            fi
            ;;
        *.pdf)
            if command -v pdfinfo &> /dev/null; then
                if pdfinfo "$report_file" &> /dev/null; then
                    local pages=$(pdfinfo "$report_file" | grep "Pages:" | awk '{print $2}')
                    echo "✓ PDF valid ($pages pages)"
                else
                    echo "❌ PDF file corrupted"
                    return 1
                fi
            fi
            ;;
    esac
    
    echo ""
    echo "✓ Report verification complete"
    echo ""
    echo "💡 Manual checks recommended:"
    echo "   1. Open file and verify formatting"
    echo "   2. Check table of contents"
    echo "   3. Verify all images display correctly"
    echo "   4. Check page numbers and headers"
    echo "   5. Review references section"
    
    return 0
}

# Usage
verify_report "report.docx"
```

## General Error Handling Patterns

### Pattern 10: Comprehensive Error Handler

**Purpose**: Centralized error handling for scripts

```bash
#!/bin/bash
# error-handler.sh

# Enable strict error handling
set -euo pipefail

# Error handler function
error_handler() {
    local line_number=$1
    local command=$2
    local error_code=$3
    
    echo ""
    echo "❌ Error occurred in script"
    echo "   Line: $line_number"
    echo "   Command: $command"
    echo "   Exit code: $error_code"
    echo ""
    
    # Provide context-specific help
    case $error_code in
        1)
            echo "💡 General error - check command syntax and arguments"
            ;;
        2)
            echo "💡 Misuse of shell command - check script logic"
            ;;
        126)
            echo "💡 Command cannot execute - check permissions"
            echo "   Try: chmod +x script.sh"
            ;;
        127)
            echo "💡 Command not found - check if tool is installed"
            ;;
        130)
            echo "💡 Script terminated by Ctrl+C"
            ;;
        *)
            echo "💡 Check error message above for details"
            ;;
    esac
    
    # Cleanup on error
    cleanup_on_error
    
    exit $error_code
}

# Cleanup function
cleanup_on_error() {
    echo ""
    echo "Performing cleanup..."
    
    # Remove temporary files
    rm -f /tmp/research-assistant-*
    
    # Log error
    echo "$(date): Error in script at line $1" >> error.log
    
    echo "Cleanup complete"
}

# Set error trap
trap 'error_handler ${LINENO} "$BASH_COMMAND" $?' ERR

# Your script logic here
echo "Script running with error handling..."
```

## Using These Patterns

### Integration Example

```bash
#!/bin/bash
# complete-workflow-with-error-handling.sh

# Source error handler
source error-handler.sh

# Source validation functions
source validate-before-convert.sh
source validate-url.sh

# Main workflow
main() {
    local input_file="$1"
    local url="$2"
    
    echo "Starting research workflow..."
    
    # Step 1: Convert document with validation
    if convert_document "$input_file" "output.md"; then
        echo "✓ Document conversion complete"
    else
        echo "❌ Document conversion failed"
        return 1
    fi
    
    # Step 2: Scrape web content with validation
    if validate_url "$url"; then
        crwl crawl "$url" --output markdown --output-file "scraped.md"
        echo "✓ Web scraping complete"
    else
        echo "❌ Web scraping failed"
        return 1
    fi
    
    # Step 3: Generate report with validation
    if validate_report_ready "report.md"; then
        pandoc report.md -o report.docx
        verify_report "report.docx"
        echo "✓ Report generation complete"
    else
        echo "❌ Report generation failed"
        return 1
    fi
    
    echo ""
    echo "✓ Workflow complete!"
}

# Run main workflow
main "$@"
```

## Best Practices

1. **Always validate inputs** before processing
2. **Provide clear error messages** with actionable solutions
3. **Implement fallback strategies** for critical operations
4. **Log errors** for debugging and improvement
5. **Clean up** temporary files on error
6. **Test error paths** as thoroughly as success paths
7. **Document common issues** and their solutions
8. **Update patterns** based on real-world experience

## Conclusion

These error handling patterns help create robust, user-friendly research workflows. Adapt them to your specific needs and always prioritize clear communication when things go wrong.