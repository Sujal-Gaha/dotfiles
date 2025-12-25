# Dotfiles Setup Guide

This repository contains my personal configuration files (dotfiles), managed using **GNU Stow**.

The goal is simple:

-   Keep all configuration in one version-controlled place
-   Recreate my setup quickly on a new machine
-   Avoid tracking generated files or system-specific junk

If you are reading this because things broke or you cloned this on a fresh system, follow the steps below **in order**.

---

## Requirements

Make sure these are installed first:

-   `git`
-   `stow`

On Arch-based systems:

```sh
sudo pacman -S git stow
```

On Debian/Ubuntu:

```sh
sudo apt install git stow
```

---

## Repository Layout

Each top-level directory is a **stow package**:

```text
.dotfiles/
├── vim/        → Vim configuration
├── git/        → Git configuration
├── scripts/    → Helper scripts (not stowed)
└── README.md
```

Stow mirrors the directory structure **inside each package** into `$HOME`.

Example:

```text
vim/.vimrc                → ~/.vimrc
vim/.vim/coc-settings.json → ~/.vim/coc-settings.json
```

Only hand-written configuration files live here.
Generated files (plugins, caches, downloads) are intentionally excluded.

---

## First-Time Setup (New Machine)

### 1. Clone the repository

```sh
cd ~
git clone https://github.com/Sujal-Gaha/dotfiles.git .dotfiles
cd .dotfiles
```

---

### 2. Inspect before doing anything destructive

Always do a dry run first:

```sh
stow -n vim
stow -n git
```

This shows exactly what symlinks will be created.
If something looks wrong, **stop and fix the directory layout**.

---

### 3. Stow the packages

Once the dry run looks correct:

```sh
stow vim git
```

This will create symlinks in `$HOME` pointing back into `.dotfiles`.

---

## Vim Notes

-   Plugin directories such as `.vim/autoload` and `.vim/plugged` are **not tracked**
-   They are recreated automatically by the plugin manager

After stowing Vim configs, open Vim and install plugins:

```vim
:PlugInstall
```

(or the equivalent command for the plugin manager in use)

---

## Updating Configs

**Always edit files inside `.dotfiles`, never the symlink targets in `$HOME`.**

Example:

```sh
$HOME/.dotfiles/vim/.vimrc
```

Then commit changes normally:

```sh
git status
git commit -am "Update vim config"
```

---

## Adding a New Config

1. Create a new package directory:

```sh
mkdir zsh
```

2. Mirror the desired home path inside it:

```sh
zsh/.zshrc → ~/.zshrc
```

3. Dry run and stow:

```sh
stow -n zsh
stow zsh
```

---

## Important Warnings

-   Do **not** commit generated files (plugins, caches, history)
-   Do **not** use `stow --adopt` except for one-time migrations
-   If something goes wrong, `stow -D <package>` cleanly removes symlinks

---

## Recovery Checklist

If everything is broken and you’re panicking:

1. Clone the repo
2. Install `stow`
3. Run `stow -n <package>`
4. Run `stow <package>`
5. Regenerate plugins/tools as needed

Nothing in `$HOME` should be manually copied.

---

## Philosophy

-   Dotfiles track **intent**, not state
-   If a file can be regenerated, it doesn’t belong here
-   Simple layouts beat clever automation

If this repo feels boring, it’s doing its job.
