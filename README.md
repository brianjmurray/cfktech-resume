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

This project uses GitHub Issues to track Phase 2 and Phase 3 work. Issues are linked to feature branches, PRs, and releases using a simple keyword pattern.

### Workflow: From Issue to Live

1. **Pick an issue** (e.g., #24 "Blog post: brew-setup-and-update")
2. **Create feature branch** from the issue:
   ```bash
   git checkout -b feature/issue-24-brew-blog
   ```
3. **Make changes** and test locally
4. **Commit with issue keyword**:
   ```bash
   git commit -m "Add brew-setup-and-update blog post - fixes #24"
   git push origin feature/issue-24-brew-blog
   ```
5. **Create PR** on GitHub:
   ```bash
   gh pr create --title "Blog post: brew-setup-and-update - fixes #24"
   ```
   - **Key**: Include "fixes #24" in PR title or commit message
   - Build check runs automatically on PR
6. **Review & merge**:
   ```bash
   gh pr merge --merge --delete-branch
   ```
   - When PR merges, GitHub automatically closes issue #24
7. **Auto-release triggers**:
   - New version created (v1.0.16)
   - PDF generated (if resume changed)
   - GitHub Pages updates live (2-3 minutes)

### Issue Keywords That Auto-Close

Add any of these keywords with the issue number in your **commit message** or **PR title** to auto-close the issue when merged:
- `fixes #24` - closes the issue
- `closes #24` - closes the issue
- `resolves #24` - closes the issue

**Example commits**:
```bash
git commit -m "Add brew blog post - fixes #24"
git commit -m "Update project cards - closes #26, #27"
git commit -m "Implement search functionality - resolves #28"
```

### Current Phases

**Phase 2** (More Content):
- [#24](https://github.com/brianjmurray/cfktech-resume/issues/24) Blog post: brew-setup-and-update
- [#25](https://github.com/brianjmurray/cfktech-resume/issues/25) SQL Server Database Projects (published)
- [#26](https://github.com/brianjmurray/cfktech-resume/issues/26) Project card: brew-setup-and-update
- [#27](https://github.com/brianjmurray/cfktech-resume/issues/27) Project card: cfktech-resume

**Phase 3** (Advanced Features):
- [#28](https://github.com/brianjmurray/cfktech-resume/issues/28) Blog search functionality
- [#29](https://github.com/brianjmurray/cfktech-resume/issues/29) Blog tags and categories
- [#30](https://github.com/brianjmurray/cfktech-resume/issues/30) Email newsletter integration
- [#31](https://github.com/brianjmurray/cfktech-resume/issues/31) Analytics and engagement tracking
- [#32](https://github.com/brianjmurray/cfktech-resume/issues/32) Buy Me a Coffee donations

Check the [Issues tab](https://github.com/brianjmurray/cfktech-resume/issues) for details on each issue.

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

