#!/bin/bash

value=1

handle_usr1() {
    value=$((value + 2))
}

handle_usr2() {
    value=$((value * 2))
}

terminate_handler() {
    echo "handler is being terminated by generator"
    exit 0
}

trap 'handle_usr1' USR1
trap 'handle_usr2' USR2
trap 'terminate_handler' SIGTERM

while true; do
    echo "value: $value"
    sleep 1
done
