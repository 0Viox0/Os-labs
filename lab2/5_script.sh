#!/bin/bash

echo -n > ./5_task_output_file.txt

firstOccurence=1

previousId=""

currentSum=0
currentCount=0

while read -r line; do
    if [ $firstOccurence -eq 1 ]; then
        previousId=$(echo "$line" | awk -F'[:=]' '{print $4}')
        firstOccurence=0

        currentArt=$(echo "$line" | awk -F'[:=]' '{print $6}')
        currentSum=$(echo "$currentSum + $currentArt" | bc)

        echo "$line" >> 5_task_output_file.txt

        currentCount=$(($currentCount + 1))
        continue
    fi

    currentId=$(echo "$line" | awk -F'[:=]' '{print $4}')

    if [ "$currentId" != "$previousId" ]; then
        average=$(echo "scale=2; $currentSum / $currentCount" | bc)

        echo "Average_Running_Children_of_ParentID=$previousId is $average" >> ./5_task_output_file.txt
        echo "$line" >> 5_task_output_file.txt

        currentSum=0
        currentCount=0

        currentArt=$(echo "$line" | awk -F'[:=]' '{print $6}')
        currentSum=$(echo "$currentSum + $currentArt" | bc)

        currentCount=$(($currentCount + 1))
    else
        echo "$line" >> 5_task_output_file.txt

        currentArt=$(echo "$line" | awk -F'[:=]' '{print $6}')
        currentSum=$(echo "$currentSum + $currentArt" | bc)

        currentCount=$(($currentCount + 1))
    fi

    previousId=$currentId

done < ./4_task_output_file.txt
