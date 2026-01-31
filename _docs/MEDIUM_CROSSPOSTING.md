# Cross-Posting to Medium: Workflow & Checklist

> **Goal**: Manually syndicate blog posts from cfktech.com to Medium while maintaining SEO benefits via canonical URLs.

---

## Why Manual Cross-Posting?

- **No API Limitations**: Medium's public API is deprecated for non-partner accounts (requires 10K+ followers)
- **Full Control**: You manage formatting, metadata, and publication timing
- **Quick Process**: ~5 minutes per post once you know the workflow
- **Built-in Email**: Medium subscribers get automatic email notifications—no newsletter infrastructure needed

---

## Prerequisites

1. ✅ Medium account created
2. ✅ Medium publication set up (optional but recommended for branding)
3. ✅ cfktech.com blog posts with tags (already done)
4. ℹ️ Medium's editor and markdown support

---

## Step-by-Step Process

### 1. **Prepare the Blog Post Content**

Before copying to Medium:

- [ ] Ensure post is published on cfktech.com at `https://cfktech.com/blog/[post-slug]/`
- [ ] Copy the full post content (including title)
- [ ] Note the publication date from frontmatter
- [ ] Collect all tags from the post frontmatter

**Example**:
```
Post: Homebrew Automation for macOS Updates
URL: https://cfktech.com/blog/homebrew-automation-macos-updates/
Tags: Bash, macOS, Automation, DevOps, Homebrew
Published: Jan 31, 2026
```

### 2. **Create Draft on Medium**

- [ ] Log into Medium
- [ ] Click **"Write"** or **"New story"** (if using a publication, click publication name first)
- [ ] Paste the blog post title into the headline field
- [ ] **DO NOT publish yet** — we need to set metadata first

### 3. **Format Content**

- [ ] Paste blog post content into Medium editor
- [ ] Medium auto-formats markdown (headings, lists, code blocks)
- [ ] Review formatting for:
  - [ ] Code blocks render correctly
  - [ ] Images display (or note if images need manual upload)
  - [ ] Links are preserved
  - [ ] Lists and numbering look right
- [ ] Make any formatting adjustments needed for Medium's editor

**Note**: Medium's markdown support is good but not perfect. Test any complex formatting.

### 4. **Add Metadata**

#### Publication Date
- [ ] Click the **date/time icon** (usually top right of editor)
- [ ] Set publish date to **match cfktech.com post date**
- [ ] This ensures chronological consistency

#### Tags/Topics
- [ ] Add tags from the blog post (same ones from cfktech.com)
- [ ] Medium allows up to 5 tags
- [ ] If post has 6+ tags, select the 5 most important
- [ ] Example: `bash`, `macos`, `automation`, `devops`, `homebrew`

#### Featured Image (Optional)
- [ ] Add a featured image if the blog post uses one
- [ ] Or leave blank if no image needed
- [ ] Medium will show the first image as the preview if not set

### 5. **Add Canonical URL (Critical for SEO)**

This tells search engines the original source is cfktech.com.

- [ ] After formatting content, look for **"More"** menu (three dots) in editor
- [ ] Find **"Story details"** or **"Publication settings"**
- [ ] Look for **"Canonical link"** or **"This story was originally published at"** field
- [ ] Paste the full cfktech.com URL:
  ```
  https://cfktech.com/blog/[post-slug]/
  ```
- [ ] Example: `https://cfktech.com/blog/homebrew-automation-macos-updates/`

**Why this matters**: 
- Google respects canonical URLs for SEO
- Readers see cfktech.com gets credit for the original
- Prevents duplicate content penalties

### 6. **Add Footer with Attribution**

Add this markdown to the **end** of the post before publishing:

```markdown
---

*This post was originally published on [cfktech.com](https://cfktech.com/blog/[post-slug]/).*

*For more posts on Copilot CLI, DevOps, and automation, visit [cfktech.com](https://cfktech.com).*
```

**Example**:
```markdown
---

*This post was originally published on [cfktech.com](https://cfktech.com/blog/homebrew-automation-macos-updates/).*

*For more posts on Copilot CLI, DevOps, and automation, visit [cfktech.com](https://cfktech.com).*
```

This:
- ✅ Credits cfktech.com as the original source
- ✅ Provides a backlink for readers
- ✅ Drives traffic back to your site

### 7. **Review & Publish**

- [ ] Read through the post one more time on Medium
- [ ] Check formatting, images, and links
- [ ] Verify canonical URL is set
- [ ] Verify tags are correct
- [ ] Click **"Publish"** or **"Schedule"** (if scheduling for later)

### 8. **Post-Publish: Update Blog Record**

After publishing, create a record in your repo or notes:

```markdown
## Cross-Posted to Medium

- [ ] Homebrew Automation - https://medium.com/@[your-handle]/homebrew-automation-macos-updates
  - Published: Jan 31, 2026
  - Canonical: https://cfktech.com/blog/homebrew-automation-macos-updates/
  - Tags: bash, macos, automation, devops, homebrew
```

This helps you track which posts are on Medium.

---

## Troubleshooting

### Issue: Can't find "Canonical link" setting

**Solution**: 
- Different Medium layouts may hide this differently
- Try: Story details → More options → Canonical link
- Or: Look for "This story was originally published..."
- If unavailable on your account, note it in the footer instead

### Issue: Code formatting looks wrong

**Solution**:
- Medium uses ` ``` ` for code blocks
- If using language-specific code fences (` ```bash `), Medium converts automatically
- Review the rendered version and adjust if needed

### Issue: Images aren't showing

**Solution**:
- Medium requires uploading images directly (no external links for most cases)
- Either:
  1. Re-upload images from your blog to Medium
  2. Or skip images and reference them in text: "See the code example below"
  3. Add a note: "*View the full post with images at [cfktech.com](https://cfktech.com/blog/...)*"

### Issue: Links to other cfktech.com posts

**Solution**:
- Keep cfktech.com links as-is (they work)
- Or update to include Medium cross-posts once they're published
- Example: "Read more in my [related Medium post](https://medium.com/@handle/...)"

---

## Quick Checklist Template

Copy this for each post:

```
[ ] Title copied and formatted
[ ] Content pasted and formatted
[ ] Publish date set to match cfktech.com
[ ] Tags added (up to 5)
[ ] Canonical URL set: https://cfktech.com/blog/[slug]/
[ ] Footer attribution added
[ ] Reviewed formatting & links
[ ] Published
[ ] Cross-post link recorded in notes
```

---

## Batch Processing Multiple Posts

If you have several unpublished posts to cross-post:

1. **Set aside 30 minutes** (5-6 posts)
2. **Start with 1-2 posts** to get comfortable with the process
3. **Work in batches of 3** if possible (reduce context switching)
4. **Space posts out** if Medium discourages rapid publishing
5. **Document any learnings** for future posts

---

## Future Automation Ideas (Phase 3c+)

- Python script to auto-generate Medium-formatted markdown with canonical URL
- GitHub Action to track which posts have been cross-posted
- IFTTT recipe to auto-import from RSS feed to Medium (requires Medium partner program)

---

## References

- Medium Editor Guide: https://help.medium.com/hc/en-us/categories/200102496-Writing
- Canonical URLs & SEO: https://en.wikipedia.org/wiki/Canonical_link_element
- cfktech.com Blog: https://cfktech.com/blog/
- cfktech.com RSS Feed: https://cfktech.com/feed.xml
