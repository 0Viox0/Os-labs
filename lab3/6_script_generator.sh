#!/bin/bash

terminateHandler() {
    echo "generator has resieved SIGTERM, exiting..."
    kill -TERM "$handlerPid"
    exit 0
}

trap 'terminateHandler' SIGTERM

./6_script_handler.sh &

handlerPid=$!


while true; do
    read -r input_string

    if [[ "$input_string" == "+" ]]; then
        kill -USR1 "$handlerPid"

    elif [[ "$input_string" == "*" ]]; then
        kill -USR2 "$handlerPid"

    elif [[ "$input_string" == "TERM" ]]; then
        kill -TERM "$handlerPid"
        echo "generator is being terminated"
        exit 0
    fi
done
