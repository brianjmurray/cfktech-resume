---
layout: post
title: "Automating macOS Updates with Homebrew: Keeping Your Mac Fresh"
date: 2026-01-31
excerpt: "A practical guide to automating macOS, Homebrew, App Store, and package manager updates using a single script. Save time, maintain consistency, and ensure your development environment stays current."
---

Keeping a macOS development machine up-to-date is a constant challenge. Between OS updates, Homebrew packages, App Store apps, npm packages, Azure CLI tools, and VS Code extensions, it's easy to fall behind or forget something important. In this post, I'll show you how to automate the entire process with a single bash script—the same approach I've used for years on my development Macs.

## The Problem: Manual Update Fatigue

Without automation, keeping everything current requires:

- Manually running `softwareupdate` for macOS
- Remembering to run `brew upgrade`
- Running `mas upgrade` for App Store apps
- Manually updating each Homebrew tap and CLI tool (Azure CLI, etc.)
- Updating the Brewfile to track new installations
- Creating Git commits and PRs to track changes
- Backing up dotfiles and configurations

Even worse, inconsistencies can creep in. You install something on one Mac but forget it on another. You upgrade a tool and don't track the version anywhere. You configure something in VS Code and lose it when you get a new machine.

## The Solution: Automated Update Pipeline

The answer is a simple automation approach that runs all updates in sequence, commits the results to Git, and creates a pull request. This way:

✅ Everything stays current automatically  
✅ Changes are tracked in Git (history + rollback capability)  
✅ Multiple Macs stay in sync  
✅ New machines can be set up quickly  
✅ You have a record of what's installed and when  

## How It Works: The Three Core Files

### 1. The Brewfile: Package Manifest

The Brewfile is the heart of the system. It's a declarative list of everything installed via Homebrew, including:

- **Homebrew taps** (external package repositories like `dbt-labs/dbt`, `hashicorp/tap`)
- **Brew packages** (CLI tools like `docker`, `node`, `python@3.11`)
- **Casks** (GUI applications like `visual-studio-code`, `docker`)
- **App Store apps** (managed via `mas`, the Mac App Store CLI)
- **VS Code extensions** (automatically synced to all machines)

Example Brewfile structure:

```bash
# Taps
tap "1password/tap"
tap "dbt-labs/dbt"
tap "hashicorp/tap"

# Core tools
brew "git"
brew "docker"
brew "python@3.11"
brew "node"

# Casks (GUI apps)
cask "visual-studio-code"
cask "docker"
cask "1password"

# App Store apps
mas "1Password 7", id: 1569813296
mas "Final Cut Pro", id: 424389933

# VS Code extensions
vscode "ms-python.python"
vscode "ms-azuretools.vscode-docker"
```

When you run `brew bundle`, it installs everything listed. When you run `brew bundle dump`, it updates the Brewfile with your current installed packages.

### 2. The Update Script: Orchestration

The `update.sh` script automates the entire update process:

```bash
#!/bin/bash

# Timestamp for branch/commit naming
now=$(date '+%Y%m%d%H%M%S')

# Pull latest from main
git pull origin

# Create timestamped branch
git checkout -b $now

# Run updates in sequence
sudo softwareupdate -ia --verbose \
 && brew update \
 && brew upgrade \
 && brew bundle -v \
 && brew cleanup \
 && brew doctor -v \
 && mas upgrade \
 && brew bundle dump -f \
 && az upgrade \
 && mackup backup -f \
 && git add . \
 && git commit -m "ran update on $now" \
 && git push --set-upstream origin $now

# Create and auto-merge PR
gh pr create --fill -B "main"
gh pr merge --admin --squash

# Return to main
git checkout main
git pull origin
```

This script does everything in one command:

1. **`softwareupdate -ia`** - Install all macOS system updates (requires sudo)
2. **`brew update`** - Update Homebrew itself
3. **`brew upgrade`** - Upgrade all installed packages
4. **`brew bundle -v`** - Ensure all packages in Brewfile are installed
5. **`brew cleanup`** - Remove old versions to save disk space
6. **`brew doctor`** - Check for Homebrew issues
7. **`mas upgrade`** - Upgrade all App Store apps
8. **`brew bundle dump`** - Update Brewfile with current state
9. **`az upgrade`** - Upgrade Azure CLI (if installed)
10. **`mackup backup`** - Back up dotfiles (if using Mackup)
11. **Commit changes** - Git commit with timestamp
12. **Create PR** - Auto-create a pull request
13. **Merge PR** - Auto-merge with squash strategy
14. **Return to main** - Clean up after yourself

If any step fails, the whole chain stops (due to `&&`). This is intentional—you want to see what failed rather than continuing with a broken state.

### 3. The Initial Setup Script: First-Time Configuration

The `initial_setup.sh` script runs once on a new Mac (after Homebrew is installed):

```bash
#!/bin/bash

# Copy Brewfile from iCloud to local repo
# Assuming Brewfile is in ~/iCloud/brew-setup-and-update/Brewfile

git clone https://github.com/brianjmurray/brew-setup-and-update.git
cd brew-setup-and-update

# Install everything from Brewfile
brew bundle

# Create initial commit
git add .
git commit -m "Initial setup from Brewfile"
git push
```

Once this runs, you have a complete development environment set up automatically.

## Real-World Workflow: Week-to-Week

Here's how I use this on my personal Macs:

### Day 1 (New Mac Setup)
```bash
# Just installed macOS and Homebrew
./initial_setup.sh

# 5 minutes later: fully configured with all tools, apps, and extensions
```

### Every Other Week (Maintenance)
```bash
cd ~/iCloud/brew-setup-and-update
./update.sh

# Script runs for ~15 minutes while I work on something else
# All updates are complete, changes are tracked, new environment is live
```

### Important: Branch Name is Timestamp
The script uses a timestamp for the branch name: `20260131153000`. This means:
- Multiple runs don't conflict (each gets a unique branch)
- Branch names are sortable by date
- You can see exactly when each update ran

### Auto-Merge Strategy: Squash
The PR uses `--squash` strategy, which means:
- All commits from the update are combined into one
- Main branch stays clean with one commit per update cycle
- Easy to revert if something breaks: `git revert <commit>`

## Advanced: Keeping Macs In Sync

### Scenario: You Have Multiple Macs

If you maintain several Macs (personal, work, etc.), you can:

1. **Share the Brewfile** in iCloud, Dropbox, or GitHub
2. **Run on each Mac** on your preferred schedule
3. **Merge updates** from one Mac's PR to sync all Macs

Example setup:

```
~/iCloud/brew-setup-and-update/
├── Brewfile (shared)
├── update.sh (shared)
├── initial_setup.sh (shared)
└── Brewfile.work (work-specific variant)
```

Each Mac can customize its own Brewfile while sharing the update script.

### Scenario: New Mac Setup From Scratch

With this approach, onboarding a new Mac is:

```bash
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://brew.sh)"

# 2. Clone this repo
git clone https://github.com/brianjmurray/brew-setup-and-update.git
cd brew-setup-and-update

# 3. Run once
./initial_setup.sh

# 30 minutes later (installing everything)
# New Mac is fully configured with 100+ packages, apps, and extensions
```

Compare this to manually installing everything—it would take hours.

## Benefits Beyond Automation

### 1. **Version History**
Every update is committed to Git. You can see exactly what changed:

```bash
git log --oneline
# 20260131153000 ran update on 20260131153000
# 20260129103000 ran update on 20260129103000
# 20260125164500 ran update on 20260125164500
```

### 2. **Rollback Capability**
If an update breaks something, rollback is easy:

```bash
git revert <commit-hash>
brew bundle  # Re-apply the previous state
```

### 3. **Change Tracking**
See exactly what changed in each update:

```bash
git show 20260131153000
# Shows Brewfile changes: new packages, versions, removed apps
```

### 4. **Configuration Backup**
With Mackup, your dotfiles (`.zshrc`, `.bashrc`, VS Code settings, etc.) are automatically backed up:

```bash
~/.config/
├── .zshrc
├── .bashrc
└── [other configs]
```

All synced to cloud storage automatically.

### 5. **Cross-Platform Consistency**
All your Macs have the same:
- Homebrew packages
- Cask applications
- App Store apps
- VS Code extensions
- Configurations

No more "but it works on my laptop" issues.

## Customization: Making It Your Own

### Add Your Own Packages

Simply edit the Brewfile and re-run the update script:

```bash
# Add to Brewfile
brew "rustup"
brew "go"
cask "tableplus"

# Next update run will install them automatically
./update.sh
```

### Skip The Auto-Merge (For Review)

If you want to review changes before merging:

```bash
# Comment out the merge line
# gh pr merge --admin --squash

# Then manually review and merge:
gh pr view  # See what changed
gh pr merge  # Merge when ready
```

### Run On Specific Days

Use `cron` to run updates on a schedule:

```bash
# Edit crontab
crontab -e

# Add: Run every other Friday at 5 PM
0 17 * * 5 cd ~/brew-setup-and-update && ./update.sh 2>&1 >> update.log
```

### Run Before Important Work

If you have a critical project coming up, run the update beforehand:

```bash
# Make sure everything is current before a big sprint
./update.sh
```

## Potential Issues & Solutions

### Issue: Update Fails Midway

**Problem**: One step fails, script stops.  
**Solution**: Check the output, fix the issue, re-run. The `&&` chain ensures nothing continues if something fails.

Example:
```bash
# If brew doctor finds issues, it stops
# Fix the issue, then re-run
brew doctor
# Fix reported issues...
./update.sh  # Try again
```

### Issue: Password Prompt (sudo)

**Problem**: `softwareupdate` requires sudo, script pauses.  
**Solution**: Enter your password or temporarily use sudo without password.

Temporary solution (use with caution):
```bash
# Allow brew commands without password prompt
sudo visudo
# Add: %admin ALL=(ALL) NOPASSWD: /usr/bin/softwareupdate
```

### Issue: PR Auto-Merge Fails

**Problem**: PR creation or merge fails (permissions, branch protection, etc.).  
**Solution**: Manually merge from GitHub, or adjust branch protection rules.

### Issue: Some Apps Won't Update

**Problem**: Certain apps fail to install or upgrade.  
**Solution**: Check if the package name is correct, or install manually:

```bash
# Some packages may require specific versions
brew install [package]@[version]
brew bundle dump  # Update Brewfile
```

## Best Practices

### 1. Keep the Repo Private or Public?

**Public** (like my repo):
- Useful for showing your tech stack
- Good for sharing your setup with others
- Safe: doesn't include credentials (they're in environment files)

**Private**:
- Better for sensitive configs
- Easier to track personal customizations

### 2. Don't Commit Secrets

Never commit:
- API keys
- Passwords
- SSH keys
- `.npmrc` files with tokens

Use `.gitignore` for sensitive files:

```bash
# .gitignore
.env
.npmrc
*.pem
```

### 3. Test on a Spare Mac First

If you have multiple Macs, test your Brewfile on a non-critical one first.

### 4. Review Changes in the PR

Always glance at the PR before it auto-merges:

```bash
gh pr view  # See what changed
# Look for unexpected removals or issues
# If anything looks wrong, deny the merge manually
```

## Takeaways

Automating macOS updates saves time, maintains consistency, and ensures your development environment stays current. By using a simple Brewfile + update script + Git workflow, you get:

- **One command** (`./update.sh`) runs everything
- **Complete version history** of your Mac's state
- **Easy rollback** if something breaks
- **Multi-Mac sync** automatically
- **New Mac setup** in 30 minutes instead of 3 hours

## Next Steps

1. **Fork the repo**: [github.com/brianjmurray/brew-setup-and-update](https://github.com/brianjmurray/brew-setup-and-update)
2. **Customize the Brewfile** to match your setup
3. **Run the script** on your development Mac
4. **Watch Git track all updates** from then on

Your future self will thank you when you get a new Mac and everything is set up automatically. Happy updating!

---

**Have you automated your Mac setup? Share your approach in the comments or on Twitter!**
