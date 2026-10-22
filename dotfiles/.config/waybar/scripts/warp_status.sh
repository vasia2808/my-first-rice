#!/bin/bash

STATUS=$(warp-cli status | grep "Status update:" | awk '{print $3}')

if [ "$STATUS" = "Connected" ]; then
    echo '{"text": "On", "tooltip": "Cloudflare WARP Connected"}'
else
    echo '{"text": "Off", "tooltip": "Cloudflare WARP Disconnected"}'
fi

