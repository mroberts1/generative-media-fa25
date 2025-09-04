# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is a Quarto website project for an academic course **VM402-09 Generative Media: History, Theory, Practice** taught at Emerson College. The website serves as a course syllabus and resource hub, built with Quarto and deployed via GitHub Pages.

**Key Technologies:**
- Quarto (website generation and publishing)
- R (for data processing, though minimal usage)
- SCSS/CSS (custom theming)
- GitHub Pages (hosting)
- Chicago Author-Date citation style

## Quick Start Commands

### Local Development
```bash
# Render the website locally
quarto render

# Preview the website with live reload
quarto preview

# Check Quarto version
quarto --version
```

### Publishing to GitHub Pages
```bash
# Standard publishing command
quarto publish gh-pages

# If you encounter git worktree issues (common with this project)
quarto publish gh-pages --no-prompt --no-browser

# Force publish (if worktree conflicts persist)
quarto publish gh-pages --force
```

## Architecture & Structure

### Website Configuration
- **Main config**: `_quarto.yml` - defines website structure, theming, and publishing settings
- **Site URL**: https://mroberts1.github.io/generative-media-fa25/
- **Navigation**: Simple navbar with Syllabus and Bibliography
- **Theme**: Custom theme based on `ember.scss` with additional `custom.scss` overrides

### Content Organization
```
├── index.qmd                 # Main syllabus page
├── bibliography.qmd          # Course bibliography
├── references.bib            # BibTeX references
├── pdf/                      # Academic PDFs and readings
├── gif/                      # Animated images (course visuals)
├── img/                      # Static images (logos, portraits)
├── fonts/                    # Custom web fonts
├── outlanders/               # Specific media assets folder
└── _site/                    # Generated website (do not edit)
```

### Course Structure
- **Duration**: 7-week online/asynchronous summer course
- **Weekly Topics**: From furniture music to AI performance
- **Assessment Types**: Discussion posts, response papers, analytical papers
- **Academic Year**: Summer 2025 (note: may need updating for future iterations)

## Development Workflow

### Adding New Content
1. Edit `.qmd` files using Quarto markdown syntax
2. Add new references to `references.bib` for citations
3. Place media assets in appropriate folders (`pdf/`, `gif/`, `img/`)
4. Use R code chunks sparingly (mainly for package loading)

### Citation Management
- Uses Chicago Author-Date style (`chicago-author-date.csl`)
- Citations are handled via `references.bib`
- Format: `[@author2020title]` for in-text citations
- Bibliography automatically generated from `references.bib`

### Media Asset Management
- **PDF readings**: Store in `pdf/` directory, reference with relative paths
- **Visual content**: Use `gif/` for animated content, `img/` for static images
- **Animations**: Project includes educational/artistic GIFs (e.g., outlanders-brain-magazine.gif)

### Local Testing
```bash
# Always render before committing
quarto render

# Check for rendering errors
# Look for any failed file processing in terminal output

# Verify links work locally
quarto preview
```

## Publishing & Deployment

### Standard Deployment
```bash
# From the project root directory
quarto publish gh-pages
```

### Troubleshooting Publishing Issues
This project has historically had git worktree conflicts. If you encounter errors:

1. **First, try the no-prompt option:**
```bash
quarto publish gh-pages --no-prompt --no-browser
```

2. **If worktree issues persist, clean up git worktrees:**
```bash
# Remove problematic worktree directories
rm -rf .git/worktrees/quarto-publish-worktree*

# Prune git worktree references
git worktree prune

# Then retry publishing
quarto publish gh-pages
```

3. **Nuclear option for persistent issues:**
```bash
# Force publish (overwrites existing gh-pages branch)
quarto publish gh-pages --force
```

### Verification
- Check the live site: https://mroberts1.github.io/generative-media-fa25/
- Verify all links and media load correctly
- Test navigation between syllabus and bibliography pages

## Project-Specific Context

### Academic Calendar
- Course is scheduled for Summer 2025 (7 weeks: July 2 - August 19)
- Weekly structure: Wednesday to Tuesday cycles
- Update dates annually for course reruns

### Emerson College Branding
- Uses official Emerson logo (`Emerson-PrimaryLogo-Reversed-Color-400px.png`)
- Purple color scheme (`#62259d`) matches institutional branding
- Faculty contact info integrated into navigation

### Social Media Integration
- Instructor contact via multiple platforms: email, Mastodon, GitHub, Twitter, Facebook
- FontAwesome icons used for social links
- Professional academic presence maintained

### Technical Quirks
- **Git worktrees**: This project frequently encounters git worktree conflicts during publishing
- **Large media files**: Video files (`.mp4`) are gitignored due to size constraints
- **R dependency**: Minimal R usage, mainly for tidyverse/palmerpenguins (example content)

## Important Files & Locations

### Configuration
- `_quarto.yml` - Website configuration, theming, publishing settings
- `references.bib` - Bibliography database
- `chicago-author-date.csl` - Citation style
- `.gitignore` - Excludes large media files and sensitive content

### Styling
- `ember.scss` - Primary theme file
- `custom.scss` - Additional styling overrides
- `fonts/` - Custom web font files (Avenir, Helvetica, etc.)

### Content
- `index.qmd` - Main syllabus (course description, schedule, assignments)
- `bibliography.qmd` - Course readings and references
- `pdf/` - Academic readings and course materials

### Publishing Scripts (for reference)
- `comprehensive-fix.sh` - Full git worktree cleanup procedure
- `final-fix.sh` - Simplified worktree cleanup
- `correct-publish.sh` - Publishing command reference

These scripts exist due to historical publishing issues but document the solutions that work for this project.
