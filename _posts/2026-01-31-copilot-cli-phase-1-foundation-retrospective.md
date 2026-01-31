---
layout: post
title: "From Idea to Automated Resume Site: How Copilot CLI Accelerated Phase 1"
date: 2026-01-31
excerpt: "Retrospective on Phase 1 of cfktech-resume: how GitHub Copilot CLI helped design Jekyll architecture, automate GitHub Actions workflows, and ship v1.0.0-v1.0.15 in weeks instead of months."
tags: [Copilot CLI, GitHub, Retrospective, Phase 1, Jekyll]
---

## Introduction

Phase 1 of cfktech-resume happened before I was systematically documenting Copilot CLI usage. But looking back, Copilot CLI was critical to how quickly and confidently I shipped the foundation.

This post is a retrospective on Phase 1, documenting how Copilot CLI shaped the initial site architecture, workflow automation, and deployment strategy—lessons that directly informed how I approached Phases 2 and 3.

---

## Phase 1 Overview

**Timeline**: December 2025 - January 2026  
**Releases**: v1.0.0 → v1.0.15  
**Goal**: Build a professional, automated resume site on cfktech.com  
**Tech Stack**: Jekyll + GitHub Pages + GitHub Actions + pandoc

The challenge wasn't building a resume site (simple), but building one that:
- ✅ Auto-generates PDFs
- ✅ Uses semantic versioning
- ✅ Deploys automatically
- ✅ Is professionally designed
- ✅ Showcases automation skills

---

## Part 1: Discovery & Architecture with Copilot CLI

### The Starting Question

When I first started Phase 1, I asked myself: **"What's the fastest way to build a professional resume site that auto-generates PDFs and versions itself?"**

This required research into:
- Static site generators (Jekyll vs. Hugo vs. Next.js vs. others)
- Deployment platforms (GitHub Pages vs. Netlify vs. traditional hosting)
- PDF generation approaches (pandoc vs. wkhtmltopdf vs. serverless)
- CI/CD frameworks (GitHub Actions vs. GitLab CI vs. others)

Without Copilot CLI, I would have:
1. Spent 3-4 hours browsing tutorials
2. Compared tools on Reddit
3. Made fragmented decisions
4. Possibly chosen the wrong stack

### How Copilot CLI Helped

**Initial Research Phase:**

```bash
$ copilot prompt "I want to build a resume site with these requirements:
- Professional design
- Auto-generates PDF from Markdown
- Deploys automatically
- Uses semantic versioning for releases
- Low maintenance

Compare Jekyll, Hugo, and Next.js. What are the tradeoffs?"
```

**Copilot CLI Response** (synthesized from documentation + best practices):
- **Jekyll**: Mature. Simple. GitHub Pages native integration. Good for blogs. PDF generation via pandoc. *Best for static resume + blog.*
- **Hugo**: Faster builds. Less JavaScript. Requires separate deployment. Overkill for resume.
- **Next.js**: Powerful. Requires server. Expensive to run. Overcomplicated for static site.

**Decision**: Jekyll. The reasoning:
- GitHub Pages native support (free hosting)
- Markdown-first workflow (versionable)
- Simple enough to understand and modify
- Proven ecosystem for PDF generation

---

## Part 2: Architecture & Layout Design

### The Challenge

Jekyll generates static sites, but I needed:
- A professional layout (not default Jekyll theme)
- Separate pages: Resume, Home, About
- Semantic HTML for accessibility
- Modern CSS (gradients, cards, responsive design)
- PDF-friendly styling

### Copilot CLI in Action: Layout Design

Rather than start with a blank canvas, I used Copilot CLI:

```bash
$ copilot prompt "Design a Jekyll site structure for a resume + portfolio.
What should the directory structure look like?
What are the standard collections and includes?
How do I organize CSS?"
```

**Copilot CLI provided**:
- Standard Jekyll structure (`_includes/`, `_layouts/`, `assets/`)
- How collections work (for blogs added later)
- Best practices for modular CSS
- Where to put configuration

Then I asked:

```bash
$ copilot prompt "I need a professional resume layout in HTML/CSS.
The resume should:
- Display from Markdown frontmatter
- Be printable to PDF
- Have a two-column layout (skills on left, content on right)
- Use modern colors and typography

Generate a Jekyll layout template."
```

**Copilot CLI generated**:
- A professional `_layouts/default.html` template
- CSS for two-column resume layout
- Print-friendly media queries
- Semantic HTML structure

This saved hours of design iteration. Instead of trying different layouts, I had a solid foundation to refine.

### Key Insight

Copilot CLI didn't just provide code—it provided a **coherent architecture**. Rather than collecting snippets from 10 different blogs, I had a unified design philosophy backed by layout templates and CSS structure.

---

## Part 3: Automation & GitHub Actions

### The Biggest Time Saver: Workflow Design

Phase 1's killer feature is the auto-release workflow:
1. Push resume changes to main
2. GitHub Action calculates next version
3. Automatically generates PDF
4. Creates GitHub release with PDF attached
5. Deploys to GitHub Pages

Without this workflow, each resume update would be manual: bump version, generate PDF, commit changes, push.

### How Copilot CLI Shaped the Workflow

**Initial Question:**

```bash
$ copilot prompt "I want to automate resume updates in GitHub Actions.
When I push to main:
1. Calculate the next semantic version from git tags
2. Generate a PDF using pandoc
3. Create a GitHub release with the PDF as an asset
4. Deploy to GitHub Pages

Design a GitHub Actions workflow for this."
```

**Copilot CLI Provided**:
A full workflow structure covering:
- Trigger conditions (on push to main)
- Getting git history and tags
- Calculating semantic version with `git describe`
- Running pandoc to generate PDF
- Using GitHub API to create releases
- Best practices for error handling

**What Would Have Taken 4 Hours**:
- Learning GitHub Actions syntax
- Understanding context and secrets
- Figuring out how to calculate versions
- Debugging pandoc command-line options
- Handling edge cases (no previous tag, malformed version)

**What Actually Took 1 Hour**:
- Copilot CLI provided the workflow
- I customized it for my resume format
- Small tweaks for PDF styling
- Testing on actual push

### Key Technical Decisions (Shaped by Copilot CLI)

**Version Calculation**:
```bash
$ copilot prompt "Best way to calculate next semantic version from 
existing git tags in a GitHub Actions workflow?"
```

Copilot CLI recommended:
```bash
LATEST_TAG=$(git describe --tags --abbrev=0)
NEW_VERSION=$(echo $LATEST_TAG | awk -F. '{print $1"."$2"."$3+1}')
```

This simple approach saved debugging complex version management tools.

**PDF Engine Selection**:
```bash
$ copilot prompt "Should I use pandoc with pdflatex, xelatex, or wkhtmltopdf 
for converting Markdown resume to PDF? Which handles Unicode, fonts, and styling best?"
```

Copilot CLI explained:
- **pdflatex**: Fast. Limited Unicode. Works fine for English.
- **xelatex**: Slower. Full Unicode support. Better fonts.
- **wkhtmltopdf**: Deprecated. Avoid.

**Decision**: xelatex for professional appearance and future Unicode support.

---

## Part 4: Lessons That Shaped Phase 2

### Lesson 1: Systematic Versioning Enables Confidence

Phase 1 established semantic versioning (v1.0.0 → v1.0.15). This small decision had huge consequences:
- Every change is tagged and released
- Can revert to any version
- Release notes create documentation
- Creates a product feel (not just a website)

In Phase 2, this workflow was so smooth that we shipped 4 releases in one session (v1.0.16 → v1.0.19).

**Copilot CLI Contribution**: Helped design and debug the version calculation logic. Without that confidence, we might have skipped versioning entirely.

### Lesson 2: Automation Compounds

Phase 1 automated resume updates. Phase 2 automated blog deployments. Phase 3 will automate Medium cross-posting.

Each phase adds 5-10 minutes of workflow automation. By Phase 5, shipping becomes near-instant.

**Copilot CLI Contribution**: Showed how GitHub Actions patterns repeat. Once I understood the pattern (trigger → process → release), Phase 2 and 3 workflows were simple extensions.

### Lesson 3: Architecture Decisions Pay Off

Choosing Jekyll Collections for blogs in Phase 1 meant Phase 2 blog posts auto-populate into listings. One good architecture decision prevented hours of custom code in Phase 2.

**Copilot CLI Contribution**: Explained Jekyll collections early, enabling a blog-ready architecture before we wrote a single post.

### Lesson 4: Constraints Enable Shipping

GitHub Pages has constraints:
- No server-side processing
- Static files only
- Build limitations
- Jekyll-specific

Rather than fight these constraints, Copilot CLI helped me embrace them:
- Use static search (not server search)
- Generate PDFs at build time (not on-demand)
- Use client-side JavaScript (not backend APIs)

These constraints led to simpler, more reliable solutions.

---

## Part 5: What Would Have Been Different Without Copilot CLI

### Scenario A: Without Copilot CLI

**Timeline: 4-6 weeks**

1. Spend 2-3 days researching Jekyll vs. Hugo vs. Next.js
2. Watch 10 tutorials, follow conflicting advice
3. Get stuck on GitHub Actions (underdocumented)
4. Build workflows incorrectly, debug for days
5. Struggle with pandoc configuration
6. Make conservative architectural choices to avoid learning curves
7. Ship with no versioning or PDF generation
8. Regret the architecture when Phase 2 starts

**Result**: Working site, but fragile. Phases 2 and 3 would reveal architectural limitations.

### Scenario B: With Copilot CLI (What Actually Happened)

**Timeline: 1-2 weeks**

1. Copilot CLI research in 30 minutes → Jekyll decision made with confidence
2. Copilot CLI workflow templates → GitHub Actions working in 1 hour
3. Copilot CLI layout design → Professional design in 2 hours
4. Small tweaks and testing → Done

**Result**: Solid foundation. Versioning. PDF generation. Blog-ready architecture. Phase 2 and 3 built on confidence, not compromise.

---

## Part 6: The Numbers

### Time Investment (Estimates)

| Task | Without Copilot CLI | With Copilot CLI | Savings |
|------|--------|--------|--------|
| Research & decision (Jekyll) | 3 hours | 0.5 hours | 2.5 hours |
| Workflow design | 4 hours | 1 hour | 3 hours |
| Layout & CSS | 6 hours | 2 hours | 4 hours |
| Pandoc setup & debug | 3 hours | 0.5 hours | 2.5 hours |
| Testing & fixes | 4 hours | 1 hour | 3 hours |
| **Total** | **20 hours** | **5 hours** | **15 hours** |

### Confidence Multiplier

Beyond time savings, Copilot CLI provided **confidence**:
- Confident in Jekyll choice (not second-guessing)
- Confident in workflows (not worried about fragility)
- Confident in architecture (not planning major rewrites)

This confidence enabled rapid iteration in Phases 2 and 3.

---

## Part 7: How Phase 1 Wisdom Shaped Future Phases

### Pattern Recognition

Phase 1 established a pattern:
```
Issue → Branch → Commit → PR → Build Check → Release → Live
```

This simple workflow became the **standard for Phase 2 and 3**. By the time Phase 2 started, we could close 7 issues in 2 hours because the workflow was second nature.

### Reusable Components

Phase 1 built:
- Jekyll site structure
- GitHub Actions workflow patterns
- CSS framework
- README documentation

Phase 2 reused all of these, just adding content and blog posts. Phase 3 will reuse them again, adding features on top.

**This is the compounding effect of good Phase 1 work.**

### Automation Mindset

Phase 1's automation obsession (versioning, PDF generation, GitHub Actions) set the tone for Phases 2 and 3:
- Phase 2 automated blog post deployment
- Phase 3 will automate Medium cross-posting

Each phase automates more, reducing manual work.

---

## Conclusion: Phase 1 as Foundation

Phase 1 of cfktech-resume was about more than building a resume site. It was about:
1. **Choosing the right stack** (Jekyll, not over-engineered solutions)
2. **Building a solid foundation** (versioning, deployment, architecture)
3. **Establishing workflows** (issue → release → live pattern)
4. **Creating confidence** (through successful execution)

All of this was accelerated by Copilot CLI, which:
- **Answered research questions** quickly and reliably
- **Provided workflow templates** that worked first-try
- **Explained architecture patterns** that paid off in later phases
- **Reduced decision friction** so we could ship fast

---

## The Three Phases: A Complete View

**Phase 1** (Foundation): Built the platform, established workflows, automated versioning  
**Phase 2** (Content): Populated with blog posts, added projects, documented the process  
**Phase 3** (Scale): Adding discovery (search/tags), audience growth (newsletter), monetization  

Each phase builds on the previous. Phase 1's decisions made Phase 2 possible. Phase 2's patterns will make Phase 3 simpler.

**The common thread**: Using Copilot CLI to make informed decisions, avoid dead-ends, and ship confidently.

---

## What's Next

This completes the Copilot CLI retrospective series:
1. ✅ Phase 1: Foundation & Automation (this post)
2. ✅ Phase 2: Blog Infrastructure & Content
3. ✅ Phase 3: Advanced Features & Monetization Planning

Phase 3 implementation begins next, starting with blog search (#28) and tags (#29).

---

## Lessons for Other Builders

If you're building a portfolio site or similar project:

1. **Use Copilot CLI for research**: Faster than googling. More coherent than Reddit.
2. **Choose boring technology**: Jekyll > Next.js for blogs. Don't over-engineer.
3. **Automate early**: Versioning and deployment are easier early. Harder to add later.
4. **Build incrementally**: Phases allow learning and adjusting without rewriting.
5. **Document the journey**: Blog posts about the process are as valuable as the code.

---

## Resources

- **cfktech-resume repository**: https://github.com/brianjmurray/cfktech-resume
- **Phase 2 post**: [Using Copilot CLI for Blog Infrastructure](/blog/copilot-cli-phase-2-blog-infrastructure/)
- **Phase 3 post**: [Planning Advanced Features & Monetization](/blog/copilot-cli-phase-3-advanced-features/)
- **General Phase 1 retrospective**: [Building cfktech.com](/blog/cfktech-portfolio-site/)

---

*This completes the Copilot CLI journey through cfktech-resume. From foundation to content to scale—all documented, all shipped. What would you build with Copilot CLI? Share your ideas [on GitHub](https://github.com/brianjmurray/cfktech-resume).*
