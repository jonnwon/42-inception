FROM debian:bullseye

EXPOSE 9000

COPY tools/entrypoint.sh/ /entrypoint.sh

RUN apt-get -y update && \
apt-get -y install \
php7.4 \
php-fpm \
php-cli \
wget \
curl \
php-mysql \
php-mbstring \
php-xml \
sendmail \
vim && \
chmod +x entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]
