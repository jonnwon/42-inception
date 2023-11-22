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

#COPY ./conf/php-fpm.conf /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm7.4", "-F"]

#CMD ["/bin/bash"]
