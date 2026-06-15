# Gap Analysis Example

## Scenario
Identifying gaps in research coverage, missing information, and areas requiring additional investigation for an API management strategy.

## User Request
```
"Identify gaps in our API management research and suggest what additional sources we need"
```

## Workflow Steps

### 1. Define Scope
**Action**: Clarify what gaps to identify

**Questions to Ask**:
- What's the research objective? (vendor selection, strategy, etc.)
- What decisions need to be made?
- What information is critical vs nice-to-have?
- What's the timeline for decisions?

**User Response Example**:
```
"We're evaluating API gateway vendors for enterprise deployment.
Need to make decision in 3 months. Critical information:
- Technical capabilities
- Pricing and TCO
- Implementation complexity
- Vendor stability and support"
```

### 2. Inventory Existing Research
**Action**: Catalog what information we already have

**Inventory Commands**:
```bash
# List all sources by category
find sources/ -type f -name "*.md" | sed 's|sources/||' | cut -d'/' -f1 | sort | uniq -c

# Count sources per competitor
for dir in sources/Competitors/*/; do
  echo "$(basename $dir): $(find $dir -name "*.md" | wc -l) sources"
done

# List topics covered
grep -r "^##" sources/ --include="*.md" | cut -d':' -f2 | sort | uniq -c | sort -rn | head -20

# Check date coverage
find sources/ -name "*-20*.md" | grep -o '20[0-9][0-9]-[0-9][0-9]' | sort | uniq -c
```

**Inventory Results Example**:
```markdown
# Research Inventory

## Sources by Category
- Competitors: 15 sources
  - Kong: 6 sources
  - Apigee: 5 sources
  - MuleSoft: 4 sources
- Gartner: 4 sources
- Forrester: 2 sources
- Hyperscalers: 8 sources

## Topics Covered
- Features/Capabilities: 12 sources
- Pricing: 8 sources
- Security: 6 sources
- Performance: 4 sources
- Documentation: 3 sources
- Support: 1 source
- Implementation: 1 source

## Date Coverage
- 2024-06: 10 sources (current)
- 2024-03: 5 sources
- 2023-12: 3 sources
- Older: 7 sources

## Vendor Coverage
- Kong: Good (6 sources, recent)
- Apigee: Good (5 sources, recent)
- MuleSoft: Moderate (4 sources, some dated)
- Others: None
```

### 3. Map Requirements to Coverage
**Action**: Compare what we need vs what we have

**Requirements Matrix**:
```markdown
# Requirements Coverage Matrix

| Requirement | Priority | Coverage | Gap Level | Notes |
|-------------|----------|----------|-----------|-------|
| **Technical Capabilities** |
| Core gateway features | Critical | ✅ Good | None | All vendors covered |
| Performance benchmarks | Critical | ⚠️ Limited | High | Only vendor claims, no independent tests |
| Scalability limits | Critical | ⚠️ Limited | Medium | Theoretical limits, no real-world data |
| Integration capabilities | High | ✅ Good | Low | Well documented |
| API management features | High | ✅ Good | None | Comprehensive coverage |
| **Pricing & TCO** |
| List pricing | Critical | ✅ Good | Low | All vendors covered |
| Volume discounts | Critical | ❌ Missing | High | No information |
| Hidden costs | Critical | ❌ Missing | High | Implementation, training, support |
| TCO calculations | Critical | ❌ Missing | High | No complete TCO analysis |
| **Implementation** |
| Implementation time | Critical | ⚠️ Limited | High | Only vendor estimates |
| Resource requirements | High | ❌ Missing | High | Team size, skills needed |
| Migration complexity | High | ⚠️ Limited | Medium | Limited migration info |
| Training requirements | High | ❌ Missing | High | No training info |
| **Vendor Stability** |
| Financial health | Critical | ⚠️ Limited | Medium | Public companies only |
| Customer satisfaction | High | ❌ Missing | High | No customer references |
| Support quality | Critical | ⚠️ Limited | High | Only SLA info, no experience |
| Roadmap/vision | High | ⚠️ Limited | Medium | Limited forward-looking info |

**Legend**:
- ✅ Good: Comprehensive, recent, reliable
- ⚠️ Limited: Partial coverage or dated
- ❌ Missing: No information available
```

### 4. Identify Information Gaps
**Action**: Categorize and prioritize gaps

**Gap Categories**:

**A. Critical Gaps (Decision Blockers)**:
```markdown
# Critical Gaps

## 1. Real-World Performance Data
**What's Missing**: Independent performance benchmarks
**Why Critical**: Vendor claims may be optimistic
**Impact**: Can't validate performance requirements
**Risk**: May select underperforming solution

## 2. Total Cost of Ownership
**What's Missing**: Complete TCO including hidden costs
**Why Critical**: Budget approval requires accurate costs
**Impact**: May exceed budget post-selection
**Risk**: Project cancellation or scope reduction

## 3. Implementation Complexity
**What's Missing**: Realistic implementation timelines and resources
**Why Critical**: Need to plan project and resources
**Impact**: Can't commit to timeline
**Risk**: Project delays, cost overruns

## 4. Customer References
**What's Missing**: Real customer experiences and satisfaction
**Why Critical**: Validate vendor claims
**Impact**: Can't assess real-world viability
**Risk**: May select problematic vendor
```

**B. Important Gaps (Should Have)**:
```markdown
# Important Gaps

## 1. Migration Strategies
**What's Missing**: Detailed migration approaches and risks
**Why Important**: Need to plan transition from current system
**Impact**: Migration complexity unknown
**Priority**: High

## 2. Support Quality
**What's Missing**: Real support experience and responsiveness
**Why Important**: Critical for production issues
**Impact**: Can't assess operational risk
**Priority**: High

## 3. Training Requirements
**What's Missing**: Training needs and availability
**Why Important**: Team readiness affects timeline
**Impact**: Can't plan onboarding
**Priority**: Medium

## 4. Vendor Roadmap
**What's Missing**: Future product direction
**Why Important**: Long-term viability assessment
**Impact**: May select declining product
**Priority**: Medium
```

**C. Nice-to-Have Gaps (Optional)**:
```markdown
# Nice-to-Have Gaps

## 1. Community Ecosystem
**What's Missing**: Community size, activity, resources
**Why Nice**: Helpful for troubleshooting and learning
**Impact**: Slower problem resolution
**Priority**: Low

## 2. Third-Party Integrations
**What's Missing**: Comprehensive integration catalog
**Why Nice**: May need specific integrations
**Impact**: Custom integration work
**Priority**: Low

## 3. Competitive Positioning
**What's Missing**: Market share and growth trends
**Why Nice**: Indicates market validation
**Impact**: Perception risk only
**Priority**: Low
```

### 5. Suggest Additional Sources
**Action**: Recommend specific sources to fill gaps

**Source Recommendations**:

```markdown
# Recommended Additional Sources

## Critical Gap: Performance Data
**Suggested Sources**:
1. **Independent Benchmarks**
   - Search for: "API gateway performance benchmark 2024"
   - Look for: TechEmpower, Cloud Native Computing Foundation
   - Action: Web scrape benchmark reports

2. **Case Studies**
   - Search vendor sites for: "case study performance"
   - Look for: Real-world performance metrics
   - Action: Scrape and extract performance data

3. **Technical Reviews**
   - Search for: "Kong vs Apigee performance review"
   - Look for: InfoQ, DZone, Medium technical articles
   - Action: Scrape technical comparison articles

## Critical Gap: Total Cost of Ownership
**Suggested Sources**:
1. **TCO Calculators**
   - Search for: "API gateway TCO calculator"
   - Look for: Analyst firm calculators, vendor tools
   - Action: Use calculators, document assumptions

2. **Customer Interviews**
   - Reach out to: Existing customers (via LinkedIn, conferences)
   - Ask about: Hidden costs, unexpected expenses
   - Action: Document interview findings

3. **Analyst Reports**
   - Purchase: Gartner TCO analysis, Forrester cost studies
   - Look for: Detailed cost breakdowns
   - Action: Convert reports to markdown

## Critical Gap: Implementation Complexity
**Suggested Sources**:
1. **Implementation Guides**
   - Search vendor docs for: "implementation guide", "deployment guide"
   - Look for: Step-by-step processes, timelines
   - Action: Scrape implementation documentation

2. **Partner Information**
   - Search for: "Kong implementation partner", "Apigee consulting"
   - Look for: Partner estimates, typical projects
   - Action: Contact partners for estimates

3. **Community Forums**
   - Search: Stack Overflow, vendor forums, Reddit
   - Look for: Implementation experiences, gotchas
   - Action: Scrape relevant discussions

## Critical Gap: Customer References
**Suggested Sources**:
1. **Customer Case Studies**
   - Search vendor sites: "customer success stories"
   - Look for: Similar company size/industry
   - Action: Scrape case studies

2. **Review Sites**
   - Check: G2, Gartner Peer Insights, TrustRadius
   - Look for: Recent reviews, verified customers
   - Action: Scrape review data

3. **LinkedIn Research**
   - Search: "[Vendor] customer" on LinkedIn
   - Look for: Users willing to share experience
   - Action: Reach out for informational interviews
```

### 6. Prioritize Investigation Areas
**Action**: Create prioritized research plan

**Research Priority Matrix**:
```markdown
# Research Priorities

## Phase 1: Critical Gaps (Week 1-2)
**Must have for decision**

1. **Performance Benchmarks** (3 days)
   - Find independent benchmarks
   - Extract performance data
   - Create comparison matrix
   - Confidence target: High

2. **TCO Analysis** (4 days)
   - Gather all cost components
   - Build TCO model
   - Calculate 3-year costs
   - Confidence target: High

3. **Customer References** (3 days)
   - Find 2-3 references per vendor
   - Conduct interviews
   - Document findings
   - Confidence target: Medium-High

## Phase 2: Important Gaps (Week 3-4)
**Should have for confidence**

4. **Implementation Complexity** (3 days)
   - Gather implementation guides
   - Estimate timeline and resources
   - Identify risks
   - Confidence target: Medium

5. **Support Quality** (2 days)
   - Research support models
   - Find support experiences
   - Assess responsiveness
   - Confidence target: Medium

6. **Migration Strategy** (3 days)
   - Document migration approaches
   - Identify migration risks
   - Estimate migration effort
   - Confidence target: Medium

## Phase 3: Nice-to-Have (Week 5-6)
**Good to have for completeness**

7. **Training Requirements** (2 days)
8. **Vendor Roadmap** (2 days)
9. **Community Ecosystem** (1 day)

## Phase 4: Ongoing
**Continuous monitoring**

10. **Market Updates** (ongoing)
11. **Competitive Changes** (ongoing)
12. **Customer Feedback** (ongoing)
```

### 7. Document Research Opportunities
**Action**: Highlight areas for future investigation

**Research Opportunities**:
```markdown
# Research Opportunities

## Immediate Opportunities
**Can be addressed quickly**

### 1. Vendor Documentation Deep Dive
- **Opportunity**: More thorough analysis of existing docs
- **Effort**: Low (2-3 days)
- **Value**: Medium
- **Action**: Re-scrape with focus on implementation details

### 2. Analyst Report Purchase
- **Opportunity**: Access to detailed analyst research
- **Effort**: Low (budget approval + 1 day)
- **Value**: High
- **Action**: Purchase Gartner/Forrester detailed reports

### 3. Community Research
- **Opportunity**: Tap into user experiences
- **Effort**: Medium (3-4 days)
- **Value**: Medium-High
- **Action**: Systematic forum/review scraping

## Medium-term Opportunities
**Require more effort or coordination**

### 4. Proof of Concept
- **Opportunity**: Hands-on testing of top candidates
- **Effort**: High (2-3 weeks)
- **Value**: Very High
- **Action**: Set up POC environment, run tests

### 5. Customer Interviews
- **Opportunity**: Direct feedback from users
- **Effort**: Medium (1-2 weeks to arrange)
- **Value**: High
- **Action**: Identify and contact references

### 6. Vendor Briefings
- **Opportunity**: Direct access to vendor information
- **Effort**: Medium (scheduling + prep)
- **Value**: Medium
- **Action**: Request detailed briefings

## Long-term Opportunities
**Strategic research initiatives**

### 7. Continuous Monitoring
- **Opportunity**: Track market evolution
- **Effort**: Low (ongoing)
- **Value**: High (long-term)
- **Action**: Set up automated monitoring

### 8. Competitive Intelligence
- **Opportunity**: Systematic competitor tracking
- **Effort**: Medium (ongoing)
- **Value**: High (strategic)
- **Action**: Establish CI process

### 9. Industry Benchmarking
- **Opportunity**: Compare with industry peers
- **Effort**: High (requires network)
- **Value**: Medium-High
- **Action**: Join industry groups, attend conferences
```

### 8. Create Action Plan
**Action**: Develop concrete next steps

**Gap Closure Action Plan**:
```markdown
# Gap Closure Action Plan

## Week 1: Critical Research

### Monday-Tuesday: Performance Research
- [ ] Search for independent benchmarks
- [ ] Scrape TechEmpower, CNCF reports
- [ ] Extract performance metrics
- [ ] Create comparison spreadsheet
- **Owner**: [Name]
- **Deliverable**: Performance comparison matrix

### Wednesday-Thursday: TCO Analysis
- [ ] List all cost components
- [ ] Gather pricing data
- [ ] Build TCO model
- [ ] Calculate 3-year costs
- **Owner**: [Name]
- **Deliverable**: TCO comparison spreadsheet

### Friday: Customer Reference Research
- [ ] Search for case studies
- [ ] Scrape review sites
- [ ] Identify potential references
- [ ] Reach out for interviews
- **Owner**: [Name]
- **Deliverable**: Reference contact list

## Week 2: Critical Research Completion

### Monday-Tuesday: Customer Interviews
- [ ] Conduct 2-3 interviews per vendor
- [ ] Document findings
- [ ] Synthesize feedback
- **Owner**: [Name]
- **Deliverable**: Customer feedback report

### Wednesday-Friday: Implementation Research
- [ ] Scrape implementation guides
- [ ] Estimate timelines
- [ ] Identify resource needs
- [ ] Document risks
- **Owner**: [Name]
- **Deliverable**: Implementation complexity assessment

## Week 3-4: Important Gaps
[Continue with Phase 2 priorities]

## Success Criteria
- [ ] All critical gaps addressed
- [ ] Confidence level: High for decision
- [ ] Documentation complete
- [ ] Ready for vendor selection
```

## Best Practices

### 1. Systematic Approach
- Inventory existing research first
- Map requirements to coverage
- Categorize gaps by priority
- Create actionable plan

### 2. Prioritization
- Focus on decision-critical gaps first
- Consider effort vs value
- Align with timeline
- Be realistic about resources

### 3. Specificity
- Identify specific missing information
- Suggest specific sources
- Provide concrete actions
- Assign owners and deadlines

### 4. Continuous Assessment
- Reassess gaps as research progresses
- Update priorities based on findings
- Track gap closure progress
- Identify new gaps discovered

### 5. Documentation
- Document what's missing and why
- Track gap closure efforts
- Record sources consulted
- Note remaining uncertainties

## Common Pitfalls to Avoid

### 1. Analysis Paralysis
❌ Don't try to fill every gap
✅ Focus on decision-critical information

### 2. Perfectionism
❌ Don't wait for perfect information
✅ Accept "good enough" for decisions

### 3. Scope Creep
❌ Don't expand research indefinitely
✅ Stay focused on original objectives

### 4. Ignoring Constraints
❌ Don't ignore time/budget limits
✅ Prioritize within constraints

### 5. Poor Communication
❌ Don't keep gaps hidden
✅ Communicate gaps and risks clearly

## Related Examples
- [Literature Review](literature-review.md)
- [Competitive Analysis](competitive-analysis.md)
- [Trend Analysis](trend-analysis.md)