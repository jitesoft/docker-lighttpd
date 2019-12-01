# syntax=docker/dockerfile:experimental
FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest
ARG VERSION
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/lighttpd" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/lighttpd/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/lighttpd" \
      com.jitesoft.app.lighttpd.version="${VERSION}"

ARG TARGETARCH
ENV PORT=80 \
    SERVER_NAME="localhost" \
    SERVER_ROOT="/var/www/html/" \
    CONFIG_FILE="/etc/lighttpd/lighttpd.conf" \
    SKIP_HEALTHCHECK="false" \
    MAX_FDS="1024"

RUN --mount=type=bind,source=./out,target=/tmp/lighty-bin \
    addgroup -g 1000 -S lighttpd \
 && adduser -u 1000 -S lighttpd -G lighttpd \
 && cp /tmp/lighty-bin/startup /tmp/lighty-bin/healthcheck /usr/local/bin \
 && chmod -R +x /usr/local/bin \
 && apk add --no-cache --virtual .req pcre-dev \
 && tar -xzhf /tmp/lighty-bin/lighttpd-${TARGETARCH}.tar.gz -C /usr/local \
 && mkdir -p /etc/lighttpd/conf.d /usr/local/lighttpd.d \
 && cp /tmp/lighty-bin/lighttpd.conf /etc/lighttpd \
 && cp /tmp/lighty-bin/conf.d/*.conf /etc/lighttpd/conf.d/

HEALTHCHECK --interval=1m --timeout=5s --start-period=30s CMD healthcheck
CMD startup
