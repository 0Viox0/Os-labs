#!/bin/bash

(
while true; do
    sleep 5
    echo "" > ./createdFiles.txt
    while IFS= read -r folderName; do
        if [ -d "$folderName" ]; then
            find "$folderName" -type f >> ./createdFiles.txt
        fi
    done < ./createdFolders.txt
done
) &

hehePid=$!
echo $hehePid > toDeleteStuff.txt

tail -f ./hehe | while read -r line; do
if [ -n "$line" ]; then
    mkdir -p "$line"
    echo "$line" > toGeneratorMessage
fi
done
