#!/bin/bash


for ((i = 1; i <= 20; i++)); do
    for ((j = 0; j < 10; j++)); do
        { time ./launchScript.bash "$i"; } 2>> ./output/heheWhereNIs$i
    done
done
