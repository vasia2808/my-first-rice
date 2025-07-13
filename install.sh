#!/bin/bash

RICE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
RICE_CONFIG_DIR=$RICE_DIR/dotfiles/.config

[ -d "$XDG_CONFIG_HOME" ] && CONFIG_DIR=$XDG_CONFIG_HOME || CONFIG_DIR=~/.config

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

sudo pacman -Syu --needed alacritty fastfetch hypridle hyprland hyprlock hyprpaper mako neovim ranger rofi-wayland thunar waybar wofi zsh

paru -Syu --needed qimgv
