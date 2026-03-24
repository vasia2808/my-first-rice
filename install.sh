#!/bin/bash

RICE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
RICE_CONFIG_DIR=$RICE_DIR/dotfiles/.config

[ -d "$XDG_CONFIG_HOME" ] && CONFIG_DIR=$XDG_CONFIG_HOME || CONFIG_DIR=$HOME/.config

sudo pacman -Syu --needed --noconfirm alacritty fastfetch firefox ffmpegthumbnailer gvfs-mtp grim hypridle hyprland hyprlock hyprpaper hyprpolkitagent mako neovim otf-font-awesome paru pipewire-jack pipewire-pulse playerctl pwvucontrol qimgv ranger rofi-wayland thunar tumbler ttf-jetbrains-mono-nerd waybar wl-clipboard wl-clip-persist xdg-desktop-portal-hyprland zsh

if [ ! -d "$CONFIG_DIR" ]; then
    echo Creating config directory
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

sudo ln -s /usr/bin/alacritty /usr/bin/konsole

sudo cp -r getty@tty1.service.d /etc/systemd/system

gsettings set org.gnome.desktop.interface font-name 'JetBrainsMono Nerd Font 11'
gsettings set org.gnome.desktop.wm.preferences button-layout ':'

