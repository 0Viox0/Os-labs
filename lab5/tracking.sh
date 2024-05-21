#!/bin/bash

log_file="usage_log.txt"

get_ram_usage() {
    free -k | awk '/^Mem:/ {print $3}'
}

get_max_ram() {
    free -k | awk '/^Mem:/ {print $2}'
}

get_swap_usage() {
    free -k | awk '/^Swap:/ {print $3}'
}

get_max_swap() {
    free -k | awk '/^Swap:/ {print $2}'
}

echo "Logging RAM and swap usage every second..."
while true; do
    ram_usage=$(get_ram_usage)
    max_ram=$(get_max_ram)
    swap_usage=$(get_swap_usage)
    max_swap=$(get_max_swap)

    echo "$(date +"%Y-%m-%d %H:%M:%S"), $ram_usage KB, $max_ram KB, $swap_usage KB, $max_swap KB" >> "$log_file"

    sleep 1
done
