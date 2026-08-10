# Download links, not manual steps

**Feature:** website-download-links
**Date:** 2026-08-10
**Shipped:** yes (direct commit to `main`, no PR since this repo has no fork)

## Problem

The VS Code extension page walked a visitor through five manual steps to find
the extension in the Marketplace search box. The CLI page never linked
GitHub Releases at all, so the only documented install path was the shell
one-liner. The home page's "Get Started" list called the CLI and extension
"Install" targets even though neither page it linked to had an actual
download action on it yet.

## What I verified rather than assumed

The Marketplace listing page at `marketplace.visualstudio.com/items` is a
client-rendered SPA shell. A plain `curl` to that URL returns HTTP 200 and an
empty `<title>` for any `itemName`, including ones that don't exist, so a bare
200 check proves nothing. I confirmed the extension is real by querying the
Marketplace Gallery API directly:

```
POST https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery
```

The response returned `publisherName: AIFirstProgramming`,
`extensionName: ai-first-programming`, `displayName: AI First Programming`,
version `1.6.0`, and `flags: validated, public`. That's the actual existence
proof, not the HTTP status code.

For the CLI page, I confirmed `github.com/aifirstprogramming/aifirstcli/releases/latest`
resolves (redirects to the current tag, HTTP 200 after following redirects)
and the releases index also returns 200.

## Decisions and alternatives

**Marketplace link over rewriting the whole install flow.** The page kept its
five numbered steps as a fallback rather than deleting them outright. Some
readers land on this page from a search engine without VS Code already open,
so a text description of where the extension lives still has value. I
condensed the five steps into one sentence, keeping the same two literal
search phrases ("ai first programming" / "ai first book") so the page still
tells a reader who prefers manual search exactly what to type.

**`/releases/latest` instead of a pinned tag.** The CLI page could have linked
a specific version like `/releases/download/v0.6.0/...`, but that link goes
stale the moment a new version ships and nobody remembers to update a
markdown file when cutting a release. `/releases/latest` is GitHub's
tag-agnostic alias and always points at the current release.

**Home page CTA reuses the existing bullet list.** Rather than adding a new
block, I renamed "Get Started" to "Download" and reordered the CLI/extension
bullets to the top, since those are now the two things with actual download
targets. The book series and GitHub links stayed as-is.

## How the result was checked

- `hugo --minify --gc --panicOnWarning` exits 0, no panics or warnings (only
  automated gate this repo has).
- Every added link checked live with `curl -sS -o /dev/null -w '%{http_code}'`:
  Marketplace listing 200, `releases/latest` 200 (following the redirect),
  releases index 200.
- Confirmed `content/cli/_index.md` line 23 (the printed install one-liner)
  is byte-identical to before the change.
- Confirmed the CRLF line endings on `content/_index.md` and
  `content/vscode-extension/_index.md`, and the LF line endings on
  `content/cli/_index.md`, were preserved (checked the raw bytes before and
  after editing, not just a visual diff).
- Grepped for `/releases/download/v` across `content/` post-edit: no hits,
  so no tag-pinned asset URL slipped in.
