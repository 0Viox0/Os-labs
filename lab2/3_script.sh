#!/bin/bash

ps -eo pid,lstart,cmd --sort=start_time | tail -n 1 | awk '{print $1}'
