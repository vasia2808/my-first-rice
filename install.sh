#!/bin/bash

RICE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
RICE_CONFIG_DIR=$RICE_DIR/config

[ -d "$XDG_CONFIG_HOME" ] && CONFIG_DIR="$XDG_CONFIG_HOME" || CONFIG_DIR="~/.config"

for app_name in `ls "$RICE_CONFIG_DIR"`
  do
    primary=$CONFIG_DIR/$app_name
    backup=${primary}_bak
    rice=$RICE_CONFIG_DIR/$app_name

    if [ -d "$backup" ]; then
      echo There is backup for $app_name! Uninstall the rice and try again!
      continue
    fi

    mv "$primary" "$backup"
    ln -s "$rice" "$primary"
  done
