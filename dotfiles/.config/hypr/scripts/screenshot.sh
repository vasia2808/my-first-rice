#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

file_name="$(date '+%Y-%m-%d_%H-%M-%S_%3N').png"
file_path="$HOME/Pictures/Screenshots/$file_name"

grim -l 1 "$file_path"

"$SCRIPT_DIR/screenshot-dim"

action=$(notify-send -i "$file_path" --action='default=xxx' "Screenshot captured" "$file_name")

if [ "$action" = "default" ]; then
    qimgv "$file_path"
fi

