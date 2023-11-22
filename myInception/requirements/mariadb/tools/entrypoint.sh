#!/bin/bash

mkdir -p /var/run/mysqld/
chown -R mysql:mysql /var/run/mysqld/
chown -R mysql:mysql /var/lib/mysql/

if [ ! -d "/var/lib/mysql/$MARIADB_NAME" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql/
    mysqld &
    MYSQL_PID=$!

sleep 10

mysqladmin -u root password "$MARIADB_ROOT_PWD"

mysql -u root <<-EOSQL
CREATE DATABASE $MARIADB_NAME;
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PWD';
GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO '$MARIADB_USER'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOSQL

    kill -TERM $MYSQL_PID
    wait $MYSQL_PID
fi

exec "$@"
