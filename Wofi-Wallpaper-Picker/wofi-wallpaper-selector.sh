#!/usr/bin/env bash

############################
# CONFIGURAÇÃO
############################

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper-selector"

THUMBNAIL_WIDTH="250"
THUMBNAIL_HEIGHT="141"

# Diretório do próprio script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$SCRIPT_DIR/assets"

mkdir -p "$CACHE_DIR"

############################
# FUNÇÕES
############################

generate_thumbnail() {
    local input="$1"
    local output="$2"
    # Adicionei -auto-orient para evitar fotos deitadas
    magick "$input" -auto-orient \
        -thumbnail "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}^" \
        -gravity center \
        -extent "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" \
        "$output"
}

############################
# MENU WOFi
############################

generate_menu() {
    

    for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
        [[ -f "$img" ]] || continue

        thumbnail="$CACHE_DIR/$(basename "${img%.*}").png"

        if [[ ! -f "$thumbnail" ]] || [[ "$img" -nt "$thumbnail" ]]; then
            generate_thumbnail "$img" "$thumbnail"
        fi

        echo -en "img:$thumbnail\x00info:$(basename "$img")\x1f$img\n"
    done
}

selected=$(generate_menu | wofi --show dmenu \
    --cache-file /dev/null \
    --define "image-size=${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" \
    --columns 3 \
    --allow-images \
    --insensitive \
    --sort-order=default \
    --prompt "Select Wallpaper" \
    --conf ~/.config/wofi/wallpaper.conf
)

############################
# APLICA WALLPAPER E CORES
############################

if [[ -n "$selected" ]]; then

    if [[ "$selected" == *"RANDOM"* ]]; then
        original_path=$(find "$WALLPAPER_DIR" -type f \( \
            -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \
        \) | shuf -n 1)
    else
        # Lógica de limpeza ajustada para garantir leitura correta
        clean_path="${selected#img:}"
        
        # Tenta pegar o caminho limpo após o caractere invisível do wofi
        extracted_path=$(echo "$selected" | awk -F'\x1f' '{print $NF}')
        
        if [[ -f "$extracted_path" ]]; then
            original_path="$extracted_path"
        elif [[ "$clean_path" == "$CACHE_DIR"* ]]; then
            base_name="$(basename "${clean_path%.*}")"
            original_path=$(find "$WALLPAPER_DIR" -type f -iname "$base_name.*" | head -n 1)
        else
            original_path="$clean_path"
        fi
    fi

    if [[ -n "$original_path" && -f "$original_path" ]]; then
        uri="file://$original_path"

        # 1. Aplica Wallpaper no GNOME
        gsettings set org.gnome.desktop.background picture-uri "$uri"
        gsettings set org.gnome.desktop.background picture-uri-dark "$uri"
        gsettings set org.gnome.desktop.screensaver picture-uri "$uri"

	# Limpeza de cache
        rm -rf "$HOME/.cache/wal/schemes"

        # 2. Gera paleta com pywal16
        wal -i "$original_path" -n -q -t --backend haishoku --saturate 0.4

	    #aplica tema no firefox
	    pywalfox update
        
        # 3. ATUALIZAÇÃO DO SISTEMA (Novo: Força o GNOME a reler as cores)
        # Sem isso, as cores só mudam se você fizer logout
        touch "$HOME/.config/gtk-4.0/gtk.css"
        touch "$HOME/.config/gtk-3.0/gtk.css"
    fi
fi
