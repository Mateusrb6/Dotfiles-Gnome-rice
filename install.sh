#!/usr/bin/env bash
set -euo pipefail

############################
# CORES
############################
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

info()  { echo -e "${GREEN}[✔]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[✘]${NC} $1"; }

############################
# SYMLINKS — .config
############################
echo ""
echo "══════════════════════════════════════"
echo "  Dotfiles Installer — GNOME Rice"
echo "══════════════════════════════════════"
echo ""

CONFIG_DIRS=("fastfetch" "kitty" "wofi" "gtk-3.0" "gtk-4.0")

for dir in "${CONFIG_DIRS[@]}"; do
    src="$DOTFILES_DIR/.config/$dir"
    dest="$HOME/.config/$dir"

    if [[ ! -d "$src" ]]; then
        warn "Source not found, skipping: $src"
        continue
    fi

    # Backup existing directory if it's not already a symlink
    if [[ -d "$dest" && ! -L "$dest" ]]; then
        backup="$dest.bak.$(date +%s)"
        warn "Backing up existing $dest → $backup"
        mv "$dest" "$backup"
    fi

    ln -sfn "$src" "$dest"
    info "Linked $dest → $src"
done

############################
# SYMLINK — .zshrc
############################
if [[ -f "$DOTFILES_DIR/zsh/.zshrc" ]]; then
    if [[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
        backup="$HOME/.zshrc.bak.$(date +%s)"
        warn "Backing up existing ~/.zshrc → $backup"
        mv "$HOME/.zshrc" "$backup"
    fi

    ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
    info "Linked ~/.zshrc → $DOTFILES_DIR/zsh/.zshrc"
fi

############################
# WALLPAPER SELECTOR
############################
WALLPAPER_SCRIPT="$DOTFILES_DIR/Wofi-Wallpaper-Picker/wofi-wallpaper-selector.sh"
if [[ -f "$WALLPAPER_SCRIPT" ]]; then
    chmod +x "$WALLPAPER_SCRIPT"
    info "Made wallpaper selector executable"
fi

############################
# WALLPAPERS
############################
WALLPAPER_SRC="$DOTFILES_DIR/wallpapers"
WALLPAPER_DEST="$HOME/Pictures/wallpapers"

if [[ -d "$WALLPAPER_SRC" ]]; then
    mkdir -p "$WALLPAPER_DEST"
    cp -n "$WALLPAPER_SRC"/* "$WALLPAPER_DEST"/ 2>/dev/null || true
    info "Copied wallpapers to $WALLPAPER_DEST (existing files preserved)"
fi

############################
# GNOME SETTINGS (dconf)
############################
DCONF_FILE="$DOTFILES_DIR/gnome-settings.dconf"
if [[ -f "$DCONF_FILE" ]]; then
    read -rp "$(echo -e "${YELLOW}[?]${NC} Load GNOME settings from dconf dump? This will overwrite current GNOME settings. [y/N] ")" answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        dconf load /org/gnome/ < "$DCONF_FILE"
        info "GNOME settings loaded from $DCONF_FILE"
    else
        warn "Skipped GNOME settings import"
    fi
fi

echo ""
info "Dotfiles installed successfully! 🎉"
echo ""
