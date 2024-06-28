#!/bin/bash

cpuUsage=$(/usr/bin/top -bn1 | /usr/bin/awk '/Cpu/ { print $2}')
memUsage=$(/usr/bin/free -m | /usr/bin/awk '/Mem/{print $3}')
Date=$(/usr/bin/date)

echo "${Date}: Mem = ${memUsage} MB, CPU = ${cpuUsage} %" >> /WebServer/logs/mem_lx02.txt
