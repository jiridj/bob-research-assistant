# Contributing to Research Assistant Skill

Thank you for your interest in contributing to the Research Assistant skill for Bob! This guide will help you get started.

## 🎯 Ways to Contribute

- **Add new features** - Enhance skill capabilities
- **Improve documentation** - Make guides clearer and more comprehensive
- **Create templates** - Add new report templates
- **Write examples** - Demonstrate workflows and use cases
- **Fix bugs** - Improve reliability and performance
- **Add utility scripts** - Automate common tasks
- **Share feedback** - Suggest improvements

## 🚀 Getting Started

### 1. Set Up Your Development Environment

```bash
# Clone the repository
git clone <repo-url>
cd bob-research-assistant-skill

# Install the skill locally
./install.sh

# Verify installation
# Ask Bob: "What research capabilities do you have?"
```

### 2. Choose Your Development Workflow

**Option A: Reinstall After Changes** (Recommended for beginners)
```bash
# 1. Make changes to files in .bob/skills/research-assistant/
vim .bob/skills/research-assistant/SKILL.md

# 2. Reinstall to test
./install.sh  # Say 'y' to overwrite

# 3. Test with Bob
# Bob now uses your updated skill

# 4. Commit when satisfied
git add .
git commit -m "feat: Your contribution"
```

**Option B: Symlink for Live Development** (Advanced)
```bash
# One-time setup
rm -rf ~/.bob/skills/research-assistant
ln -s $(pwd)/.bob/skills/research-assistant ~/.bob/skills/research-assistant

# Now edits are immediately live - no reinstall needed!
# Just edit files and test with Bob
```

## 📝 Contribution Guidelines

### Code Style

**Shell Scripts:**
- Use `#!/bin/bash` shebang
- Include usage instructions in header
- Add colored output for better UX
- Handle errors gracefully
- Make scripts executable: `chmod +x script.sh`

**Markdown Documentation:**
- Use clear headings and structure
- Include code examples
- Add usage instructions
- Keep line length reasonable (< 120 chars)

**Skill Definition (SKILL.md):**
- Follow existing patterns
- Include examples for new features
- Document command patterns
- Add to appropriate sections

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```bash
# Format: <type>(<scope>): <description>

# Types:
feat:     # New feature
fix:      # Bug fix
docs:     # Documentation only
style:    # Formatting, no code change
refactor: # Code restructuring
test:     # Adding tests
chore:    # Maintenance

# Examples:
git commit -m "feat(templates): Add case study template"
git commit -m "fix(scripts): Handle spaces in filenames"
git commit -m "docs(guides): Improve batch operations guide"
```

### Branch Naming

```bash
# Format: <type>/<short-description>

git checkout -b feat/add-case-study-template
git checkout -b fix/batch-conversion-error
git checkout -b docs/improve-readme
```

## 🎨 What to Contribute

### High-Priority Areas

1. **New Templates** (`.bob/skills/research-assistant/templates/`)
   - Case studies
   - White papers
   - Research proposals
   - Grant applications

2. **Utility Scripts** (`scripts/`)
   - Data analysis helpers
   - Export/import tools
   - Validation utilities
   - Reporting tools

3. **Examples** (`.bob/skills/research-assistant/examples/`)
   - Real-world workflows
   - Industry-specific use cases
   - Advanced techniques

4. **Guides** (`.bob/skills/research-assistant/guides/`)
   - Best practices
   - Troubleshooting
   - Integration guides

### Adding a New Template

```bash
# 1. Create template file
cat > .bob/skills/research-assistant/templates/case-study.md << 'EOF'
# Case Study Template

**Title**: [Case Study Title]
**Date**: [Date]
**Author**: [Author Name]

## Executive Summary
[Brief overview]

## Background
[Context and situation]

## Challenge
[Problem statement]

## Solution
[Approach taken]

## Results
[Outcomes and metrics]

## Lessons Learned
[Key takeaways]
EOF

# 2. Test the template
./install.sh

# 3. Document in README
# Add to templates list

# 4. Commit
git add .
git commit -m "feat(templates): Add case study template"
```

### Adding a New Utility Script

```bash
# 1. Create script
cat > scripts/export-to-csv.sh << 'EOF'
#!/bin/bash
# Export research data to CSV format
# Usage: ./export-to-csv.sh INPUT_FILE OUTPUT_FILE

# ... script implementation ...
EOF

# 2. Make executable
chmod +x scripts/export-to-csv.sh

# 3. Test the script
./scripts/export-to-csv.sh test-input.md test-output.csv

# 4. Document in scripts/README.md
# Add usage instructions

# 5. Commit
git add scripts/export-to-csv.sh scripts/README.md
git commit -m "feat(scripts): Add CSV export utility"
```

### Improving Documentation

```bash
# 1. Edit documentation
vim .bob/skills/research-assistant/guides/batch-operations.md

# 2. Test by reinstalling
./install.sh

# 3. Verify with Bob
# Ask Bob questions to test the updated documentation

# 4. Commit
git add .
git commit -m "docs(guides): Clarify batch operations workflow"
```

## 🧪 Testing Your Changes

### Manual Testing Checklist

Before submitting:

- [ ] Install script works: `./install.sh`
- [ ] Skill loads in Bob (no errors)
- [ ] New features work as expected
- [ ] Documentation is clear and accurate
- [ ] Examples run successfully
- [ ] Scripts are executable
- [ ] No broken links in documentation
- [ ] Commit messages follow conventions

### Testing with Bob

```bash
# 1. Install your changes
./install.sh

# 2. Test with Bob
# Ask Bob to use your new feature/template/script

# 3. Verify output
# Check that results are correct

# 4. Test edge cases
# Try unusual inputs or scenarios
```

## 📤 Submitting Your Contribution

### For Team Members (Direct Access)

```bash
# 1. Create feature branch
git checkout -b feat/your-feature

# 2. Make changes and commit
git add .
git commit -m "feat: Your contribution"

# 3. Push to repository
git push origin feat/your-feature

# 4. Create Pull Request
# Go to repository and create PR
# Add description of changes
# Request review from team lead

# 5. Address review feedback
# Make requested changes
git add .
git commit -m "fix: Address review feedback"
git push origin feat/your-feature

# 6. Merge when approved
# Team lead will merge your PR
```

### Pull Request Template

When creating a PR, include:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] New feature
- [ ] Bug fix
- [ ] Documentation update
- [ ] Performance improvement

## Changes Made
- Added X template
- Updated Y documentation
- Fixed Z bug

## Testing
- [ ] Tested with ./install.sh
- [ ] Verified with Bob
- [ ] Checked documentation links
- [ ] Ran example workflows

## Screenshots (if applicable)
[Add screenshots of new features]

## Related Issues
Closes #123
```

## 🐛 Reporting Issues

### Bug Reports

Include:
- **Description**: What went wrong?
- **Steps to Reproduce**: How to trigger the bug?
- **Expected Behavior**: What should happen?
- **Actual Behavior**: What actually happened?
- **Environment**: OS, Bob version, dependencies
- **Logs**: Error messages or output

### Feature Requests

Include:
- **Use Case**: Why is this needed?
- **Proposed Solution**: How should it work?
- **Alternatives**: Other approaches considered?
- **Examples**: Similar features elsewhere?

## 📚 Resources

### Documentation Structure

```
.bob/skills/research-assistant/
├── SKILL.md              # Skill definition (Bob reads this)
├── README.md             # User guide
├── templates/            # Report templates
├── guides/               # How-to guides
└── examples/             # Practical examples

scripts/                  # Utility scripts
├── README.md             # Script documentation
└── *.sh                  # Individual scripts

README.md                 # Project overview
CONTRIBUTING.md           # This file
SHARING.md                # Distribution guide
```

### Key Files to Know

- **SKILL.md**: Defines skill behavior for Bob
- **templates/**: Report templates used by Bob
- **guides/**: Reference documentation
- **examples/**: Workflow demonstrations
- **scripts/**: Automation utilities

## 💡 Tips for Contributors

### Best Practices

1. **Start Small**: Begin with documentation or simple scripts
2. **Ask Questions**: Reach out if you're unsure
3. **Test Thoroughly**: Verify changes work as expected
4. **Document Well**: Explain what and why
5. **Follow Patterns**: Match existing code style
6. **Commit Often**: Small, focused commits are better

### Common Pitfalls to Avoid

❌ **Don't**:
- Commit large binary files
- Make unrelated changes in one commit
- Skip testing before committing
- Forget to update documentation
- Use absolute paths in scripts

✅ **Do**:
- Test on clean installation
- Update relevant documentation
- Use relative paths
- Follow commit conventions
- Ask for help when needed

## 🤝 Code Review Process

### What Reviewers Look For

- **Functionality**: Does it work correctly?
- **Code Quality**: Is it well-written and maintainable?
- **Documentation**: Is it properly documented?
- **Testing**: Has it been tested?
- **Style**: Does it follow conventions?

### Responding to Feedback

- Be open to suggestions
- Ask for clarification if needed
- Make requested changes promptly
- Thank reviewers for their time
- Learn from the feedback

## 🎓 Learning Resources

### Understanding Bob Skills

- Read existing skill files in `.bob/skills/research-assistant/`
- Study the SKILL.md format and patterns
- Review examples to understand workflows
- Test features with Bob to see how they work

### Shell Scripting

- [Bash Guide](https://mywiki.wooledge.org/BashGuide)
- [ShellCheck](https://www.shellcheck.net/) - Script linter
- Study existing scripts in `scripts/` directory

### Markdown

- [Markdown Guide](https://www.markdownguide.org/)
- [GitHub Flavored Markdown](https://github.github.com/gfm/)

## 📞 Getting Help

### Questions?

1. **Check Documentation**: Review guides and examples
2. **Search Issues**: Someone may have asked before
3. **Ask Team**: Reach out to team members
4. **Create Issue**: Open a question issue if needed

### Contact

- **Team Lead**: [Your Name/Email]
- **Repository**: [Repository URL]
- **Chat**: [Team Chat Channel]

## 🙏 Thank You!

Your contributions make this skill better for everyone. We appreciate your time and effort!

---

**Happy Contributing!** 🎉

*Last Updated: 2026-06-17*