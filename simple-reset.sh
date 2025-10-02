#!/bin/bash
# Simple reset to before video commits

echo "🔍 Current situation:"
echo "Current .git size: $(du -sh .git | cut -f1)"
echo "Unpushed commits: $(git rev-list --count origin/main..HEAD)"

echo ""
echo "📋 Recent commits:"
git --no-pager log --oneline -5

echo ""
echo "⚠️  WARNING: This will:"
echo "   - Reset to origin/main (lose 2 local commits)"
echo "   - Remove all video files from working directory"
echo "   - Keep your repository clean and pushable"

read -p "Do you want to proceed? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Aborted"
    exit 1
fi

echo ""
echo "🧹 Creating backup of current work..."
git stash push -m "Backup before reset - $(date)"

echo ""
echo "⏪ Resetting to origin/main..."
git reset --hard origin/main

echo ""
echo "🗑️  Removing any remaining video files..."
find . -name "*.mp4" -size +1M -delete 2>/dev/null || true
find . -name "*.webm" -size +1M -delete 2>/dev/null || true
rm -rf temp_keep_videos 2>/dev/null || true

echo ""
echo "🧹 Cleaning up git..."
git gc --prune=now --aggressive

echo ""
echo "✅ Repository reset!"
echo "New .git size: $(du -sh .git | cut -f1)"
echo "Repository is now in sync with origin/main"

echo ""
echo "📤 You can now safely make new commits and push normally."
echo "   Your stashed work is available with: git stash pop"