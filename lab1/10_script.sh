#!/bin/bash

man bash > hehe.txt

tr -cs 'A-Za-z' '\n' < hehe.txt | tr 'A-Z' 'a-z' | awk 'length>=4' > fourSymbolsWordLength.txt

sort < fourSymbolsWordLength.txt | uniq -c | sort -nr | head -n 3 > answer.txt

cat answer.txt
