#!/bin/bash

RICE_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
RICE_CONFIG_DIR="$RICE_DIR/dotfiles/.config"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
THEMES_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/themes"
ICONS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/icons"

packages=(
    alacritty
    engrampa
    fastfetch
    ffmpeg-audio-thumbnailer
    ffmpegthumbnailer
    firefox
    grim
    gvfs-mtp
    hypridle
    hyprland
    hyprlock
    hyprpaper
    intel-media-driver
    kid3-qt
    mako
    mpd
    mpd-mpris
    mpv
    mpv-mpris
    neovim
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    otf-font-awesome
    paru
    pavucontrol
    pipewire-jack
    pipewire-pulse
    playerctl
    polkit-gnome
    qbittorrent
    qimgv
    rmpc
    rofi-wayland
    telegram-desktop
    thunar
    thunar-archive-plugin
    ttf-jetbrains-mono-nerd
    tumbler
    waybar
    wl-clip-persist
    wl-clipboard
    xdg-desktop-portal-hyprland
    zsh
)

sudo pacman -Syu --needed --noconfirm ${packages[@]}

mkdir -p "$CONFIG_DIR"

for source in "$RICE_CONFIG_DIR"/*
    do
        app_name="$(basename "$source")"
        target="$CONFIG_DIR/$app_name"
        backup="$target.bak"

        if [ -e "$target" ] && [ ! -e "$backup" ]; then
            mv "$target" "$backup"
        fi

        ln -sfn "$source" "$target"
    done

for file in .zsh .zprofile .zshenv .zshrc
    do
        ln -sfn "$RICE_DIR/dotfiles/$file" "$HOME/$file"
    done

chsh -s /usr/bin/zsh

mkdir -p "$THEMES_DIR"
mkdir -p "$ICONS_DIR"

ln -sfn "$RICE_DIR/GTK/Material-Black-Cherry-BE-Custom" "$THEMES_DIR/Material-Black-Cherry-BE-Custom"
ln -sfn "$RICE_DIR/GTK/Material-Black-Cherry-Numix-Custom" "$ICONS_DIR/Material-Black-Cherry-Numix-Custom"
ln -sfn "$RICE_DIR/GTK/volantes_light_cursors" "$ICONS_DIR/volantes_light_cursors"
ln -sfn "$RICE_DIR/GTK/default" "$ICONS_DIR/default"

gsettings set org.gnome.desktop.interface gtk-theme 'Material-Black-Cherry-BE-Custom'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Material-Black-Cherry-Numix-Custom'
gsettings set org.gnome.desktop.wm.preferences button-layout ':'
gsettings set org.gnome.desktop.interface font-name 'JetBrainsMono Nerd Font 11'

mkdir -p "$HOME/.local/share/mpd/playlists"
mkdir -p "$HOME/.local/state/mpd"

systemctl --user enable mpd
systemctl --user enable mpd-mpris

if [ ! -e "/usr/bin/konsole" ]; then
    sudo ln -s /usr/bin/alacritty /usr/bin/konsole
fi

sudo cp -r getty@tty1.service.d /etc/systemd/system

