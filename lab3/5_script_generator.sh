#!/bin/bash

pipeName=channel.pipe

mkfifo $pipeName

./5_script_handler.sh $$ &

trap "rm -f $pipeName; exit" SIGINT SIGTERM EXIT

echo "+" > $pipeName
echo "5" > $pipeName
echo "10" > $pipeName
echo "*" > $pipeName
echo "2" > $pipeName
echo "3" > $pipeName
echo "QUIT" > $pipeName

wait
