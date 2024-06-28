#!/bin/bash

#echo test1
#cd /home/annie/ANNIEDAQ
#source Setup.sh
#cd -
#export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

########################## Lock function garentees only one instance #########################
exec 200>/WebServer/Mirror/lock
flock -n 200 || exit 1

##############################################

#echo test2

#cd /home/annie/ANNIEDAQ/Webpage/Webmirror/CAEN_HV
#./GetHV.sh 
#cd ..

#rm -rf /home/annie/ANNIEDAQ/Webpage/Webmirror/logs
#rm -rf /home/annie/ANNIEDAQ/Webpage/Webmirror/images
#rm -rf /home/annie/ANNIEDAQ/Webpage/Webmirror/monitoringplots

#for file in `ls /var/www/html/ | grep -v zip | grep -v output`
#do
#cp -r -L /var/www/html/$file /home/annie/ANNIEDAQ/Webpage/Webmirror/
#done

#cat /var/www/html/index.html | sed s:.cgi-bin/::g | sed s:.cgi:.html:g > /home/annie/ANNIEDAQ/Webpage/Webmirror/index.html
#cat /var/www/html/instructions.html |  sed s:.cgi-bin/::g|sed s:.cgi:.html:g > /home/annie/ANNIEDAQ/Webpage/Webmirror/instructions.html
#/var/www/cgi-bin/logs.cgi |  sed s:.cgi-bin/::g|sed s:.cgi:.html:g| sed s:'\.\./':'':g | sed s:/logs:./logs:g > /home/annie/ANNIEDAQ/Webpage/Webmirror/tmp
wget 127.0.0.1/index.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/index.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/index.html

wget 127.0.0.1/Cameras.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/Cameras.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/Cameras.html

wget 127.0.0.1/instructions.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/instructions.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/instructions.html

wget 127.0.0.1/cgi-bin/control.cgi -O /WebServer/Mirror/tmp
echo Mirrored at `date` : Note: Control interface does not work on mirrored site > /WebServer/Mirror/control.html
cat /WebServer/Mirror/tmp  | sed s:.cgi-bin/::g| sed s:.cgi:.html:g | sed s:'\.\./':'':g >> /WebServer/Mirror/control.html

wget 127.0.0.1/cgi-bin/SQL.cgi -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/SQL.html
cat /WebServer/Mirror/tmp  | sed s:.cgi-bin/::g| sed s:.cgi:.html:g | sed s:'\.\./':'':g >> /WebServer/Mirror/SQL.html

wget 127.0.0.1/cgi-bin/RunType.cgi -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/RunType.html
cat /WebServer/Mirror/tmp  | sed s:.cgi-bin/::g| sed s:.cgi:.html:g | sed s:'\.\./':'':g >> /WebServer/Mirror/RunType.html

wget 127.0.0.1/cgi-bin/logs.cgi -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/logs.html
cat /WebServer/Mirror/tmp  | sed s:.cgi-bin/::g| sed s:.cgi:.html:g | sed s:'\.\./':'':g >> /WebServer/Mirror/logs.html

wget 127.0.0.1/cgi-bin/monitoring.cgi -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/monitoring.html
cat /WebServer/Mirror/tmp  | sed s:.cgi-bin/::g| sed s:.cgi:.html:g | sed s:'\.\./':'':g >> /WebServer/Mirror/monitoring.html

wget 127.0.0.1/MRDSummary.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/MRDSummary.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/MRDSummary.html

wget 127.0.0.1/Checklist.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/Checklist.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/Checklist.html

wget 127.0.0.1/ChecklistPrint.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/ChecklistPrint.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/ChecklistPrint.html

wget 127.0.0.1/MRDHitmaps.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/MRDHitmaps.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/MRDHitmaps.html

wget 127.0.0.1/MRDLastFile.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/MRDLastFile.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/MRDLastFile.html

wget 127.0.0.1/MRDRates.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/MRDRates.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/MRDRates.html

wget 127.0.0.1/MRDTimeEvolution.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/MRDTimeEvolution.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/MRDTimeEvolution.html

wget 127.0.0.1/TankBuffer.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/TankBuffer.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/TankBuffer.html

wget 127.0.0.1/TankElectronics.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/TankElectronics.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/TankElectronics.html

wget 127.0.0.1/TankFrequency.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/TankFrequency.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/TankFrequency.html

wget 127.0.0.1/TankSummary.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/TankSummary.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/TankSummary.html

wget 127.0.0.1/TankTimeEvolution.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/TankTimeEvolution.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/TankTimeEvolution.html

wget 127.0.0.1/TriggerSummary.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/TriggerSummary.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/TriggerSummary.html

wget 127.0.0.1/TriggerRates.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/TriggerRates.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/TriggerRates.html

wget 127.0.0.1/TriggerAlignment.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/TriggerAlignment.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/TriggerAlignment.html

wget 127.0.0.1/LAPPDBuffer.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/LAPPDBuffer.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/LAPPDBuffer.html

wget 127.0.0.1/LAPPDFreq.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/LAPPDFreq.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/LAPPDFreq.html

wget 127.0.0.1/LAPPDLive.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/LAPPDLive.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/LAPPDLive.html

wget 127.0.0.1/LAPPDSlowControl.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/LAPPDSlowControl.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/LAPPDSlowControl.html

wget 127.0.0.1/LAPPDSlowControlPrint.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/LAPPDSlowControlPrint.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/LAPPDSlowControlPrint.html

wget 127.0.0.1/LAPPDSummary.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/LAPPDSummary.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/LAPPDSummary.html

wget 127.0.0.1/LAPPDTimeEvolution.html -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/LAPPDTimeEvolution.html
cat /WebServer/Mirror/tmp | sed s:.cgi-bin/::g | sed s:.cgi:.html:g  >> /WebServer/Mirror/LAPPDTimeEvolution.html

wget http://192.168.163.61:8001/CAEN_HV/  -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/CAEN_HV/index.html
cat /WebServer/Mirror/tmp >> /WebServer/Mirror/CAEN_HV/index.html

wget http://192.168.163.61:8001/CAEN_HV/Summary_Page/  -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/CAEN_HV/Summary_Page/index.html
cat /WebServer/Mirror/tmp >> /WebServer/Mirror/CAEN_HV/Summary_Page/index.html

wget http://192.168.163.61:8001/CAEN_HV/Channel_Table/  -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/CAEN_HV/Channel_Table/index.html
cat /WebServer/Mirror/tmp >> /WebServer/Mirror/CAEN_HV/Channel_Table/index.html

wget http://192.168.163.61:8001/CAEN_HV/graphs.html  -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/CAEN_HV/graphs.html
cat /WebServer/Mirror/tmp >> /WebServer/Mirror/CAEN_HV/graphs.html

wget http://192.168.163.61:8001/CAEN_HV/Alarm_Screencap/  -O /WebServer/Mirror/tmp
echo Mirrored at `date` > /WebServer/Mirror/CAEN_HV/Alarm_Screencap/index.html
cat /WebServer/Mirror/tmp >> /WebServer/Mirror/CAEN_HV/Alarm_Screencap/index.html

wget http://192.168.163.61:8001/CAEN_HV/voltages.png  -O /WebServer/Mirror/CAEN_HV/voltages.png
wget http://192.168.163.61:8001/CAEN_HV/currents.png  -O /WebServer/Mirror/CAEN_HV/currents.png
wget http://192.168.163.61:8001/CAEN_HV/voltages_differences.png  -O /WebServer/Mirror/CAEN_HV/voltages_differences.png
wget http://192.168.163.61:8001/CAEN_HV/currents_differences.png  -O /WebServer/Mirror/CAEN_HV/currents_differences.png


psql -h 192.168.163.21 -U admin -d rundb -H -c "select * from run" > /WebServer/Mirror/ndbrun.html
psql -h 192.168.163.21 -U admin -d rundb -H -c "select * from configfiles" > /WebServer/Mirror/ndbconfigfiles.html
psql -h 192.168.163.21 -U admin -d rundb -H -c "select * from control order by Date desc" > /WebServer/Mirror/ndbcontrol.html
psql -h 192.168.163.21 -U admin -d rundb -H -c "select * from daq" > /WebServer/Mirror/ndbdaq.html
psql -h 192.168.163.21 -U admin -d rundb -H -c "select * from geometry" > /WebServer/Mirror/ndbgeometry.html
psql -h 192.168.163.21 -U admin -d rundb -H -c "select * from hv" > /WebServer/Mirror/ndbhv.html
psql -h 192.168.163.21 -U admin -d rundb -H -c "select * from lappd" > /WebServer/Mirror/ndblappd.html
psql -h 192.168.163.21 -U admin -d rundb -H -c "select * from logging" > /WebServer/Mirror/ndblogging.html
psql -h 192.168.163.21 -U admin -d rundb -H -c "select * from mrd" > /WebServer/Mirror/ndbmrd.html
psql -h 192.168.163.21 -U admin -d rundb -H -c "select * from runconfig" > /WebServer/Mirror/ndbrunconfig.html
psql -h 192.168.163.21 -U admin -d rundb -H -c "select * from vme" > /WebServer/Mirror/ndbvme.html

##commented to hear if hv laptop off

#rm -f /home/annie/ANNIEDAQ/Webpage/Webmirror/tmp
#echo Mirrored at `date` `/var/www/cgi-bin/monitoring.cgi` |  sed s:.cgi-bin/::g|sed s:.cgi:.html:g | sed s:'\.\./':'':g > /home/annie/ANNIEDAQ/Webpage/Webmirror/monitoring.html
#echo Mirrored at `date` `/var/www/cgi-bin/monitoringnr.cgi` |  sed s:.cgi-bin/::g|sed s:.cgi:.html:g | sed s:'\.\./':'':g > /home/annie/ANNIEDAQ/Webpage/Webmirror/monitoringnr.html
#echo Mirrored at `date` `/var/www/cgi-bin/SQL.cgi` |  sed s:.cgi-bin/::g| sed s:.cgi:.html:g | sed s:'\.\./':'':g > /home/annie/ANNIEDAQ/Webpage/Webmirror/SQL.html


#echo finnished downloading trying to send
#for file in `ls /var/www/html/ -r`

#LOG=/data/logs/archiver/archiver.log
PAPR=/annie/data/web/daq/
TARG=annieraw@anniegpvm01


PRINC=`cat  /home/annie_local/.kerberos/annieraw.principal`
KEYTAB=/home/annie_local/.kerberos/annieraw.keytab
#export KRB5CCNAME=/home/annie/.kerberos/krb5cc_archiver

su annie -c 'rsync -rLptg /WebServer/Mirror/ /exp/annie/web/daq'

 #kinit -k -t ${KEYTAB} ${PRINC}
 #scp -rp -c blowfish -q /WebServer/Mirror/*  ${TARG}:${PAPR}/
###scp -r -q /WebServer/Mirror/*  annieraw@anniegpvm02:/annie/data/web/daq/
