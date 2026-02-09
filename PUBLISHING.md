# Publishing to CurseForge - Setup Guide

## Repository is Ready! ✅

Git repository initialized with:
- ✅ `.gitignore` for WoW addon development
- ✅ `.pkgmeta` for CurseForge packaging
- ✅ GitHub Actions workflow for automated releases
- ✅ `README.md` with feature documentation
- ✅ `CHANGELOG.md` tracking all changes
- ✅ `LICENSE` (MIT)
- ✅ Initial commit to `main` branch

## Next Steps

### 1. Create GitHub Repository

1. Go to https://github.com/new
2. Name: `MuteRepetitiveBrann`
3. **Do NOT** initialize with README/license (we already have them)
4. Create repository
5. Copy the remote URL (e.g., `https://github.com/yourusername/MuteRepetitiveBrann.git`)

### 2. Push Your Code

Run these commands in your terminal:

```powershell
cd "c:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\MuteRepetitiveBrann"
git remote add origin https://github.com/YOURUSERNAME/MuteRepetitiveBrann.git
git branch -M main
git push -u origin main
```

Replace `YOURUSERNAME` with your actual GitHub username.

### 3. Setup CurseForge API Key

1. Go to https://www.curseforge.com/account/api-tokens
2. Click "Generate Token"
3. Name: `GitHub Actions - MuteRepetitiveBrann`
4. Copy the token (you'll only see it once!)

### 4. Add Secret to GitHub

1. Go to your GitHub repo → Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Name: `CF_API_KEY`
4. Value: Paste your CurseForge API token
5. Click "Add secret"

### 5. Create Your First Release

When you're ready to publish an update:

```powershell
cd "c:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\MuteRepetitiveBrann"

# Make your changes, then commit them
git add -A
git commit -m "Description of changes"

# Create and push a version tag (this triggers the release)
git tag v1.4.0
git push origin main --tags
```

**The GitHub Action will automatically:**
- Package your addon using BigWigs packager
- Create a GitHub Release
- Upload to CurseForge
- Include your CHANGELOG.md in the release notes

### 6. Future Updates

For each new version:

1. Update `MuteRepetitiveBrann.toc` with new `## Version:`
2. Add changes to `CHANGELOG.md`
3. Commit changes:
   ```powershell
   git add -A
   git commit -m "v1.4.1 - Bug fixes"
   ```
4. Tag and push:
   ```powershell
   git tag v1.4.1
   git push origin main --tags
   ```

### Troubleshooting

**GitHub Action fails:**
- Check your `CF_API_KEY` secret is correct
- Verify the token has "Upload Files" permission on CurseForge
- Check the Actions tab on GitHub for error logs

**Packager warnings:**
- The packager will automatically:
  - Respect `.pkgmeta` ignore list
  - Handle TOC file processing
  - Skip development files

**Update README.md URLs:**
- Replace `https://github.com/yourusername/` with your actual URLs
- Update CurseForge project link once created

## Testing Locally

To test packaging without publishing:

```powershell
# Install the packager (requires bash/WSL on Windows)
curl -s https://raw.githubusercontent.com/BigWigsMods/packager/master/release.sh | bash -s -- -d
```

This creates a zip file you can test before pushing tags.

---

**Your addon is now ready for automated CurseForge releases! 🎉**
