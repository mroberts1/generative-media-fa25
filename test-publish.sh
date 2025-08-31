#!/bin/bash

echo "🚀 Testing Quarto publish after cleanup..."

# Change to project directory
cd "/Users/dokoissho/Obsidian/teaching/emerson/media-criticism-su25/quarto-project"

echo "📂 Current directory: $(pwd)"

# Check git status
echo "📊 Git status:"
git status

echo ""
echo "🔄 Fetching from remote..."
git fetch origin

echo ""
echo "✅ Ready to publish! Run one of these commands:"
echo ""
echo "   quarto publish gh-pages"
echo "   quarto publish gh-pages --no-browser --no-prompt"
echo ""
echo "If you want to test locally first:"
echo "   quarto preview"
