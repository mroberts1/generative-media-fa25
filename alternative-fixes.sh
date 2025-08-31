#!/bin/bash

# Alternative: Reset Quarto publishing completely
echo "🔄 Alternative approach: Reset Quarto publishing setup..."

cd "/Users/dokoissho/Obsidian/teaching/emerson/media-criticism-su25/quarto-project"

echo "📂 Working in: $(pwd)"

# Option 1: Try publishing with force flag
echo "🚀 Option 1: Force publish..."
echo "Run: quarto publish gh-pages --force"
echo ""

# Option 2: Remove and recreate gh-pages branch
echo "🚀 Option 2: Reset gh-pages branch..."
echo "Commands to run manually:"
echo "  git checkout main"
echo "  git branch -D gh-pages"
echo "  git push origin --delete gh-pages"
echo "  quarto publish gh-pages"
echo ""

# Option 3: Publish to a different branch
echo "🚀 Option 3: Publish to different branch..."
echo "Commands to run:"
echo "  quarto publish gh-pages --branch docs"
echo ""

# Option 4: Completely reinitialize
echo "🚀 Option 4: Complete reset (nuclear option)..."
echo "Commands to run:"
echo "  rm -rf .git"
echo "  git init"
echo "  git remote add origin https://github.com/mroberts1/media-criticism-su25.git"
echo "  git add ."
echo "  git commit -m 'Reinitialize repository'"
echo "  git push -u origin main"
echo "  quarto publish gh-pages"
echo ""

echo "⚠️  Try options in order - start with Option 1"
