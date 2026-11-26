#!/usr/bin/env bash

monitor="Virtual-1"
mode_file="/sys/class/drm/card1-${monitor}/modes"

udevadm monitor --kernel --subsystem-match=drm |
while IFS= read -r event; do
    [[ "$event" == *" change "*"/drm/card1 "* ]] || continue

    sleep 0.1

    mode=$(head -n1 "$mode_file")

    [[ -n "$mode" ]] || continue

    hyprctl eval "hl.monitor({
        output = \"$monitor\",
        mode = \"$mode@60\",
        position = \"0x0\",
        scale = 1
    })"
done

