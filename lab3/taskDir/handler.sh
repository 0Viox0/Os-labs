#!/bin/bash

mkfifo toGeneratorMessage

tail -f ./hehe | while read -r line; do
    if [ -n "$line" ]; then
        mkdir -p "$line"
        # echo "Created directory '$line'"
        echo "$line" > toGeneratorMessage
    fi
done
