#!/bin/bash

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin

process_list=$(ps -aux | grep 'usbip_auto_bind.sh' | grep -v 'grep' | awk -F' ' '{print $2}')
[ -z "$process_list" ] || kill "$process_list"

local_vid_pid=$(usbip list -p -l | cut -d'#' -f1 | cut -d'=' -f2)
for local_id in $local_vid_pid; do
    usbip unbind -b $local_id 2>/dev/null
done