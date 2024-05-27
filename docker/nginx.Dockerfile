FROM nginx:stable-alpine

RUN delgroup dialout

RUN addgroup -g 1000 --system laravel
RUN adduser -G laravel --system -D -s /bin/sh -u 1000 laravel
RUN sed -i "s/user  nginx/user laravel/g" /etc/nginx/nginx.conf
