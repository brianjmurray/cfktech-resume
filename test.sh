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

echo "Step 7: Manual verification - Sample tag page content"
echo "Sample SQL Server tag page:"
head -30 _site/blog/tags/sql-server/index.html | tail -20

echo ""
echo "================================"
echo "Testing Complete!"
echo "================================"
