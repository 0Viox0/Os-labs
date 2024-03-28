#!/bin/bash

mkdir ~/test &>/dev/null && echo "catalog test was created successfully" >> ~/report && touch ~/test/$(date +"%Y_%m_%d_%H_%M_%S_Starting_Script")

ping -c 1 www.net_nikogo.ru &>/dev/null || echo "$(date +"%Y-%m-%d %H:%M:%S") could not reach host www.net_nikogo.ru" >> ~/report
