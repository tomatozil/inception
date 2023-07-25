FROM alpine:3.17
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    nginx \
    openssl \
    && rm -rf /var/cache/apk/*

RUN mkdir /etc/nginx/ssl

COPY ./init_ssl.sh /etc/nginx/ssl/init_ssl.sh
RUN chmod 755 /etc/nginx/ssl/init_ssl.sh
WORKDIR /etc/nginx/ssl/
RUN ./init_ssl.sh

COPY ./my_config.conf /etc/nginx/http.d/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]