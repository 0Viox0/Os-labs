#!/bin/bash

max_memory=0
max_pid=0

for curProc in /proc/[0-9]*
do
    current_memory=$(awk '/VmRSS/{print $2}' "$curProc/status")

    if [ -n "$current_memory" ] && [ "$current_memory" -gt "$max_memory" ]; then
        max_memory=$current_memory
        max_pid=$curProc
    fi
done

processId=$(basename "$max_pid")

echo "$processId $max_memory"
