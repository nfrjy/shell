cd /usr/local/src
tar zxvf libiconv-1.14.tar.gz
cd libiconv-1.14
./configure && make && make install

cd /usr/local/src
tar zxvf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure && make && make install
/sbin/ldconfig
cd libltdl/
./configure --enable-ltdl-install
make && make install

echo "/usr/lib" >> /etc/ld.so.conf
echo "/usr/local/lib" >> /etc/ld.so.conf
ldconfig

. $cur_dir/add_nginx_user.sh