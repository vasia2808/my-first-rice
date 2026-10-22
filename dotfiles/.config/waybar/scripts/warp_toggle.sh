#!/bin/bash

STATUS=$(warp-cli status | grep "Status update:" | awk '{print $3}')

if [ "$STATUS" = "Connected" ]; then
    warp-cli disconnect
else
    warp-cli connect
fi

