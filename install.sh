#!/bin/bash

RICE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
RICE_CONFIG_DIR=$RICE_DIR/dotfiles/.config
CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}
THEMES_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/themes
ICONS_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/icons

sudo pacman -Syu --needed --noconfirm alacritty engrampa fastfetch firefox ffmpegthumbnailer gvfs-mtp grim hypridle hyprland hyprlock hyprpaper mako mpd mpd-mpris mpv mpv-mpris neovim noto-fonts-cjk otf-font-awesome pavucontrol paru pipewire-jack pipewire-pulse playerctl polkit-gnome qbittorrent qimgv rmpc rofi-wayland thunar thunar-archive-plugin tumbler ttf-jetbrains-mono-nerd waybar wl-clipboard wl-clip-persist xdg-desktop-portal-hyprland zsh

if [ ! -d "$CONFIG_DIR" ]; then
    mkdir "$CONFIG_DIR"
fi

for app_name in `ls "$RICE_CONFIG_DIR"`
  do
    primary=$CONFIG_DIR/$app_name
    backup=${primary}_bak
    rice=$RICE_CONFIG_DIR/$app_name

    if [ -d "$backup" ]; then
      echo There is backup for $app_name! Uninstall the rice and try again!
      continue
    fi

    if [ -d "$primary" ]; then
        mv "$primary" "$backup"
    fi

    ln -s "$rice" "$primary"
  done

ln -s "$RICE_DIR/dotfiles/.zsh" "$HOME/.zsh"
ln -s "$RICE_DIR/dotfiles/.zprofile" "$HOME/.zprofile"
ln -s "$RICE_DIR/dotfiles/.zshenv" "$HOME/.zshenv"
ln -s "$RICE_DIR/dotfiles/.zshrc" "$HOME/.zshrc"

chsh -s /usr/bin/zsh

if [ ! -d "$THEMES_DIR" ]; then
    mkdir -p "$THEMES_DIR"
fi

if [ ! -d "$ICONS_DIR" ]; then
    mkdir -p "$ICONS_DIR"
fi

ln -s "$RICE_DIR/GTK/Material-Black-Cherry-BE-Custom" "$THEMES_DIR/Material-Black-Cherry-BE-Custom"
ln -s "$RICE_DIR/GTK/Material-Black-Cherry-Numix-Custom" "$ICONS_DIR/Material-Black-Cherry-Numix-Custom"
ln -s "$RICE_DIR/GTK/volantes_light_cursors" "$ICONS_DIR/volantes_light_cursors"
ln -s "$RICE_DIR/GTK/default" "$ICONS_DIR/default"

gsettings set org.gnome.desktop.interface gtk-theme 'Material-Black-Cherry-BE-Custom'
gsettings set org.gnome.desktop.interface icon-theme 'Material-Black-Cherry-Numix-Custom'
gsettings set org.gnome.desktop.wm.preferences button-layout ':'
gsettings set org.gnome.desktop.interface font-name 'JetBrainsMono Nerd Font 11'

mkdir -p "$HOME/.local/share/mpd/playlists"
mkdir -p "$HOME/.local/state/mpd"

systemctl --user enable mpd
systemctl --user enable mpd-mpris

sudo ln -s /usr/bin/alacritty /usr/bin/konsole

sudo cp -r getty@tty1.service.d /etc/systemd/system

