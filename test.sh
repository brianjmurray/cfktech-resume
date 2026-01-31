#!/bin/bash
# Test script to verify cfktech.com tag pages work correctly

set -e

cd "$(dirname "$0")"

echo "================================"
echo "cfktech-resume Testing Script"
echo "================================"
echo ""

echo "Step 1: Building Jekyll site..."
bundle exec jekyll build --quiet 2>&1 | grep -v "Configuration file:" || true
echo "✓ Build complete"
echo ""

echo "Step 2: Checking tag pages exist..."
TAG_FILES=$(find blog/tags -name "*.md" | wc -l)
echo "Found $TAG_FILES tag files"
echo ""

echo "Step 3: Extracting all tags from blog posts..."
echo "Unique tags in posts:"
grep -h "^tags:" _posts/*.md | sed 's/tags: \[//; s/\]//' | tr ',' '\n' | sed 's/^ //; s/ $//' | sort -u | nl
echo ""

echo "Step 4: Checking tag file definitions..."
echo "Tag file definitions:"
for f in blog/tags/*.md; do
  TAG=$(grep "^tag:" "$f" | sed 's/^tag: //')
  PERMALINK=$(grep "^permalink:" "$f" | sed 's/^permalink: //')
  echo "  $TAG -> $PERMALINK"
done
echo ""

echo "Step 5: Verifying _site/ output..."
if [ -d "_site/blog/tags" ]; then
  GENERATED_TAGS=$(find _site/blog/tags -name "index.html" | wc -l)
  echo "Generated $GENERATED_TAGS tag pages in _site/"
else
  echo "⚠️  No _site/blog/tags directory found"
fi
echo ""

echo "Step 6: Testing tag pages for content..."
for tag_dir in _site/blog/tags/*/; do
  TAG_NAME=$(basename "$tag_dir")
  POST_COUNT=$(grep -c "blog-post-preview\|<article" "$tag_dir/index.html" 2>/dev/null || echo 0)
  if [ "$POST_COUNT" = "0" ]; then
    echo "❌ /blog/tags/$TAG_NAME/ has NO posts"
  else
    echo "✓ /blog/tags/$TAG_NAME/ has $POST_COUNT posts"
  fi
done
echo ""

echo "Step 7: Validating ALL tag links in generated tag pages..."
echo "Extracting and verifying tag cloud href attributes..."
BROKEN_LINKS=0
CHECKED_LINKS=0

# For each tag page, find all tag links and verify the destination exists
for tag_page in _site/blog/tags/*/index.html; do
  # Extract all href="/blog/tags/..." from post-tag class links
  grep -o 'class="post-tag"[^>]*href="[^"]*"' "$tag_page" 2>/dev/null | sed 's/.*href="\([^"]*\)".*/\1/' | while read href; do
    CHECKED_LINKS=$((CHECKED_LINKS + 1))
    # Convert href to file path: /blog/tags/ci-cd/ -> _site/blog/tags/ci-cd/index.html
    TARGET="_site${href}index.html"
    
    if [ ! -f "$TARGET" ]; then
      echo "❌ BROKEN LINK: $href (from $(basename $(dirname "$tag_page"))) -> file not found: $TARGET"
      BROKEN_LINKS=$((BROKEN_LINKS + 1))
    fi
  done
done

if [ "$BROKEN_LINKS" -eq 0 ]; then
  echo "✓ All $CHECKED_LINKS tag links validated - no 404s found"
fi
echo ""

echo "Step 8: Verifying each tag page has matching posts..."
MISMATCHES=0

for f in blog/tags/*.md; do
  TAG=$(grep "^tag:" "$f" | sed 's/^tag: //')
  PERMALINK=$(grep "^permalink:" "$f" | sed 's/^permalink: //' | sed 's#/blog/tags/##' | sed 's#/$##')
  TAG_PAGE="_site/blog/tags/${PERMALINK}/index.html"
  
  if [ ! -f "$TAG_PAGE" ]; then
    echo "❌ MISSING: Tag page not generated for '$TAG' at $TAG_PAGE"
    MISMATCHES=$((MISMATCHES + 1))
    continue
  fi
  
  # Count posts on the page (if any)
  POST_COUNT=$(grep -c 'class="blog-post-preview"' "$TAG_PAGE" 2>/dev/null || echo 0)
  
  # Check if tag is used in any posts
  POSTS_WITH_TAG=$(grep -l "\"$TAG\"" _posts/*.md 2>/dev/null | wc -l)
  
  # Should have matching posts or explicitly known to be empty
  if [ "$POSTS_WITH_TAG" -gt 0 ] && [ "$POST_COUNT" -eq 0 ]; then
    echo "❌ MISMATCH: Tag '$TAG' has $POSTS_WITH_TAG posts but 0 appear on tag page"
    MISMATCHES=$((MISMATCHES + 1))
  fi
done

if [ "$MISMATCHES" -eq 0 ]; then
  echo "✓ All tag pages have correct content"
fi
echo ""

echo "================================"
if [ "$BROKEN_LINKS" -gt 0 ] || [ "$MISMATCHES" -gt 0 ]; then
  echo "❌ Testing FAILED - Found $((BROKEN_LINKS + MISMATCHES)) issues"
  echo "================================"
  exit 1
else
  echo "✅ All tests PASSED!"
  echo "================================"
  exit 0
fi
