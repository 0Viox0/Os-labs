#!/bin/bash

if [ $# -ne 1 ]; then
    echo "The proper usage of the script is: $0 <filename>."
    exit 1
fi

filename="$1"
trashDir="$HOME/.trash"
logFile="$HOME/.trash.log"

if [ ! -d "$trashDir" ]; then
    mkdir "$trashDir" || { echo "Couldn't create directory $trashDir."; exit 1; }
fi

if [ ! -f "$filename" ]; then
    echo "The file '$filename' does not exist in the current directory."
    exit 1
fi

linkName=""
nextNumber=0

if [ -f "$logFile" ]; then
    while true; do
        if ! awk '{print $2}' "$logFile" | grep -q $nextNumber; then
            linkName=$nextNumber
            break
        fi
        ((nextNumber++))
    done
else
    linkName="0"
fi

ln -- "$filename" "$trashDir/$linkName" || {
    echo "failed to create a hard link for '$filename'."
    exit 1
}

actuallPath=$(realpath -- "$filename")

rm -f -- "$filename" 2>/dev/null || {
    echo "failed to delete original file: '$filename' but the hard link was created successfully."
    rm -f "$trashDir/$linkName"
    exit 1
}

echo "$actuallPath $linkName" >> "$logFile" || {
    echo "failed to write to log file '$logFile'."
    exit 1
}
