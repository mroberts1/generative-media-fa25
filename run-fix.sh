#!/bin/bash

# Immediate fix for Quarto publishing error
echo "🔧 Fixing Quarto publishing error directly..."

cd "/Users/dokoissho/Obsidian/teaching/emerson/media-criticism-su25/quarto-project"

# Step 1: Completely remove worktrees directory
echo "🧹 Removing all worktree references..."
rm -rf .git/worktrees

# Step 2: Clean up any .quarto publish directories  
echo "🧹 Cleaning .quarto directory..."
find .quarto -name "*publish*" -type d -exec rm -rf {} + 2>/dev/null || true
find .quarto -name "*worktree*" -type d -exec rm -rf {} + 2>/dev/null || true

# Step 3: Reset git worktree list
echo "🔧 Resetting git state..."
git worktree prune 2>/dev/null || true

# Step 4: Check current status
echo "📊 Current git status:"
git status --porcelain

echo ""
echo "✅ Cleanup complete! Now try:"
echo "   quarto publish gh-pages --force"
echo ""
echo "If that fails, try:"
echo "   quarto publish gh-pages --no-browser --no-prompt --force"

# Make this script executable
chmod +x "$0"
