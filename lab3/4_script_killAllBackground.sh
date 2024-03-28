#!/bin/bash

while IFS= read -r pid; do
    kill "$pid"
    echo "Killed PID: $pid"
done < ./killProcessesFile
