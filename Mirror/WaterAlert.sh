#!/bin/bash

if [  `cat /WebServer/Mirror/WaterSensor/leaks  | grep WATER | wc -l` != '0' ]
then
    sleep 70
    
    if [  `cat /WebServer/Mirror/WaterSensor/leaks  | grep WATER | wc -l` != '0' ]
    then
	/usr/sbin/sendmail  vfischer@ucdavis.edu < /WebServer/Mirror/WaterSensor/leaks
	/usr/sbin/sendmail vincent.fj.fischer@gmail.com < /WebServer/Mirror/WaterSensor/leaks
	/usr/sbin/sendmail  tjpershing@ucdavis.edu < /WebServer/Mirror/WaterSensor/leaks
	/usr/sbin/sendmail benjamin.richards@warwick.ac.uk < /WebServer/Mirror/WaterSensor/leaks
	/usr/sbin/sendmail  mnieslon@uni-mainz.de < /WebServer/Mirror/WaterSensor/leaks
	/usr/sbin/sendmail  etiras@fnal.gov <  /WebServer/Mirror/WaterSensor/leaks
	/usr/sbin/sendmail  malte.stender@desy.de <  /WebServer/Mirror/WaterSensor/leaks
	/usr/sbin/sendmail  benedict.kaiser@uni-tuebingen.de <  /WebServer/Mirror/WaterSensor/leaks
	/usr/sbin/sendmail  mascenci@iastate.edu < /WebServer/Mirror/WaterSensor/leaks
	/usr/sbin/sendmail  franklin.lemmons@mines.sdsmt.edu < /WebServer/Mirror/WaterSensor/leaks
	curl -X POST --data-urlencode "payload={\"text\": \"`cat /WebServer/Mirror/WaterSensor/leaks`\"}" https://hooks.slack.com/services/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
	curl -u WaterAdmin:waterannie19 http://192.168.163.100:80/outlet?1=OFF
	curl -u WaterAdmin:waterannie19 http://192.168.163.100:80/outlet?2=OFF
	
    fi
fi
