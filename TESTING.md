# Testing Guide for cfktech.com

## The Problem We Discovered

We've been merging PRs without verifying they actually work:
- Tag pages created but posts didn't show up
- Issues closed prematurely
- Broken links not caught
- Created tags didn't match post tags

**Example**: We "fixed" tag pages 3 times before realizing the real issue

## Testing Strategy

### Before Every Merge

1. **Run local test script** (before pushing)
   ```bash
   ./test.sh
   ```
   This checks:
   - Tag names match between posts and tag files
   - All tag pages would generate correctly
   - No obvious structural issues

2. **Manual verification on live site** (after merge)
   - Visit the feature's main page
   - Click all new links
   - Verify no 404s
   - Confirm posts appear on tag pages

### Tag Page Testing Checklist

When fixing tag pages, verify:

- [ ] Post has correct tag name (must match tag file definition)
- [ ] Tag file `tag:` value matches post frontmatter exactly
- [ ] Permalink uses hyphenated slug: `/blog/tags/tag-name/`
- [ ] Run `test.sh` shows matching tags
- [ ] Merge PR
- [ ] Visit `/blog/tags/tag-slug/` on live site
- [ ] See at least 1 blog post displayed
- [ ] Click a post link - it works (no 404)
- [ ] THEN close the issue

### Using test.sh

**What it does:**
```bash
./test.sh
```

Outputs:
1. Jekyll build status
2. Count of tag files
3. All unique tags in posts (with spaces preserved)
4. All tag file definitions
5. Summary of generated tag pages
6. Post count per tag page

**What to look for:**
- Tags in "Step 3" should match "Step 4"
- All tag pages in Step 6 should have post counts
- No "❌ NO POSTS" messages

**Example good output:**
```
✓ /blog/tags/sql-server/ has 1 posts
✓ /blog/tags/phase-1/ has 1 posts
```

**Example bad output:**
```
❌ /blog/tags/sql-server/ has NO posts  ← Fix before merging!
```

## Common Issues & Fixes

### Issue: Tag page has no posts

**Cause**: Tag name mismatch
- Post tag: `SQL Server`
- Tag file tag: `SQLServer` ← WRONG

**Fix**: Make tag values identical
- Post: `tags: [SQL Server]`
- Tag file: `tag: SQL Server`

### Issue: Tag page 404s

**Cause**: Permalink mismatch
- Post links to: `/blog/tags/sql-server/`
- Tag file has: `/blog/tags/sql_server/` ← WRONG

**Fix**: Use hyphens not underscores
- Correct: `permalink: /blog/tags/sql-server/`

### Issue: Link works but page empty

**Cause**: Jekyll wasn't rebuilt
- Run: `jekyll build` locally
- Check `_site/blog/tags/` directory
- Verify index.html exists

## GitHub Actions Integration (TODO)

Future: Add automated testing to every PR
- Runs `./test.sh` automatically
- Blocks merge if tests fail
- Comments results on PR

## Issue Closing Process (NEW)

**OLD way** (broken):
1. Make PR
2. Merge
3. Close issue in commit

**NEW way** (correct):
1. Make PR
2. Build passes → merge
3. Manual test on live site
4. Verify no issues
5. THEN close issue

## Questions?

If a tag page isn't working:
1. Run `./test.sh`
2. Check for mismatches in Step 3 vs Step 4
3. Fix the mismatch
4. Run test.sh again
5. Verify on live site
6. THEN merge and close
# Workflow Test

Testing workflow validation.
# Testing Complete

The CI/CD pipeline is now fully functional.
Test
# Test PR for Staging Workflow

This is a test PR to verify the staging deployment pipeline works correctly.

See the PR comments for:
1. Validation results
2. Staging URL (https://cfktech.com/staging/pr-X/)
3. Testing checklist

