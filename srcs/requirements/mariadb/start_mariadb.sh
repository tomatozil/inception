#!/bin/sh

if [ ! -d "/run/mysqld" ]; then
  mkdir -p /run/mysqld
  chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
#  -- Create a new database
#  -- Create a new user for WordPress
#  -- Grant all privileges on the WordPress database to the user
#  -- Flush privileges to apply the changes
    tfile=`mktemp`
    cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES ;
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DB\`;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON \`$MYSQL_DB\`.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';
FLUSH PRIVILEGES ;
EOF
    /usr/bin/mysqld --user=mysql --bootstrap < $tfile
    rm -f $tfile
fi

exec /usr/bin/mysqld --user=mysql