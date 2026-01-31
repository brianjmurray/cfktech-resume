# Actual Testing Strategy

**Problem**: We found multiple tag slug issues that test.sh missed. We need a REAL testing strategy, not just claims.

## The CI/CD Bug Discovery

We had to manually find:
1. `_layouts/tag.html` - tag cloud links in individual tag pages
2. `blog/tags.md` - main tag cloud page links  
3. `blog/index.md` - blog post excerpt tag links

**All three had the same issue**: Only replaced spaces, not slashes.
- Result: `CI/CD` → `ci/cd` instead of `ci-cd` → broken links

**Why test.sh didn't catch it initially**: 
- Checked file definitions, not rendered HTML
- Checked if posts appear on pages
- But didn't follow every link in generated output

## Actual Testing Approach (Starting Fresh)

### 1. BUILD CHECK (What exists currently)
```bash
# Step 1: Build Jekyll
jekyll build

# Step 2: Verify _site/ directory exists
```

### 2. INTEGRITY CHECK (New)
```bash
# For EVERY tag-related page, extract all href attributes
# For EVERY href, verify the file exists in _site/

for page in _site/blog/tags/*/index.html _site/blog/tags/index.html; do
  grep -o 'href="[^"]*"' "$page" | while read href; do
    target="_site${href}"
    if [ ! -f "$target" ]; then
      ERROR: "Broken link: $href"
    fi
  done
done
```

### 3. RENDER MATCH CHECK (New)
```bash
# For each tag file (blog/tags/something.md):
# - Extract tag name and permalink
# - Build URL from Liquid: {{ tag | downcase | replace: ' ', '-' | replace: '/', '-' }}
# - Verify it matches the permalink

For each tag in _posts:
  - Find all {{ tag }} references in generated HTML
  - Verify they all link to pages that exist
  - Verify generated slug matches permalink
```

### 4. LINK FOLLOWING CHECK (New)
```bash
# Actually follow links:
# When test.sh finds href="/blog/tags/ci-cd/", verify:
# 1. File exists: _site/blog/tags/ci-cd/index.html
# 2. File is not empty
# 3. File contains expected content (posts)
```

### 5. SPECIAL CHARACTER CHECK (New)
```bash
# For each tag with special characters (/, spaces, dashes, etc):
# - Test the Liquid filters
# - Compare generated slug to file system
# - Error if mismatch
```

## What Should Actually Happen in PR Validation

1. **Build Jekyll** → detect syntax errors
2. **Verify files exist** → detect missing pages  
3. **Extract all links** → detect href generation
4. **Verify links work** → detect broken links
5. **Check for 404s** → detect file not found
6. **Match rendering to files** → detect slug mismatches
7. **Comment PR** → report findings

## Why We Need This

We've found bugs by:
- Manually visiting the site
- Looking at layout files
- Checking what files exist

test.sh should catch these BEFORE anyone has to manually check.

## Implementation

### Option 1: Enhanced Bash Script
- Extract all hrefs from generated HTML
- Verify each target file exists
- Check for 404 patterns
- ~50 lines of bash

### Option 2: Link Checker Tool
- Use built-in tools (wget, curl) to test links
- Build local HTML and follow links
- Report broken references
- ~100 lines of bash

### Option 3: Jekyll Plugin
- Create custom Jekyll plugin
- Validates during build
- Reports errors before HTML generated
- More complex but catches issues during build

## Recommended: Option 1 (Enhanced Bash) + Manual Spot Checks

1. **Automated test.sh**:
   - Builds Jekyll
   - Extracts all hrefs
   - Verifies files exist
   - Fails if ANY broken link found

2. **Manual verification (before merging)**:
   - Actually click links on staging
   - Verify content is correct
   - Spot check a few pages

3. **Production monitoring**:
   - Check logs for 404s
   - Monitor broken link reports

## Current State

FIXED:
- ✅ `_layouts/tag.html` line 20 - added second replace filter
- ✅ `blog/tags.md` line 15 - added second replace filter  
- ✅ `blog/index.md` - already has correct filter

NEXT: Enhance test.sh to actually validate what was fixed

## The Bottom Line

**Stop claiming things are fixed without verifying**. 

Real testing means:
1. Change code
2. Build output
3. **Actually inspect output**
4. Verify changes work
5. Only then claim fixed

Not:
1. Change code
2. Say it's fixed
3. Find out it wasn't

