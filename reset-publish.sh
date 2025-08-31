#!/bin/bash

echo "🔄 Reset Quarto publishing setup completely..."

cd "/Users/dokoissho/Obsidian/teaching/emerson/media-criticism-su25/quarto-project"

# Step 1: Remove all worktree references completely
echo "🧹 Step 1: Complete worktree cleanup..."
rm -rf .git/worktrees
git worktree prune 2>/dev/null || true

# Step 2: Remove any _publish.yml that might exist
echo "🧹 Step 2: Remove publish configuration..."
rm -f _publish.yml

# Step 3: Clean .quarto directory
echo "🧹 Step 3: Clean .quarto directory..."
rm -rf .quarto/_publish*
rm -rf .quarto/*publish*
rm -rf .quarto/*worktree*

# Step 4: Reset gh-pages branch completely
echo "🔄 Step 4: Reset gh-pages branch..."
git fetch origin 2>/dev/null || true

# Check current branch
current_branch=$(git branch --show-current)
echo "Current branch: $current_branch"

# If we're on gh-pages, switch to main first
if [ "$current_branch" = "gh-pages" ]; then
    git checkout main 2>/dev/null || git checkout master 2>/dev/null || echo "Could not switch to main/master"
fi

# Delete local gh-pages if it exists
if git show-ref --verify --quiet refs/heads/gh-pages; then
    echo "Deleting local gh-pages branch..."
    git branch -D gh-pages 2>/dev/null || true
fi

# Step 5: Show current status
echo "📊 Current status:"
git status --short
echo ""
git branch -a

echo ""
echo "✅ Publishing setup reset complete!"
echo ""
echo "🚀 Now try publishing (this should create a fresh gh-pages branch):"
echo "   quarto publish gh-pages"
echo ""
echo "Alternative commands if needed:"
echo "   quarto publish gh-pages --no-prompt"
echo "   quarto publish gh-pages --no-browser --no-prompt"
