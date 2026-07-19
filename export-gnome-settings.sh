#!/usr/bin/env bash
# Exports GNOME settings to a dconf dump file.
# Run this from within the dotfiles directory to update the saved settings.
# Usage: ./export-gnome-settings.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTPUT="$SCRIPT_DIR/gnome-settings.dconf"

echo "Exporting GNOME settings..."
dconf dump /org/gnome/ > "$OUTPUT"
echo "✅ Saved to $OUTPUT"
echo ""
echo "To restore on another machine, run:"
echo "  dconf load /org/gnome/ < gnome-settings.dconf"
