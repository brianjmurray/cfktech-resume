---
layout: post
title: "Building cfktech.com: A Portfolio Site with Automated CI/CD"
date: 2026-01-31
excerpt: "From resume site to portfolio: how I built a fully automated site using Jekyll, GitHub Pages, semantic versioning, and CI/CD pipelines to showcase projects and thought leadership."
tags: [Jekyll, GitHub Pages, CI/CD, Portfolio, Automation]
---

## The Journey: Resume to Portfolio

My professional website evolved significantly in early 2026. It started as a simple resume site (v1.0.0-v1.0.14) and transformed into a full portfolio platform with automated deployments, blog infrastructure, and project showcases. This post shares the technical decisions, challenges, and solutions behind cfktech.com.

## Phase 0: The Resume Site (v1.0.0-v1.0.14)

### What Started It All

I needed a professional web presence that was:
- **Self-hosted** on a custom domain
- **Always up-to-date** with my resume
- **Professional-looking** with minimal maintenance
- **Demonstrating automation skills** (as a data engineer)

### Solution: Jekyll + GitHub Pages

I chose a simple stack:
- **Jekyll** for static site generation (no server needed)
- **GitHub Pages** for free hosting with custom domain support
- **Markdown** for resume content (versionable, easy to edit)
- **GitHub Actions** for automation

### Key Features (v1.0.0-v1.0.14)

**Semantic Versioning**: Every time I updated my resume, a GitHub Action would:
1. Calculate the next patch version (e.g., v1.0.3 → v1.0.4)
2. Create a git tag and GitHub release
3. Generate a PDF from the Markdown resume
4. Upload the PDF to the release assets
5. Deploy to GitHub Pages

**PDF Generation**: Using pandoc + XeLaTeX to convert Markdown to professional PDF:
```bash
pandoc resume.md -o resume.pdf --pdf-engine=xelatex --standalone
```

**Branch Protection**: Enforcing PR reviews before merging to main, ensuring all changes were reviewed.

**QR Codes**: Added LinkedIn and Databricks credential links (later removed due to PDF rendering issues).

**Result**: A fully automated resume site that updated with a single git push.

## Phase 1: Portfolio Expansion (v1.0.15+)

After successfully automating the resume site, I realized it could be so much more. I wanted to:
- **Share knowledge** through blog posts
- **Showcase projects** from my GitHub
- **Build thought leadership** in data architecture
- **Maintain momentum** with a semi-automated workflow

### Home Page Redesign

Instead of just displaying the resume on the homepage, I created a portfolio landing page with:

**Hero Section**: A gradient background with compelling headline
```css
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
```

**About Section**: Professional bio with specializations and recent focus areas

**Featured Work**: Auto-populated from blog posts (first 3 appear on homepage)

**Contact CTA**: Direct links to email, GitHub, and LinkedIn

### Blog Infrastructure

Implemented **Jekyll Collections** for blog posts:

**File Structure**:
```
_posts/
  ├── 2026-01-31-sql-server-database-projects-template.md
  └── 2026-01-31-cfktech-portfolio-site.md (this post!)
```

**Automatic URL Generation**: Posts automatically get URLs like `/blog/post-title/`

**Post Template**: Dedicated layout for blog posts with title, date, and styling

**Blog Listing**: `/blog/` automatically lists all posts in reverse chronological order

### Projects Showcase

Created a `/projects/` page featuring GitHub repositories:
- Grid layout with project cards
- Tech stack tags for each project
- Links to GitHub repositories and related blog posts
- Template ready for adding more projects

### Workflow Validation

Added **GitHub Actions build check** on pull requests:
- Validates Jekyll builds successfully before merge
- Catches configuration or syntax errors early
- Prevents broken deploys

## Technical Highlights

### Challenge #1: Resume as Source of Truth

**Problem**: Resume needed to be accessible both on GitHub Pages (HTML) and as a downloadable PDF.

**Solution**: Use Markdown as the single source of truth:
- `resume.md` contains resume content with pandoc frontmatter
- GitHub Action converts to PDF on every release
- Homepage extracts relevant content for web display
- `/resume/` page links to PDF download

### Challenge #2: Auto-Release Complexity

**Problem**: The auto-release workflow regenerated index.md from resume.md, overwriting the new portfolio homepage.

**Discovery**: This was by design for v1.0.14 (when homepage = resume wrapper), but broke in Phase 1 (when homepage = portfolio).

**Solution**: Removed index.md regeneration from auto-release workflow. Now:
- `index.md` is the portfolio homepage (manually maintained)
- `/resume/` page links to PDF downloads
- Auto-release only generates PDF and creates release (no index regeneration)

### Challenge #3: Build Failure Debugging

Initial Phase 1 deployment revealed two issues:

**Issue 1**: Gemfile specified `jekyll-feed (~> 0.18)` which doesn't exist on rubygems.org
- **Fix**: Changed to `jekyll-feed (~> 0.17)` (latest available)

**Issue 2**: `/resume/index.md` referenced a non-existent include file
- **Fix**: Removed placeholder include, added fallback content

Both issues caught by GitHub Actions build check before going live!

## Architecture Decisions

### CSS Inline vs Separate Files

**Decision**: Inline CSS in `_layouts/default.html`

**Why**: 
- GitHub Pages works best with single-file layouts
- Easier to maintain (layout + styles in one place)
- No need for asset pipeline
- 400+ lines of modern CSS (gradients, cards, hover effects, responsive grid)

### Collections vs Static Pages

**Decision**: Used Jekyll collections for blog

**Why**:
- Automatic URL generation from filenames
- Liquid loops to automatically populate listings
- Scalable (easy to add posts without modifying templates)
- Standard Jekyll pattern

### Workflow Separation

**Decision**: Separate build-check workflow from auto-release

**Why**:
- Build validation happens on every PR (fail fast)
- Auto-release only runs on main after approval
- Keeps concerns separated
- Clear staging (PR = validation, merge = deploy)

## The Deployment Pipeline

```
Code Changes
    ↓
Create Feature Branch
    ↓
Push to GitHub
    ↓
GitHub Actions Build Check ✓
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
Live on cfktech.com ✓
```

Time from code push to live: ~2-3 minutes

## What's Live Now

### Pages

- **Home**: https://cfktech.com (portfolio landing)
- **Blog**: https://cfktech.com/blog/ (post listings)
- **Projects**: https://cfktech.com/projects/ (project showcases)
- **Resume**: https://cfktech.com/resume/ (PDF download)

### First Posts

- "SQL Server Database Projects: Schema Management Template" - featuring mssql-database-project
- "Building cfktech.com: A Portfolio Site with Automated CI/CD" - this post!

### Automation

- Semantic versioning (v1.0.15)
- PDF generation from Markdown
- GitHub Pages deployment
- Build validation on PRs
- Feature branch → Main → Auto-Release → Live

## What's Next

### Phase 2: More Content
- Add 2-3 more blog posts from existing GitHub projects
- Create more project showcase cards
- Deepen thought leadership content

### Phase 3: Advanced Features
- Search functionality for blog
- Tags/categories for posts
- Email newsletter integration
- Analytics (understanding audience)
- Subtle monetization (courses, templates, consulting)

## Key Lessons

1. **Automate what you repeat**: If you're doing something manually multiple times, automate it
2. **Fail fast with validation**: Build checks catch issues before they go live
3. **Markdown is underrated**: Single source of truth that works everywhere
4. **Simple tools scale**: Jekyll + GitHub Pages handles it all without complexity
5. **Git history is documentation**: Each commit tells a story of evolution

## Try It Yourself

If you want to build something similar:

1. **Clone a Jekyll starter** or use the GitHub Pages template
2. **Write content in Markdown** (posts, pages, resume)
3. **Add custom CSS** for your brand (gradients, cards, hero sections)
4. **Set up GitHub Actions** for PDF generation, versioning, or other automation
5. **Push to main** and watch it deploy automatically

## Conclusion

cfktech.com represents my commitment to:
- **Continuous learning** (Jekyll, GitHub Actions, automation)
- **Professional presence** (portfolio + blog + projects)
- **Thought leadership** (sharing what I know about data architecture)
- **Automation over manual work** (letting CI/CD handle deployments)

The site will evolve with my career, showcasing new projects and sharing insights from the data engineering and architecture world. And it all happens with the push of a git commit.

---

Interested in the technical details? Check out the repository:

**[cfktech-resume on GitHub →](https://github.com/brianjmurray/cfktech-resume)**

Questions about portfolio sites, Jekyll, automation, or data architecture? Reach out on LinkedIn or email me at brian@cfktech.com.
