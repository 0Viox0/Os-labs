#!/bin/bash

for ((j = 0; j < 10; j++)); do
    ({ time ./launchScript.bash "$1"; } 2>> ./output4/parallelHeheWhereNIs$1) &
done

echo launched 10 processes, maximum time to wait is $(($1 * 10)) seconds
