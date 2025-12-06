#!/bin/bash
# Setup script for initializing the PaperMod theme

echo "Setting up PaperMod theme for Hugo..."

# Add the theme as a git submodule
git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod

# Update submodules
git submodule update --init --recursive

echo "Theme setup complete!"
echo "You can now run 'hugo server' to preview the site locally."

