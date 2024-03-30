#!/bin/bash

pipe=hehe
mkfifo "$pipe"

./handler.sh &

(
tail -f toGeneratorMessage | while read -r line; do
if [ -n "$line" ]; then
    echo "folder created $line" >> ./createdFolders.txt
fi
done
) &

recentPid=$!

(
while true; do
    sleep 10s
    echo "-------------output every 10 seconds-------------"
    cat ./createdFolders.txt
    echo "-------------output every 10 seconds-------------"
done
) &

recentPid2=$!

echo "enter the values"

while true; do
    read -r input

    if [[ -z "$input" ]]; then
        continue
    elif [ "$input" == "TERM" ]; then break
    else
        echo "$input" > "$pipe"
    fi
done

echo "" > "$pipe"

rm -f "$pipe"
rm -f ./toGeneratorMessage
rm -f ./createdFolders.txt

kill $recentPid
kill $recentPid2
