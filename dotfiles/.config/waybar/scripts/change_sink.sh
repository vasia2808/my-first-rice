#!/bin/bash

mapfile -t sinks < <(wpctl list | awk '$3 == "audio/sink" { print $1 }')

if (( ${#sinks[@]} == 0 )); then
    echo "No audio sinks found" >&2
    exit 1
fi

case "$1" in
    next)
        direction=1
        ;;
    previous)
        direction=-1
        ;;
    "")
        direction=1
        ;;
    *)
        echo "Usage: $0 [next|previous]" >&2
        exit 1
        ;;
esac

current=$(wpctl list | awk '$3 == "audio/sink" && $4 == "*" { print $1 }')

for i in "${!sinks[@]}"; do
    if [[ "${sinks[$i]}" == "$current" ]]; then
        next=$(( (i + direction + ${#sinks[@]}) % ${#sinks[@]} ))
        wpctl set-default "${sinks[$next]}"
        exit $?
    fi
done

wpctl set-default "${sinks[0]}"

