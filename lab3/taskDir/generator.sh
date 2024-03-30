#!/bin/bash

pipe=hehe
mkfifo "$pipe"

./handler.sh &

echo "enter the values"

(
tail -f toGeneratorMessage | while read -r line; do
if [ -n "$line" ]; then
    echo "folder created $line"
fi
done
) &

recentPid=$!

while true; do
    read -r input

    if [[ -z "$input" ]]; then
        continue
    elif [ "$input" == "TERM" ]; then
        break
    else
        echo "$input" > "$pipe"
    fi
done

echo "" > "$pipe"

rm -f "$pipe"

kill $recentPid
