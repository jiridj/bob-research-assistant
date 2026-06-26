# Conversation Flows Guide

This guide demonstrates multi-turn conversation patterns for complex research workflows.

## Overview

Effective research assistance requires maintaining context across multiple interactions, asking clarifying questions, and guiding users through complex workflows.

## Flow Patterns

### Pattern 1: New Research Project with Wiki

**Scenario**: User starts a new research project, ingests a source, reviews the inbox, and merges into the wiki.

**Flow Structure**:
1. Project initialization
2. Source ingest → inbox draft
3. Human review and approval
4. Merge into wiki
5. Query against wiki

**Complete Conversation**:

```
User: "Start a new research project on API management trends"

Bob: "A few questions to scope this properly:
1. What's the primary goal? (vendor comparison, trend identification, market sizing)
2. What decisions will this research inform?
3. Scope and timeline?

Or say 'just set it up' and I'll create the structure and we'll fill in goals.md together."

User: "Just set it up"

Bob: [Creates project structure]

✓ Created research/api-management-trends/
  goals.md, notes/, analysis/, reports/

Note: wiki/ and inbox/ are at the repo root and shared across all projects.

Fill in goals.md when you're ready, then add your first source."

User: "Ingest sources/Gartner/gartner-mq-2025.md"

Bob: [Reads source, drafts inbox entry]

✓ Inbox entry ready: inbox/gartner-mq-2025/

  manifest.md  — 5 items pending review
  summary.md   — source summary page
  new-pages.md — 3 proposed new pages (Apigee, Kong, API Management)
  diff.md      — 2 proposed updates (overview.md, Kong entity)

Review the inbox folder, check off items you approve in manifest.md, edit any files freely.
When ready: 'merge inbox/gartner-mq-2025'"

User: [Reviews files, checks 4 of 5 items in manifest.md, edits a claim in diff.md]

User: "merge inbox/gartner-mq-2025"

Bob: [Reads manifest, processes checked items only]

✓ Merged inbox/gartner-mq-2025:
  Created: wiki/sources/gartner-mq-2025.md
  Created: wiki/entities/Apigee.md
  Created: wiki/concepts/api-management.md
  Updated: wiki/entities/Kong.md
  Skipped: wiki/overview.md (unchecked)
  Updated: wiki/index.md
  Appended: wiki/log.md
  Archived: inbox/.archive/gartner-mq-2025/

User: "What's Kong's current market position?"

Bob: [Reads wiki/index.md → wiki/entities/Kong.md]

Based on wiki/entities/Kong.md (updated from gartner-mq-2025):
Kong holds a Challengers position in the 2025 Gartner MQ, up from Niche Players in 2023...

This answer is worth saving. Say 'file this answer' to add it to the wiki."
```

### Pattern 2: Document Processing Workflow

**Scenario**: User has multiple documents to process and analyze

**Flow Structure**:
1. Document identification
2. Batch processing
3. Organization
4. Initial analysis

**Complete Conversation**:

```
User: "I have 5 PDFs from AWS re:Invent. Convert them to markdown"

Bob: "I'll help you convert the AWS re:Invent PDFs.

First, where are the PDFs located?
1. ~/Downloads/
2. ~/Documents/
3. Specify custom path"

User: "They're in ~/Downloads/reinvent-2024/"

Bob: "Found 5 PDFs in ~/Downloads/reinvent-2024/:
1. serverless-best-practices.pdf (45 pages)
2. api-gateway-deep-dive.pdf (38 pages)
3. lambda-performance.pdf (52 pages)
4. security-patterns.pdf (41 pages)
5. cost-optimization.pdf (35 pages)

Where should I save the converted files?
Suggested: sources/vendor-docs/aws/reinvent-2024/

Or specify custom location."

User: "Use the suggested location"

Bob: "Perfect. A few more questions:

1. Image handling:
   - Exclude images (faster, text-only)
   - Export images separately (for reference)
   
2. Should I create a project for this content?
   - Yes, create 'aws-reinvent-2024' project
   - No, just convert and organize
   
3. Any specific naming convention?
   - Use original names
   - Use descriptive names (e.g., 'serverless-best-practices-2024.md')"

User: "Exclude images, create a project, use descriptive names"

Bob: "Great! I'll:
1. Convert 5 PDFs to markdown (excluding images)
2. Save to sources/vendor-docs/aws/reinvent-2024/
3. Create research/aws-reinvent-2024/ project
4. Use descriptive naming

Proceed?"

User: "Yes"

Bob: [Executes batch conversion]

"✓ Conversion complete

Converted 5 PDFs:
1. sources/vendor-docs/aws/reinvent-2024/serverless-best-practices-2024.md (45 pages)
2. sources/vendor-docs/aws/reinvent-2024/api-gateway-deep-dive-2024.md (38 pages)
3. sources/vendor-docs/aws/reinvent-2024/lambda-performance-2024.md (52 pages)
4. sources/vendor-docs/aws/reinvent-2024/security-patterns-2024.md (41 pages)
5. sources/vendor-docs/aws/reinvent-2024/cost-optimization-2024.md (35 pages)

Total: 211 pages converted

✓ Created project: research/aws-reinvent-2024/
✓ Updated source index

Would you like me to:
1. Create an initial analysis of the content
2. Extract key takeaways from each document
3. Compare with other vendor approaches"

User: "Extract key takeaways from each document"

Bob: "I'll extract key takeaways from all 5 documents.

For each document, I'll identify:
- Main topics covered
- Best practices recommended
- Key technical details
- Action items

This will take a few minutes. Proceed?"

User: "Yes"

Bob: [Analyzes documents]

"✓ Key takeaways extracted

Created: research/aws-reinvent-2024/analysis/key-takeaways.md

Summary by document:

1. Serverless Best Practices (8 takeaways)
   - Cold start optimization techniques
   - Event-driven architecture patterns
   - Cost management strategies

2. API Gateway Deep Dive (6 takeaways)
   - Request/response transformation
   - Caching strategies
   - Integration patterns

3. Lambda Performance (10 takeaways)
   - Memory optimization
   - Concurrency management
   - Monitoring and debugging

4. Security Patterns (7 takeaways)
   - IAM best practices
   - Encryption strategies
   - Threat detection

5. Cost Optimization (5 takeaways)
   - Right-sizing functions
   - Reserved capacity
   - Monitoring and alerts

Total: 36 key takeaways documented

Would you like me to:
1. Create a consolidated summary
2. Compare with Azure/GCP approaches
3. Generate an implementation guide"
```

### Pattern 3: Comparative Research

**Scenario**: User wants to compare multiple vendors or solutions

**Flow Structure**:
1. Define comparison scope
2. Gather sources
3. Extract comparable data
4. Create comparison matrix
5. Generate insights

**Complete Conversation**:

```
User: "I need to compare Kong, Apigee, and AWS API Gateway"

Bob: "I'll help you create a comprehensive comparison of Kong, Apigee, and AWS API Gateway.

First, what aspects are most important for your comparison?
1. Features and capabilities
2. Performance and scalability
3. Pricing and licensing
4. Ease of use and deployment
5. Ecosystem and integrations
6. All of the above

Or specify custom criteria."

User: "Focus on features, performance, and pricing"

Bob: "Perfect. I'll compare Kong, Apigee, and AWS API Gateway on:
- Features and capabilities
- Performance and scalability
- Pricing and licensing

Let me search for relevant sources...

Found sources:

Kong (5):
- Gartner MQ evaluation
- Forrester Wave assessment
- Kong features documentation
- Kong performance benchmarks
- Kong pricing page

Apigee (5):
- Gartner MQ evaluation
- Forrester Wave assessment
- Apigee capabilities documentation
- Apigee performance data
- Apigee pricing information

AWS API Gateway (4):
- Gartner MQ evaluation
- Forrester Wave assessment
- AWS documentation
- AWS pricing calculator

Should I:
1. Use all available sources
2. Focus on analyst reports only
3. Let you select specific sources"

User: "Use all available sources"

Bob: "✓ Using 14 sources for comparison

I'll create a comprehensive comparison covering:

Features:
- Core API management capabilities
- Security features
- Developer tools
- Analytics and monitoring
- Plugin/extension ecosystem

Performance:
- Throughput (requests/second)
- Latency (p50, p95, p99)
- Scalability limits
- Resource efficiency

Pricing:
- Licensing models
- Cost per million requests
- Enterprise pricing
- Hidden costs

This will take several minutes. Proceed?"

User: "Yes"

Bob: [Performs analysis]

"✓ Comparison analysis complete

Created: research/vendor-comparison/analysis/kong-apigee-aws-comparison.md

Comparison Matrix:

Features (15 criteria):
- Kong: 13/15 ✓
- Apigee: 14/15 ✓
- AWS: 12/15 ✓

Performance:
- Kong: 50K req/s, 5ms p95 latency
- Apigee: 45K req/s, 8ms p95 latency
- AWS: 10K req/s, 12ms p95 latency

Pricing (per 1M requests):
- Kong: $0.50 (self-hosted) to $2.50 (managed)
- Apigee: $3.50 (standard) to $7.00 (enterprise)
- AWS: $3.50 (REST) to $1.00 (HTTP)

Key Insights:
1. Kong offers best performance and flexibility
2. Apigee provides most comprehensive features
3. AWS offers simplest deployment and integration

Would you like me to:
1. Create a decision framework
2. Add more vendors to comparison
3. Generate an executive summary
4. Deep dive into specific criteria"

User: "Create a decision framework"

Bob: "I'll create a decision framework based on the comparison.

Framework will include:
- Use case scenarios
- Vendor recommendations by scenario
- Decision criteria weighting
- Total cost of ownership analysis

Proceed?"

User: "Yes"

Bob: [Creates framework]

"✓ Decision framework created

Created: research/vendor-comparison/analysis/decision-framework.md

Framework Structure:

Scenarios (4):
1. High-performance, open-source preferred
   → Recommendation: Kong
   
2. Enterprise features, managed service
   → Recommendation: Apigee
   
3. AWS-native, simple deployment
   → Recommendation: AWS API Gateway
   
4. Hybrid/multi-cloud
   → Recommendation: Kong or Apigee

Decision Matrix:
- Performance priority: Kong (9/10), Apigee (7/10), AWS (6/10)
- Feature richness: Apigee (9/10), Kong (8/10), AWS (7/10)
- Cost efficiency: Kong (9/10), AWS (7/10), Apigee (5/10)
- Ease of use: AWS (9/10), Apigee (7/10), Kong (6/10)

TCO Analysis (3-year):
- Kong: $150K - $300K
- Apigee: $400K - $800K
- AWS: $200K - $500K

Would you like me to:
1. Generate an executive summary
2. Create a presentation
3. Add more scenarios
4. Export to Word document"
```

### Pattern 4: Iterative Analysis

**Scenario**: User refines analysis through multiple iterations

**Flow Structure**:
1. Initial analysis
2. Review and feedback
3. Refinement
4. Additional analysis
5. Final synthesis

**Complete Conversation**:

```
User: "Analyze the Gartner report for API management trends"

Bob: "I'll analyze the Gartner Magic Quadrant for API Management 2024.

Analysis focus:
1. Market trends
2. Vendor positioning
3. Technology evolution
4. Predictions

Or specify custom focus areas."

User: "Focus on market trends and predictions"

Bob: "I'll focus on market trends and predictions from the Gartner report.

Reading: sources/gartner/magic-quadrant-api-management-2024.md (45 pages)

Extracting:
- Trend mentions and analysis
- Market predictions
- Technology evolution
- Adoption patterns

Proceed?"

User: "Yes"

Bob: [Performs analysis]

"✓ Initial analysis complete

Created: research/api-management-trends-2024/analysis/gartner-trends-v1.md

Identified:
- 8 market trends
- 5 predictions for 2024-2025
- 3 technology shifts

Top Trends:
1. AI/ML integration in API management
2. Shift to event-driven architectures
3. Increased focus on API security

Would you like me to:
1. Show detailed findings
2. Compare with other analyst reports
3. Refine the analysis"

User: "Show detailed findings for the AI/ML trend"

Bob: "Detailed findings for AI/ML Integration trend:

From Gartner MQ 2024:

Trend Overview:
- 78% of vendors now offer AI/ML capabilities
- Primary use cases: intelligent routing, anomaly detection, predictive analytics
- Market maturity: Early adoption phase

Key Points:
1. Intelligent Routing
   - ML-based traffic optimization
   - Automatic failover decisions
   - Load balancing improvements
   
2. Anomaly Detection
   - Real-time threat identification
   - Behavioral analysis
   - Automated response

3. Predictive Analytics
   - Capacity planning
   - Performance forecasting
   - Cost optimization

Vendor Adoption:
- Leaders: Kong, Apigee, MuleSoft (advanced features)
- Challengers: AWS, Azure (basic features)
- Niche: Emerging vendors (experimental)

Gartner Prediction:
'By 2026, 60% of API management platforms will include AI-powered capabilities as standard features'

Would you like me to:
1. Analyze other trends in detail
2. Compare with Forrester's perspective
3. Add this to executive summary"

User: "Compare with Forrester's perspective on AI/ML"

Bob: "I'll compare Gartner and Forrester perspectives on AI/ML in API management.

Reading: sources/forrester/wave-api-management-2024.md

Comparing:
- Trend identification
- Vendor assessment
- Predictions
- Recommendations

Proceed?"

User: "Yes"

Bob: [Performs comparison]

"✓ Comparison complete

Updated: research/api-management-trends-2024/analysis/gartner-trends-v2.md

Comparison: AI/ML Integration

Gartner Perspective:
- Focus: Operational efficiency and automation
- Adoption: 78% of vendors
- Maturity: Early adoption
- Prediction: 60% standard by 2026

Forrester Perspective:
- Focus: Developer experience and productivity
- Adoption: 65% of vendors (more conservative)
- Maturity: Experimental to early adoption
- Prediction: 50% standard by 2027

Key Differences:
1. Gartner more optimistic on adoption pace
2. Forrester emphasizes developer tools over operations
3. Different vendor maturity assessments

Consensus Points:
- AI/ML is a major trend
- Intelligent routing most common use case
- Security applications growing
- Still early in adoption curve

Would you like me to:
1. Synthesize both perspectives
2. Analyze other trends
3. Create final trend report"

User: "Synthesize both perspectives and create final report"

Bob: "I'll synthesize both analyst perspectives and create a final trend report.

Report will include:
- Consensus trends (agreed by both)
- Divergent views (where they differ)
- Synthesized predictions
- Recommendations

Proceed?"

User: "Yes"

Bob: [Creates synthesis]

"✓ Final trend report created

Created: research/api-management-trends-2024/analysis/trend-synthesis-final.md

Report Structure:

1. Executive Summary
   - 5 consensus trends
   - 3 divergent perspectives
   - Synthesized predictions

2. Detailed Trend Analysis
   - AI/ML Integration (consensus: major trend)
   - Serverless Adoption (consensus: growing)
   - Security Focus (consensus: critical)
   - Event-Driven Architecture (Gartner emphasis)
   - Developer Experience (Forrester emphasis)

3. Predictions Synthesis
   - Conservative: 50% AI adoption by 2027 (Forrester)
   - Optimistic: 60% AI adoption by 2026 (Gartner)
   - Realistic: 55% AI adoption by 2026-2027

4. Recommendations
   - Evaluate AI capabilities in vendor selection
   - Plan for event-driven architectures
   - Prioritize security features

Your trend analysis is complete! Would you like me to:
1. Generate executive summary
2. Create presentation
3. Export to Word document"
```

### Pattern 5: Source Discovery and Addition

**Scenario**: User needs to find and add relevant sources during research

**Flow Structure**:
1. Define search criteria
2. Search and rank sources
3. Review and select
4. Add to project
5. Update analysis

**Complete Conversation**:

```
User: "Find more sources about API security"

Bob: "I'll search for sources about API security.

Searching in:
- sources/gartner/
- sources/forrester/
- sources/vendor-docs/
- sources/web/

Search criteria:
- Keyword: 'API security'
- Related terms: security, authentication, authorization, threats

Proceed?"

User: "Yes"

Bob: [Performs search]

"Found 12 sources about API security:

High Relevance (4):
1. sources/gartner/market-guide-api-security-2024.md
   - 'API Security Market Guide 2024'
   - Topics: Threats, best practices, vendor landscape
   - 28 pages
   
2. sources/vendor-docs/aws/api-gateway-security-2024-06-10.md
   - 'AWS API Gateway Security Best Practices'
   - Topics: Authentication, authorization, encryption
   - 15 pages
   
3. sources/forrester/api-security-predictions-2024.md
   - 'API Security Predictions 2024'
   - Topics: Emerging threats, trends
   - 18 pages
   
4. sources/web/owasp-api-security-top-10-2024-06-12.md
   - 'OWASP API Security Top 10'
   - Topics: Common vulnerabilities, mitigation
   - 12 pages

Medium Relevance (5):
[Additional sources...]

Low Relevance (3):
[Additional sources...]

Would you like me to:
1. Add all high-relevance sources to your project
2. Show details for specific sources
3. Search for more sources"

User: "Add all high-relevance sources and show me what's in the OWASP document"

Bob: "✓ Added 4 high-relevance sources to research/api-management-trends-2024/

Updated: sources/index.md

OWASP API Security Top 10 (2024):

Document Overview:
- Source: https://owasp.org/API-Security/
- Scraped: 2024-06-12
- Content: 12 pages
- Focus: Common API vulnerabilities

Top 10 Vulnerabilities:
1. Broken Object Level Authorization
2. Broken Authentication
3. Broken Object Property Level Authorization
4. Unrestricted Resource Consumption
5. Broken Function Level Authorization
6. Unrestricted Access to Sensitive Business Flows
7. Server Side Request Forgery
8. Security Misconfiguration
9. Improper Inventory Management
10. Unsafe Consumption of APIs

Each vulnerability includes:
- Description
- Example scenarios
- Prevention strategies
- Testing methods

This complements the analyst reports well. Would you like me to:
1. Analyze security trends across all sources
2. Create a security best practices guide
3. Compare vendor security features"

User: "Analyze security trends across all sources"

Bob: "I'll analyze security trends across all 4 new sources plus existing sources.

Total sources for analysis: 7
- 2 analyst reports (Gartner, Forrester)
- 2 vendor docs (AWS, Kong)
- 1 standards doc (OWASP)
- 2 previous sources

Analysis will identify:
- Common security concerns
- Recommended practices
- Vendor capabilities
- Emerging threats

Proceed?"

User: "Yes"

Bob: [Performs analysis]

"✓ Security trend analysis complete

Created: research/api-management-trends-2024/analysis/security-trends.md

Key Findings:

Top Security Concerns (by mention frequency):
1. Authentication/Authorization (7/7 sources)
   - OAuth 2.0, JWT, API keys
   - Zero-trust architecture
   
2. API Abuse/DDoS (6/7 sources)
   - Rate limiting
   - Threat detection
   
3. Data Exposure (6/7 sources)
   - Encryption in transit/at rest
   - Data masking
   
4. Injection Attacks (5/7 sources)
   - Input validation
   - SQL/NoSQL injection prevention

Emerging Trends:
- AI-powered threat detection (mentioned in 3 sources)
- API security gateways (mentioned in 4 sources)
- Behavioral analytics (mentioned in 2 sources)

Vendor Capabilities:
- Kong: Strong on rate limiting, plugin ecosystem
- Apigee: Advanced analytics, threat detection
- AWS: IAM integration, encryption

Recommendations:
1. Implement multi-layered security
2. Use API security gateways
3. Enable comprehensive logging
4. Regular security audits

Would you like me to:
1. Add this to your main trend analysis
2. Create a security-focused report
3. Compare vendor security features in detail"
```

## Best Practices for Conversation Flows

### 1. Maintain Context

Track conversation state across turns:
```
Bob: "We've completed:
✓ Project initialization
✓ Source gathering (8 documents)
✓ Initial trend analysis
→ Currently: Creating executive summary

Next steps after summary:
- Generate full report
- Create presentation
- Export to Word"
```

### 2. Provide Clear Options

Offer specific choices at decision points:
```
Bob: "I can proceed in three ways:
1. Quick analysis - High-level trends only
2. Standard analysis - Detailed trends and insights
3. Deep analysis - Comprehensive with comparisons

Which approach would you prefer?"
```

### 3. Confirm Understanding

Repeat back what you understood:
```
Bob: "Let me confirm:
- Convert 5 AWS PDFs
- Save to sources/vendor-docs/aws/reinvent-2024/
- Create project for analysis
- Exclude images
- Use descriptive naming

Is this correct?"
```

### 4. Show Progress

Update user on long-running operations:
```
Bob: "Analyzing 7 sources for security trends...
✓ 1/7: Gartner Market Guide (extracted 12 security points)
✓ 2/7: Forrester Predictions (extracted 8 security points)
→ 3/7: AWS Best Practices (in progress)
..."
```

### 5. Suggest Next Steps

Guide the workflow:
```
Bob: "Analysis complete! Based on your research goals, I suggest:
1. Create executive summary (15 minutes)
2. Generate comparison matrix (10 minutes)
3. Export to Word document (5 minutes)

Or would you like to explore the findings first?"
```

## Related Documentation

- [Common Commands Guide](common-commands.md) - Individual command patterns
- [Folder Management Examples](../examples/folder-management/) - Project workflows
- [Main SKILL.md](../SKILL.md) - Complete skill documentation

## Summary

Effective conversation flows:
- Maintain context across turns
- Ask clarifying questions
- Provide clear options
- Confirm understanding
- Show progress
- Suggest next steps
- Handle iterations gracefully
- Guide users through complex workflows