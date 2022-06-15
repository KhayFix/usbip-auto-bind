#!/bin/bash

PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin

allowed_vid_pid=()

while :; do
    for allowed_id in ${allowed_vid_pid[@]}; do
        local_vid_pid=$(usbip list -p -l | awk "/${allowed_id}/" | cut -d'#' -f1 | cut -d'=' -f2)
        for local_id in $local_vid_pid; do
            usbip bind -b $local_id 2>/dev/null
        done
    done
    sleep 2
done