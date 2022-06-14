#!/bin/bash

allowed_vid_pid=()

while :; do
    for allowed_id in ${allowed_vid_pid[@]}; do
        local_vid_pid=$()
        for local_id in $local_vid_pid; do
            usbip bind -b $local_id 2>/dev/null
        done
    done
    sleep 2
done