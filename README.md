# AI First Programming Website

GitHub Pages website for the AI First Book Series, built with Hugo.

## Setup

### Prerequisites

- [Hugo](https://gohugo.io/installation/) (extended version recommended)
- Git

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/aifirstprogramming/aifirstwebsite.git
   cd aifirstwebsite
   ```

2. Initialize the theme (PaperMod):
   ```bash
   git submodule update --init --recursive
   ```
   
   The `.gitmodules` file is already configured. This command will clone the PaperMod theme into the `themes/` directory.

### Local Development

Run the development server:

```bash
hugo server
```

The site will be available at `http://localhost:1313`

### Building

Build the static site:

```bash
hugo
```

The generated site will be in the `public/` directory.

## Deployment

The site is automatically deployed to GitHub Pages on every push to the `main` branch via GitHub Actions.

### Initial GitHub Pages Setup

1. Go to your repository settings on GitHub
2. Navigate to **Pages** in the left sidebar
3. Under **Source**, select **GitHub Actions** (not "Deploy from a branch")
4. The GitHub Actions workflow will automatically deploy on every push to `main`

### Deployment Workflow

The workflow:
1. Checks out the repository (including submodules for the theme)
2. Sets up Hugo (extended version)
3. Builds the site with production settings
4. Deploys to GitHub Pages

The site will be available at: `https://aifirstprogramming.github.io/aifirstwebsite/`

## Site Structure

- `content/` - Markdown content files
  - `_index.md` - Homepage
  - `book-series/` - Book series page
  - `vscode-extension/` - VS Code extension page
- `themes/` - Hugo themes (PaperMod)
- `hugo.toml` - Hugo configuration

## License

Apache License 2.0 - See LICENSE file for details.
