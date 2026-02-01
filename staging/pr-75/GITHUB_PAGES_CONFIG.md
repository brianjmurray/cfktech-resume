# GitHub Pages Staging Configuration

## Current Setup

- **Production**: cfktech.com (from main branch, _site/ directory)
- **Staging**: Not yet configured

## Goal

Deploy staging/ directory to: https://cfktech.com/staging/

## Solution: GitHub Actions Deploy to Production

Since GitHub Pages can only serve one branch per repository, we need:

**Option 1: Use GitHub Actions to deploy staging/ (Recommended)**
- GitHub Actions builds PR to /staging/
- GitHub Actions deploys /staging/ contents to a gh-pages branch
- GitHub Pages serves gh-pages branch as /staging/ subdirectory

**Option 2: Create separate branch (Simpler)**
- Create `staging` branch
- Point GitHub Pages to serve from staging branch → /staging/ path
- Configure _config_staging.yml with baseurl: /staging

## Implementation: Option 2 (Simpler)

### Step 1: Configure baseurl for Staging

Create `/Users/brianmurray/Documents/Source/cfktech-resume/_config_staging.yml`:
```yaml
title: "Brian J. Murray - Resume (Staging)"
baseurl: "/staging"
url: "https://cfktech.com"

# ... rest of config same as _config.yml
```

This tells Jekyll to build links relative to /staging/

### Step 2: Update GitHub Actions Workflow

File: `/Users/brianmurray/Documents/Source/cfktech-resume/.github/workflows/pr-validation.yml`

Change Jekyll build for PRs:
```bash
bundle exec jekyll build --destination ./staging --config _config.yml,_config_staging.yml
```

The second config overrides baseurl to /staging

### Step 3: Deploy staging/ Folder

The GitHub Actions workflow needs to:
1. Build PR to /staging/ with baseurl: /staging
2. Deploy /staging/ contents somewhere GitHub Pages can serve it

**This requires GitHub Pages Deploy Action:**
- Action: peaceiris/actions-gh-pages
- Uploads /staging/ to special branch (e.g., staging-pages)
- GitHub Pages configured to serve that branch at /staging/ path

## Alternative: Simpler for Now

Since staging doesn't exist on production yet, let's:

1. **Manually test PRs locally** using staging/ build
2. **After PR validation passes** → Merge to main
3. **Production auto-deploys** (already works)
4. **Later: Add GitHub Pages staging deployment** once we need it

This unblocks merging #66 and gets the validation running!

## To Enable Later (Phase 5)

When we're ready for full staging deployment:
1. Create _config_staging.yml with baseurl: /staging
2. Add GitHub Actions deploy step using peaceiris/actions-gh-pages
3. Configure GitHub Pages for staging-pages branch
4. Update STAGING_PLAN.md with final configuration

## Current Blocking Issue

**We can't fully implement GitHub Pages staging deployment yet because:**
- Would need to modify GitHub Pages settings (requires repo admin)
- Need to set up special gh-pages branch handling
- Can work around this with manual deployment after CI passes

## Recommended Path Forward

1. ✅ Merge PR #66 (testing infrastructure is ready)
2. ✅ Test workflow on next PR - it will build to /staging/
3. ⏳ Manual verification: Download staging/ artifacts and test locally
4. 🔜 Phase 5: Add GitHub Actions deploy step to push staging/ live
