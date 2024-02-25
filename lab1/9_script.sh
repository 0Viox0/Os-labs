#!/bin/bash

log_files=$(find /var/log -type f -name "*.log")

echo "$log_files"
