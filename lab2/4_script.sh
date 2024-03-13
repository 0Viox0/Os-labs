#!/bin/bash

echo -n > ./4_task_output_file.txt

for proc in /proc/[0-9]*
do
    if [ -d "$proc" ]; then
        processId=$(basename "$proc")

        parentId=$(awk '/PPid/{print $2}' "$proc"/status)

        sum_exec_runtime=$(awk '{print $3}' "$proc"/sched | sed -n '3p')
        nr_switches=$(awk '{print $3}' "$proc"/sched | sed -n '7p')

        average_running_time=$(echo "scale=2; $sum_exec_runtime / $nr_switches" | bc)

        echo "ProcessID=$processId : Parent_ProcessID=$parentId : Average_Running_Time=$average_running_time" >> 4_task_output_file.txt
    fi
done

sort -t '=' -k3 -n 4_task_output_file.txt -o 4_task_output_file.txt
