#!/bin/bash

echo "🔧 Quarto publish with correct options..."

cd "/Users/dokoissho/Obsidian/teaching/emerson/media-criticism-su25/quarto-project"

echo "📂 Working in: $(pwd)"

# First, let's see what publish options are available
echo "📋 Available quarto publish options:"
quarto publish --help

echo ""
echo "🚀 Try these commands in order:"
echo ""
echo "1. Basic publish:"
echo "   quarto publish gh-pages"
echo ""
echo "2. Publish without prompts:"
echo "   quarto publish gh-pages --no-prompt"
echo ""
echo "3. Publish without browser opening:"
echo "   quarto publish gh-pages --no-browser"
echo ""
echo "4. Publish without prompts or browser:"
echo "   quarto publish gh-pages --no-prompt --no-browser"
echo ""
echo "5. If the gh-pages branch doesn't exist, create it first:"
echo "   git checkout -b gh-pages"
echo "   git push -u origin gh-pages"
echo "   git checkout main"
echo "   quarto publish gh-pages"
echo ""
echo "6. Nuclear option - delete and recreate gh-pages:"
echo "   git branch -D gh-pages"
echo "   git push origin --delete gh-pages"
echo "   quarto publish gh-pages"
