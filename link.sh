#!/usr/bin/env bash
# Symlink dotfiles from this repo into $HOME.
# Existing files are moved to <file>.bak first. Safe to re-run.
set -euo pipefail
cd "$(dirname "$0")"
REPO="$PWD"

# repo path                         -> home path
LINKS=(
  "shell/.zshrc                       .zshrc"
  "shell/.zprofile                    .zprofile"
  "shell/.zshenv                      .zshenv"
  "shell/.p10k.zsh                    .p10k.zsh"
  "shell/.bash_profile                .bash_profile"
  "shell/.profile                     .profile"
  "git/gitconfig                      .gitconfig"
  "git/ignore                         .config/git/ignore"
  "terminal/kitty                     .config/kitty"
  "terminal/herdr/config.toml         .config/herdr/config.toml"
  "terminal/herdr/plugins/config      .config/herdr/plugins/config"
  "editors/nvim                       .config/nvim"
  "editors/ideavimrc                  .ideavimrc"
  "macos/aerospace.toml               .aerospace.toml"
  "macos/yabairc                      .yabairc"
  "macos/skhdrc                       .skhdrc"
  "macos/karabiner                    .config/karabiner"
  "cli/btop/btop.conf                 .config/btop/btop.conf"
  "cli/gh/config.yml                  .config/gh/config.yml"
  "cli/qmd/index.yml                  .config/qmd/index.yml"
  "cli/litecli/config                 .config/litecli/config"
  "cli/mycli/myclirc                  .myclirc"
  "cli/psql/psqlrc                    .psqlrc"
  "claude/settings.json               .claude/settings.json"
  "claude/statusline.sh               .claude/statusline.sh"
  "claude/hooks                       .claude/hooks"
  "claude/skills/ponytail             .claude/skills/ponytail"
)

for entry in "${LINKS[@]}"; do
  read -r src dst <<<"$entry"
  target="$HOME/$dst"
  mkdir -p "$(dirname "$target")"
  if [ -e "$target" ] && [ ! -L "$target" ]; then mv "$target" "$target.bak"; fi
  ln -sfn "$REPO/$src" "$target"
  echo "linked ~/$dst"
done
