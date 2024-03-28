#!/bin/bash

# create 3 zombie processes
# display all zombie processes
# ps -au | awk '$8=="Z" {print $0}'

# (sleep 1 &)
# (sleep 1 &)
# (sleep 1 &)
#
# sleep 300

# for ((i=0; i<3; i++)); do
#     (sleep 100 &)
# done
#
# exit

# for ((i=0; i<3; i++)); do
#    child_pid=0
#    child_pid=$(fork)
#    
#    if [ "$child_pid" -gt 0 ]; then
#        sleep 10
#    else
#        exit 0
#    fi
# done
#
# sleep 10

for i in {1..3}
do
    (sleep 1 & exec sleep 1000) &
done

sleep 2

ps aux | awk '{ if ($8 == "Z") print $0 }'
