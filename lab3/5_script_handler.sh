#!/bin/bash

mode="addition"
result=1

addNums() {
    result=$(echo "$result + $1" | bc)
}

multNums() {
    result=$(echo "$result * $1" | bc)
}

handleInput() {
    case "$1" in
        "+")
            mode="addition"
            ;;
        "*")
            mode="multiplication"
            ;;
        [0-9]*)
            if [ "$mode" = "addition" ]; then
                addNums "$1"
            elif [ "$mode" = "multiplication" ]; then
                multNums "$1"
            fi
            ;;
        "QUIT")
            echo "exiting because of the generator..."

            echo "the asnwer is $result"

            kill -s SIGTERM "$2"

            exit
            ;;
    esac
}

tail -f ./channel.pipe | while read -r line; do
    handleInput "$line" "$1"
done
