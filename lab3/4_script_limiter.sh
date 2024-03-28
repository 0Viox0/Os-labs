#!/bin/bash

pid1=$(head -n 1 ./killProcessesFile)
pid3=$(head -n 2 ./killProcessesFile | tail -n 1 ./killProcessesFile)

cpulimit -p "$pid1" -l 10 &

limiter_pid=$!

# we remove 3rd process because we will delete it further
sed -i '$d' ./killProcessesFile

echo $limiter_pid >> ./killProcessesFile

kill -s KILL "$pid3"
