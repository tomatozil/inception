FROM alpine:3.17
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    mariadb \
    mysql-client \
    tini

RUN sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
RUN sed -i 's/#bind-address=0.0.0.0/bind-address=0.0.0.0/g' /etc/my.cnf.d/mariadb-server.cnf

COPY ./start_mariadb.sh /start_mariadb.sh
RUN chmod 755 /start_mariadb.sh

EXPOSE 3306

ENTRYPOINT ["/sbin/tini", "--", "/start_mariadb.sh"]

#CMD sleep infinity