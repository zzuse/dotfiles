# dotfiles

Personal dotfiles for macOS and Linux, deployed with [rcm](https://github.com/thoughtbot/rcm).

Inspired by https://github.com/thoughtbot/dotfiles.

## How it works

`rcup` symlinks every top-level entry of `~/dotfiles` into `$HOME` with a dot
prefix — `zshrc` → `~/.zshrc`, `gitconfig` → `~/.gitconfig`. Directories recurse,
so `func/notify-send` → `~/.func/notify-send`. Nothing is copied; edits to the
repo take effect immediately.

After linking, `rcup` runs `hooks/post-up`, which clones oh-my-zsh, its plugins,
p10k, and the nvim config, and wires up the macOS apps that don't read dotfiles
from `$HOME` (VSCode, Rime).

Shell startup chain:

```
~/.zshrc                 main entry — oh-my-zsh, plugins, p10k, banner
  └─ ~/.func/*           shell functions, sourced explicitly by name
  └─ ~/.zshrc-$(uname)   per-OS config: PATH, aliases, functions
       └─ ~/.aliases     shared aliases
       └─ ~/.logout      runs on shell exit via `trap`
```

## Two directories for code

They look similar and are not interchangeable:

| | `func/` | `do/` |
|---|---|---|
| Becomes | `~/.func/` | `~/.do/` |
| Contains | shell **function** definitions | **executable** scripts |
| Reached by | `source` line in `zshrc` | `$PATH` |
| Runs in | your current shell | a subprocess |

**`func/` — sourced functions.** Definitions that must run in the current shell
(they change its state, or you want them available as shell functions). Not on
`$PATH`. Each file needs an explicit line in `zshrc`; there is no glob loop, so
a new file is inert until you add one:

```zsh
source ~/dotfiles/func/notify-send
```

**`do/` — executables on `$PATH`.** Standalone scripts with a shebang and the
executable bit. `~/.do` is already on `$PATH` (`zshrc-Darwin:3`), so anything
dropped in here is callable by name after `rcup` — no config change needed:

```sh
chmod +x do/newscript
env RCRC=$HOME/dotfiles/rcrc rcup do
newscript --help
```

Caveat: `~/.do` is only added to `$PATH` on macOS. To use it on Linux, add it to
`zshrc-Linux` as well.

## What's in here

### Shell

| File | Purpose |
|---|---|
| `zshrc` | Main entry. oh-my-zsh, p10k theme, plugins, ASCII banner |
| `zshrc-Darwin` | macOS: `$PATH`, aliases, `finc`/`ew`/`cdf` helpers, pyenv, Go |
| `zshrc-Linux` | Linux equivalent |
| `aliases` | Shared aliases; also sources `~/.aliases.local` if present |
| `logout` | Session summary on exit; appends to `~/.logout_history` |
| `func/notify-send` | Push a DingTalk notification. Needs `$DINGBOTTOKEN` |
| `do/brainstorm` | SSH to the dev host, show git state, open Claude Code |
| `do/icloud-sync` | AppleScript (`#!/usr/bin/osascript`) that opens System Settings on the iCloud Drive "Apps syncing" pane. Needs Accessibility permission for the calling process |

### Tool configs

| File | Purpose |
|---|---|
| `gitconfig`, `gitignoreglobal` | git |
| `vimrc`, `vimrc.bundles` | vim / vim-plug |
| `tmux.conf` | tmux |
| `clang-format` | Read automatically by `clang-format` |
| `gdbinit` | Read automatically by `gdb` |
| `default.custom.yaml` | Rime input method. Linked into `~/Library/Rime` by `post-up` |
| `vscode-settings.json` | Linked into VSCode's User dir by `post-up` |
| `yabairc`, `skhdrc` | yabai WM + skhd hotkeys (both run as launchd agents) |

### Setup

| File | Purpose |
|---|---|
| `rcrc` | rcm config: `EXCLUDES` and `DOTFILES_DIRS` |
| `bootstrap.sh` | Fresh macOS: brew/port, packages, shell, then `rcup` |
| `hooks/post-up` | Run automatically by `rcup` |
| `install_tmux.sh` | Multi-platform tmux build. Called by `post-up` |
| `Brewfile` | `brew bundle` / `brew bundle dump` |

### Not in use

Kept for reference, but nothing invokes these:

| File | Why |
|---|---|
| `zshrc-Brain` | Old work machine (megface paths). `post-up` deletes `~/.zshrc-Brain`; the `source` block in `zshrc:58-60` is commented out |
| `zshrc-VM` | Same — `post-up` deletes it, `zshrc:61-63` commented out |
| `auto-git-pull.sh` | Referenced only inside a commented-out block of `~/Library/LaunchAgents/com.user.autogitpull.plist`. That job is not loaded, and the plist fails `plutil -lint` |
| `tunes.scpt` | Now-playing for iTunes, which no longer exists. No references |
| `dircolors` | Only use is the commented-out `eval $(dircolors ...)` at `zshrc-Linux:28` |
| `vscode-extensions.txt` | The install line at `hooks/post-up:13` is commented out |
| `vscode-keybindings.json` | Linked to `~/.vscode-keybindings.json`, but `post-up` only links `settings.json` into VSCode — this never reaches the editor |
| `tmux_attach.sh` | Works, but nothing calls it. Run by hand if wanted |

Also stale, inside otherwise-live files:

* `power()` (`zshrc-Darwin:26`) switches to the powerlevel9k theme, but `ZSH_THEME` is powerlevel10k.
* `EXCLUDES` in `rcrc` lists `tmux`, but no entry by that name exists.
* `.gitignore` has `!bin`, a negation with no matching ignore rule and no `bin/` directory.

## Install

### 1. Get rcm

macOS: `brew install rcm` (the old `brew tap thoughtbot/formulae` step is no
longer needed) or `sudo port install rcm`.

Ubuntu:

```sh
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
sudo apt-get update
sudo apt-get install rcm
```

On Ubuntu 16.04 with python3.6, you may first need:

```sh
cd /usr/lib/python3/dist-packages
ln -s apt_pkg.cpython-35m-x86_64-linux-gnu.so apt_pkg.cpython-36m-x86_64-linux-gnu.so
```

CentOS:

```sh
cd /etc/yum.repos.d/
wget https://download.opensuse.org/repositories/utilities/RHEL_7/utilities.repo
yum install rcm
```

From source, for old machines with openssl trouble:

```sh
wget http://curl.haxx.se/ca/cacert.pem
curl --cacert cacert.pem -LO https://thoughtbot.github.io/rcm/dist/rcm-1.2.3.tar.gz
tar -xvf rcm-1.2.3.tar.gz
cd rcm-1.2.3 && ./configure && make && make install
```

### 2. Deploy

```sh
git clone https://github.com/zzuse/dotfiles.git
env RCRC=$HOME/dotfiles/rcrc rcup
```

Safe to re-run any time. Limit it to one entry with `rcup do`. On a fresh macOS
box, `./bootstrap.sh` installs the packages first, then does this.

Sensitive values live in a separate private repo — point `RCRC` at that repo's
`rcrc` to layer it on top.

## Working on the dotfiles

Edit files in `~/dotfiles` directly (the symlinks mean changes are already
live), then:

```sh
git add XXX && git commit && git push origin master
```

`mkrc` adds to `dotfiles-local` by default. To adopt an existing dotfile into
this repo instead:

```sh
mkrc -d dotfiles .XXX
```

which moves `~/.XXX` to `dotfiles/XXX` and symlinks it back.

## Deprecated

Backing up app plists with [mackup](https://github.com/lra/mackup) is no longer
used. It's still handy on Linux; on macOS, install apps as needed and use
`brew bundle dump` to refresh the `Brewfile`.

## LICENSE

MIT
