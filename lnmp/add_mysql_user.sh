#/usr/sbin/groupadd mysql -g 501
/usr/sbin/useradd -u 501 -c "MySQL Server" mysql5.5 -s /sbin/nologin
mkdir -p /data/mysql/{data,logs/{binlog,relaylog}}
chown mysql5.5:mysql5.5 -R /data/mysql
