# Example 1: Creating a New Research Project

This example demonstrates how to initialize a new research project with proper folder structure and metadata.

## Scenario

You need to start a new research project on "API Management Trends 2024" to analyze the current state of the API management market and identify emerging trends.

## Conversation Flow

### User Request
```
User: "I need to start a new research project on API management trends for 2024"
```

### Bob's Response

**Step 1: Clarify Requirements**
```
Bob: "I'll help you set up a research project on API management trends. 
Let me ask a few questions to structure this properly:

1. What's the primary goal? (e.g., vendor comparison, market analysis, trend identification)
2. Do you have specific sources in mind?
3. What deliverables do you need? (e.g., executive summary, full report, presentation)
4. What's your timeline?"
```

### User Clarification
```
User: "I need to:
1. Analyze market trends and identify emerging patterns
2. Start with Gartner and Forrester reports
3. Deliver an executive summary and full research report
4. Complete in 2 weeks"
```

### Bob's Actions

**Step 2: Create Project Structure**
```bash
# Create project directory
mkdir -p research/api-management-trends-2024

# Create subdirectories
mkdir -p research/api-management-trends-2024/{sources,analysis,output}

# Create working files
touch research/api-management-trends-2024/notes.md
touch research/api-management-trends-2024/analysis.md
touch research/api-management-trends-2024/report.md
```

**Step 3: Initialize Project Metadata**
```bash
cat > research/api-management-trends-2024/README.md << 'EOF'
# Research Project: API Management Trends 2024

**Created**: 2024-06-12
**Last Updated**: 2024-06-12
**Status**: In Progress
**Lead Researcher**: [Your Name]
**Timeline**: 2 weeks (Due: 2024-06-26)

## Executive Summary

Analysis of current API management market trends, emerging patterns, and future directions based on analyst reports and industry sources.

## Research Questions

1. What are the dominant trends in API management for 2024?
2. How are vendors adapting to these trends?
3. What emerging technologies are impacting the market?
4. What predictions can we make for 2025?

## Scope

**In Scope**:
- API gateway technologies
- API management platforms
- Market trends and patterns
- Vendor capabilities and positioning
- Emerging technologies (AI/ML, serverless, etc.)

**Out of Scope**:
- Detailed pricing analysis
- Implementation guides
- Specific vendor recommendations

## Sources Used

### Primary Sources
- [ ] Gartner Magic Quadrant for API Management 2024
- [ ] Gartner Market Guide for API Management 2024
- [ ] Forrester Wave: API Management Solutions 2024
- [ ] Forrester Predictions 2024

### Secondary Sources
- [ ] Vendor documentation (Kong, Apigee, AWS)
- [ ] Industry blogs and articles
- [ ] Technical documentation

## Methodology

1. **Source Gathering** (Days 1-2)
   - Convert analyst reports to markdown
   - Scrape relevant vendor documentation
   - Collect industry articles

2. **Analysis** (Days 3-8)
   - Identify key trends across sources
   - Categorize trends by theme
   - Analyze vendor positioning
   - Track emerging technologies

3. **Synthesis** (Days 9-11)
   - Create trend analysis
   - Develop predictions
   - Identify implications

4. **Report Generation** (Days 12-14)
   - Write executive summary
   - Complete full research report
   - Review and finalize

## Key Findings

[To be populated during research]

## Recommendations

[To be developed]

## Timeline

- **Week 1 (June 12-18)**:
  - Days 1-2: Source gathering and conversion
  - Days 3-5: Initial analysis
  - Days 6-7: Deep dive analysis

- **Week 2 (June 19-26)**:
  - Days 8-9: Synthesis and trend identification
  - Days 10-11: Report writing
  - Days 12-13: Review and refinement
  - Day 14: Final delivery

## Deliverables

- [ ] Executive Summary (2-3 pages)
- [ ] Full Research Report (15-20 pages)
- [ ] Trend Analysis Document
- [ ] Source Bibliography

## Next Steps

- [ ] Convert Gartner Magic Quadrant to markdown
- [ ] Convert Forrester Wave to markdown
- [ ] Create initial notes document
- [ ] Set up source tracking

## Notes

- Focus on actionable trends
- Include specific examples from vendors
- Highlight emerging technologies
- Consider implications for different organization sizes
EOF
```

**Step 4: Create Source Index**
```bash
cat > research/api-management-trends-2024/sources/index.md << 'EOF'
# Sources Index - API Management Trends 2024

**Last Updated**: 2024-06-12
**Total Sources**: 0

## Analyst Reports

### Gartner
- [ ] Magic Quadrant for API Management 2024 (Pending conversion)
- [ ] Market Guide for API Management 2024 (Pending conversion)

### Forrester
- [ ] Wave: API Management Solutions 2024 (Pending conversion)
- [ ] Predictions 2024 (Pending conversion)

## Vendor Documentation

### Kong
- [ ] Features overview (Pending scrape)
- [ ] Architecture documentation (Pending scrape)

### Apigee
- [ ] Product capabilities (Pending scrape)
- [ ] Use cases (Pending scrape)

### AWS API Gateway
- [ ] Service documentation (Pending scrape)
- [ ] Best practices (Pending scrape)

## Web Content

### Industry Articles
- [ ] [To be added]

### Technical Blogs
- [ ] [To be added]

## Statistics
- **Total Sources**: 0
- **Converted**: 0
- **Pending**: 8+
- **Last Updated**: 2024-06-12
EOF
```

**Step 5: Initialize Notes File**
```bash
cat > research/api-management-trends-2024/notes.md << 'EOF'
# Research Notes - API Management Trends 2024

## 2024-06-12

### Project Initialization
- Created project structure
- Defined research questions
- Identified initial sources
- Set 2-week timeline

### Initial Observations
[To be added as research progresses]

### Questions to Explore
- How is AI/ML being integrated into API management?
- What role does serverless play in API architectures?
- How are security concerns evolving?

### Ideas
[Capture ideas and insights here]
EOF
```

**Step 6: Create Analysis Template**
```bash
cat > research/api-management-trends-2024/analysis.md << 'EOF'
# Analysis - API Management Trends 2024

## Trend Categories

### 1. Technology Trends
[To be populated]

### 2. Market Trends
[To be populated]

### 3. Vendor Trends
[To be populated]

### 4. Emerging Patterns
[To be populated]

## Cross-Source Analysis

### Common Themes
[Identify themes appearing across multiple sources]

### Divergent Views
[Note where sources disagree]

### Gaps
[Identify missing information]

## Predictions

### Short-term (2024-2025)
[Based on current trends]

### Medium-term (2025-2027)
[Extrapolate from patterns]

## Implications

### For Enterprises
[What this means for large organizations]

### For SMBs
[What this means for smaller organizations]

### For Vendors
[What this means for API management vendors]
EOF
```

### Bob's Confirmation

```
Bob: "✓ Created research project: api-management-trends-2024

Project structure:
research/api-management-trends-2024/
├── README.md (project metadata)
├── notes.md (research notes)
├── analysis.md (analysis template)
├── report.md (report template)
├── sources/
│   └── index.md (source tracking)
├── analysis/ (analysis artifacts)
└── output/ (generated reports)

Next steps:
1. Convert Gartner Magic Quadrant to markdown
2. Convert Forrester Wave to markdown
3. Begin initial analysis

Would you like me to start converting the analyst reports?"
```

## Key Takeaways

### What Bob Did Well

1. **Asked Clarifying Questions**: Understood requirements before creating structure
2. **Created Comprehensive Metadata**: Included timeline, scope, methodology
3. **Set Up Tracking**: Source index and progress tracking
4. **Provided Templates**: Pre-populated files with structure
5. **Clear Next Steps**: Outlined what to do next

### Project Structure Benefits

1. **Organized**: Clear separation of sources, analysis, and output
2. **Documented**: README explains project goals and approach
3. **Trackable**: Source index and progress checklist
4. **Scalable**: Can add more sources and analysis as needed
5. **Collaborative**: Others can understand project structure

### Best Practices Demonstrated

1. **Metadata First**: Created comprehensive README before starting work
2. **Source Tracking**: Set up index to track all sources
3. **Template Usage**: Pre-populated files with structure
4. **Timeline Planning**: Broke work into manageable phases
5. **Clear Deliverables**: Defined what will be produced

## Variations

### Minimal Setup

For quick projects:
```bash
mkdir -p research/quick-project
touch research/quick-project/{README.md,notes.md,report.md}
```

### Advanced Setup

For complex projects:
```bash
mkdir -p research/complex-project/{sources/{documents,web,data},analysis,output/{reports,presentations},archive}
# Create comprehensive metadata and templates
```

### Collaborative Setup

For team projects:
```bash
# Initialize with git
cd research/team-project
git init
# Add .gitignore, CONTRIBUTING.md, etc.
```

## Related Examples

- [Example 2: Organizing Sources](example-2-organizing-sources.md) - Managing source materials
- [Example 3: Project Maintenance](example-3-project-maintenance.md) - Keeping projects organized

## Related Documentation

- [Project Initialization Guide](../../guides/project-initialization.md) - Detailed guide
- [Source Organization Guide](../../guides/source-organization.md) - Source management
- [Main SKILL.md](../../SKILL.md) - Complete skill documentation