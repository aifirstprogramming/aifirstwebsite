# Re-sync installers after the aifirstcli progress-bar fix

> **AI development artifact, sync record.**
> Records a routine re-sync of the hosted installer copies, not a design decision.
>
> | | |
> | --- | --- |
> | **Feature id** | `installer-progress` |
> | **Date** | 2026-08-09 |
> | **Source commit** | `aifirstprogramming/aifirstcli@98d2d112928ab63a116d6494de15c438f6cfaaeb` |

## What changed

`aifirstcli`'s `install/install.ps1` had a fraction-clamp bug in `Get-Bar`: `[Math]::Min(1, $Fraction)`
resolved to the `Int32` overload, so the progress bar stayed empty until the download finished, then
jumped straight to full. That was fixed upstream at
`98d2d112928ab63a116d6494de15c438f6cfaaeb`.

This re-sync pulls that fix (and the matching `install.sh`) into this repository via
`./scripts/sync-installers.sh`, so the copies served from `aifirstprogramming.com/install.sh` and
`/install.ps1` match the fixed source.

## What was verified

- `static/install.sh` and `static/install.ps1` are byte-identical to `install/install.sh` and
  `install/install.ps1` at the source commit (matching md5sums).
- `sh -n static/install.sh` passes.
- `shellcheck static/install.sh` passes.
- `hugo --minify --gc --panicOnWarning` builds clean.

No other files changed. `content/cli/_index.md` and `scripts/sync-installers.sh` are untouched.
