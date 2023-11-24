FROM debian:bullseye

EXPOSE 3306

COPY ./tools/entrypoint.sh /entrypoint.sh

RUN apt-get update && \
    apt-get install -y vim mariadb-server && \
    chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld"]
