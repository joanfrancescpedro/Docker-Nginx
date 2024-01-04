
# We use the alpine image as the base OS
FROM alpine:latest

LABEL maintainer="Dockerfile maintainer <joan.f.pedro@protonmail.com>"

# We run the command to update the packages in the system and install nginx in our system:
RUN addgroup -g 101 -S nginx &&\
    adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx && \
    apk update  && \
    apk upgrade && \
    apk add openrc --no-cache && \
    apk add nginx && \
    apk add --no-cache tzdata && \
    apk add --no-cache curl ca-certificates && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Volumes
VOLUME /usr/share/nginx/html
VOLUME /etc/nginx
VOLUME /var/log/nginx/log

# We copy our content of the Content to create our website 
# and the configuration files we have for the app
COPY content /usr/share/nginx/html
COPY conf /etc/nginx

# We run the service
# RUN rc-service nginx start

# We expose the nginx port, 80
EXPOSE 80

STOPSIGNAL SIGQUIT

# We run the cmd to make the service permanent
CMD ["nginx", "-g", "daemon off;"]