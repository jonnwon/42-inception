#!/bin/bash

MYSQL_ROOT_PASSWORD=${MARIADB_PWD}
MYSQL_DATABASE=${MARIADB_NAME}
MYSQL_USER=${MARIADB_USER}
MYSQL_PASSWORD=${MARIADB_PWD}

mkdir -p /var/run/mysqld/
chown -R mysql:mysql /var/run/mysqld/
chown -R mysql:mysql /var/lib/mysql/

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
  mysql_install_db --user=mysql --datadir=/var/lib/mysql/
  mysqld &
  MYSQL_PID=$!

  sleep 10

  mysqladmin -u root password "$MYSQL_ROOT_PASSWORD"

  mysql -u root <<-EOSQL
    CREATE DATABASE $MYSQL_DATABASE;
    CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
    GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
  EOSQL

  # Instead of using kill -TERM, use mysqladmin shutdown to gracefully shut down the MySQL server process
  mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown
  wait $MYSQL_PID
fi

exec mysqld
