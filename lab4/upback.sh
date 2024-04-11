#!/bin/bash

base_dir="/home/viox"
restore_dir="/home/viox/restore"

latest_backup=$(find "$base_dir" -maxdepth 1 -type d -name 'Backup-*' | sort | tail -n 1)

if [[ -z "$latest_backup" ]]; then
    echo "No backup directory found."
    exit 1
fi

if [[ ! -d "$restore_dir" ]]; then
    mkdir -p "$restore_dir" || {
        echo "directory $restore_dir wasn't created succesfully"
        exit 1
    }
fi

find "$latest_backup" -type f ! -name '*.[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]' -exec cp {} "$restore_dir" \;

echo "Files restored from the latest backup: $latest_backup"
