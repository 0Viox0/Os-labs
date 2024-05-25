#!/bin/bash

for ((i = 1; i <= 20; i++)); do
    echo ------------DOING EXPERIMENTS FOR N = "$i"------------
    for ((j = 0; j < 10; j++)); do
        echo started experiment number $(($j + 1))
        ({ time ./parallelLaunchScript.bash "$i"; } 2>> ./tryOutput2/parallelHeheWhereNIs$i)
    done
done
