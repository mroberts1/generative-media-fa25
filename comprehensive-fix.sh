#!/bin/bash

# Comprehensive Quarto publish fix script
# This script addresses multiple potential issues with Quarto publishing

echo "🔧 Comprehensive Quarto publish fix..."

# Change to project directory
cd "/Users/dokoissho/Obsidian/teaching/emerson/media-criticism-su25/quarto-project"

echo "📂 Working in: $(pwd)"

# Step 1: Complete worktree cleanup
echo "🧹 Step 1: Complete git worktree cleanup..."

# Remove all quarto publish worktrees (forcefully)
git worktree list 2>/dev/null | grep "quarto-publish-worktree" | while read -r line; do
    worktree_path=$(echo "$line" | awk '{print $1}')
    worktree_name=$(basename "$worktree_path")
    echo "  Removing worktree: $worktree_name at $worktree_path"
    git worktree remove "$worktree_name" --force 2>/dev/null || true
    rm -rf "$worktree_path" 2>/dev/null || true
done

# Remove the .git/worktrees directory entirely if it exists
if [ -d ".git/worktrees" ]; then
    echo "  Removing .git/worktrees directory..."
    rm -rf .git/worktrees
fi

# Step 2: Clean up any leftover .quarto publish directories
echo "🧹 Step 2: Cleaning .quarto directory..."
if [ -d ".quarto" ]; then
    find .quarto -name "*publish*" -type d 2>/dev/null | while read -r dir; do
        echo "  Removing: $dir"
        rm -rf "$dir"
    done
    
    find .quarto -name "*worktree*" -type d 2>/dev/null | while read -r dir; do
        echo "  Removing: $dir"
        rm -rf "$dir"
    done
fi

# Step 3: Reset git configuration
echo "🔧 Step 3: Resetting git configuration..."
git config --unset-all remote.origin.fetch 2>/dev/null || true
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Step 4: Clean up any git references to gh-pages worktrees
echo "🔧 Step 4: Cleaning git references..."
if [ -f ".git/logs/refs/heads/gh-pages" ]; then
    echo "  Cleaning gh-pages log references..."
    # Don't delete the log, just ensure it's not corrupted
    git reflog expire --expire=now --all 2>/dev/null || true
fi

# Step 5: Ensure gh-pages branch exists and is clean
echo "🔄 Step 5: Setting up gh-pages branch..."
git fetch origin 2>/dev/null || echo "  Warning: Could not fetch from origin"

# Check if gh-pages branch exists locally
if git show-ref --verify --quiet refs/heads/gh-pages; then
    echo "  Local gh-pages branch exists"
    git checkout main 2>/dev/null || git checkout master 2>/dev/null || true
    git branch -D gh-pages 2>/dev/null || true
fi

# Check if gh-pages exists on remote
if git show-ref --verify --quiet refs/remotes/origin/gh-pages; then
    echo "  Remote gh-pages branch exists, creating local tracking branch"
    git checkout -b gh-pages origin/gh-pages 2>/dev/null || true
    git checkout main 2>/dev/null || git checkout master 2>/dev/null || true
else
    echo "  No remote gh-pages branch found"
fi

# Step 6: Verify git status
echo "📊 Step 6: Current git status..."
echo "Git status:"
git status --short
echo ""
echo "Git branches:"
git branch -a
echo ""
echo "Git remotes:"
git remote -v

# Step 7: Test quarto
echo "🚀 Step 7: Testing quarto..."
if command -v quarto >/dev/null 2>&1; then
    echo "  Quarto version: $(quarto --version)"
    echo "  ✅ Quarto is available"
else
    echo "  ❌ Quarto command not found"
    echo "  Make sure Quarto is installed and in your PATH"
fi

echo ""
echo "✅ Cleanup complete!"
echo ""
echo "🚀 Try publishing now with:"
echo "   quarto publish gh-pages"
echo ""
echo "Or if that fails, try:"
echo "   quarto publish gh-pages --no-browser --no-prompt"
echo ""
echo "For debugging, you can also try:"
echo "   quarto render"
echo "   quarto publish gh-pages --no-render"
