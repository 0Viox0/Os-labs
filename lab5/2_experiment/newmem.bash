#!/bin/bash

N=$1

array=()

add_elements() {
	for ((i = 1; i <= 10; i++)); do
		array+=($i)
	done
}

while true; do
	add_elements

	length=${#array[@]}

	if (($length >= $N)); then
		exit
	fi
done
