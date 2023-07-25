FROM alpine:3.17

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    curl \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-phar \
    php81-mbstring \
    mysql-client \
    tini

WORKDIR /

RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php81/php-fpm.d/www.conf
RUN sed -i 's/;chdir = \/var\/www/chdir = \/var\/www\/html/g' /etc/php81/php-fpm.d/www.conf

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin
RUN chmod +x /usr/local/bin/wp-cli.phar
RUN ln -sf /usr/local/bin/wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

EXPOSE 9000

ADD ./entrypoin.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

#CMD sleep infinity

#tini -> shell script를 쓰면은 pid 1이 돼 