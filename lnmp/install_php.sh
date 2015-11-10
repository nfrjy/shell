#!/bin/bash

cur_dir=$(pwd)

#. $cur_dir/install_phplib.sh


cd /usr/local/src

wget http://www.php.net/get/php-5.4.15.tar.gz/from/cn2.php.net/mirror
tar zxvf php-5.4.15.tar.gz
cd php-5.4.15
./configure --with-iconv --enable-fpm --prefix=/usr/local/services/php \
--with-mysql=/usr/local/services/mysql \
--with-config-file-path=/usr/local/services/php/etc \
--with-mysqli=/usr/local/services/mysql/bin/mysql_config \
--with-curl --with-pdo-mysql=mysqlnd --with-libxml-dir --enable-xml --enable-mbstring --enable-soap --enable-sockets --with-mcrypt --with-gd --enable-bcmath
make ZEND_EXTRA_LIBS='-liconv' 
make install
cp /usr/local/src/php-5.4.15/php.ini-production /usr/local/services/php/etc/php.ini
#配置文件没加载扩展
cp $cur_dir/conf/php/php-fpm /etc/init.d/php-fpm
cp $cur_dir/conf/php/php-fpm.conf /usr/local/services/php/etc/php-fpm.conf

cp /usr/local/services/mysql/lib/libmysqlclient.so.18 /usr/lib64
ldconfig

chmod +x /etc/init.d/php-fpm
chkconfig --add php-fpm
chkconfig --level 345 php-fpm on

mkdir -p /data/logs/php
chown www:www -R /data/logs/php


. $cur_dir/install_phpext.sh

service php-fpm start



curl -H "Content-type:text/html;charset=utf-8" -d "{\"caller\":\"15069143435\",\"qno\":\"3088558455\",\"clidata\":\"43517726\"}" http://14.17.107.196/qvoice/call
