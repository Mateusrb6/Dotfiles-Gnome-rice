# Fedora Gnome Rice

<details>
<summary>📸 Show Screenshots</summary>
<table align="center">
  <tr>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Mateusrb6/Dotfiles-Gnome-rice/main/assets/Screenshot2.png" alt="forge1" width="500">
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Mateusrb6/Dotfiles-Gnome-rice/main/assets/Screenshot1.png" alt="forge2" width="500">
    </td>
  </tr>
</table>

</details>

### GNOME Extensions

<details>
<summary> Blur My Shell </summary>
Adds blur effects to the GNOME Shell interface, including the top panel and other UI elements.
</details>

<details>
<summary> Just Perfection </summary>
Customizes GNOME Shell appearance by hiding or showing various UI elements like the activities button, clock, and more.
</details>

<details>
<summary> Gnome 4x UI Improvements </summary>
Enhances GNOME 40+ UI with various visual and functional improvements to the shell experience.
</details>

<details>
<summary> Logo Menu </summary>
Replaces the Activities button with a custom logo or menu button for quick access to applications and system features.
</details>

<details>
<summary> Media Controls </summary>
Displays media player controls in the GNOME Shell for quick access to play, pause, and skip functions.
</details>

<details>
<summary> Open Bar </summary>
Adds a customizable bar to the GNOME Shell for quick application launching and window management.
</details>

<details>
<summary> Space Bar </summary>
Displays workspaces in the top bar for easy navigation and workspace switching.
</details>

<details>
<summary> Top Bar Organizer </summary>
Allows customization of the top bar layout, including repositioning and hiding elements.
</details>

<details>
<summary> User Themes </summary>
Enables the use of custom GTK and GNOME Shell themes.
</details>

<details>
<summary> Vitals </summary>
Shows system vitals like CPU, memory, and temperature in the top bar.
</details>

<details>
<summary> AppIndicator and KStatusNotifierItem Support </summary>
Adds support for legacy application indicators in the system tray area.
</details>

<details>
<summary> Places status indicator </summary>
Displays quick access to system places like home folder, desktop, and mounted drives in the top bar.
</details>

<details>
<summary> Lockscreen Background </summary>
Customizes the lockscreen background image or wallpaper.
</details>

### Applications

- 🎧 **Vencord**  
  **What:** [Vencord](https://github.com/Vendicated/Vencord) is a client-side Discord modification that adds plugins, themes and extra UI tweaks for the Discord desktop/web clients.  
  **Install on Fedora:** 
  - Open your terminal and run the following command. Then follow the instructions in your terminal.
  ```
         sh -c "$(curl -sS https://vencord.dev/install.sh)"
  ```
  > ⚠️ Modifying clients can break the official app and may violate terms of service; use at your own risk.
  
  **Usage:**
    - After installing Vencord, you can access configurations of discord to select themes and plugins from Vencord.

    ![Material Discord theme](https://raw.githubusercontent.com/Mateusrb6/Dotfiles-Gnome-rice/main/assets/material-discord-theme.png)
- 🎶 **Spicetify**  
  **What:** [Spicetify](https://github.com/spicetify/cli) is a CLI tool to customize and theme the Spotify desktop client (also supports Flatpak installs with extra steps).  
  **Install on Fedora:**
  - Use curl to install.

  ```
          curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
  ```
  - After installing Spicetify and Marketplace, you can customize Spotify using themes and extensions from the Marketplace tab in Spotify's sidebar.
  **Usage:**
  - Install Blossom theme using spicetify marketplace. 

  ![Blossom](https://github.com/spicetify/spicetify-themes/blob/master/Blossom/images/home.png?raw=true)

- 🍜 **Wofi**  
  **What:** [Wofi](https://hg.sr.ht/~sircmpwn/wofi) is a lightweight application launcher for Wayland (wlroots compositors), similar to `rofi`/`dmenu`. Use it to run commands, launch desktop apps (`drun`), or display custom menus.
  **Install on Fedora:**
  - Install from Fedora repositories: 
  ```
          sudo dnf install wofi
  ```
  **Usage:**   
  - Paste the .config/wofi into ~/.config/wofi. The script wofi-wallpaper-selector.sh calls wofi to show the thumbnail of available wallpapers — don’t forget to set the right path to your wallpaper directory.

  > ⚠️ Wofi requires a Wayland compositor (e.g., Sway); it won't run on a pure X11 session without a Wayland compatibility layer.

  ![Wofi](https://raw.githubusercontent.com/Mateusrb6/Dotfiles-Gnome-rice/main/assets/wofi.png)

- 🎨 **pywal16**  
  **What:** A small utility (fork/variant of `pywal`) that generates 16-color palettes from an image and applies them to your terminal, GTK themes and other supported apps to create a cohesive colour scheme. Useful for matching your desktop and apps to your wallpaper.
  **Install on Fedora:**
  - Using pip: `pip install pywal16`  

  **Usage:** The script wofi-wallpaper-selector use pywal16 to generate color-palletes based on the current wallpaper.

  <h3 align="center"><img src="https://i.imgur.com/5WgMACe.gif" width="200px"></h3>

 - 🐚 **Oh My Zsh**  
  **What:** [Oh My Zsh](https://ohmyz.sh/) is a delightful, open source, community-driven framework for managing your Zsh configuration. It comes bundled with hundreds of helpful functions, helpers, plugins, and themes.  
  **Install on Fedora:**
    - Using curl:
     ```
            curl -fsSL https://linux.toys/install.sh | bash
     ``` 
    **Usage:** After installation, your `.zshrc` file will be automatically configured. You can customize it by:
      1. Enabling plugins: Uncomment or add plugins to the `plugins=()` line in `~/.zshrc`
      2. Changing themes: Set `ZSH_THEME="refined"` in `~/.zshrc` 
      3. Plugins: `git`, `zsh-syntax-highlighting`, `zsh-autosuggestions`

    ![Oh My Zsh!](https://raw.githubusercontent.com/Mateusrb6/Dotfiles-Gnome-rice/main/assets/ohmyzsh-logo-ansi.png)

- ⭐ **fastfetch**  
  **What:** [fastfetch](https://github.com/fastfetch/fastfetch) is a fast, lightweight system information tool (similar to `neofetch`) that prints concise system details and an optional ASCII logo to the terminal. It's optimized for speed and low resource usage.
  **Install on Fedora:**
    - Install from Fedora repositories if available: `sudo dnf install fastfetch`

    **Usage:** You can type fastfetch in your terminal to see anytime you want and add to zsh configurations to see it everytime the terminal opens.
    1. Open .zshrc in a text editor like nano.
    2. Add the following block at the end of the file:
    ```
            if [[ -o interactive && -z "$FASTFETCH_SHOWN" && -z "$SSH_CONNECTION" ]]; then
            export FASTFETCH_SHOWN=1
            fastfetch
            fi
    ```
    3. Save the file and open a new terminal.

    ![Fastfetch](https://raw.githubusercontent.com/Mateusrb6/Dotfiles-Gnome-rice/main/assets/fastfetch.png)
+ 🛠️ **LinuxToys** 

  **What:** [LinuxToys](https://github.com/psygreg/linuxtoys) is a collection of user-friendly tools designed for Linux systems. It aims to make powerful Linux functionality accessible to all users through an intuitive interface.  
  **Install on Fedora:** 
  
  - Automatic instalation: The simplest way to install LinuxToys is by using the automated installation script. Open your terminal and run:
     ```
         curl -fsSL https://linux.toys/install.sh | bash
     ``` 
  - Copr: 
    ``` 
        sudo dnf copr enable psygreg/linuxtoys
        sudo dnf install linuxtoys 
    ```
    ![LinuxToys](https://raw.githubusercontent.com/Mateusrb6/Dotfiles-Gnome-rice/main/assets/linux-toys.png)


 ### Scripts

- 🖌️ **wofi-wallpaper-selector.sh**  
  **What:** [Wofi wallpaper selector](https://github.com/Mateusrb6/Dotfiles-Gnome-rice) is a script that changes wallpaper and color schemes based on the palette of the current photo. It uses wofi, pywal16, pywalfox (extension for firefox), and ImageMagick.  
  **Install on Fedora:**
    - Download the script from this repository's folder.
    - Make it executable: `chmod +x wofi-wallpaper-selector.sh`
  
  **Usage:**
    - Create a `.desktop` file to launch the script via shortcut:
      1. Open `~/.local/share/applications/wofi-wallpaper-selector.desktop` in a text editor.
      2. Add the following:
      ```
              [Desktop Entry]
              Type=Application
              Name=Wofi Wallpaper Selector
              Exec=/path/to/wofi-wallpaper-selector.sh
              Icon=preferences-desktop-wallpaper
              NoDisplay=true
      ```
      3. Replace `/path/to/` with the actual script path.
      4. Launch with: `gtk-launch wofi-wallpaper-selector.desktop` or bind it to `Alt+W` in keyboard shortcuts.
    - You can also launch wofi-wallpaper-selector using wofi, just need to press Super+Space (shortcut of wofi), then search for wallpaper selector.

    ![Wallpaper selector](https://raw.githubusercontent.com/Mateusrb6/Dotfiles-Gnome-rice/main/assets/wofi-wallpaper-selector.png)




 ### Keyboard shortcuts

| Name             | Command                                         | Shortcut    |
| ---------------- | ----------------------------------------------- | ----------- |
| File Manager     | `nautilus`                                      | `Super+F` |
| Wallpaper Picker | `gtk-launch wallpaper-selector.desktop` | `Alt+W`   |
| Terminal         | `kitty`                                         | `Super+T` |
| wofi             | `wofi`                                          | `Super+Space`|



🚧🚧🚧 Under Construction 🚧🚧🚧