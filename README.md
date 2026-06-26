# Research Assistant — a Bob skill

A [Bob](https://github.com/your-org/bob) skill that turns your AI assistant into a persistent, compounding research partner. Import documents, scrape the web, build a living wiki, and generate professional reports — all through natural conversation.

## Inspiration: Karpathy's llm-wiki

This skill is directly inspired by Andrej Karpathy's [llm-wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f), which proposes a simple but powerful idea:

> Use an LLM as a persistent, editable knowledge base where the LLM itself is responsible for writing, updating, and querying structured wiki pages from conversation.

The insight is that LLMs are already good at synthesizing information into structured text — so instead of treating each conversation as ephemeral, you can have the model maintain a growing wiki that compounds over time. Each new document or web page you bring in enriches the same knowledge base rather than disappearing when the session ends.

This skill operationalises that idea with a human-in-the-loop gate: Bob drafts proposed wiki updates into an **inbox**, you review and approve them, and only then do they land in the wiki. The result is a research knowledge base you trust, because nothing gets written without your sign-off.

## What it does

**Import documents.** Give Bob a PDF, Word doc, or PowerPoint and say "import this." Bob converts it to markdown, drafts wiki pages from its contents, and waits for you to approve before writing anything.

**Scrape the web.** Point Bob at a URL and it extracts the content, detects changes on re-scrapes, and archives old versions automatically.

**Maintain a wiki.** A `wiki/` folder at the root of your research project grows over time. It is topic-organised, cross-linked, and fully readable as plain markdown. Bob keeps an index and a log so nothing gets lost.

**Generate reports.** Ask Bob to produce a competitive analysis, executive summary, or technical deep dive. It draws on your wiki and source files to write a structured Word document.

**Query your knowledge base.** Ask questions and Bob synthesizes answers with citations to wiki pages and original sources. Substantive answers can be filed back into the wiki.

## Install

```bash
git clone <repo-url>
cd bob-research-assistant
./install.sh
```

The installer copies the skill to `~/.bob/skills/research-assistant` — Bob's global skills directory. Once installed, the skill is available in every Bob session, in any folder.

See [docs/getting-started.md](docs/getting-started.md) for a walkthrough aimed at non-technical users.

## How it works

```
originals/    raw files you import (PDFs, DOCX, PPTX)
sources/      converted markdown — one subfolder per vendor or site
inbox/        Bob's draft proposals, waiting for your review
wiki/         the approved knowledge base — grows with each merge
research/     optional project folders for notes, analysis, reports
```

The flow for importing a document:

1. **Convert** — `docling` turns the file into clean markdown in `sources/`
2. **Draft** — Bob reads the source and proposes wiki pages in `inbox/`
3. **Review** — you open `inbox/[slug]/manifest.md`, check what you approve
4. **Merge** — say "merge inbox/[slug]" and approved pages land in `wiki/`

Nothing touches the wiki until step 4. You stay in control.

## Prerequisites

| Tool | Purpose | Install |
|------|---------|---------|
| [docling](https://github.com/DS4SD/docling) | PDF/DOCX/PPTX → markdown | `pip install docling` |
| [crawl4ai](https://github.com/unclecode/crawl4ai) | Web scraping | `pip install crawl4ai` |
| [pandoc](https://pandoc.org) | Report generation | `brew install pandoc` |

Python 3.8+ required. Internet connection needed for web scraping.

## Documentation

- [Getting Started](docs/getting-started.md) — step-by-step guide for new users
- [Contributing](docs/CONTRIBUTING.md) — how to improve the skill
- [Sharing](docs/SHARING.md) — how to distribute the skill to your team
- [Test Plan](docs/TEST_PLAN.md) — manual and automated test scenarios
- [Wishlist](docs/WISHLIST.md) — future ideas and open questions
