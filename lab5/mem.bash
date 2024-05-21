#!/bin/bash

array=()
step=0

add_elements() {
    for ((i = 1; i <= 10; i++)); do
        array+=($i)
    done
}

while true; do
    add_elements
    ((step++))

    if ((step % 100000 == 0)); then
        echo "Array size: ${#array[@]}" >> report.log
    fi
done
