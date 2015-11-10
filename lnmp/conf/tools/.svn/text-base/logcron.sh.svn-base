#!/bin/bash
log_dir="/log"
time=`date +%Y%m%d`
for i in `cat /usr/local/sbin/domain_list`
do
   /bin/mkdir -p  ${log_dir}/days > /dev/null 2>&1
   /bin/mv  ${log_dir}/$i.log  ${log_dir}/days/$i.$time.log  > /dev/null 2>&1 
   /bin/gzip -9 ${log_dir}/days/$i.$time.log 
done
killall -HUP nginx
killall -HUP nginx
#rm
find /log/days/ -name "*.log.gz" -mtime 7|xargs rm -rf 
