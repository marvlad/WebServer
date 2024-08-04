#!/bin/bash

echo "`date` `top -b -n 1| grep Analyse`" >> /WebServer/logs/monlog
