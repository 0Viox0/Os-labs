#!/bin/bash

touch info.log

awk '$3 == "INFO:"' ./anacondaMockSyslog.log > info.log
