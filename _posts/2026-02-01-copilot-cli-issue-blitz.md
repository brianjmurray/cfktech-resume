---
layout: post
title: "Closing 6 Issues in One Session: What Copilot CLI Does Well (and Where It Struggles)"
date: 2026-02-01
tags: [Copilot CLI, GitHub, DevOps, Automation, CI/CD, Retrospective]
---

## The Goal: Clear the Issue Backlog

Tonight I set out to tackle the remaining open issues on cfktech.com using GitHub Copilot CLI exclusively. The result: all 6 issues closed. But the journey revealed both the strengths and limitations of AI-assisted development—particularly around testing and deployment infrastructure.

## The Issues Tackled

| Issue | Description | Outcome |
|-------|-------------|---------|
| #64 | Testing & staging infrastructure | ⚠️ Partially working |
| #32 | Buy Me a Coffee donation button | ✅ Complete |
| #25 | Close SQL Server post issue | ✅ Complete |
| #31 | Google Analytics 4 integration | ✅ Complete |
| #30 | Medium cross-posting strategy | ✅ Complete (was already done) |
| #59 | Accessibility & Dark Mode | ✅ Complete |

## Where Copilot CLI Excelled

### Quick Feature Implementation

For straightforward features, Copilot CLI was remarkably efficient:

**Issue #32 (Donation Button)**: Asked for a Buy Me a Coffee link in three locations. Copilot:
1. Found the URL from the GitHub issue comments
2. Edited `index.md`, `_layouts/post.html`, and `_layouts/default.html` in parallel
3. Added ~70 lines of CSS with gradient backgrounds and responsive design
4. Created the PR with proper `fixes #32` syntax

Total time: ~15 minutes from request to merged.

**Issue #31 (Analytics)**: After I provided my GA4 Measurement ID, Copilot added the 8-line tracking script to the correct location in the `<head>` section. Done in under 10 minutes.

**Issue #59 (Dark Mode)**: This was the most impressive. Copilot:
- Added CSS custom properties (25+ variables)
- Implemented `prefers-color-scheme: dark` media query
- Added skip-to-main-content link
- Added ARIA labels for accessibility
- Added focus states for keyboard navigation
- Added `prefers-reduced-motion` support

153 lines of changes, all following best practices.

### Issue Triage

Copilot correctly identified that Issue #30 ("Medium API automation") was already complete—the `_docs/MEDIUM_CROSSPOSTING.md` documentation existed with a comprehensive 230-line manual workflow. It recommended closing with a comment explaining why API automation isn't possible (Medium deprecated their API for non-partner accounts).

### Bug Detection and Fixing

When the donation button appeared unreadable on blog posts (white text on light background), Copilot quickly diagnosed the issue: the `.btn-secondary` class was designed for dark backgrounds. It added specific `.post-donation .btn` styling with an orange background (#ff813f) to fix the contrast issue.

## Where We Struggled: Testing Infrastructure

This is where things got complicated. Issue #64 was about implementing automated testing and staging deployment—and despite multiple attempts across several sessions, **we still don't have a fully working staging environment**.

### The Original Problem

Earlier in the project, we merged changes that broke the CI/CD tag page on production. The tag link pointed to `/blog/tags/ci/cd/` instead of `/blog/tags/ci-cd/`. Our test script passed, but the actual rendered page was broken.

This led to Issue #64: create a testing infrastructure that catches these issues before production.

### What We Tried

**Attempt 1: Local test.sh validation**
- Created a bash script to verify tag file structure
- Problem: Can't run Jekyll builds locally (no Ruby/Bundler installed on my machine)
- Result: Script passes but doesn't catch rendering bugs

**Attempt 2: GitHub Actions PR validation workflow**
- Created `.github/workflows/pr-validation.yml`
- Builds Jekyll and runs test.sh in CI
- Problem: Validates structure, not rendered output

**Attempt 3: Staging deployment with peaceiris/actions-gh-pages**
- Created `.github/workflows/deploy-staging.yml`
- Intended to deploy PRs to `/staging/pr-{NUMBER}/` for manual review
- Problem 1: GitHub Actions permissions error (403 denied)
- Problem 2: YAML parsing error from multi-line JavaScript template literal
- Problem 3: Workflow runs on wrong events

### Current State

After multiple fixes:
- ✅ PR validation runs test.sh (catches structural issues)
- ✅ YAML syntax error fixed (collapsed multi-line strings)
- ⚠️ Staging deployment still not actually deploying
- ❌ No way to preview PRs before merge

The staging workflow "passes" in CI but the staging URLs don't actually work. We can see the workflow ran, but the pages aren't accessible.

### Why This Is Hard

The fundamental challenge: **catching rendering bugs requires seeing the rendered output**. Static analysis (checking file existence, validating frontmatter) can't tell you if a tag link will resolve correctly on the live site.

Options for the future:
1. **Install Ruby/Jekyll locally** - Run full builds before pushing
2. **Netlify/Vercel preview deployments** - Built-in PR previews
3. **Fix the peaceiris action** - Debug GitHub Pages permissions
4. **Playwright/Cypress tests** - Automated browser testing on deployed URLs

For now, we're relying on careful code review and quick rollbacks if issues reach production.

## The YAML Gotcha

One specific bug worth noting: the staging workflow had a multi-line JavaScript string in a GitHub Actions step:

```javascript
// This broke YAML parsing
const message = `🚀 **Staging Ready!**

Your changes have been deployed...`;
```

YAML interpreted the empty lines as significant, causing a parse error at line 63. The fix was collapsing to a single line:

```javascript
const message = `🚀 **Staging Ready!**\n\nYour changes have been deployed...`;
```

This is the kind of subtle issue that's easy to create when generating multi-line strings in YAML files.

## Session Stats

- **Issues Closed**: 6
- **PRs Merged**: 4
- **Lines Changed**: ~350
- **Time**: ~2 hours
- **Versions Released**: v1.0.29 → v1.0.31

## Key Takeaways

### Copilot CLI Strengths
- **Parallel file editing** - Changes to multiple files in one operation
- **GitHub integration** - Creating issues, PRs, merging, all from terminal
- **CSS and HTML** - Generated well-structured, accessible dark mode
- **Issue triage** - Correctly identified already-completed work

### Copilot CLI Limitations
- **Complex CI/CD debugging** - Struggled with GitHub Actions permissions and YAML edge cases
- **Persistent state issues** - Same staging bug "fixed" multiple times without resolution
- **Can't verify its own work** - No browser to check if changes actually render correctly
- **Over-confidence** - Would report "fixed" when the underlying issue remained

### What I'd Do Differently

1. **Verify before closing** - Don't trust "all checks passed" without manual review
2. **Simpler staging approach** - Maybe Netlify instead of custom GitHub Pages deployment
3. **Local development setup** - Install Jekyll to test locally before pushing
4. **Different model for infrastructure work** - Now that I've enabled Claude Opus, may retry the staging deployment with a different model

## What's Next

With the backlog cleared, the site now has:
- 📊 Google Analytics 4 tracking
- ☕ Donation buttons (3 locations)
- 🌙 Automatic dark mode
- ♿ Accessibility improvements (skip links, focus states, ARIA)
- 📄 RSS feed
- 🔍 Blog search
- 🏷️ Tag system

The staging deployment remains the one unfinished piece. It's on my list to revisit—possibly with a different approach or a different AI model to get fresh perspective on the GitHub Actions configuration.

---

*Session completed: February 1, 2026*  
*All issues closed, staging still pending*  
*Copilot CLI verdict: Great for features, needs work for DevOps*
