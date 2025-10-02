#!/bin/bash
# Fix large video files in git history

echo "🔍 Analyzing repository size..."
echo "Current .git size: $(du -sh .git | cut -f1)"

echo ""
echo "📁 Large files in recent commits:"
git --no-pager log --oneline --name-only HEAD~2..HEAD | grep -E '\.(mp4|webm)$' | sort | uniq

echo ""
echo "⚠️  WARNING: This will rewrite git history!"
echo "   - This will remove large video files from ALL commits"
echo "   - You'll need to force push the cleaned repository"
echo "   - Anyone else with this repo will need to re-clone"

read -p "Do you want to proceed? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Aborted"
    exit 1
fi

echo ""
echo "🧹 Creating backup branch..."
git branch backup-before-cleanup

echo ""
echo "🗑️  Removing large video files from history..."

# Use git filter-repo if available, otherwise filter-branch
if command -v git-filter-repo &> /dev/null; then
    echo "Using git-filter-repo (recommended)..."
    git filter-repo --strip-blobs-bigger-than 50M --force
else
    echo "Using git filter-branch (slower)..."
    # Remove files over 50MB from history
    git filter-branch --tree-filter '
        find . -size +50M -delete 2>/dev/null || true
        find . -name "*.mp4" -delete 2>/dev/null || true
        find . -name "*.webm" -delete 2>/dev/null || true
    ' --tag-name-filter cat -- --all
    
    # Clean up
    git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
    git reflog expire --expire=now --all
    git gc --prune=now --aggressive
fi

echo ""
echo "✅ Repository cleaned!"
echo "New .git size: $(du -sh .git | cut -f1)"

echo ""
echo "📤 Next steps:"
echo "1. Review the changes: git log --oneline -5"
echo "2. Force push to update remote: git push origin main --force"
echo "3. If issues occur, restore from backup: git checkout backup-before-cleanup"

echo ""
echo "⚠️  Note: After force pushing, the GitHub Actions deployment will automatically update your site."