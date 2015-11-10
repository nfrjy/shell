#!/bin/bash
PATH=/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
suffix=$(date +%m-%d-%Y)
cpath=/data/backup
dblist=(lt_bbs lt_uc bbstxt nuomi nuomiwo)
sockpath="/data/mysql/3306/mysql.sock"

for ((i=0; i<${#dblist[@]};i++))
do
     	if [ -d $cpath ]
	then
		# direcotry exists, we're good to continue
		filler="just some action to prevent syntax error"
	else
		#we need to make the directory
		echo Creating $cpath
		mkdir -p $cpath
	fi

       #now backup db
       sqlfile=${cpath}/${dblist[$i]}_$suffix.sql.gz
       mysqldump -S ${sockpath} --flush-logs -uroot -plinuxtone --add-drop-table ${dblist[$i]}|gzip -c > $sqlfile
       
       if [ $? -eq 0 ]
	  then
		printf "%s was backed up successfully to %s\n\n" ${dblist[$i]} $sqlfile 
       	  else
		printf "WARNING: An error occured while attempting to backup %s to %s\n\n" ${dblist[$i]} $sqlfile
       fi
done
#
find $cpath -name "*.sql.gz" -mtime 7|xargs rm -rf 
