#!/bin/bash

processCount=$(ps -u viox | wc -l)

echo "$processCount" > 1_task_output_file.txt

ps -u viox -o pid,cmd >> 1_task_outputfile.txt
