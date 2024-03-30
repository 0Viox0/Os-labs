#!/bin/bash

pipe=hehe

mkfifo "$pipe"
mkfifo toGeneratorMessage

touch ./createdFolders.txt
touch ./createdFiles.txt

./handler.sh &

(
tail -f toGeneratorMessage | while read -r line; do
if [ -n "$line" ]; then
    echo "$line" >> ./createdFolders.txt
fi
done
) &

recentPid=$!

(
while true; do
    sleep 10s
    echo "-------------output every 10 seconds-------------"
    cat ./createdFolders.txt
    echo "-------------new files:-------------"
    cat ./createdFiles.txt
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
rm -f ./createdFiles.txt

toDelete=$(head -n 1 ./toDeleteStuff.txt)

kill "$toDelete"
kill $recentPid2
kill $recentPid

rm -rf ./toDeleteStuff.txt
