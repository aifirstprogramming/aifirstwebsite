<!-- Written from a Claude Code session (`62a2fb7f`, 2026-08-07). Historical record. -->

# Serving the CLI installers from this repository

> **AI development artifact — design note.**
> Written during the session that added `static/install.sh`, `static/install.ps1`,
> `scripts/sync-installers.sh` and the `/cli/` page. It records the decisions behind those files
> and what was actually checked before making them. Where this note and the site disagree, the
> site is right.
>
> | | |
> | --- | --- |
> | **Session** | `62a2fb7f` |
> | **Date** | 2026-08-07 |
> | **Landed as** | `cbb0d9b Serve the AI First CLI installers and add a CLI page`, `760cf2a Surface the CLI on the homepage` |

## The problem

The AI First books print an install one-liner. For it to be short enough to typeset and stable
enough to print, it has to resolve against the series' own domain:

```bash
curl -fsSL https://aifirstprogramming.com/install.sh | bash   # macOS, Linux
irm https://aifirstprogramming.com/install.ps1 | iex          # Windows
```

The installer scripts belong to the [`aifirstcli`](https://github.com/aifirstprogramming/aifirstcli)
repository — they live there under `install/`, they are tested there by CI, and that is where edits
belong. The obvious approach was therefore to publish them from that repository with its own GitHub
Pages workflow.

## Why they live here instead

**Two repositories cannot serve one custom domain.** `aifirstprogramming.com` is already served by
this repository's Pages deployment. A second Pages site claiming the same CNAME does not merge with
the first — it takes the domain, or fails, depending on which deploys last. The CLI repository's
Pages workflow was written and then deleted before it ever ran
(`aifirstcli@9838554 Consume @aifirst/content from a git tag; drop Pages workflow`).

So the installers are served from the repository that owns the domain, and `install/` in the CLI
repository remains the source of truth. `scripts/sync-installers.sh` pulls a copy across, from a
release tag, from `main`, or from a local checkout.

## Why the copies are committed rather than fetched at build time

Fetching the installers during the Hugo build would keep them automatically current. It was
rejected for two reasons:

1. **The site must keep deploying when the CLI repository is unreachable.** A build-time fetch makes
   every deployment of this site depend on another repository being available.
2. **A change to what readers execute should be a reviewable diff.** These two files are piped
   straight into `bash` and `iex` by people following a printed book. Committing them means any
   change to them appears in a pull request rather than shifting silently under a published URL.

The cost is that the copies can go stale. `sync-installers.sh` exists so that refreshing them is one
command, and it runs `sh -n static/install.sh` before accepting the result — a broken installer is
worse than a stale one, because it is the first thing a reader of the book ever runs.

## One thing that looked like a bug and was not

`hugo.toml` sets `baseURL` to the `github.io` default rather than the custom domain. That looks
wrong, and the tempting fix is to change it.

**Do not.** The deploy workflow overrides `baseURL` on the Hugo command line at build time. The
value committed in `hugo.toml` is what local builds use; the deployed value comes from the
workflow. This was checked against the live site before touching anything.

## How it was verified

Not by inspection. After the CLI's v0.1.1 release published, the actual printed one-liner was run
end to end in a sandbox: it resolved the release, selected the `aifirst-linux-x64` asset, verified
the checksum, and installed. `SHA256SUMS` was then downloaded independently and the installed binary
hashed against it — they matched, which is what makes the installer's verification step meaningful
rather than a no-op.

The three URLs that the book depends on were confirmed live after deployment:
`/install.sh`, `/install.ps1`, and the `/cli/` page.
