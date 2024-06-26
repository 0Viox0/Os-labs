#!/bin/bash
# -a accumulated output
# -o only those which are actually doing write/read
# -b non-interactive code
# -qqq without header
# -n 60 for 60 seconds

top_processes=$(iotop -n 20 -ob -qqq | sort -k4 -nr | head -n 3) 

iotop -n 20 -ob -qqq > iotop_outpuh.txt

max_proc=$(sort -k4 -nr iotop_output.txt | head -n 3)

echo "$top_processes" | while read -r line; do
    pid=$(echo "$line" | awk '{print $1}')
    command=$(echo "$line" | awk '{print $9}')
    data_read=$(echo "$line" | awk '{print $4}')

    echo "$pid : $command : $data_read"
done
