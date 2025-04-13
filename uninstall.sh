#!/bin/bash

RICE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
RICE_CONFIG_DIR=$RICE_DIR/config

[ -d "$XDG_CONFIG_HOME" ] && CONFIG_DIR="$XDG_CONFIG_HOME" || CONFIG_DIR="~/.config"

for app_name in `ls "$RICE_CONFIG_DIR"`
  do
    primary=$CONFIG_DIR/$app_name
    backup=${primary}_bak

    if [ ! -d "$backup" ]; then
      echo There is no backup for $app_name! The config will not be restored!
      continue
    fi

    rm $primary
    mv $backup $primary
  done

