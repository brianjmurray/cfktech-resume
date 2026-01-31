# cfktech.com Resume Site

A Jekyll-based resume site with GitHub Pages hosting, automated semantic versioning, PDF generation, and CI/CD pipeline. Demonstrates GitHub Copilot CLI usage for repository management and GitHub Actions automation.

## Overview

This project demonstrates:
- **Static site hosting** using Jekyll + GitHub Pages with custom domain
- **Semantic versioning** — automatic patch version bumping on resume changes
- **Automated PDF generation** from Markdown (pandoc + XeLaTeX)
- **Versioned releases** with downloadable PDF assets
- **Branch protection** enforcing PR reviews before main branch merges
- **GitHub Actions automation** for release creation, PDF generation, and index regeneration
- **QR codes** for LinkedIn profile and credential links
- **GitHub Copilot CLI** workflows and commands documented

## Features

✅ Resume hosted at https://cfktech.com via GitHub Pages (custom domain + HTTPS)  
✅ Resume content in Markdown (`resume.md`) with metadata frontmatter  
✅ Automatic `index.md` regeneration for Jekyll rendering  
✅ QR codes for LinkedIn and credential links  
✅ Semantic versioning (v1.0.0 format, auto-incremented patch version)  
✅ PDF auto-generated on resume changes and pushed to release assets  
✅ Single consolidated GitHub Actions workflow for release + PDF + index sync  
✅ Branch protection on main (require PR review before merge)  
✅ HTTPS with GitHub-managed certificate (auto-renews)  
✅ **Phase 1**: Portfolio site with blog, projects showcase, and modern styling  
✅ **Phase 1**: Local testing + GitHub Actions build validation on PRs  

## Local Development

### Setup

1. **Install Ruby 3.2+** (required for Jekyll)
   ```bash
   ruby --version  # Should be 3.2.0+
   ```

2. **Install dependencies**:
   ```bash
   bundle install
   ```

3. **Start local server**:
   ```bash
   bundle exec jekyll serve
   ```
   Visit http://localhost:4000 in your browser. Changes auto-reload as you save files.

### Creating a Feature Branch

1. **Create a branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make changes** and test locally with `jekyll serve`

3. **Commit and push**:
   ```bash
   git add .
   git commit -m "Your commit message"
   git push -u origin feature/your-feature-name
   ```

4. **Create a pull request** on GitHub (GitHub Actions build check runs automatically)

5. **Review & merge** (build must pass before merging)

### Build Locally

```bash
bundle exec jekyll clean && bundle exec jekyll build
```

Verify the `_site/` directory is generated with no errors.

## Architecture

```
cfktech-resume/
├── resume.md                         # Resume content (Markdown, source of truth)
│   ├── Pandoc metadata block (lines 1–7)
│   ├── LinkedIn contact with QR code
│   └── CERTIFICATIONS section with QR codes
├── index.md                          # Jekyll page (auto-regenerated from resume.md)
├── _config.yml                       # Jekyll config (title, url, layout)
├── _layouts/
│   └── default.html                  # Minimal HTML template
├── linkedin-qr.png                   # QR code → LinkedIn profile
├── databricks-qr.png                 # QR code → Databricks credential
├── CNAME                             # Custom domain for GitHub Pages (cfktech.com)
├── .github/workflows/
│   └── auto_release.yml              # Single workflow: versioning + release + PDF + sync
└── README.md                         # This file
```

## Workflow: auto_release.yml

**Trigger**: `push` to `main` branch with changes to:
- `resume.md`
- `_layouts/**`
- `_config.yml`

**Steps**:
1. **Checkout** with full history (for git tag calculation)
2. **Get latest tag** from git history
3. **Calculate next version** (semantic patch bump: v1.0.3 → v1.0.4)
4. **Check if tag exists** for current commit (skip if already tagged)
5. **Regenerate index.md** from resume.md with Jekyll frontmatter
6. **Create release** with auto-incremented version tag
7. **Install pandoc + TeX Live** (Ubuntu packages)
8. **Generate PDF** from resume.md using XeLaTeX engine
9. **Upload PDF** to release assets via GitHub REST API
10. **Commit regenerated index.md** back to main (triggers GitHub Pages rebuild)

**Permissions**: `contents: write` (allows release creation, PDF upload, and pushing commits)

## Getting Started

### 1. Update Your Resume

Edit `resume.md` with your content:

```markdown
---
title: ""
titlepage: false
author: Your Name
geometry: margin=0.8in
fontsize: 10pt
---

# Your Name

**Email**: email@example.com · ![](linkedin-qr.png){width=0.4in} LinkedIn: [profile](https://linkedin.com/in/yourprofile)

## Professional Experience

**Company Name**, City  
*Title* (Start–End)
- Achievement or responsibility 1
- Achievement or responsibility 2

## CERTIFICATIONS

![](cert-qr.png){width=0.4in} **Certification Name** (Month Year)

## EDUCATION

**School Name**, City  
Degree (Year)
```

The metadata block (lines 1–7) controls PDF formatting. Set `title: ""` and `titlepage: false` to suppress a title page.

### 2. Generate QR Codes (Optional)

```bash
# Generate QR code for LinkedIn profile
qrencode -o linkedin-qr.png -s 4 "https://www.linkedin.com/in/yourprofile"

# Generate QR code for credential URL
qrencode -o cert-qr.png -s 4 "https://credentials.example.com/your-id"

# Embed in resume.md
# ![](linkedin-qr.png){width=0.4in} LinkedIn
# ![](cert-qr.png){width=0.4in} Certification
```

### 3. Commit and Push to Main

```bash
git checkout -b feature/update-resume
git add resume.md linkedin-qr.png
git commit -m "Update: Resume and QR codes"
gh pr create --title "Update resume"
gh pr merge --merge -d   # Approve and merge
```

**The workflow automatically**:
- Creates release v1.0.4 (auto-versioned)
- Generates `resume.pdf`
- Uploads PDF to release assets
- Regenerates `index.md` and commits to main
- Triggers GitHub Pages rebuild (site updates within 1–2 minutes)

### 4. Configure Custom Domain

1. Update DNS at registrar (A records):
   ```
   185.199.108.153
   185.199.109.153
   185.199.110.153
   185.199.111.153
   ```

2. GitHub Pages **Settings → Pages**:
   - Custom domain: `yourname.com`
   - Enforce HTTPS: ✅ (auto-manages certificate)

### 5. Branch Protection

**Settings → Branches → Add rule**:
- Branch: `main`
- ✅ Require pull request reviews (1 approver)
- ✅ Require status checks to pass (Pages must build)
- ✅ Require branches to be up to date
- ✅ Dismiss stale reviews on push

## Downloading Your Resume

Resume PDF is available at:
```
https://github.com/brianjmurray/cfktech-resume/releases/download/v1.0.4/resume.pdf
```

Or via GitHub CLI:
```bash
gh release download v1.0.4 --pattern "resume.pdf"
```

Or visit the [Releases page](../../releases) to download any version.

## GitHub Copilot CLI Reference

### Repository Setup & Configuration

```bash
# Clone and navigate
gh repo clone brianjmurray/cfktech-resume
cd cfktech-resume

# View repo metadata
gh repo view --json description,homepage,isPrivate

# Set homepage
gh repo edit --homepage https://cfktech.com
```

### Branch & PR Management

```bash
# Create feature branch
git checkout -b feature/update-resume

# Create pull request
gh pr create --title "Update resume content" --body "Added certifications"

# View PR status
gh pr view <PR_NUMBER>

# Approve PR (if you have permissions)
gh pr review <PR_NUMBER> --approve

# Merge PR (deletes feature branch)
gh pr merge <PR_NUMBER> --merge --delete-branch
```

### Release & Version Management

```bash
# List all releases
gh release list

# View specific release with assets
gh release view v1.0.4

# Download PDF from latest release
gh release download --pattern "resume.pdf"

# Download from specific version
gh release download v1.0.3 --pattern "resume.pdf" -D ~/Downloads
```

### Workflow Monitoring

```bash
# List recent workflow runs
gh run list --workflow auto_release.yml --limit 5

# View specific run details
gh run view <RUN_ID> --json status,conclusion,createdAt

# View full logs for a run
gh run view <RUN_ID> --log | head -100

# Check failed jobs only
gh run list --status completed --conclusion failure
```

### GitHub Pages Status

```bash
# Check Pages configuration
gh api repos/brianjmurray/cfktech-resume/pages --jq '.status, .https_enforced, .cname'

# Enable HTTPS (if not already)
gh api repos/brianjmurray/cfktech-resume/pages -f https_enforced=true
```

## Protecting the Repository

### Branch Protection on Main

Prevents direct pushes; all changes must come via PR from feature branches.

**To set up via CLI**:
```bash
# Note: Full branch protection config via CLI is complex; use GitHub web UI

# Quick web UI setup:
# Settings → Branches → Add rule
# - Branch name pattern: main
# - ✅ Require pull request reviews (1 approver)
# - ✅ Require status checks to pass (Pages build)
# - ✅ Require branches to be up to date before merging
# - ✅ Dismiss stale pull request approvals
# - ✅ Block force pushes
```

### Workflow Permissions

The `auto_release.yml` workflow uses minimal permissions:
```yaml
permissions:
  contents: write  # Only: create releases, push index.md commits
```

This token **cannot**:
- Delete the repository
- Modify settings
- Access other repos or secrets

### Branching Strategy

1. **Create feature branch** from main:
   ```bash
   git checkout -b feature/update-resume
   ```

2. **Make changes** to `resume.md`, QR codes, or layouts

3. **Push and create PR**:
   ```bash
   git push origin feature/update-resume
   gh pr create
   ```

4. **PR triggers**:
   - GitHub Pages build check (must pass)
   - Status check for branch protection

5. **Merge PR** (via CLI or web):
   ```bash
   gh pr merge --merge -d  # Deletes feature branch after merge
   ```

6. **Workflow runs automatically**:
   - Detects `resume.md` change
   - Creates release (v1.0.4)
   - Generates PDF
   - Pushes `index.md` back to main
   - GitHub Pages rebuilds (live in 1–2 min)

## Advanced: Semantic Versioning Details

The workflow automatically bumps the **patch version** (v1.0.3 → v1.0.4) on any commit to `resume.md`.

**How it works**:
1. Fetch latest git tag: `git describe --tags --abbrev=0` → `v1.0.3`
2. Extract version parts: MAJOR=1, MINOR=0, PATCH=3
3. Increment PATCH: `PATCH=$((PATCH + 1))` → 4
4. Create new tag: `v1.0.4`
5. Create release with tag

**To manually change MAJOR or MINOR**:
- Edit `.github/workflows/auto_release.yml`
- Modify the `Calculate next version` step
- Or manually create release: `gh release create v2.0.0 --title "Resume v2.0.0"`

## Local Development

### Preview Site Locally
```bash
# Install Jekyll
gem install bundler jekyll

# Install dependencies
bundle install

# Serve locally
bundle exec jekyll serve
```
Visit `http://localhost:4000` — changes to `resume.md` auto-reload.

### Generate PDF Locally
```bash
# Install tools (macOS)
brew install pandoc texlive

# Generate (uses resume.md metadata block)
pandoc resume.md -o resume.pdf --pdf-engine=xelatex --standalone
```

## Customization

### Change Site Title or URL
Edit `_config.yml`:
```yaml
title: "Your Name - Resume"
url: "https://yourname.com"
baseurl: ""
```

### Change HTML Layout
Edit `_layouts/default.html`:
```html
<style>
  body { font-family: Georgia, serif; max-width: 900px; margin: 0 auto; }
  h1 { color: #333; border-bottom: 2px solid #0066cc; }
</style>
```

### Modify PDF Formatting
Edit the pandoc metadata block in `resume.md` (lines 1–7):
```yaml
---
title: ""
titlepage: false
author: Your Name
geometry: margin=0.8in
fontsize: 10pt
---
```

Available options:
- `title: "Your Title"` or `""` (no title page)
- `geometry: margin=1in` (1-inch margins)
- `fontsize: 11pt` (font size)
- `date: "January 2026"` (date on title page)

## Troubleshooting

### Website not updating after merge
- **Check**: GitHub Pages build status in **Settings → Pages → Recent deployments**
- **Fix**: The `auto_release.yml` workflow regenerates `index.md` and commits it back to main. This may take 2–3 minutes after PR merge.
- **Verify**: `grep "CERTIFICATIONS" index.md` should show your content

### Workflow didn't trigger
- **Cause**: Workflow only triggers on changes to `resume.md`, `_layouts/**`, or `_config.yml`
- **Not triggered by**: changes to workflow file itself, QR code images, or README
- **Fix**: If you update the workflow, make a test change to `resume.md` to trigger it

### PDF missing QR codes in release
- **Check**: Ensure QR code PNG files are committed: `git ls-files *.png`
- **Check**: `resume.md` references are correct: `![](filename.png){width=0.4in}`
- **Test locally**: `pandoc resume.md -o test.pdf --pdf-engine=xelatex`

### DNS not working
- **Check**: `dig cfktech.com` or `nslookup cfktech.com`
- **Expected**: 4 A records pointing to GitHub Pages IPs:
  ```
  185.199.108.153
  185.199.109.153
  185.199.110.153
  185.199.111.153
  ```
- **Note**: DNS changes can take 24–48 hours to propagate

### HTTPS certificate not issued
- **Cause**: DNS must be configured and resolving first
- **Check**: **Settings → Pages → Custom domain** should show domain without error
- **Wait**: GitHub issues cert within 15 min of DNS resolving
- **Force**: Try unchecking/re-checking "Enforce HTTPS"

## License

This template is provided as-is. Feel free to modify and use for your resume site.

---

**Learn More**:
- [GitHub Pages Documentation](https://pages.github.com)
- [GitHub Copilot CLI](https://github.com/features/copilot)
- [Jekyll Documentation](https://jekyllrb.com)
- [Pandoc Documentation](https://pandoc.org)
