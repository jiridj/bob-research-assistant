# Research Assistant Skill — Test Plan

## Overview

This document outlines the manual and automated test scenarios for the Research Assistant skill.

## Automated Tests

Run `./quick-test.sh` to execute the automated test suite. All checks must pass before releasing.

## Manual Test Scenarios

### 1. Skill Activation
- Open Bob and start a new conversation
- Ask: *"Research the competitive landscape for AI coding assistants"*
- Verify the research-assistant skill activates

### 2. Web Research
- Trigger a web search via the skill
- Verify results are fetched and cited correctly
- Verify sources include clickable URLs

### 3. Document Conversion
- Place a PDF in the research project folder
- Ask Bob to convert and analyse it
- Verify markdown output is generated

### 4. Report Generation
- Complete a research session
- Ask Bob to generate a report
- Verify the report follows one of the templates in `.bob/skills/research-assistant/templates/`

### 5. Wiki Knowledge Base
- Run a research session that produces findings
- Verify a wiki entry is created or updated in the knowledge base
- Verify human-in-the-loop review prompt appears before committing

### 6. Template Coverage
| Template | Verified |
|---|---|
| `competitor-analysis.md` | [ ] |
| `market-analysis.md` | [ ] |
| `technical-deep-dive.md` | [ ] |
| `company-pov.md` | [ ] |
| `company-deep-dive.md` | [ ] |
| `why-how-what.md` | [ ] |
| `_common-elements.md` | [ ] |

## Regression Checklist

- [ ] All `quick-test.sh` tests pass
- [ ] No broken script references in SKILL.md
- [ ] Install script completes without errors on a clean machine
- [ ] All guide documents render correctly in markdown
