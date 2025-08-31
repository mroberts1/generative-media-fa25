#!/bin/bash

# Fix Quarto publishing error by cleaning up leftover worktrees and git config
# Run this from the quarto project directory

echo "🔧 Fixing Quarto publishing error..."

# Change to the project directory
cd "/Users/dokoissho/Obsidian/teaching/emerson/media-criticism-su25/quarto-project"

echo "📂 Current directory: $(pwd)"

# Step 1: Remove any leftover quarto publish worktrees
echo "🧹 Cleaning up git worktrees..."
if [ -d ".git/worktrees" ]; then
    for worktree_dir in .git/worktrees/quarto-publish-worktree-*; do
        if [ -d "$worktree_dir" ]; then
            worktree_name=$(basename "$worktree_dir")
            echo "  Removing worktree: $worktree_name"
            git worktree remove "$worktree_name" --force 2>/dev/null || true
            rm -rf "$worktree_dir"
        fi
    done
fi

# Step 2: Clean up the git config duplicates
echo "🔧 Cleaning up git config..."
# Back up the current config
cp .git/config .git/config.backup

# Remove duplicate fetch lines and clean up config
cat .git/config | awk '
BEGIN { in_remote = 0; seen_fetch = 0 }
/^\[remote "origin"\]/ { in_remote = 1; seen_fetch = 0; print; next }
/^\[/ && !/^\[remote "origin"\]/ { in_remote = 0; seen_fetch = 0; print; next }
in_remote == 1 && /^[[:space:]]*fetch = \+refs\/heads\/gh-pages:refs\/remotes\/origin\/gh-pages/ {
    if (seen_fetch == 0) {
        print
        seen_fetch = 1
    }
    next
}
{ print }
' > .git/config.tmp && mv .git/config.tmp .git/config

echo "✅ Git config cleaned up (backup saved as .git/config.backup)"

# Step 3: Remove any leftover .quarto publish directories
echo "🧹 Cleaning up .quarto directory..."
if [ -d ".quarto" ]; then
    find .quarto -name "*publish*" -type d -exec rm -rf {} + 2>/dev/null || true
    find .quarto -name "*worktree*" -type d -exec rm -rf {} + 2>/dev/null || true
fi

# Step 4: Check git status
echo "📊 Git status:"
git status --porcelain

# Step 5: Try to fetch latest from remote
echo "🔄 Fetching latest from remote..."
git fetch origin

echo ""
echo "✅ Cleanup complete! You should now be able to publish with:"
echo "   quarto publish gh-pages"
echo ""
echo "If you still get errors, you can also try:"
echo "   quarto publish gh-pages --no-browser --no-prompt"
