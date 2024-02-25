#!/bin/bash

if [ $# -ne 3 ]; then
    echo "you should've entered 3 arguments but entered $#"
    exit 1
fi

if [ "$1" -gt "$2" ] && [ "$1" -gt "$3" ]; then
    echo "$1 is the max number";
fi

if [ "$2" -gt "$1" ] && [ "$2" -gt "$3" ]; then
    echo "$2 is the max number";
fi

if [ "$3" -gt "$2" ] && [ "$3" -gt "$1" ]; then
    echo "$3 is the max number";
fi
