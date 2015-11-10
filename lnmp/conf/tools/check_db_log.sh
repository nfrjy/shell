#!/bin/bash
#check_db_error_log
#*/5 * * * * /usr/local/sbin/check_db_log.sh > /dev/null 2>&1 
date=`date +%y\%m\%d`
file=/data/scripts/db_mail

tail  /data/mysql/3306/logs/error.log | grep $date | grep 'ERROR' > $file

cat  /data/mysql/3306/logs/error.log >>  /data/mysql/3306/logs/error.log.old
echo >  /data/mysql/3306/logs/error.log

if [ `ls -l $file | awk '{print $5}'` -eq 0 ];
        then exit 0
        else mail -s "linuxtone db error" cnseek@gmail.com < $file
fi
