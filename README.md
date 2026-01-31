# cfktech.com: Data Architecture Portfolio + Blog

A modern Jekyll-based portfolio site featuring blog posts, project showcases, and automated CI/CD. Demonstrates professional web presence combined with GitHub automation and infrastructure-as-code practices.

## Overview

This project demonstrates:
- **Portfolio site** with hero landing page, blog, and project showcases
- **Static site hosting** using Jekyll + GitHub Pages with custom domain (HTTPS)
- **Blog infrastructure** with Jekyll collections, auto-generated URLs, and listings
- **Semantic versioning** — automatic patch version bumping on changes
- **Automated PDF generation** from Markdown resume (pandoc + XeLaTeX)
- **Versioned releases** with downloadable PDF assets
- **GitHub Actions automation** for PDF generation, release creation, and deployment
- **Build validation** on pull requests (fail fast)
- **Branch protection** enforcing PR reviews before main branch merges

## Features

✅ Portfolio site at https://cfktech.com (GitHub Pages + custom domain + HTTPS)  
✅ **Home page**: Hero section + professional about + featured work preview  
✅ **Blog**: Jekyll collections with auto-generated URLs (`/blog/post-title/`)  
✅ **First blog post**: SQL Server Database Projects schema management template  
✅ **Second blog post**: Building cfktech.com (portfolio + CI/CD architecture)  
✅ **Projects page**: Showcase featured projects with links and tech stacks  
✅ **Resume page**: PDF download link + professional layout  
✅ **Navigation**: Sticky nav across all pages (Home | Blog | Projects | Resume | GitHub)  
✅ **Modern CSS**: Gradient hero, card layouts, responsive design, hover effects  
✅ Resume content in Markdown (`resume.md`) with metadata frontmatter  
✅ Automatic PDF generation from resume.md (pandoc + XeLaTeX)  
✅ Semantic versioning (v1.0.0 format, auto-incremented patch version)  
✅ PDF uploaded to GitHub releases as downloadable asset  
✅ GitHub Actions automation for releases and deployments  
✅ Pull request build validation (Jekyll build check)  
✅ Branch protection on main (require PR review before merge)  

## What's Live Now

**v1.0.15+** - Portfolio site with blog infrastructure

### Pages
- **Home**: https://cfktech.com - Portfolio hero + about + featured work
- **Blog**: https://cfktech.com/blog/ - Blog post listings
- **Projects**: https://cfktech.com/projects/ - Featured project showcases
- **Resume**: https://cfktech.com/resume/ - Resume page with PDF download

### Recent Posts
- "SQL Server Database Projects: Schema Management Template" (Jan 31, 2026)
- "Building cfktech.com: A Portfolio Site with Automated CI/CD" (Jan 31, 2026)

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

## Project Structure

```
cfktech-resume/
├── index.md                              # Portfolio homepage (hero + about + featured)
├── resume.md                             # Resume content (Markdown, source of truth)
├── _config.yml                           # Jekyll config (collections, defaults)
├── _layouts/
│   ├── default.html                      # Main template (nav + CSS + layout)
│   ├── home.html                         # Homepage layout wrapper
│   └── post.html                         # Blog post template
├── _posts/
│   ├── 2026-01-31-sql-server-database-projects-template.md
│   └── 2026-01-31-cfktech-portfolio-site.md
├── blog/index.md                         # Blog listing page
├── projects/index.md                     # Projects showcase page
├── resume/index.md                       # Resume page (links to PDF)
├── CNAME                                 # Custom domain (cfktech.com)
├── Gemfile                               # Ruby dependencies
├── .gitignore                            # Git ignore patterns
└── .github/workflows/
    ├── auto_release.yml                  # Release + PDF generation + deploy
    └── build-check.yml                   # PR build validation
```

## Workflow Architecture

### Deployment Pipeline

```
Code Changes
    ↓
Feature Branch
    ↓
Push to GitHub
    ↓
Build Check (PR validation) ✓
    ↓
Create Pull Request
    ↓
Review & Approve
    ↓
Merge to Main
    ↓
Auto-Release Workflow
├─ Calculate Version
├─ Generate PDF
├─ Create Release Tag
└─ Deploy to GitHub Pages
    ↓
Live on cfktech.com ✓ (2-3 minutes)
```

### auto_release.yml

**Trigger**: Push to main with changes to:
- `resume.md` - Resume content changes
- `_layouts/**` - Template/styling changes
- `_config.yml` - Configuration changes
- `blog/**` - Blog posts
- `projects/**` - Project showcases

**Steps**:
1. Get latest git tag
2. Calculate next version (semantic patch bump)
3. Create release tag
4. Generate PDF from resume.md (pandoc + XeLaTeX)
5. Upload PDF to GitHub release assets
6. Deploy to GitHub Pages

**Permissions**: `contents: write` (allows tag creation and PDF upload)

### build-check.yml

**Trigger**: Pull request to main

**Steps**:
1. Checkout code
2. Set up Ruby 3.2
3. Install dependencies (bundler + gems)
4. Run Jekyll build
5. Fail if build errors detected

**Purpose**: Catch configuration or Markdown syntax errors before merge

## Architecture Decisions

### Why Jekyll Collections for Blog?

✓ Automatic URL generation from filenames  
✓ Liquid loops for auto-population of listings  
✓ Scalable (add posts without modifying templates)  
✓ Standard Jekyll pattern  
✓ Works great with GitHub Pages

### Why Inline CSS?

✓ GitHub Pages works best with single-file layouts  
✓ Easier to maintain (layout + CSS in one place)  
✓ No asset pipeline needed  
✓ Modern CSS: gradients, cards, responsive design, 400+ lines

### Why Separate Build-Check Workflow?

✓ PR validation happens on every PR (fail fast)  
✓ Auto-release only runs on main (intentional deployment)  
✓ Clear separation of concerns  
✓ Prevents failed builds from reaching production

### Resume as Single Source of Truth

✓ `resume.md` generates both website content and PDF  
✓ One source → multiple outputs (site + PDF)  
✓ Ensures consistency  
✓ Versionable in git

## Common Tasks

### Add a Blog Post

1. Create file: `_posts/YYYY-MM-DD-title.md`
2. Add frontmatter:
   ```yaml
   ---
   layout: post
   title: "Your Post Title"
   date: 2026-01-31
   excerpt: "Short description for listings"
   ---
   ```
3. Write content in Markdown
4. Push to feature branch → PR → Merge → Auto-deployed

### Update Resume

1. Edit `resume.md` with new content
2. Commit and push to main
3. Auto-release creates new version (v1.0.16)
4. PDF auto-generated and uploaded to release
5. `/resume/` page updated with new PDF link

### Add a Project to Showcase

1. Edit `projects/index.md`
2. Add project card with title, description, tech tags, links
3. Commit → Push → PR → Merge → Live (2-3 min)

### Update Styling

1. Edit CSS in `_layouts/default.html`
2. Test locally: `jekyll serve`
3. Commit → Push → PR → Build check validates → Merge → Live

## Technical Stack

- **Site Generator**: Jekyll 4.3+
- **Hosting**: GitHub Pages
- **Domain**: Custom domain via Hover.com
- **HTTPS**: GitHub-managed certificate (auto-renews)
- **PDF Generation**: Pandoc + XeLaTeX
- **CI/CD**: GitHub Actions
- **Version Control**: Git + GitHub
- **CSS Framework**: Custom modern CSS (no frameworks)
- **Markdown**: Jekyll-native support

## Version History

**v1.0.15** - Phase 1: Portfolio redesign, blog infrastructure
- New portfolio homepage (hero + about)
- Blog infrastructure with Jekyll collections
- First blog post: SQL Server Database Projects
- Projects showcase page
- Modern CSS with responsive design
- Build validation workflow
- Fixed: Gemfile jekyll-feed version
- Fixed: Removed missing include references

**v1.0.14** - Last resume-only version
- Fully automated resume + PDF generation
- Semantic versioning
- GitHub Pages deployment

**v1.0.0-v1.0.13** - Resume site with QR codes
- Initial resume site setup
- PDF generation implementation
- QR code experiments (later removed)

## Future Phases

### Phase 2: More Content
- Add 2-3 more blog posts from GitHub projects
- Create more project showcase cards
- Expand thought leadership content

### Phase 3: Advanced Features
- Search functionality for blog
- Tags/categories for posts
- Email newsletter integration
- Analytics and engagement tracking
- Subtle monetization (courses, templates, consulting)

## GitHub Issues for Project Management

This project uses GitHub Issues to track work:
- Issues for Phase 2 features
- Issues for Phase 3 enhancements
- Issues for bugs or improvements

Check the [Issues tab](https://github.com/brianjmurray/cfktech-resume/issues) for current work.

## Contributing

This is a personal portfolio project, but feel free to:
- Fork and create your own version
- Adapt the layout/styling
- Use as a template for your portfolio

## License

This project is provided as-is for portfolio purposes.

---

## Quick Links

- **Live Site**: https://cfktech.com
- **GitHub Repo**: https://github.com/brianjmurray/cfktech-resume
- **Latest Release**: https://github.com/brianjmurray/cfktech-resume/releases/latest
- **Latest PDF**: https://github.com/brianjmurray/cfktech-resume/releases/latest/download/resume.pdf

## Questions?

Questions about the site, Jekyll, GitHub automation, or data architecture?

- **Email**: brian@cfktech.com
- **LinkedIn**: [@brianjmurray](https://www.linkedin.com/in/brianjmurray/)
- **GitHub**: [@brianjmurray](https://github.com/brianjmurray)

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
