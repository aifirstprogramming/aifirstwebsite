#!/bin/sh
# Refresh the CLI installer scripts served from this site.
#
#   static/install.sh   ->  https://aifirstprogramming.com/install.sh
#   static/install.ps1  ->  https://aifirstprogramming.com/install.ps1
#
# These are copies. The originals live in the aifirstcli repo under install/,
# and that is where edits belong — this script only pulls them across.
#
# Run it after any change to the installers, then commit the result.
#
#   ./scripts/sync-installers.sh          # from the latest CLI release tag
#   ./scripts/sync-installers.sh main     # from the tip of main
#   ./scripts/sync-installers.sh ../aifirstcli   # from a local checkout

set -eu

cd "$(dirname "$0")/.."
mkdir -p static

src="${1:-}"

if [ -d "$src" ]; then
  echo "Copying installers from $src"
  cp "$src/install/install.sh" static/install.sh
  cp "$src/install/install.ps1" static/install.ps1
else
  ref="${src:-$(
    curl -fsSL https://api.github.com/repos/aifirstprogramming/aifirstcli/releases/latest |
      sed -n 's/.*"tag_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1
  )}"
  [ -n "$ref" ] || { echo "could not resolve a CLI ref" >&2; exit 1; }
  echo "Downloading installers from aifirstcli@$ref"
  base="https://raw.githubusercontent.com/aifirstprogramming/aifirstcli/$ref/install"
  curl -fsSL "$base/install.sh"  -o static/install.sh
  curl -fsSL "$base/install.ps1" -o static/install.ps1
fi

# A broken installer is worse than a stale one — it is the first thing a reader
# of the book ever runs.
sh -n static/install.sh || { echo "static/install.sh has a syntax error" >&2; exit 1; }

echo "Updated static/install.sh and static/install.ps1 — review and commit."
