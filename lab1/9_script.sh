#!/bin/bash

# without recursion
for file in /var/log/*.log; do
    currentFileLinesCount=$(wc -l < "$file")
    totalLines=$((totalLines+currentFileLinesCount))
done

echo "without recursion: $totalLines"

# with recursion
echo -n "with recursion " && find /var/log -type f -name "*.log" -exec wc -l {} + | awk '{total+=$1} END {print total}'
