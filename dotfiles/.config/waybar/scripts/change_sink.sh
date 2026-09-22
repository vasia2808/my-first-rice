#!/bin/bash

mapfile -t sinks < <(wpctl list | awk '$3 == "audio/sink" { print $1 }')
current=$(wpctl list | awk '$3 == "audio/sink" && $4 == "*" { print $1 }')

for i in "${!sinks[@]}"; do
    [[ "${sinks[$i]}" == "$current" ]] && {
        wpctl set-default "${sinks[$((i + 1)) % ${#sinks[@]}]}"
        exit
    }
done

