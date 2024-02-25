#!/bin/bash

output=$(pwd)

if [ "${output:1:4}" == "home" ]; then
    echo "exited with code 0"
    exit 0
else
    echo "exited with code 1"
    exit 1
fi
