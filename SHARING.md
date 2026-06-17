# Sharing the Research Assistant Skill

This guide explains how to share the Research Assistant skill with other Bob users, covering both private and public distribution methods.

## 📦 What You're Sharing

The Research Assistant skill includes:
- **Skill definition**: `.bob/skills/research-assistant/SKILL.md`
- **Documentation**: 5,000+ lines across 36 markdown files
- **Templates**: 5 report templates for different use cases
- **Guides**: 9 comprehensive guides
- **Examples**: 20+ practical examples
- **Utility scripts**: 13 automation scripts

## 🎯 Distribution Options

### Option 1: Git Repository (Recommended)

**Best for**: Teams, version control, easy updates

#### Setup

1. **Create a Git repository** (GitHub, GitLab, or Bitbucket)
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Research Assistant skill"
   ```

2. **Push to remote**
   ```bash
   git remote add origin <your-repo-url>
   git push -u origin main
   ```

3. **Share repository URL** with users

#### Installation for Users

```bash
# Clone repository
git clone <repo-url>
cd bob-research-assistant-skill

# Run installer
./install.sh
```

#### Updates

Users can easily update:
```bash
cd bob-research-assistant-skill
git pull origin main
./install.sh
```

**Pros:**
- ✅ Version control and history
- ✅ Easy updates via `git pull`
- ✅ Collaboration-friendly
- ✅ Issue tracking
- ✅ Pull requests for contributions

**Cons:**
- ❌ Requires Git knowledge
- ❌ Repository access management needed

---

### Option 2: Compressed Archive

**Best for**: Simple one-time sharing, no infrastructure

#### Create Archive

```bash
# Create tar.gz
tar -czf research-assistant-skill-v1.0.tar.gz \
  .bob/skills/research-assistant/ \
  scripts/ \
  install.sh \
  README.md

# Or create zip
zip -r research-assistant-skill-v1.0.zip \
  .bob/skills/research-assistant/ \
  scripts/ \
  install.sh \
  README.md
```

#### Share Archive

- Email attachment
- File sharing service (Dropbox, Google Drive)
- Internal file server
- USB drive

#### Installation for Users

```bash
# Extract tar.gz
tar -xzf research-assistant-skill-v1.0.tar.gz
cd research-assistant-skill

# Or extract zip
unzip research-assistant-skill-v1.0.zip
cd research-assistant-skill

# Run installer
./install.sh
```

**Pros:**
- ✅ Simple and straightforward
- ✅ No infrastructure needed
- ✅ Works offline
- ✅ No technical knowledge required

**Cons:**
- ❌ Manual updates required
- ❌ No version tracking
- ❌ Larger file size

---

### Option 3: Direct Installation Script

**Best for**: Public distribution, one-command installation

#### Setup

1. **Host files** on a web server or GitHub
2. **Create installation URL**

#### Installation for Users

```bash
# One-command installation
curl -fsSL https://your-domain.com/install.sh | bash

# Or from GitHub
curl -fsSL https://raw.githubusercontent.com/user/repo/main/install.sh | bash
```

**Pros:**
- ✅ Simplest for end users
- ✅ One command installation
- ✅ Professional appearance
- ✅ Easy to share (just a URL)

**Cons:**
- ❌ Requires web hosting
- ❌ Security considerations (running remote scripts)

---

### Option 4: Internal Package Repository

**Best for**: Enterprise environments, existing package management

#### Setup with npm (example)

1. **Create package.json**
   ```json
   {
     "name": "@yourorg/bob-research-assistant",
     "version": "1.0.0",
     "description": "Research Assistant skill for Bob",
     "scripts": {
       "postinstall": "./install.sh"
     }
   }
   ```

2. **Publish to internal registry**
   ```bash
   npm publish --registry=https://npm.yourcompany.com
   ```

#### Installation for Users

```bash
npm install -g @yourorg/bob-research-assistant
```

**Pros:**
- ✅ Professional package management
- ✅ Automated updates
- ✅ Access control
- ✅ Dependency management

**Cons:**
- ❌ Requires infrastructure setup
- ❌ More complex initial setup

---

## 📋 Pre-Distribution Checklist

Before sharing, ensure:

- [ ] All scripts are executable (`chmod +x scripts/*.sh install.sh`)
- [ ] Documentation is complete and accurate
- [ ] Examples work correctly
- [ ] Dependencies are clearly documented
- [ ] Installation script is tested on clean system
- [ ] README includes quick start guide
- [ ] License file is included (if public)
- [ ] Contact information is provided

---

## 🔒 Private Sharing (Team/Organization)

### Recommended Approach

1. **Private Git Repository**
   - GitHub/GitLab private repo
   - Access control via repository permissions
   - Internal documentation

2. **Installation Instructions**
   ```bash
   # Clone private repository
   git clone https://github.com/yourorg/bob-research-assistant.git
   cd bob-research-assistant
   ./install.sh
   ```

3. **Team Onboarding**
   - Share repository URL
   - Provide installation guide
   - Set up team communication channel
   - Document common issues

### Access Management

- Use repository permissions for access control
- Create teams for different access levels
- Use branch protection for main branch
- Require pull requests for changes

---

## 🌍 Public Sharing (Open Source)

### Recommended Approach

1. **Public GitHub Repository**
   - Clear README with badges
   - Comprehensive documentation
   - Issue templates
   - Contributing guidelines
   - Code of conduct

2. **Choose a License**
   - **MIT**: Most permissive, allows commercial use
   - **Apache 2.0**: Patent protection included
   - **GPL v3**: Copyleft, derivatives must be open source

3. **Create Release**
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```

4. **Promote**
   - Bob community forums
   - Social media (Twitter, LinkedIn)
   - Blog post or tutorial
   - Demo video

### Public Repository Structure

```
bob-research-assistant-skill/
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   └── feature_request.md
│   └── workflows/
│       └── ci.yml
├── .bob/skills/research-assistant/
├── scripts/
├── install.sh
├── README.md
├── LICENSE
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
└── CHANGELOG.md
```

---

## 📝 Documentation Requirements

### For Private Sharing

**Minimum:**
- Installation instructions
- Quick start guide
- Prerequisites
- Troubleshooting

### For Public Sharing

**Required:**
- Comprehensive README
- Installation guide
- Usage examples
- API/command reference
- Contributing guidelines
- License
- Changelog

**Recommended:**
- Video tutorial
- Screenshots/GIFs
- FAQ section
- Roadmap
- Security policy

---

## 🔄 Version Management

### Semantic Versioning

Use semantic versioning (MAJOR.MINOR.PATCH):

- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes

Example: `v1.2.3`

### Changelog

Maintain a CHANGELOG.md:

```markdown
# Changelog

## [1.0.0] - 2026-06-17
### Added
- Initial release
- 13 utility scripts
- Comprehensive documentation
- 5 report templates

## [1.1.0] - 2026-07-01
### Added
- Multimedia transcription support
- New presentation generation

### Fixed
- Bug in batch conversion script
```

### Git Tags

```bash
# Create annotated tag
git tag -a v1.0.0 -m "Release version 1.0.0"

# Push tags
git push origin --tags

# List tags
git tag -l
```

---

## 🚀 Installation Methods Comparison

| Method | Ease of Use | Updates | Version Control | Best For |
|--------|-------------|---------|-----------------|----------|
| Git Repository | ⭐⭐⭐⭐ | Easy (`git pull`) | ✅ Yes | Teams, collaboration |
| Compressed Archive | ⭐⭐⭐⭐⭐ | Manual | ❌ No | Simple sharing |
| Direct Install Script | ⭐⭐⭐⭐⭐ | Re-run script | ❌ No | Public distribution |
| Package Repository | ⭐⭐⭐ | Automatic | ✅ Yes | Enterprise |

---

## 💡 Recommendations

### For Small Teams (< 10 people)
**Use**: Private Git repository
- Easy to set up
- Good collaboration features
- Simple access control

### For Organizations (10-100 people)
**Use**: Private Git repository + Internal documentation
- Centralized documentation
- Team-based access control
- Integration with existing tools

### For Public/Open Source
**Use**: Public GitHub repository + Website
- Maximum visibility
- Community contributions
- Professional presentation

---

## 🆘 Support and Maintenance

### For Private Sharing

1. **Create internal documentation**
   - Wiki or Confluence page
   - FAQ section
   - Known issues

2. **Set up communication channel**
   - Slack/Teams channel
   - Email list
   - Regular office hours

3. **Assign maintainers**
   - Primary contact person
   - Backup maintainer
   - Clear escalation path

### For Public Sharing

1. **Use GitHub Issues**
   - Bug reports
   - Feature requests
   - Questions

2. **Create discussion forum**
   - GitHub Discussions
   - Discord server
   - Community forum

3. **Provide documentation**
   - Comprehensive guides
   - Video tutorials
   - Blog posts

---

## 📊 Success Metrics

Track these metrics to measure adoption:

### Private Sharing
- Number of installations
- Active users
- Support requests
- Feature requests

### Public Sharing
- GitHub stars
- Forks
- Downloads
- Contributors
- Issues/PRs

---

## 🔐 Security Considerations

### Before Sharing

- [ ] Remove sensitive information
- [ ] Review all scripts for security issues
- [ ] Document security best practices
- [ ] Include security policy (for public)

### For Users

- [ ] Verify source before installation
- [ ] Review scripts before running
- [ ] Use official installation methods
- [ ] Keep skill updated

---

## 📞 Getting Help

### For Skill Users

1. Check documentation
2. Review examples
3. Search existing issues
4. Contact maintainer

### For Skill Maintainers

1. Review this guide
2. Check Bob documentation
3. Join Bob community
4. Ask for help in forums

---

## 🎉 Next Steps

1. **Choose distribution method** based on your needs
2. **Prepare repository/archive** with all files
3. **Test installation** on clean system
4. **Share with users** using chosen method
5. **Gather feedback** and iterate

---

**Questions?** Open an issue or contact the maintainer.

**Last Updated**: 2026-06-17