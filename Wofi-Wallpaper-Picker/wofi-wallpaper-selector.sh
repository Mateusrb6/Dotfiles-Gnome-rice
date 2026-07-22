#!/usr/bin/env bash

############################
# CONFIGURAÇÃO
############################

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper-selector"
SHELL_THEME_SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/Pywal-Gnome-Shell-Theme/generate-shell-theme.sh"

THUMBNAIL_WIDTH="250"
THUMBNAIL_HEIGHT="141"

# Cria diretório de cache se não existir
mkdir -p "$CACHE_DIR"

# Evita erros caso a pasta de wallpapers esteja vazia
shopt -s nullglob

############################
# VERIFICAÇÃO DE DEPENDÊNCIAS
############################

MISSING=()
for cmd in wofi gsettings wal; do
    command -v "$cmd" &>/dev/null || MISSING+=("$cmd")
done
# ImageMagick: aceita magick (v7) ou convert (v6)
if ! command -v magick &>/dev/null && ! command -v convert &>/dev/null; then
    MISSING+=("ImageMagick")
fi

if [[ ${#MISSING[@]} -gt 0 ]]; then
    echo "Erro: dependências não encontradas: ${MISSING[*]}" >&2
    exit 1
fi

############################
# FUNÇÕES
############################

generate_thumbnail() {
    local input="$1"
    local output="$2"
    
    # Verifica se usa 'magick' (v7) ou 'convert' (v6)
    local cmd="magick"
    if ! command -v magick &> /dev/null; then
        cmd="convert"
    fi

    "$cmd" "$input" -auto-orient \
        -thumbnail "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}^" \
        -gravity center \
        -extent "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" \
        "$output"
}

############################
# GERAÇÃO DO MENU
############################

generate_menu() {
    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
        [[ -f "$img" ]] || continue

        # Pega o nome do arquivo sem extensão (ex: 'paisagem')
        base_name=$(basename "${img%.*}")
        thumbnail="$CACHE_DIR/$base_name.png"

        # Gera thumbnail se não existir ou se a imagem original for mais nova
        if [[ ! -f "$thumbnail" ]] || [[ "$img" -nt "$thumbnail" ]]; then
            generate_thumbnail "$img" "$thumbnail"
        fi

        # Envia para o Wofi: Ícone + Nome do arquivo
        echo -en "img:$thumbnail\x00info:$base_name\n"
    done
}

# Executa o Wofi e guarda o resultado bruto
selected_raw=$(generate_menu | wofi --show dmenu \
    --cache-file /dev/null \
    --define "image-size=${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" \
    --columns 3 \
    --allow-images \
    --insensitive \
    --sort-order=default \
    --prompt "Select Wallpaper" \
    --conf ~/.config/wofi/wallpaper.conf)

############################
# PROCESSAMENTO DA ESCOLHA
############################

final_path=""

if [[ -n "$selected_raw" ]]; then
    # 1. O Wofi retorna algo como: "img:/caminho/cache/foto.png"
    # Removemos o prefixo "img:"
    clean_selection="${selected_raw#img:}"
    
    # 2. Pegamos apenas o nome do arquivo da thumbnail (ex: 'foto.png')
    thumb_filename=$(basename "$clean_selection")
    
    # 3. Removemos a extensão para ter apenas o nome base (ex: 'foto')
    filename_no_ext="${thumb_filename%.*}"

    # 4. Buscamos o arquivo original na pasta de wallpapers correspondente a esse nome
    # Isso garante que pegamos o arquivo certo seja ele .jpg, .jpeg ou .png
    final_path=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -name "$filename_no_ext.jpg" -o -name "$filename_no_ext.jpeg" -o -name "$filename_no_ext.png" \) | head -n 1)
fi

############################
# APLICAÇÃO (GNOME + PYWAL)
############################

if [[ -n "$final_path" && -f "$final_path" ]]; then

    echo "Aplicando wallpaper: $final_path"
    uri="file://$final_path"

    # 1. Define Wallpaper no GNOME
    gsettings set org.gnome.desktop.background picture-uri "$uri"
    gsettings set org.gnome.desktop.background picture-uri-dark "$uri"
    gsettings set org.gnome.desktop.screensaver picture-uri "$uri"

    # Limpa cache antigo do Pywal
    rm -rf "$HOME/.cache/wal/schemes"

    # 2. Gera cores com Pywal
    wal -i "$final_path" -n -q -t --backend haishoku --saturate 0.4

    # 3. Atualiza Firefox (Pywalfox)
    pywalfox update
    
    # 4. Força atualização visual do sistema (Libadwaita/GTK4)
    touch "$HOME/.config/gtk-4.0/gtk.css"
    touch "$HOME/.config/gtk-3.0/gtk.css"

    # 5. Atualiza o tema do GNOME Shell (Quick Settings, painel, etc.)
    if [[ -x "$SHELL_THEME_SCRIPT" ]]; then
        "$SHELL_THEME_SCRIPT" || echo "Aviso: falha ao atualizar o tema do GNOME Shell." >&2
    fi

else
    # Caso cancele o menu ou ocorra erro
    echo "Nenhuma imagem selecionada."
fi