#ask password
#mysqlrootpwd="admin"
if [ "$mysqladminpwd" = "" ]; then
      mysqladminpwd="admin"
fi
printf "\n"
#setting password
exec 4>&1 ;mysqladminpwd=$(dialog --title "Setting MySQL root Password" --backtitle "Easy install LEMP http://www.linuxtone.org" --inputbox "Enter Password for MySQL root:" 8 60 2>&1 1>&4);exec 4>&-

mysql -S /tmp/mysql.sock -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY '${mysqladminpwd}'";
mysql -S /tmp/mysql.sock -uroot -p${mysqladminpwd} -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY '${mysqladminpwd}'";
mysql -S /tmp/mysql.sock -uroot -p${mysqladminpwd} -e "FLUSH PRIVILEGES";

/etc/init.d/mysqld restart > /dev/null 2>&1

#sed -i "/mysql_password=/ {s/.*/mysql_password=\"${mysqladminpwd}\"/}" /etc/init.d/mysql
color dgrn
echo "+--------------------------------------------------------------------------------+"
echo "All is done!"
echo "Your password root : ${mysqladminpwd}"
echo "You Can input : mysql -uroot -p${mysqladminpwd}"


