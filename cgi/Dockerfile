FROM registry.gitlab.com/jitesoft/dockerfiles/lighttpd:latest
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>"

ENV FPM_CONTAINER="fpm" \
    FPM_PORT=9000

COPY --chown=lighttpd:lighttpd fastcgi.conf /etc/lighttpd/mod_fastcgi_fpm.conf
COPY --chown=lighttpd:lighttpd startup.sh startup

RUN echo 'include "mod_fastcgi_fpm.conf"' >> /etc/lighttpd/lighttpd.conf \
    && chmod +x ./startup

CMD ./startup
