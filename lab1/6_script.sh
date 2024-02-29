#!/bin/bash

touch full.log

grep "WARN" ./anacondaMockSyslog.log | sed 's/WARNING/Warning: /' > full.log

grep "INFO" ./anacondaMockSyslog.log | sed 's/INFO/Information: /' >> full.log

cat full.log
