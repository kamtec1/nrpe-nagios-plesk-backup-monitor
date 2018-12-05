#!/bin/bash

#nrpe-nagios-plesk-backup-monitor v 1.0
#Last update: 05.12.2018
#Written by Sergey Babkevych (kamtec1) SecurityInet 
#SecurityInet Web site for updates regarding new release
#https://www.securityinet.com
#Github link for updates:
#https://github.com/kamtec1/nrpe-nagios-plesk-backup-monitor
#Change log:
#https://github.com/kamtec1/nrpe-nagios-plesk-backup-monitor/blob/master/README.md
#nrpe-nagios-plesk-backup-monitor is licensed under the GNU General Public License v3.0
#If you hgave questions you may send me a massage : kamtec1@gmail.com or sergey@securityinet.com

set -x

LC_ALL=C
STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2

####
####

current_date=`date +%Y-%m-%d`
backup_plesk_log_dir_location="/opt/backup/nfs_backup/.discovered"
backup_plesk_log_dir=$(ls -d /opt/backup/nfs_backup/.discovered/*/ | sort -n | tail -1 | cut -d "/" -f6 )
backup_plesk_log_dir_date=$(ls -l --full-time $backup_plesk_log_dir_location/$backup_plesk_log_dir/props | cut -d " " -f6)


##########################################
#check if time of the folder is the time of the server - every day backup
##########################################
if [ "$current_date" != "$backup_plesk_log_dir_date" ]
then
echo "Backup unsuccessfully - backup date error"
exit $STATE_CRITICAL
fi
##########################################


backup_plesk_check_dumpresult=$(ls $backup_plesk_log_dir_location/$backup_plesk_log_dir | grep "dumpresult")
backup_plesk_check_status=$(ls $backup_plesk_log_dir_location/$backup_plesk_log_dir | grep "status")


if [ "$backup_plesk_check_dumpresult" = "dumpresult_SUCCESS" ] && [ "$backup_plesk_check_status" = "status_OK" ]
then
        echo "Backup completed successfully"
        exit $STATE_OK

elif [ "$backup_plesk_check_status" = "status_ERROR" ]
then
        echo "Backup unsuccessfully - status ERROR"
        exit $STATE_CRITICAL
fi


#NEXT PLEASE...#
#############################################



if      [ "$backup_plesk_check_dumpresult" = "dumpresult_SUCCESS" ] && [ "$backup_plesk_check_status" = "status_OK" ]
then
        echo "Backup completed successfully"
        exit $STATE_OK

elif    [ "$backup_plesk_check_dumpresult" == 'dumpresult_WARNINGS' ]
then
        echo "server is backuped with WARNINGS"
        exit $STATE_OK
else
        echo "BACKUP FAILED"
        exit $STATE_CRITICAL
fi

#############################################

