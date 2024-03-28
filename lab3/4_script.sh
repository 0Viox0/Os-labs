#!/bin/bash

calculate() {
    while true; do
        result=$(echo "scale=10; $1 * $2" | bc)
    done
}

calculate 1234567890 987654321 &
pid1=$!

calculate 9876543210 123456789 &
pid2=$!

calculate 123456789 9876543210 &
pid3=$!

echo $pid1 $pid2 $pid3

echo -e "$pid1\n$pid2\n$pid3" > killProcessesFile
