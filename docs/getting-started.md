# Getting Started

This guide is for anyone who wants to use the Research Assistant skill with Bob — no programming experience required.

---

## What is this?

The Research Assistant turns Bob into a research partner that *remembers things*. Normally, when you close a conversation with an AI assistant, everything you discussed disappears. This skill changes that.

When you bring in documents or web pages, Bob converts them into plain text and proposes a set of notes to store in a `wiki/` folder inside your project. You review those notes, approve what you want, and the knowledge stays there permanently — ready for Bob to reference in any future conversation.

Over time, your wiki grows. Each source you add enriches it. Bob can answer questions by drawing on everything in the wiki, cite where information came from, and generate reports from it.

---

## Before you start

You need three tools installed on your computer. If you are not comfortable with the Terminal, ask someone technical to do this step once — you won't need to repeat it.

Open Terminal (on Mac: press ⌘ Space, type "Terminal", press Enter) and run:

```
pip install docling crawl4ai
brew install pandoc
```

Then install the skill itself:

```
git clone <repo-url>
cd bob-research-assistant
./install.sh
```

That's it. The skill is now available every time you use Bob, in any folder.

---

## Your first research project

### Step 1 — Create a folder for your research

Make a new folder on your computer for the topic you're researching. For example, you might create a folder called `my-research` on your Desktop. Open that folder in Bob.

### Step 2 — Set up the folder structure

Tell Bob:

> "Set up a new research project called [your topic]"

Bob will create a few folders inside your project:
- `sources/` — where converted documents will live
- `wiki/` — your growing knowledge base
- `inbox/` — a staging area where Bob puts draft notes for your review
- `originals/` — your original files, unchanged

### Step 3 — Import your first document

You have a PDF you want to research. Tell Bob:

> "Import this PDF: /path/to/your/file.pdf — it's from Gartner"

Bob will:
1. Convert the PDF to plain text
2. Read through it
3. Propose a set of wiki notes in your `inbox/` folder

Bob will then say something like: *"Inbox entry ready at `inbox/gartner-report/`. Review and edit, then say 'merge inbox/gartner-report'."*

### Step 4 — Review the draft notes

Open the file `inbox/gartner-report/manifest.md` in any text editor. You'll see a checklist of proposed notes, like:

```
- [ ] Create wiki page: market-overview
- [ ] Create wiki page: competitor-analysis
- [ ] Update wiki page: trends
```

Put an `x` in the boxes next to items you want to keep:

```
- [x] Create wiki page: market-overview
- [x] Create wiki page: competitor-analysis
- [ ] Update wiki page: trends   ← leave unchecked to skip
```

You can also open `inbox/gartner-report/summary.md` to read and edit the actual content before it goes into your wiki.

### Step 5 — Approve and save

Tell Bob:

> "Merge inbox/gartner-report"

Bob writes the checked items into your `wiki/` folder, skips the rest, and archives the inbox entry. Your wiki now has those pages.

---

## Asking questions

Once you have content in your wiki, you can ask Bob anything:

> "What does my research say about pricing strategies?"

> "Compare the three competitors I've imported so far"

> "What are the key trends across my sources?"

Bob will answer with citations, pointing back to the exact wiki pages and original documents.

If Bob gives you a particularly useful answer, it can save it back to the wiki:

> "That's useful — file this answer in the wiki"

---

## Scraping a web page

If you want to capture content from a website:

> "Scrape https://example.com/article"

Bob extracts the text, stores it in `sources/`, and you can import it into your wiki the same way as a document.

If you scrape the same page again later, Bob detects whether anything changed and archives the old version — so you have a history.

---

## Generating a report

When you're ready to produce a document from your research:

> "Generate a competitive analysis report from my wiki"

> "Write an executive summary of what I've found"

Bob produces a Word document (`.docx`) drawing on your wiki and source files. You can open it in Word or Google Docs like any other document.

---

## A typical session

Here is what a real research session might look like:

```
You:  "Import reports/forrester-wave-2024.pdf — it's from Forrester"
Bob:  ✓ Converted to sources/Forrester/forrester-wave-2024.md
      ✓ Inbox entry ready: inbox/forrester-wave-2024/

      Open inbox/forrester-wave-2024/manifest.md, check the items you want, 
      then say "merge inbox/forrester-wave-2024".

You:  [opens manifest.md, checks 4 of 6 items, saves]

You:  "Merge inbox/forrester-wave-2024"
Bob:  ✓ Created: wiki/vendors/forrester-leaders.md
      ✓ Created: wiki/market/wave-2024.md
      ✓ Updated: wiki/trends.md
      ✓ Skipped: 2 unchecked items

You:  "What vendors are in the Leaders quadrant?"
Bob:  Based on wiki/vendors/forrester-leaders.md (source: Forrester Wave 2024)...
      [answer with citations]

You:  "Generate a vendor comparison report"
Bob:  ✓ Report saved: output/vendor-comparison.docx
```

---

## Tips

**Start small.** Import one or two documents, get comfortable with the inbox review flow, then expand.

**Edit before merging.** The `inbox/` files are just text — you can freely edit `summary.md` before approving. What you see in the file is exactly what lands in the wiki.

**Your wiki is just files.** Everything in `wiki/` is plain markdown text. You can read it, edit it, search it, or back it up like any other folder on your computer.

**Nothing is permanent by accident.** Bob never writes to the wiki without your explicit "merge" command. You are always in control of what gets saved.

**It works across sessions.** Close Bob, come back tomorrow, and your wiki is still there. Bob reads it at the start of each relevant conversation.

---

## Getting help

If something goes wrong, describe what happened to Bob in plain English:

> "I tried to import a PDF and got an error — what should I do?"

> "I accidentally merged something I didn't want. Can I undo it?"

Bob will diagnose the problem and suggest fixes.

For more technical details, see the [CONTRIBUTING.md](CONTRIBUTING.md) guide or explore the `.bob/skills/research-assistant/` folder inside this repository.
