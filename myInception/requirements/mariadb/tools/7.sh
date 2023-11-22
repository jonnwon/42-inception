#!/bin/sh

MYSQL_ROOT_PASSWORD=${MARIADB_PWD}
MYSQL_DATABASE=${MARIADB_NAME}
MYSQL_USER=${MARIADB_USER}
MYSQL_PASSWORD=${MARIADB_PWD}

if [ ! -d "/var/lib/mysql/$MARIADB_NAME" ]; then
  mysql_install_db --datadir=/var/lib/mysql --auth-root-authentication-method=normal >/dev/null
sleep 10
  mysqld --bootstrap << EOF


use mysql;

CREATE DATABASE $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

flush privileges;

EOF
fi

echo "\
--------------------

@mariadb ready
@port:3306

--------------------"

exec "$@"
