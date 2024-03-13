#!/bin/bash

grep -r -E -h -o '[[:alnum:]+\._-]+@[[:alnum:]+\._-]+\.[[:alpha:].]{2,}' /etc/* | awk 'BEGIN { ORS=", " } { print }' > emails.lst

# BEGIN - actions that should be taken before the input file is processed.
# ORS - Output Record Separator
# -h without the path to the file
# -o - only what matched
