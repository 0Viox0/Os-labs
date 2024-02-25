#!/bin/bash

echo "Keep entering strings. press q to exit:"

read -r value

answerString=""

while [ "$value" != 'q' ]; do

    # this is done to remove unneeded space at the start of the string
    [ -z "$answerString" ] && answerString="$value" || answerString="$answerString $value"

    read -r value
done

echo "Your entered strings were:"
echo "$answerString"
