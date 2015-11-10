#!/bin/bash
. /etc/profile

cur_dir=$(pwd)
show_option(){
    cat << EOF
Install Option:
    (N): Only compile and install Nginx;
    (M): Only compile and install MySQL;
    (P): Only compile and install PHP;
    (A): Compile and install LEMP(Nginx+MySQL+PHP);
    (Q): Quit;
EOF
    read -p "Please select an option (N,M,P,A,Q Default: A): > " OPTION
    case "$OPTION" in
    ""|A|a)
	sh $cur_dir/yum.sh
#	wget -i $cur_dir/list.txt -P /usr/local/src
 	sh $cur_dir/install_nginx.sh
 	sh $cur_dir/install_mysql_5.5.16.sh
	sh $cur_dir/install_phplib.sh
 	sh $cur_dir/install_php.sh
        exit 0;
    ;;
    M|m)
	sh $cur_dir/yum.sh
 	sh $cur_dir/install_mysql_5.5.16.sh
        lemp_complete mysql
        exit 0;
    ;;
    P|p)
	sh $cur_dir/{yum.sh,install_phplib.sh}
 	sh $cur_dir/install_php.sh
        lemp_complete php
        exit 0;
    ;;
    N|n)
 	sh $cur_dir/install_nginx_1.2.1.sh
        lemp_complete nginx
        exit 0;
    ;;
    Q|q)
        exit 0;
    ;;
    *)
        show_option;
    ;;
    esac
}

show_option

lemp_complete(){
    if [[ $1 == "lemp" ]];then
        /etc/rc.d/init.d/mysqld start
        /etc/init.d/nginx start
        /etc/init.d/fastcgi start
        color red
        echo "Congratulations! LEMP configuration complete!"
        color dred
        echo "You can visit http://$IP/test.php"
        color dgrn
        cat << EOF
+--------------------------------------------------------------------------------+
|                  === Installation Document Description ===                     |
+--------------------------------------------------------------------------------+
      MySQL SCRIPTS      :         /etc/init.d/mysqld start
      NGINX SCRIPTS      :         /etc/init.d/nginx start
      FASTCGI SCRIPTS    :         /etc/init.d/fastcgi start
      MySQL DATAPATH     :         $MYSQL_DATA_DIR/$MYSQL_PORT
      MYSQL PATH         :         $MYSQL_PREFIX
      MYSQL LISTEN PORT  :         $MYSQL_PORT
      PHP PATH           :         $PHP_PREFIX
      PHP CONFIG         :         $PHP_PREFIX/etc
      NGINX PATH         :         $NGINX_PREFIX
      NGINX LISTEN PORT  :         $NGINX_PORT
      NGINX DOCUMENTROOT :         $NGINX_ROOT
+--------------------------------------------------------------------------------+
|    Easy to install LEMP!   Have Fun^_^!     http://www.linuxtone.org           |
+--------------------------------------------------------------------------------+
EOF
        echo -en "\033[39;49;0m"
   elif [[ $1 == "mysql" ]];then
        /etc/rc.d/init.d/mysqld start
        color red
        echo "Congratulations! MySQL configuration complete!"
        color dgrn
        cat << EOF
+--------------------------------------------------------------------------------+
|                  === Installation Document Description ===                     |
+--------------------------------------------------------------------------------+
      MySQL SCRIPTS      :         /etc/init.d/mysqld start
      MySQL DATAPATH     :         $MYSQL_DATA_DIR/$MYSQL_PORT
      MYSQL PATH         :         $MYSQL_PREFIX
      MYSQL LISTEN PORT  :         $MYSQL_PORT
+--------------------------------------------------------------------------------+
|    Easy to install LEMP!   Have Fun^_^!     http://www.linuxtone.org           |
+--------------------------------------------------------------------------------+
EOF
        echo -en "\033[39;49;0m"
    elif [[ $1 == "php" ]];then
        /etc/init.d/fastcgi start
        color red
        echo "Congratulations! PHP configuration complete!"
        color dgrn
        cat << EOF
+--------------------------------------------------------------------------------+
|                  === Installation Document Description ===                     |
+--------------------------------------------------------------------------------+
      FASTCGI SCRIPTS    :         /etc/init.d/fastcgi start
      PHP PATH           :         $PHP_PREFIX
      PHP CONFIG         :         $PHP_PREFIX/etc
+--------------------------------------------------------------------------------+
|    Easy to install LEMP!   Have Fun^_^!     http://www.linuxtone.org           |
+--------------------------------------------------------------------------------+
EOF
        echo -en "\033[39;49;0m"
    elif [[ $1 == "nginx" ]];then
        /etc/init.d/nginx start
        if [ $NGINX_PORT == "80" ];then
            URL=$IP
        else
            URL=$IP:$NGINX_PORT
        fi
        color red
        echo "Congratulations! Nginx configuration complete!"
        color dred
        echo "You can visit http://$URL/test.html"
        color dgrn
        cat << EOF
+--------------------------------------------------------------------------------+
|                  === Installation Document Description ===                     |
+--------------------------------------------------------------------------------+
      NGINX SCRIPTS      :         /etc/init.d/nginx start
      NGINX PATH         :         $NGINX_PREFIX
      NGINX LISTEN PORT  :         $NGINX_PORT
      NGINX DOCUMENTROOT :         $NGINX_ROOT
+--------------------------------------------------------------------------------+
|    Easy to install LEMP!   Have Fun^_^!     http://www.linuxtone.org           |
+--------------------------------------------------------------------------------+
EOF
        echo -en "\033[39;49;0m"
    fi
}
