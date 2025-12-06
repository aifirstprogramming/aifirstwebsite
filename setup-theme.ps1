# PowerShell script for setting up the PaperMod theme on Windows

Write-Host "Setting up PaperMod theme for Hugo..." -ForegroundColor Green

# Add the theme as a git submodule
git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod

# Update submodules
git submodule update --init --recursive

Write-Host "Theme setup complete!" -ForegroundColor Green
Write-Host "You can now run 'hugo server' to preview the site locally." -ForegroundColor Cyan

