# Resume Site with GitHub Pages + Automated PDF

A Jekyll-based resume site template with automated PDF generation via GitHub Actions. Hosted on a custom domain using GitHub Pages with HTTPS.

## Overview

This project demonstrates:
- **Static site hosting** using Jekyll + GitHub Pages
- **Custom domain** with HTTPS via GitHub Pages
- **Automated PDF generation** from Markdown using GitHub Actions
- **Versioned releases** with downloadable resume assets
- **GitHub Copilot CLI** workflows for repo management and automation

## Features

✅ Resume hosted via GitHub Pages (custom domain + HTTPS)  
✅ Resume content stored in Markdown (`resume.md`)  
✅ Clean single-page Jekyll layout  
✅ PDF auto-generated on each release  
✅ HTTPS with GitHub-managed certificate  

## Architecture

```
resume-site/
├── resume.md                         # Resume content (source of truth)
├── index.md                          # Jekyll page that renders resume.md
├── _config.yml                       # Jekyll configuration
├── _layouts/
│   └── default.html                  # HTML template
├── .github/workflows/
│   └── generate_pdf.yml              # GitHub Actions: PDF generation
├── CNAME                             # Custom domain for GitHub Pages
└── README.md                         # This file
```

## Getting Started

### 1. Fork or Clone This Template

```bash
gh repo create my-resume-site --public --clone
cd my-resume-site
```

### 2. Edit Your Resume

Edit `resume.md` with your resume content in Markdown:

```markdown
# Your Name

## Professional Experience

### Company Name
#### Your Title (Start–End)
- Achievement or responsibility 1
- Achievement or responsibility 2
```

Commit and push changes:

```bash
git add resume.md
git commit -m "Update resume"
git push origin main
```

The site at your custom domain updates automatically.

### 3. Set Up Custom Domain

**Option A: GitHub Pages Settings**
1. Go to **Settings → Pages**
2. Under "Custom domain", enter your domain (e.g., `yourname.com`)
3. GitHub creates a CNAME file and shows DNS instructions

**Option B: Via Copilot CLI (automated)**
```bash
gh api repos/OWNER/REPO/pages -f cname=yourname.com
```

Update DNS records at your registrar:
- **A records** (for apex domain): `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
- Or **CNAME** (for www subdomain): `USERNAME.github.io`

### 4. Enable HTTPS

In **Settings → Pages**, once DNS is configured, check "Enforce HTTPS". GitHub auto-issues a certificate.

## Generating a Resume PDF

### Create a Release to Trigger PDF Generation

```bash
gh release create v1.0 \
  --title "Resume v1.0" \
  --notes "Initial release"
```

The GitHub Actions workflow automatically:
1. Generates `resume.pdf` from `resume.md`
2. Uploads the PDF as a release asset

**Download** the PDF from the [Releases](../../releases) page.

### Updating an Existing PDF

Create a new release:

```bash
gh release create v1.1 \
  --title "Resume v1.1" \
  --notes "Updated: [changes here]"
```

## PDF Generation Workflow

**Trigger**: On release publish  
**File**: `.github/workflows/generate_pdf.yml`

**Steps**:
1. Install pandoc and TeX Live
2. Convert `resume.md` → `resume.pdf` (using XeLaTeX)
3. Upload PDF to release assets

**Why XeLaTeX?**
- Better font support (TrueType, OpenType)
- Professional PDF output
- Handles special characters well

## GitHub Copilot CLI Reference

### Repository Setup
```bash
# Create a new repo
gh repo create my-resume-site --public --source=. --push

# Set homepage
gh repo edit OWNER/REPO --homepage https://yourname.com
```

### Release Management
```bash
# Create a release
gh release create v1.0 --title "Resume v1.0" --notes "Release notes"

# List releases
gh release list

# Delete a release
gh release delete v1.0 --confirm
```

### GitHub Pages
```bash
# Check Pages status
gh api repos/OWNER/REPO/pages --jq '.status, .https_enforced'

# Set custom domain
gh api repos/OWNER/REPO/pages -f cname=yourname.com
```

### Workflow Monitoring
```bash
# List workflow runs
gh run list --repo OWNER/REPO --limit 10

# View workflow logs
gh run view <RUN_ID> --log

# Check a specific job
gh run view <RUN_ID> --json jobs
```

## Protecting Your Repository (Public Repo)

Since this is a public repository, consider these settings to prevent unauthorized changes:

### Branch Protection
1. **Settings → Branches → Add rule**
2. **Branch name pattern**: `main`
3. Enable:
   - ✅ **Require pull request reviews** (1 approver minimum)
   - ✅ **Require status checks** (GitHub Pages build must pass)
   - ✅ **Require branches to be up to date**
   - ✅ **Dismiss stale pull request approvals**

### Access Control
1. **Settings → Collaborators** — Only add trusted collaborators
2. **Settings → Code security → Private vulnerability reporting** (if needed)
3. Consider making the repo **private** if you prefer to limit visibility

### Workflow Permissions
The `generate_pdf.yml` workflow uses:
- `permissions: contents: write` — allows uploading to releases only
- `GITHUB_TOKEN` — scoped to this repo only (no personal access)

## Local Development

### Preview Site Locally
```bash
gem install bundler jekyll
bundle install
bundle exec jekyll serve
```
Visit `http://localhost:4000`

### Generate PDF Locally
```bash
# Install pandoc and texlive-xetex
brew install pandoc texlive

# Generate PDF
pandoc resume.md -o resume.pdf --pdf-engine=xelatex
```

## Customization

### Styling
Edit `_layouts/default.html` to customize CSS:

```html
<style>
  body { font-family: "Georgia", serif; max-width: 900px; }
  h1 { color: #333; border-bottom: 2px solid #0066cc; }
</style>
```

### PDF Styling
Add a pandoc metadata block to `resume.md`:

```yaml
---
title: Your Name
author: Your Name
date: January 2026
geometry: margin=1in
fontsize: 11pt
---
```

Then generate with metadata:
```bash
pandoc resume.md -o resume.pdf --pdf-engine=xelatex --metadata-file resume.md
```

### Jekyll Config
Edit `_config.yml` to change site title or add plugins:

```yaml
title: "Your Name - Resume"
baseurl: ""
url: "https://yourname.com"
```

## Troubleshooting

### GitHub Pages not updating
- Check **Settings → Pages** to confirm source is `main` branch, root directory
- Verify CNAME file exists and contains your domain
- Wait 1–2 minutes for GitHub's build to complete

### PDF upload fails in Actions
- Verify workflow has `permissions: contents: write`
- Check workflow logs: `gh run view <RUN_ID> --log`
- Ensure GITHUB_TOKEN is not rate-limited

### DNS not resolving
- Flush DNS cache: `sudo dscacheutil -flushcache` (macOS)
- Check DNS records: `dig yourname.com @8.8.8.8`
- Allow 24–48 hours for propagation

## License

This template is provided as-is. Feel free to modify and use for your resume site.

---

**Learn More**:
- [GitHub Pages Documentation](https://pages.github.com)
- [GitHub Copilot CLI](https://github.com/features/copilot)
- [Jekyll Documentation](https://jekyllrb.com)
- [Pandoc Documentation](https://pandoc.org)
