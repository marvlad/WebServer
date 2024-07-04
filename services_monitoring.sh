#!/bin/bash
set -x

# paths are relative to the script directory
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "current dir is ${SCRIPTDIR}"

#Run the services script
#export LD_LIBRARY_PATH=${SCRIPTDIR}/cgi-bin/monitor_monitor/setup/ToolDAQFramework/lib:$LD_LIBRARY_PATH
. ${SCRIPTDIR}/cgi-bin/monitor_monitor/setup/Setup.sh
echo "LD path is ${LD_LIBRARY_PATH}"
${SCRIPTDIR}/cgi-bin/monitor_monitor/check_services
echo "check_services returned $?"

# check if our output file has any contents
if [ -s ${SCRIPTDIR}/cgi-bin/monitor_monitor/services_errors.txt ]; then

	#echo "Found missing services!!!"

	# replace quotes so we don't mess up bash
	#sed -i "s/\"/'/g" ${SCRIPTDIR}/cgi-bin/monitor_monitor/services_errors.txt

	while read -r PAYLOAD; do

		#echo "We are in the if clause"

		#echo $PAYLOAD
	
		# send to slack
		curl -X POST -H --silent --data-urlencode "payload={\"text\": \"${PAYLOAD}\"}" https://hooks.slack.com/services/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

	done < ${SCRIPTDIR}/cgi-bin/monitor_monitor/services_errors.txt

	#clear error file after sending to slack
	> ${SCRIPTDIR}/cgi-bin/monitor_monitor/services_errors.txt
fi

# check if our output file has any contents
if [ -s ${SCRIPTDIR}/cgi-bin/monitor_monitor/current_run.txt ]; then

        while read -r RUN; do

                # check database
                RUNTYPE=$(echo "Select name FROM runconfig WHERE id = (SELECT runconfig FROM run WHERE runnum=${RUN})" | psql annie -h 192.168.163.21 -d rundb -t)
		echo "RunType    ${RUNTYPE}">> ${SCRIPTDIR}/cgi-bin/monitor_monitor/current_status.txt

        done < ${SCRIPTDIR}/cgi-bin/monitor_monitor/current_run.txt

fi

#Copy current txt files over to /WebServer/monitoringplots
cp ${SCRIPTDIR}/cgi-bin/monitor_monitor/current_*txt /WebServer/monitoringplots/

sleep 1
