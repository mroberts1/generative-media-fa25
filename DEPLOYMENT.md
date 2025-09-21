# Deployment Setup

This site now uses **GitHub Actions** for automatic deployment to GitHub Pages.

## How It Works

1. **Automatic Deployment**: When you push changes to the `main` or `master` branch, GitHub Actions automatically:
   - Builds the Quarto website
   - Deploys it to GitHub Pages
   
2. **Manual Deployment**: You can also trigger deployment manually from the GitHub Actions tab

## Setup Requirements

### GitHub Repository Settings

You need to configure your GitHub repository settings **once**:

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Pages**
3. Under **Source**, select **GitHub Actions**
4. Save the settings

### First-Time Setup

After pushing the workflow file:

1. The first GitHub Actions run will create the deployment
2. Subsequent pushes will automatically update the site
3. Your site will be available at: https://mroberts1.github.io/generative-media-fa25/

## Workflow Features

- **Multi-language support**: Handles R, Python, and JavaScript dependencies
- **Caching**: Speeds up builds by caching dependencies  
- **Security**: Uses minimal required permissions
- **Flexibility**: Can be triggered manually or on pull requests

## Migration from Local Publishing

### Old Method (No longer needed):
```bash
quarto publish gh-pages
```

### New Method:
Simply push your changes:
```bash
git add .
git commit -m "Update content"
git push origin main
```

The site will automatically rebuild and deploy!

## Troubleshooting

- Check the **Actions** tab in your GitHub repository for build logs
- The workflow runs on `ubuntu-latest` with the latest Quarto version
- If builds fail, check the workflow logs for specific error messages

## Benefits

✅ **Automatic deployment** - No manual publish commands needed  
✅ **No local git worktree issues** - Builds run in clean environment  
✅ **Version control** - All deployments are tracked in git history  
✅ **Collaboration friendly** - Anyone with push access can deploy  
✅ **Pull request previews** - Can be configured for PR previews