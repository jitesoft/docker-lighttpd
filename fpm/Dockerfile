FROM registry.gitlab.com/jitesoft/dockerfiles/lighttpd:latest
ENV FPM_CONTAINER="fpm" \
    FPM_PORT=9000 \
    CHECK_LOCAL="enable"

COPY 000-fastcgi.conf /etc/lighttpd/conf.d/
COPY startup.sh /usr/local/bin/startup-fpm
RUN chmod +x /usr/local/bin/startup-fpm

CMD [ "startup-fpm" ]
