# dotfiles

Personal macOS setup: shell, terminal, editors, window management, CLI tools, Claude Code, Obsidian.

## Layout

| Folder | What's in it | Lives at |
|---|---|---|
| `shell/` | zsh (oh-my-zsh + powerlevel10k), bash/profile | `~/.zshrc`, `~/.p10k.zsh`, ... |
| `git/` | git config (delta pager), global ignore | `~/.gitconfig`, `~/.config/git/ignore` |
| `terminal/kitty/` | kitty config, theme, tabs, open-actions | `~/.config/kitty/` |
| `terminal/herdr/` | herdr config, plugin list, plugin settings | `~/.config/herdr/` |
| `editors/nvim/` | Neovim (AstroNvim) | `~/.config/nvim/` |
| `editors/ideavimrc` | IdeaVim for JetBrains | `~/.ideavimrc` |
| `jetbrains/` | IntelliJ CE + PyCharm CE: keymaps, code style, editor/font/theme/vim options, plugin list, vmoptions | import by hand (see below) |
| `macos/` | AeroSpace, yabai, skhd, Karabiner | `~/.aerospace.toml`, `~/.yabairc`, `~/.skhdrc`, `~/.config/karabiner/` |
| `cli/` | btop, gh, qmd, mycli, psql, litecli | `~/.config/...`, `~/.myclirc`, `~/.psqlrc` |
| `claude/` | Claude Code settings, statusline, herdr hook, personal skill (`ponytail`) | `~/.claude/` |
| `obsidian/.obsidian/` | Obsidian app config: plugins + their settings, hotkeys, themes, snippets | `<vault>/.obsidian/` |
| `Brewfile` | everything installed via Homebrew | `brew bundle` |

## Restore on a new machine

```sh
# 1. Homebrew + every package/app
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --file=Brewfile

# 2. oh-my-zsh + powerlevel10k (zshrc expects both)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# 3. Symlink configs into $HOME (existing files get a .bak)
./link.sh

# 4. Secrets: put any tokens/passwords in ~/.secrets.zsh (untracked, sourced by .zshrc)
```

**Obsidian:** copy (don't symlink) into the vault: `cp -R obsidian/.obsidian "<vault>/"`.

**JetBrains:** install the IDE, then copy `keymaps/`, `codestyles/` and `options/*.xml` into
`~/Library/Application Support/JetBrains/<IDE><version>/` while the IDE is closed.
Reinstall plugins from `installed-plugins.txt`.

**herdr plugins:** `plugins.json` lists them; herdr re-downloads them. Only `plugins/config/` is tracked.

## Not tracked on purpose

- SSH keys, `gh` auth (`hosts.yml`), cloud credentials, API tokens.
- Caches, logs, sessions, history files.

## Candidates for cleanup

In `shell/.zshrc`:
- Multiple competing MySQL `PATH`/`LDFLAGS` blocks (mysql-client, mysql, mysql@8.0)

Across `shell/` profile files: `. "$HOME/.cargo/env"` is sourced 3 times; the MacPorts PATH in `.zprofile` is unused if you only use Homebrew.

`terminal/kitty/kitty.conf` is the full 100 KB commented default file; only a few lines are actual settings.
