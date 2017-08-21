# nrpe-nagios-plesk-backup-monitor
NRPE check Plesk backup status

Summary:
This is a plugin (backup_plesk_checker) that monitors backup status in Plesk panel - Success/Warning/Error/Date checker.


Full Description:
This is a basic plugin (backup_plesk_checker) that monitors backup activities in Plesk panel.
This plugin have 4 main options:
1) Success status - backup ok
2) Warning status - backup have warnings
3) Error status - backup have errors
4) Backup unsuccessful - date not equal to backup date


and will be more :) 



Installation instructions:

Edit file /etc/sudoers and add the following;

nrpe ALL=(root) NOPASSWD: /usr/lib64/nagios/plugins/backup_plesk_checker.sh
nagios ALL=(root) NOPASSWD: /usr/lib64/nagios/plugins/backup_plesk_checker.sh
Edit file /etc/nagios/nrpe.cfg and add the following;

command[check_backup]=/usr/bin/sudo /usr/lib64/nagios/plugins/backup_plesk_checker.sh
Copy backup_plesk_checker.sh to /usr/lib64/nagios/plugins/ and give this script 777 or just execute :)

And the Final step is to define service/define command to specific servers in Nagios server.

------------------------------------------------------------------------------------

nrpe-nagios-plesk-backup-monitor v 0.1a 
Written by Sergey Babkevych SecurityInet https://www.securityinet.com
