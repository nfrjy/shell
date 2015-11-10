sed -i 's/error_reporting = E_ALL \& ~E_NOTICE/error_reporting = E_WARNING \& E_ERROR/g' /usr/local/services/php/etc/php.ini
sed -i '/display_errors/ {s/On/Off/g};/log_errors/ {s/Off/On/g}' /usr/local/services/php/etc/php.ini
sed -i "s#;error_log = filename#error_log = /tmp/php-error.log#g" /usr/local/services/php/etc/php.ini
sed -i "s#;always_populate_raw_post_data = On#always_populate_raw_post_data = On#g" /usr/local/services/php/etc/php.ini

cat >>/usr/local/services/php/etc/php.ini<<EOF
extension_dir = "/usr/local/services/php/lib/php/extensions/no-debug-non-zts-20090626/"
extension = "memcache.so"
extension = "memcached.so"
extension = "imagick.so"
extension = "tidy.so"
extension = "gmagick.so"
extension = "eaccelerator.so"

eaccelerator.cache_dir="/data/cache/eaccelerator_cache"
eaccelerator.enable="1"
eaccelerator.optimizer="1"
eaccelerator.check_mtime="1"
eaccelerator.debug="0"
eaccelerator.filter=""
eaccelerator.shm_max="0"
eaccelerator.shm_ttl="3600"
eaccelerator.shm_prune_period="3600"
eaccelerator.shm_only="0"
eaccelerator.compress="1"
eaccelerator.compress_level="9"
EOF
