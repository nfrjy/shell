cd /usr/local/src
tar -xvf libevent-2.0.13-stable.tar.gz
cd libevent-2.0.13-stable
./configure && make && make install

cd /usr/local/src
tar -xvf memcached-1.4.7.tar.gz
cd memcached-1.4.7
/usr/local/services/php/bin/phpize
./configure --prefix=/usr/local/services/memcached
make && make install

# 
cd /usr/local/src
wget https://launchpad.net/libmemcached/1.0/1.0.2/+download/libmemcached-1.0.2.tar.gz
tar -xvf libmemcached-1.0.2.tar.gz
cd libmemcached-1.0.2
./configure --prefix=/usr/local/services/libmemcached
make && make install

#
cd /usr/local/src
wget http://pecl.php.net/get/memcached-2.1.0.tgz
tar -xvf memcached-2.1.0.tgz
cd memcached-2.1.0
/usr/local/services/php/bin/phpize
./configure --enable-memcached --with-php-config=/usr/local/services/php/bin/php-config --with-zlib-dir --with-libmemcached-dir=/usr/local/services/libmemcached/
make && make install

#php
cd /usr/local/src
tar -xvf php-ext-memcache-2.2.6.tgz
cd memcache-2.2.6
/usr/local/services/php/bin/phpize
./configure --with-php-config=/usr/local/services/php/bin/php-config
make && make install

ldconfig

