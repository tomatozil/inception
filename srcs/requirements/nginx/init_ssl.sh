#!/bin/sh

openssl req -new -newkey rsa:2048 -nodes -keyout rootCA.key -out rootCA.csr -days 365 -subj "/CN=jiyun/C=KR/ST=Seoul/O=42Seoul/OU=www.jiyun.42.fr"
openssl x509 -req -in rootCA.csr -signkey rootCA.key -out rootCA.crt -days 365
openssl req -new -newkey rsa:2048 -nodes -keyout server.key -out server.csr -days 365 -subj "/CN=jiyun/C=KR/ST=Seoul/O=42Seoul/OU=www.jiyun.42.fr"
openssl x509 -req -in server.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out server.crt -days 365