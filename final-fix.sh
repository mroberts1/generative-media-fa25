#!/bin/bash

echo "🔧 Final fix for Quarto publishing..."

cd "/Users/dokoissho/Obsidian/teaching/emerson/media-criticism-su25/quarto-project"

echo "📂 Working in: $(pwd)"

# Remove the problematic worktree directory completely
echo "🗑️  Removing worktree backup..."
rm -rf .git/worktrees/quarto-publish-worktree-74671f8cf669cc76.bak

# Remove entire worktrees directory if it's now empty
if [ -d ".git/worktrees" ] && [ -z "$(ls -A .git/worktrees)" ]; then
    echo "🗑️  Removing empty worktrees directory..."
    rm -rf .git/worktrees
fi

# Prune any git worktree references
echo "🧹 Pruning git worktrees..."
git worktree prune 2>/dev/null || true

# Show current state
echo "📊 Current git status:"
git status --short

echo ""
echo "✅ All worktree references removed!"
echo ""
echo "🚀 Now try publishing:"
echo "   quarto publish gh-pages"
echo ""
echo "If you still get the worktree error, try:"
echo "   quarto publish gh-pages --force"
