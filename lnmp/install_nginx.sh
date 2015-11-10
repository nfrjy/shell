#!/bin/bash
. /etc/profile
cur_dir=$(pwd)

yum -y install openssl openssl-devel zlib zlib-devel

sh $cur_dir/add_nginx_user.sh

cd /usr/local/src
tar zvxf pcre-8.12.tar.gz
cd pcre-8.12
./configure --enable-utf8 && make && make install

cd /usr/local/src
wget http://nginx.org/download/nginx-1.2.1.tar.gz
tar zvxf nginx-1.2.1.tar.gz
cd nginx-1.2.1
./configure --user=www --group=www \
--prefix=/usr/local/services/nginx/ \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_sub_module \
--with-md5=/usr/lib \
--with-sha1=/usr/lib \
--with-http_realip_module \
--with-http_sub_module \
--with-http_stub_status_module \
--with-http_gzip_static_module

make && make install

mkdir -p /data/www/
mkdir -p /data/logs/nginx
chown -R www:www /data/logs/nginx
chown -R www:www /data/www


cp $cur_dir/conf/nginx/nginx.conf /usr/local/services/nginx/conf/nginx.conf
cp $cur_dir/conf/nginx/nginx.server /etc/init.d/nginx
chkconfig --add nginx
chkconfig nginx on
chmod +x /etc/init.d/nginx
service nginx start

