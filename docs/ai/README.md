# AI development artifacts

Parts of this site were built with [Claude Code](https://claude.com/claude-code). Where the agent's
reasoning is worth keeping — decisions that the resulting files do not explain on their own — it is
written down here so that anyone working on the project can read *why* the site is arranged the way
it is.

## How to read these

**They are history, not documentation.** Each note describes a decision at the moment it was made.
Where a note and the site disagree, the site is right. For how to run and deploy the site, read the
[README](../../README.md).

## Notes

| Note | Date | Subject |
| --- | --- | --- |
| [Serving the CLI installers](notes/2026-08-07-serving-the-cli-installers.md) | 2026-08-07 | Why `install.sh` and `install.ps1` are committed copies living in *this* repository rather than in the CLI repository that owns them |
| [Re-sync installers after the aifirstcli progress-bar fix](notes/2026-08-09-installer-progress-sync.md) | 2026-08-09 | Pulling the `Get-Bar` clamp fix from aifirstcli into the hosted installer copies |

## Sessions behind this repository

| Session | When | What it produced |
| --- | --- | --- |
| `62a2fb7f` | 2026-08-07 | `cbb0d9b Serve the AI First CLI installers and add a CLI page` and `760cf2a Surface the CLI on the homepage` |

That session's main subject was the [`aifirst` CLI](https://github.com/aifirstprogramming/aifirstcli);
the website changes were the last step in making its published install one-liner resolve. The
plans from that session are in the
[CLI repository](https://github.com/aifirstprogramming/aifirstcli/blob/main/docs/ai/README.md).

The rest of the site — the Hugo scaffold, the PaperMod theme wiring and the Pages workflow — was
built in December 2025, before this directory existed.

## Adding to this directory

Write a note when a decision would otherwise be invisible in the diff: something considered and
rejected, a constraint discovered by checking rather than assuming, or a rule about what must not
change. Date it, say what was actually verified, and add a row to the table above.
