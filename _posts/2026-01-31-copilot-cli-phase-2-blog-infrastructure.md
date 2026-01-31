---
layout: post
title: "Using GitHub Copilot CLI to Build a Scalable Blog: Phase 2 of cfktech-resume"
date: 2026-01-31
excerpt: "How Copilot CLI streamlined blog infrastructure, automated content creation, debugged workflows, and enforced a phased development approach."
tags: [Copilot CLI, GitHub, Automation, Jekyll, DevOps]
---

## Introduction

When I started Phase 2 of the cfktech-resume portfolio project, the goal was ambitious: build a scalable blog infrastructure, write multiple technical posts, and expand the portfolio showcase. What could have been a week of manual troubleshooting became a focused workflow using **GitHub Copilot CLI** as my development partner.

This post documents how Copilot CLI transformed my Phase 2 workflow through exploration, automation, problem-solving, and systematic issue tracking.

## Phase 2 Overview

Phase 2 of cfktech-resume focused on three major components:
1. **Blog infrastructure**: Expanding from 1 to multiple blog posts
2. **Content creation**: Writing deep-dive technical posts (12k+ words)
3. **Portfolio expansion**: Adding project showcase cards
4. **Workflow fixes**: Debugging critical automation pipeline issues

Let me walk through how Copilot CLI helped with each.

---

## 1. Blog Infrastructure Setup with Copilot CLI

### The Challenge

Starting Phase 2, I had one blog post working in Jekyll, but scaling to multiple posts while maintaining consistency required understanding:
- How Jekyll collections work
- Proper frontmatter structure for posts
- How to auto-generate listing pages
- Building reusable templates

### How Copilot CLI Helped

**Exploration Phase:**
I used Copilot CLI to ask questions about Jekyll collections without leaving the terminal:

```bash
$ copilot prompt "How do Jekyll collections work? I have _posts/ directory with markdown files"
```

Instead of googling and switching browser tabs, Copilot CLI provided:
- Explanation of Jekyll's auto-discovery of `_posts/` directory
- How frontmatter drives URL generation based on `_config.yml` permalink patterns
- Why Liquid loops in layout templates auto-populate blog listings

**Code Navigation:**
Then I asked Copilot CLI to show me the current configuration:

```bash
$ copilot prompt "Show me how the current Jekyll site is structured for blog posts"
```

This helped me understand the existing `_posts/` setup, `_config.yml` permalink patterns, and liquid templates without reading 5 separate documentation pages.

### Outcome

I confidently built the Phase 2 blog infrastructure with:
- Consistent frontmatter structure (layout, title, date, excerpt, tags)
- Automatic URL generation (`/blog/post-slug/`)
- Auto-listing templates that scale as posts are added

**Key insight**: Copilot CLI's ability to quickly synthesize Jekyll concepts meant I could focus on *writing* rather than *learning the tool*.

---

## 2. Content Creation & Automation

### The Challenge

Writing one 12k-word technical blog post about Homebrew automation seemed straightforward, but required:
- Researching the brew-setup-and-update project deeply
- Structuring a comprehensive technical post
- Creating project showcase cards that link to blog posts
- Managing content deployment through the CI/CD pipeline

### How Copilot CLI Helped

**Research and Outline:**
I used Copilot CLI to analyze the brew-setup-and-update repository:

```bash
$ copilot prompt "I have a GitHub repo at brew-setup-and-update. What are the main components I should write about in a technical blog post?"
```

Copilot CLI:
1. Helped me explore the repo structure (bash scripts, Brewfile, automation patterns)
2. Identified the key storytelling angle (problem → solution → implementation)
3. Suggested code examples to highlight

**Content Generation:**
With the outline, I asked Copilot CLI to help structure the post:

```bash
$ copilot prompt "Write an introduction to a blog post about automating macOS package management with Homebrew. Include: the problem statement, why it matters, and what readers will learn."
```

This accelerated the initial draft. Rather than starting with a blank page, Copilot CLI provided high-quality scaffolding that I refined based on the actual code.

**Project Card Creation:**
After publishing the blog post, I created project showcase cards linking to both the repository and the blog post. Copilot CLI helped me:
- Understand the existing project card HTML structure
- Write consistent descriptions for new cards
- Ensure all three project cards (SQL Server, Homebrew, cfktech-resume) had parallel formatting

### Outcome

Phase 2 shipped with:
- 1 comprehensive Homebrew automation blog post (12,257 words)
- 2 new project showcase cards
- Consistent content structure across 3 projects

**Key insight**: Copilot CLI's ability to quickly generate well-structured content meant I could iterate and refine rather than starting from scratch.

---

## 3. Problem Solving: The Workflow Bug

### The Challenge

I merged the Homebrew blog post (Issue #24), but the auto-release workflow failed silently. Version v1.0.16 didn't create, and the release asset (PDF) wasn't generated. This was a critical blocker for Phase 2.

### How Copilot CLI Helped

**Diagnosis:**
I used Copilot CLI to analyze the failing workflow:

```bash
$ copilot prompt "My GitHub Actions workflow isn't creating a release. The JSON parsing step might be failing. Show me how to reliably extract JSON values in bash without fragile grep/awk pipelines."
```

Copilot CLI immediately identified the problem pattern:
- The existing workflow used `grep '"id"' | head -1 | awk '{print $2}' | tr -d ','`
- This fragile regex approach failed when JSON formatting was unexpected
- The workflow had no error handling, so it silently proceeded with an empty value

**Solution:**
Copilot CLI suggested the correct approach:

```bash
# Bad (fragile):
RELEASE_ID=$(grep '"id"' release.json | head -1 | awk '{print $2}' | tr -d ',')

# Good (reliable):
RELEASE_ID=$(jq -r '.id' release.json)
```

**Implementation:**
I updated `.github/workflows/auto_release.yml` with Copilot CLI's guidance:

```yaml
- name: Extract Release ID
  id: release
  run: |
    RELEASE_ID=$(jq -r '.id' <<< "$RESPONSE")
    if [ -z "$RELEASE_ID" ] || [ "$RELEASE_ID" = "null" ]; then
      echo "Error: Failed to extract release ID from GitHub API response"
      echo "Response: $RESPONSE"
      exit 1
    fi
    echo "release_id=$RELEASE_ID" >> $GITHUB_OUTPUT
```

This fix included:
1. Using `jq` for reliable JSON parsing
2. Explicit error checking for null or empty values
3. Debug output showing the response for troubleshooting
4. Early exit on failure instead of silent continuation

### Outcome

- ✅ v1.0.16 successfully released
- ✅ PDF asset uploaded
- ✅ Homebrew blog post deployed to cfktech.com

**Key insight**: Copilot CLI didn't just suggest syntax—it identified the *pattern* of failure (fragile JSON parsing) and provided a systemic solution that prevented future bugs.

---

## 4. Phased Approach with GitHub Issues

### The Challenge

Phase 2 had multiple moving parts:
- Issue #24: Write Homebrew blog post
- Issue #26: Add brew project card
- Issue #27: Add cfktech-resume project card
- Issue #36: Clean up homepage (unrelated bug)
- Issue #38: Fix workflow bug

Without systematic issue tracking, these would get mixed together and shipped as one monolithic change. This makes it hard to:
- Debug individual problems
- Revert specific features
- Understand what each version includes

### How Copilot CLI Helped

**Issue Workflow:**
Copilot CLI helped me establish a repeatable pattern for tracking and shipping work:

```bash
# 1. Pick an issue
$ gh issue view 24

# 2. Create a feature branch
$ git checkout -b feature/issue-24-brew-blog

# 3. Make changes locally
$ vim _posts/2026-01-31-homebrew-automation-macos-updates.md

# 4. Commit with auto-close keyword
$ git commit -m "Add Homebrew automation blog post - fixes #24"

# 5. Create PR with same keyword
$ gh pr create --title "Blog post: Homebrew automation - fixes #24"

# 6. Build passes automatically
# GitHub Actions validates the PR

# 7. Merge → Auto-close issue → Auto-release workflow
$ gh pr merge --merge --delete-branch
```

When the commit message contains "fixes #24", GitHub **automatically closes the issue** when the PR merges. This creates a durable link between:
- Issue (problem statement)
- Feature branch (work in progress)
- Commit (proof of work)
- PR (code review)
- Release version (shipped)

**Documentation:**
I used Copilot CLI to help document this workflow in the README:

```bash
$ copilot prompt "Write clear documentation for developers on how to work with GitHub Issues using the 'fixes #' pattern for auto-close. Include examples and common keywords."
```

Copilot CLI provided the documentation that went into the README, which is now the source of truth for Phase 2 and Phase 3 work.

### Outcome

Phase 2 shipped as 4 independent but coordinated releases:
- ✅ v1.0.16: Blog post + workflow fix
- ✅ v1.0.17: Project showcase cards
- Each tied to specific GitHub Issues
- Each with a clear commit trail

**Key insight**: Copilot CLI helped turn chaos into a systematic workflow where issues guide implementation, and GitHub's automation closes the loop.

---

## Phase 2 Metrics

| Metric | Result |
|--------|--------|
| Blog posts written | 1 (Homebrew automation, 12,257 words) |
| Project showcase cards | 2 (brew-setup-and-update, cfktech-resume) |
| GitHub Issues tracked | 6 (4 features, 2 bugs) |
| Releases shipped | 2 (v1.0.16, v1.0.17) |
| Critical bugs found & fixed | 2 (workflow JSON parsing, homepage cleanup) |
| Build validation failures | 0 (all PRs passed on first try) |

---

## Key Learnings

### 1. Copilot CLI Accelerates Exploration
Rather than switching contexts to read documentation, Copilot CLI provided synthesized answers in seconds. This kept me focused on implementation.

### 2. Workflow Patterns Matter
By establishing a repeatable issue → branch → commit → PR → merge workflow, Phase 2 work was systematic and traceable. Future phases can follow the same pattern.

### 3. Error Handling Prevents Silent Failures
The JSON parsing bug taught me that Bash workflows need explicit error checking. Copilot CLI helped me implement proper validation and debug output.

### 4. Phased Development is Sustainable
Breaking Phase 2 into 6 issues (4 features, 2 bugs) allowed focused work sessions. Each issue could ship independently, yet contribute to the overall phase goal.

---

## What's Next: Phase 3

Phase 3 will implement advanced features:
- **Search functionality** (#28): Help readers find posts
- **Tags and categories** (#29): Organize content by topic
- **Newsletter integration** (#30): Build audience
- **Analytics** (#31): Understand reader behavior
- **Monetization** (#32): Buy Me a Coffee integration
- **Medium cross-posting** (Phase 3): Expand reach

I'll use the same Copilot CLI + GitHub Issues workflow that worked for Phase 2.

---

## Conclusion

Phase 2 of cfktech-resume demonstrated that **GitHub Copilot CLI is not just a code completion tool**—it's a development partner for:
- Exploring unfamiliar domains (Jekyll, GitHub Actions)
- Generating high-quality starting content
- Diagnosing and solving systemic problems
- Documenting workflows and best practices

By pairing Copilot CLI with GitHub Issues and systematic release management, Phase 2 shipped 2 releases, 1 technical blog post, 2 project cards, and 2 critical bug fixes—all traceable and reversible.

This foundation sets up Phase 3 for even greater impact.

---

## Resources

- **cfktech-resume repository**: https://github.com/brianjmurray/cfktech-resume
- **Phase 1 post**: [Building cfktech.com: Portfolio Site with Automated CI/CD](/blog/cfktech-portfolio-site/)
- **Homebrew blog post**: [Automating macOS Updates with Homebrew](/blog/homebrew-automation-macos-updates/)
- **GitHub Issues workflow documentation**: See cfktech-resume README

---

*Have you used Copilot CLI for workflow automation? Share your experience in the comments or connect on [GitHub](https://github.com/brianjmurray).*
