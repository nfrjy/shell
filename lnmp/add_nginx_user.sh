#/usr/sbin/groupadd www
/usr/sbin/useradd www -u 500
mkdir -p /data/{logs,www}
chmod 755 -R /data/{logs,www}
chown www:www -R /data/{logs,www}
