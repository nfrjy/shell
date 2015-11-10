#!/bin/bash
yum -y install wget dialog ntp vim-enhanced vixie-cron gcc gcc-c++ flex bison autoconf automake \
glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel libtool* zlib-devel \
libxml2-devel libjpeg-devel libpng-devel libtiff-devel fontconfig-devel freetype-devel libXpm-devel\
gettext-devel curl curl-devel pam-devel e2fsprogs-devel krb5-devel libidn libidn-devel openssl openssl-devel \
openldap openldap-devel net-snmp net-snmp-devel openldap-clients openldap-servers libtidy libtidy-devel
/usr/sbin/useradd -u 501 -c "MySQL Server" mysql5.5 -s /sbin/nologin
mkdir -p /data/mysql/{data,logs/{binlog,relaylog}}
chown mysql5.5:mysql5.5 -R /data/mysql

cd /usr/local/src
tar zvxf cmake-2.8.4.tar.gz
cd cmake-2.8.4
./configure && make && make install

cd /usr/local/src
tar zxvf mysql-5.5.16.tar.gz
cd mysql-5.5.16
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/services/mysql \
-DMYSQL_DATADIR=/data/mysql/data \
-DSYSCONFDIR=/etc/mysql5.5/ \
-DMYSQL_TCP_PORT=2306 \
-DMYSQL_UNIX_ADDR=/tmp/mysql.sock  \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS:STRING=utf8,gbk \
-DWITH_MYISAM_STORAGE_ENGINE=1  \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_DEBUG=0 \
-DWITH_READLINE=1 \
-DENABLED_LOCAL_INFILE=1  
gmake
make install

chown -R mysql5.5:mysql5.5 /usr/local/services/mysql
chown -R mysql5.5:mysql5.5 /data/mysql/data
cp -f /usr/local/services/mysql/support-files/my-huge.cnf /etc/mysql5.5/my.cnf

sed -i '/^PATH/s#$#:/usr/local/services/mysql/bin#' /root/.bash_profile
. /root/.bash_profile


#mkdir -p /usr/local/services/mysql/include/mysql
#ln -s /usr/local/services/mysql/include/* /usr/local/services/mysql/include/mysql/

chmod a+x /usr/local/services/mysql/scripts/mysql_install_db
/usr/local/services/mysql/scripts/mysql_install_db --basedir=/usr/local/services/mysql/ --datadir=/data/mysql/data --user=mysql5.5 --defaults-file=/etc/my.cnf

cp /usr/local/services/mysql/support-files/mysql.server  /etc/rc.d/init.d/mysql5.5  > /dev/null 2>&1
chmod 755 /etc/rc.d/init.d/mysql5.5
chkconfig --add mysql
/etc/rc.d/init.d/mysql5.5 start > /dev/null 2>&1

#rm -rf /usr/bin/mysql* > /dev/null 2>&1
cd  /usr/local/services/mysql/bin/
for i in *; do ln -s /usr/local/services/mysql/bin/$i /usr/bin/${i}5.5; done
echo "/usr/local/services/mysql/lib/" >> /etc/ld.so.conf
ldconfig
