#!/bin/bash

mkdir -p /var/run/mysqld/
chown -R mysql:mysql /var/run/mysqld/

sed -i "s/bind-address/#bind-address/" /etc/mysql/mariadb.conf.d/50-server.cnf

if [ ! -d "/var/lib/mysql/$MARIADB_NAME" ]; then
    mysqld &

    sleep 10

    mysql -u root <<-EOSQL
    CREATE DATABASE $MARIADB_NAME;
    CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PWD';
    GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO '$MARIADB_USER'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
    EOSQL

    mysqladmin -u root shutdown
fi

exec "$@"
