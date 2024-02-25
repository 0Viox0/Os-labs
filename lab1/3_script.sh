#!/bin/bash

echo "Menu. Press number for action"
echo "1 - open Nano"
echo "2 - open Vi"
echo "3 - open Links browser"
echo "4 - exit menu"

read -r number

case "$number" in
    1) nano
    ;;
    2) vi
    ;;
    3) links
    ;;
    4) exit 0
    ;;
esac
