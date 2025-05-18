#!/bin/bash

CONFIG_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
NUM_OF_MONITORS=$(hyprctl monitors | grep Monitor | wc -l)

if [[ $NUM_OF_MONITORS = 1 ]]; then
    config=$CONFIG_DIR/one_monitor.jsonc
else
    config=$CONFIG_DIR/two_monitors.jsonc
fi

style=$CONFIG_DIR/style.css

exec waybar --config "$config" --style "$style"

