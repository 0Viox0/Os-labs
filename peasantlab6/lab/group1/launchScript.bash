#!/bin/bash

# perfect values: 10000 7000
# to            : 10000 7000

for ((i = 0; i < $1; i++)); do
    ./program/main 10000 $((10000+$i))
done
