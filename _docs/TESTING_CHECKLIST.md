# Testing Checklist for Pull Requests

This document guides you through testing changes before they go to production. Each PR gets deployed to a staging environment for review.

## How Staging Works

1. **Create a PR** on any branch → GitHub Actions builds it
2. **Staging deploys** to: `https://cfktech.com/staging/pr-{PR_NUMBER}/`
3. **Manual testing** - Follow this checklist
4. **Approve or request changes** in the PR
5. **Merge when ready** - Auto-deploys to production (v1.0.X)

---

## Testing Checklist

### 1. Basic Functionality ✓
- [ ] Visit the staging link in the PR comment
- [ ] Home page loads without errors
- [ ] Check browser console for JavaScript errors (F12 → Console)
- [ ] All navigation links work (Header, Footer, etc.)

### 2. Blog Posts ✓
- [ ] Visit `/blog/` - post list displays
- [ ] Click on a blog post - it loads
- [ ] Post content displays correctly
- [ ] Post metadata (date, tags) visible

### 3. Tag System ✓ (CRITICAL - This is where bugs hide!)
- [ ] Visit `/blog/tags/` - tag cloud displays
- [ ] Click each tag link - no 404 errors
- [ ] Tag page loads and shows posts with that tag
- [ ] Tag slug in URL matches file name (e.g., `/blog/tags/ci-cd/` not `/blog/tags/ci/cd/`)
- [ ] Posts appear on their assigned tag pages
- [ ] No empty tag pages (unless intentional)

**Special attention to tags with special characters:**
- `CI/CD` → should link to `/blog/tags/ci-cd/` (with dash, not slash)
- `JavaScript/TypeScript` → should link to `/blog/tags/javascript-typescript/`
- `AWS/Cloud` → should link to `/blog/tags/aws-cloud/`

### 4. Search ✓
- [ ] Visit `/blog/search/` 
- [ ] Search box appears
- [ ] Type a keyword from a blog post
- [ ] Results display matching posts
- [ ] Click result - post loads correctly

### 5. Projects Page ✓
- [ ] Visit `/projects/`
- [ ] Project cards display
- [ ] Click project links - they work
- [ ] All images load

### 6. Resume Page ✓
- [ ] Visit `/resume/`
- [ ] Resume content displays
- [ ] PDF download link works
- [ ] (Optional) Download PDF and verify it's not corrupted

### 7. Responsive Design ✓
- [ ] Resize browser to test mobile (F12 → Responsive Design Mode)
- [ ] Check: Mobile (375px), Tablet (768px), Desktop (1920px)
- [ ] Navigation collapses on mobile
- [ ] Text is readable at all sizes
- [ ] Images scale properly
- [ ] No horizontal scrolling

### 8. Link Validation ✓
- [ ] Click through major links on the site
- [ ] Check footer links work
- [ ] Verify social media links (if present)
- [ ] Confirm no 404 errors (check browser console)

### 9. CSS & Styling ✓
- [ ] No styling is broken or missing
- [ ] Colors look correct
- [ ] Spacing (padding/margins) looks intentional
- [ ] Hover effects work on buttons/links
- [ ] Dark mode works (if implemented)

---

## What NOT to Test

These are **automatically checked** by test.sh before staging deploys:
- ❌ Jekyll build succeeds (already checked)
- ❌ All tag files exist (already checked)
- ❌ Basic link structure (already checked)

**Your job**: Test the **user experience** and **rendered output**.

---

## How to Report Issues

If you find problems:

1. **Request Changes** in the PR review
2. **Comment with specific issue**: "Tag link for 'CI/CD' goes to `/ci/cd/` instead of `/ci-cd/`"
3. **Optionally provide a screenshot** if it's a visual issue
4. **Author fixes the issue** and updates the PR
5. **Staging auto-redeploys** with the fix
6. **Re-test and approve** when fixed

---

## Example Testing Flow

### PR #72: Add new blog post about Docker

1. PR created with new post `_posts/2026-02-01-docker-guide.md`
2. GitHub Actions runs:
   - ✅ test.sh validates (post file exists, tags defined, etc.)
   - ✅ deploy-staging.yml builds to `/staging/pr-72/`
3. PR comment appears with: "🚀 Staging ready: https://cfktech.com/staging/pr-72/"
4. **You test**:
   - Visit staging link
   - Find the Docker post in `/blog/`
   - Verify tag "Docker" link works
   - Check all images load
   - Verify responsive on mobile
5. **You approve** with "Looks good! Ready to ship 🚀"
6. PR merges → auto-release creates v1.0.X → deployed to production
7. Visit https://cfktech.com to verify live

---

## Special Cases

### Adding a new tag
- [ ] New tag file created at `blog/tags/new-tag-name.md`?
- [ ] Tag page appears at `/blog/tags/new-tag-name/`?
- [ ] Posts with this tag appear on the tag page?

### Fixing a tag slug bug
- [ ] Old URL still broken?
- [ ] New URL works correctly?
- [ ] All posts moved to correct tag page?
- [ ] Old tag page gone (redirects or removed)?

### Updating Jekyll config
- [ ] All pages still build?
- [ ] CSS/JS still loads correctly?
- [ ] No broken links from config changes?

---

## Tips

- **Clear cache** if styling looks wrong: Ctrl+Shift+R (Cmd+Shift+R on Mac)
- **Check console for errors**: F12 → Console tab
- **Test on real device** if possible (not just browser resize)
- **Click multiple pages** to find issues
- **If unsure**, ask the PR author or request changes

---

## Summary

**You're looking for:**
- ✅ Does it work as a user would use it?
- ✅ Are all links clickable and functional?
- ✅ Does content display correctly?
- ✅ No console errors or 404s?
- ✅ Looks good on mobile and desktop?

**If yes to all → Approve! 🎉**
**If no → Request changes with specific details**
