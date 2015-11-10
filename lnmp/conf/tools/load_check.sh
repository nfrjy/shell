#!/bin/bash
#*/3 * * * * /usr/local/sbin/restart_php.sh  > /dev/null 2>&1
PROG=/usr/local/php-fcgi/sbin/php-fpm
LOG=/tmp/php-cgi.log
time=`date +%Y/%d/%m/%H:%M:%S`
load=`awk -F. '{print $1}' /proc/loadavg`
if [ $load -gt 10 ]; then
    echo "Restart php-cgi at ${time} " >> $LOG

    $PROG restart

fi
