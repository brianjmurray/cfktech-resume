# Automated Staging Deployment Plan

## Architecture

```
Project Root: /Users/brianmurray/Documents/Source/cfktech-resume/
├── main source files (markdown, layouts, _posts, etc.)
├── staging/                          ← NEW: Staging build output
│   └── [Jekyll builds PR here]
└── _site/                            ← Production build output
    └── [Deployed to cfktech.com]
```

## Deployment Flow

### Stage 1: GitHub Actions PR Validation (Automated)
```
PR created → GitHub Actions triggers
  1. Checkout feature branch
  2. Run: jekyll build --destination /Users/brianmurray/Documents/Source/cfktech-resume/staging/
  3. Run: ./test.sh (validation)
  4. If pass: Deploy staging/ to cfktech.com/staging/
  5. If fail: Block merge, comment on PR with errors
```

### Stage 2: Staging Verification (Manual but safe)
```
PR author/reviewer can test at: https://cfktech.com/staging/
  - Verify changes work
  - Check all links
  - Validate tag pages display posts
  - No risk: staging is separate from production
```

### Stage 3: Merge to Production (Automated)
```
PR approved → Merge to main
  1. GitHub Actions: jekyll build --destination /Users/brianmurray/Documents/Source/cfktech-resume/_site/
  2. GitHub Pages: Auto-deploys _site/ to cfktech.com
  3. Result: Changes live on production
```

## Key Paths (Always use full paths)

| Directory | Full Path | Purpose |
|-----------|-----------|---------|
| Project root | `/Users/brianmurray/Documents/Source/cfktech-resume/` | Source code |
| Staging build | `/Users/brianmurray/Documents/Source/cfktech-resume/staging/` | PR test builds |
| Production build | `/Users/brianmurray/Documents/Source/cfktech-resume/_site/` | Live deployment |
| Tests | `/Users/brianmurray/Documents/Source/cfktech-resume/test.sh` | Validation script |

## GitHub Actions Workflow (To Create)

File: `/Users/brianmurray/Documents/Source/cfktech-resume/.github/workflows/pr-validation.yml`

Workflow:
1. On PR: Run tests + build to `/Users/brianmurray/Documents/Source/cfktech-resume/staging/`
2. On push to main: Build to `/Users/brianmurray/Documents/Source/cfktech-resume/_site/`

## Staging Directory Configuration

The `/Users/brianmurray/Documents/Source/cfktech-resume/staging/` directory:
- Lives in project repo
- Gets deployed to cfktech.com/staging/ path
- Overwrites on each PR build
- Cleaned up after PR merges
- Git-ignored (not committed)

## Benefits

✅ No broken changes reach production
✅ Changes tested in staging first
✅ Automated validation catches issues
✅ Full separation: staging ≠ production
✅ Easy rollback (just rebuild)
✅ Clear PR feedback on what broke

## Next Steps

1. Create GitHub Actions workflow
2. Configure to build PRs to `/Users/brianmurray/Documents/Source/cfktech-resume/staging/`
3. Deploy staging/ folder to cfktech.com/staging/
4. Test workflow on PR #66
5. Update issue closing process to verify on staging first
