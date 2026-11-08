#!/usr/bin/env bash

file_name="$(date '+%Y-%m-%d_%H-%M-%S').png"
file_path="$HOME/Pictures/Screenshots/$file_name"

grim "$file_path"

action=$(notify-send -i "$file_path" --action='default=xxx' "Screenshot captured" "$file_name")

if [ "$action" = "default" ]; then
    qimgv "$file_path"
fi

