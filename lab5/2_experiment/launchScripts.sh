#!/bin/bash

max_launches=$1
N=$2
count=0

# Loop until maximum launches reached
while [ $count -lt $max_launches ]; do
	(./newmem.bash $N ) &

	((count++))

	sleep 1
done
