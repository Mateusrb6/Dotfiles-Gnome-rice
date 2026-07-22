#!/usr/bin/env bash
# Gera um tema do GNOME Shell (gnome-shell.css) a partir das cores atuais do
# pywal e o ativa via a extensão "User Themes". Também ajusta o accent-color
# nativo do GNOME (org.gnome.desktop.interface accent-color) para a cor
# nomeada mais próxima do accent do pywal.
#
# Uso: generate-shell-theme.sh
# Requer que 'wal' já tenha rodado (lê ~/.cache/wal/colors.json).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SASS_SRC="$SCRIPT_DIR/sass"
THEME_NAME="pywal"
THEME_DIR="$HOME/.local/share/themes/$THEME_NAME/gnome-shell"
WAL_COLORS_JSON="$HOME/.cache/wal/colors.json"

for cmd in sassc python3 dconf; do
    command -v "$cmd" &>/dev/null || { echo "Erro: '$cmd' não encontrado." >&2; exit 1; }
done

if [[ ! -f "$WAL_COLORS_JSON" ]]; then
    echo "Erro: $WAL_COLORS_JSON não encontrado (rode 'wal' antes)." >&2
    exit 1
fi

BG=$(python3 -c "import json; print(json.load(open('$WAL_COLORS_JSON'))['special']['background'])")
ACCENT=$(python3 -c "import json; print(json.load(open('$WAL_COLORS_JSON'))['colors']['color4'])")

BUILD_DIR="$(mktemp -d)"
trap 'rm -rf "$BUILD_DIR"' EXIT

cp -r "$SASS_SRC"/. "$BUILD_DIR/"
sed -i "s/__WAL_BG__/${BG}/" "$BUILD_DIR/gnome-shell-sass/_default-colors.scss"

mkdir -p "$THEME_DIR"
sassc -t compressed "$BUILD_DIR/gnome-shell-dark.scss" "$THEME_DIR/gnome-shell.css"

# A extensão User Themes só recarrega quando o valor da chave muda de fato,
# então alterna vazio -> nome para forçar o reload mesmo se já estava ativo.
dconf write /org/gnome/shell/extensions/user-theme/name "''"
dconf write /org/gnome/shell/extensions/user-theme/name "'$THEME_NAME'"

ACCENT_NAME=$(python3 "$SCRIPT_DIR/nearest-accent.py" "$ACCENT")
gsettings set org.gnome.desktop.interface accent-color "$ACCENT_NAME"

echo "Tema do GNOME Shell atualizado (bg=$BG, accent=$ACCENT -> $ACCENT_NAME)."
