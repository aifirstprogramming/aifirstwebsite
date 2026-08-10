# Re-sync installers after the aifirstcli Ctrl-C runaway fix

> **AI development artifact, sync record.**
> Records a routine re-sync of the hosted installer copies, not a design decision.
>
> | | |
> | --- | --- |
> | **Feature id** | `installer-ctrlc-runaway` |
> | **Date** | 2026-08-09 |
> | **Source commit** | `aifirstprogramming/aifirstcli@94408dfced5a43ac269253e91f492d6462039ce6` |

## What changed

`aifirstcli`'s `install/install.sh` backgrounded its downloader (`curl`/`wget`) but never
tracked its PID, so a Ctrl-C during download killed the shell's foreground wait without
touching the child: the download kept running unkillably in the background. That was fixed
upstream at `94408dfced5a43ac269253e91f492d6462039ce6` by tracking the downloader's PID,
adding a `cleanup()` that kills it, and re-raising `SIGINT` after cleanup so the caller still
sees the interrupt.

This re-sync pulls that fix (and the matching `install.ps1`, unchanged) into this repository
via `./scripts/sync-installers.sh`, so the copies served from
`aifirstprogramming.com/install.sh` and `/install.ps1` match the fixed source.

## What was verified

- `static/install.sh` and `static/install.ps1` are byte-identical to `install/install.sh` and
  `install/install.ps1` at the source commit (matching md5sums:
  `14a34c60f794cf50ee47882e9f95aa57` and `836ac9d1d6c1ead6b6213c5afdab722f`).
- `sh -n static/install.sh` passes.
- `shellcheck static/install.sh` passes.
- `hugo --minify --gc --panicOnWarning` builds clean.
- `install.ps1`'s content is unchanged. `aifirstcli`'s Ctrl-C fix has no Windows-side
  equivalent, since `Invoke-DownloadWithProgress` is synchronous with no backgrounded child.
- The previously served `static/install.sh` was missing the `-L` redirect fix from a direct
  hotfix on this repo (`80a3e69`); confirmed that fix is still present after this sync,
  since it also exists in the aifirstcli source at this commit.

No other files changed. `content/cli/_index.md` and `scripts/sync-installers.sh` are untouched.
