# syntax=docker/dockerfile:experimental
FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:3.14
ARG VERSION
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/lighttpd" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/lighttpd/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/lighttpd" \
      com.jitesoft.app.lighttpd.version="${VERSION}"

ARG WWWDATA_GUID="82"
ARG TARGETARCH
ENV PORT=80 \
    SERVER_NAME="localhost" \
    SERVER_ROOT="/var/www/html/" \
    CONFIG_FILE="/etc/lighttpd/lighttpd.conf" \
    SKIP_HEALTHCHECK="false" \
    MAX_FDS="1024" \
    WWWDATA_GUID="${WWWDATA_GUID}"

RUN --mount=type=bind,source=./out,target=/tmp/lighty-bin \
    adduser -u ${WWWDATA_GUID} -S www-data -G www-data \
 && cp /tmp/lighty-bin/startup /tmp/lighty-bin/healthcheck /usr/local/bin \
 && chmod -R +x /usr/local/bin \
 && apk add --no-cache --virtual .req pcre-dev \
 && tar -xzhf /tmp/lighty-bin/lighttpd-${TARGETARCH}.tar.gz -C /usr/local \
 && mkdir -p /etc/lighttpd/conf.d /usr/local/lighttpd.d \
 && cp /tmp/lighty-bin/lighttpd.conf /etc/lighttpd \
 && cp /tmp/lighty-bin/conf.d/*.conf /etc/lighttpd/conf.d/ \
 # Sanity check \
 && lighttpd -V

HEALTHCHECK --interval=1m --timeout=5s --start-period=30s CMD healthcheck
CMD startup
