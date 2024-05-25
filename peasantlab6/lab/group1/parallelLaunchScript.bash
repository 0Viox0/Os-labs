#!/bin/bash

# perfect values: 10000 7000
# to            : 10000 7000

pids=()

for ((i = 0; i < $1; i++)); do
    ./program/main 10000 $((10000+$i)) &
    pid=$!
    pids+=($pid)
done

for pid in "${pids[@]}"; 
do
    wait $pid
    # echo "Process with PID $pid has completed"
done

echo "All scripts have finished executing."
