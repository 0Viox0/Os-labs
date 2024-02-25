#!/bin/bash

grep -r -E -h -o '[[:alnum:]+\._-]+@[[:alnum:]+\._-]+\.[[:alpha:].]{2,}' /etc/* | awk 'BEGIN { ORS=", " } { print }' > emails.lst

# BEGIN - so that it only runs once
# ORS - output record separator
# {} awk code block
