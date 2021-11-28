# syntax=docker/dockerfile:experimental
ARG VERSION
FROM registry.gitlab.com/jitesoft/dockerfiles/lighttpd:${VERSION}
ARG VERSION
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/lighttpd" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/lighttpd/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/lighttpd" \
      com.jitesoft.app.lighttpd.version="${VERSION}"

ENV PORT=80 \
    SERVER_NAME="localhost" \
    SERVER_ROOT="/var/www/html/" \
    CONFIG_FILE="/etc/lighttpd/lighttpd.conf" \
    SKIP_HEALTHCHECK="false" \
    MAX_FDS="1024" \
    CGI_HOST="fpm" \
    CGI_PORT="9000" \
    CHECK_LOCAL="enable" \
    CGI_FILE_EXT=".php"

RUN --mount=type=bind,source=./cgi,target=/tmp/cgi \
    cp /tmp/cgi/000-fastcgi.conf /etc/lighttpd/conf.d/ \
 && cp /tmp/cgi/entrypoint /usr/local/bin/entrypoint \
 && chmod +x /usr/local/bin/entrypoint

HEALTHCHECK --interval=1m --timeout=5s --start-period=30s CMD healthcheck
ENTRYPOINT [ "entrypoint" ]
CMD [ "startup" ]
