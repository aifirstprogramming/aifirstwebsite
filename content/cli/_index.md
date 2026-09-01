---
title: "AI First CLI"
date: 2026-08-07
draft: false
description: "One-line install companion CLI for the AI First book series. Adds book skills to Claude Code, Codex, and Antigravity, serves the book's exact code examples, and tracks your progress."
---

## AI First CLI

The **aifirst** CLI is the terminal companion to the AI First book series. It installs a book skill
into whichever AI coding tools you already use, so that when you ask for a book example you get
**the book's answer** — character for character — rather than whatever a model happens to generate
today. It also keeps a private log of the exercises you've completed.

If you work in VS Code, the [VS Code Extension](../vscode-extension/) covers the same ground inside
the editor. The CLI is for everyone working in a terminal, and the two share the same book content.

### Installation

**macOS and Linux**

```bash
curl -fsSL https://aifirstprogramming.com/install.sh | bash
```

**Windows (PowerShell)**

```powershell
irm https://aifirstprogramming.com/install.ps1 | iex
```

Nothing else is required — no Node, no Python, no JVM. The download is a single self-contained
program with all the book content inside it, so it works offline once installed.

### Download

Grab the latest release directly from GitHub:

**[Download the latest release →](https://github.com/aifirstprogramming/aifirstcli/releases/latest)**

See the full [release history](https://github.com/aifirstprogramming/aifirstcli/releases) for older versions and changelogs.

### Security and code signing

AI First Programming has applied to the SignPath Foundation for open-source
Windows code signing. Windows executables remain unsigned while that
application is pending. The project's
[code signing policy](https://github.com/aifirstprogramming/aifirstcli/blob/main/CODE_SIGNING_POLICY.md)
documents privacy and network behavior, system changes, project roles, and the
release approval process.

Then set up your AI tools:

```bash
aifirst init
```

This finds the tools you have installed, shows you what it found, and asks once before installing.
It only ever writes into its own `aifirst` folder inside each tool — your settings, models, and
logins are never touched, and `aifirst skill remove` undoes it cleanly.

### Supported tools

| Tool | What you get |
| --- | --- |
| Claude Code | A book skill plus `/aifirst-next`, `/aifirst-example` and `/aifirst-progress` commands |
| Codex | The same skill and slash commands |
| Antigravity | A plugin for both the IDE and the `agy` CLI |
| VS Code | Installs the AI First extension for you |

### Working through the book

Ask for your next exercise:

```bash
aifirst next
```

It shows the exercise and the prompt from the book. Type that prompt into your AI assistant and
compare what you get. When you want to see the book's version:

```bash
aifirst show py-2-06
```

Exercise ids look like `py-2-06` (Python, chapter 2, exercise 6) or `java-3-05`. You can also just
paste a prompt from the page and let the CLI find it:

```bash
aifirst search "Write a Hello World app"
```

To write the book's code straight into a file:

```bash
aifirst apply py-2-06
```

It picks a sensible filename, and it will never overwrite something you've already written.

### Once the skill is installed

You mostly won't need the commands above. Ask your assistant in plain language:

> *Show me exercise py-2-06 from the Python book*
>
> *What's my next AI First exercise?*
>
> *How far am I through the book?*

The skill tells your assistant to fetch the answer from the CLI and reproduce it exactly, instead of
writing its own version — which is what makes the code you see match the printed page.

### Tracking your progress

```bash
aifirst progress
```

Exercises are recorded when you apply one, when your assistant walks you through one, or by hand with
`aifirst done py-2-06`. Merely viewing an exercise doesn't count it.

This is your own record, kept in a plain file at `~/.aifirst/progress.json` that you can read, edit,
copy to another machine, or delete. It isn't sent anywhere and there's no grading.

Percentages count the exercises that exist today. Later chapters of both books are still being
written, so they aren't counted against you.

### Keeping up to date

```bash
aifirst update             # the CLI itself
aifirst update --content   # new and corrected book examples
```

Book content updates separately from the program, so corrections reach you without reinstalling.

### Troubleshooting

```bash
aifirst doctor
```

This reports which tools were found, whether the book skill is installed in each, where your progress
file lives, and which content version you have.

If `aifirst` isn't found after installing, the installer will have told you which line to add to your
shell profile — open a new terminal after adding it.

### Source

The CLI is open source at [github.com/aifirstprogramming/aifirstcli](https://github.com/aifirstprogramming/aifirstcli),
and the book content it serves lives at
[github.com/aifirstprogramming/aifirstcontent](https://github.com/aifirstprogramming/aifirstcontent).
