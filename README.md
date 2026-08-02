# Arch Linux Rice

My desktop setup for Arch Linux. Managed with [chezmoi](https://www.chezmoi.io/).

## What it includes

**Desktop Environment**
- KDE Plasma 6 with Wayland
- Hyprland tiling window manager
- Ghostty terminal
- Waybar for panels

**Visual**
- Catppuccin Mocha theme throughout
- Custom GTK and Qt colors
- Papirus icons with Catppuccin variant

**Prompt & Shell**
- Starship for shell prompt
- Bash with aliases and utilities
- Fastfetch on shell startup

**Software**
- Brave and Firefox for browsing
- VS Code and Kate for editing
- Discord, Signal, Jellyfin, Obsidian, Blender
- Docker and Steam
- NVIDIA drivers and CUDA

See `pkglist.txt` for pacman packages and `aurlist.txt` for AUR packages.

## Install

**Quick path (automated)**

```bash
curl -fsLS https://raw.githubusercontent.com/caedvx/chezmoi-rice/master/install.sh | bash
```

Or with a specific repo URL:
```bash
bash install.sh https://github.com/caedvx/chezmoi-rice.git
```

The script:
- Installs chezmoi if needed
- Shows changes before applying
- Asks for confirmation

**Manual path**

1. Clone this repo: `git clone https://github.com/caedvx/chezmoi-rice.git ~/dotfiles`
2. Install [chezmoi](https://www.chezmoi.io/install/)
3. Apply: `chezmoi init --apply ~/dotfiles`

## What chezmoi does

Chezmoi copies files from this repo to your home directory. File names use chezmoi's naming:
- `dot_bashrc` → `~/.bashrc`
- `dot_config/ghostty/config` → `~/.config/ghostty/config`
- `private_kdeglobals` → `~/.config/kdeglobals` (marked as private)

## Update after changes

After you modify a file in your home directory:
```bash
chezmoi diff              # See what changed
chezmoi add ~/.bashrc     # Add to repo
chezmoi apply             # Apply to home if needed
```

## Customize for your system

Before applying, edit these files to match your setup:

- **pkglist.txt**: Remove packages you don't want
- **aurlist.txt**: Remove AUR packages
- **dot_config/fastfetch/config.jsonc**: CPU, GPU, theme settings
- **dot_config/ghostty/config**: Terminal colors, font
- **dot_config/starship.toml**: Prompt style

## Key files

- `dot_bashrc` — Shell config with aliases and starship init
- `dot_config/starship.toml` — Shell prompt (clean, single line)
- `dot_config/gtk-3.0/colors.css` — GTK theming with Catppuccin
- `dot_config/ghostty/config` — Terminal config
- `dot_config/fastfetch/config.jsonc` — System info display
- `dot_config/private_kdeglobals` — KDE Plasma theme settings
- `dot_config/private_plasma-org.kde.plasma.desktop-appletsrc` — Plasma layout and widgets

## Theme

Catppuccin Mocha (dark blue). Set across:
- GTK apps (settings.ini, colors.css)
- Qt apps (kdeglobals, kvantumrc)
- SDDM login screen
- Terminals and editors

Use dark mode in app settings if available.

## Wayland notes

Ghostty, Hyprland, and Plasma all use Wayland. Set `QT_QPA_PLATFORM=wayland` for best results if you run Qt apps on X11.

## Backup first

Chezmoi can overwrite files. Back up `~/.config` and `~/.bashrc` before running apply.
