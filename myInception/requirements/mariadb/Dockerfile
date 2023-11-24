FROM debian:bullseye

EXPOSE 3306

COPY ./tools/entrypoint.sh /entrypoint.sh

RUN apt-get update && \
    apt-get install -y vim mariadb-server && \
    chmod +x entrypoint.sh

COPY ./conf/test.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld"]
