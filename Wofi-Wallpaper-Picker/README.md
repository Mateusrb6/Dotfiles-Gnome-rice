# Wofi Wallpaper Picker

This Wofi widget allows for previewing multiple wallpapers and choosing one to be set. The wallpapers are set using **gsettings** (GNOME) and color palettes are generated with **pywal16**.

![Wallpaper Picker](https://raw.githubusercontent.com/Mateusrb6/Dotfiles-Gnome-rice/main/assets/wofi-wallpaper-selector1.png)

### Dependencies

This script requires the following tools:

| Tool | Purpose |
| --- | --- |
| `wofi` | Application launcher / menu |
| `ImageMagick` (`magick` or `convert`) | Thumbnail generation |
| `pywal16` (`wal`) | Color palette generation from wallpaper |
| `pywalfox` | Applies pywal colors to Firefox |
| `gsettings` | Sets GNOME wallpaper |

This will only work on **GNOME Wayland**.

### Installation

1. Clone the repo
2. Copy `wofi/wallpaper.conf` to `~/.config/wofi/`
3. Make the script executable:
   ```bash
   chmod +x wofi-wallpaper-selector.sh
   ```
4. Run the script

The script automatically checks `~/Pictures/wallpapers` for wallpapers. Change the `WALLPAPER_DIR` variable if you have a different path.

### Usage

You can launch the wallpaper selector by:
- Running the script directly
- Using wofi (`Super+Space`) and searching for "Wallpaper Selector"
- Binding it to a keyboard shortcut (e.g., `Alt+W`)

### Credits

This is a personal fork of [highonskooma/Wofi-Wallpaper-Picker](https://github.com/highonskooma/Wofi-Wallpaper-Picker), adapted for GNOME with pywal16 integration.
