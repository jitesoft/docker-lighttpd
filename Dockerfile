# syntax=docker/dockerfile:experimental
FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:3.20
ARG VERSION
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/lighttpd" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/lighttpd/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/lighttpd" \
      com.jitesoft.app.lighttpd.version="${VERSION}" \
      # Open container labels
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.created="${BUILD_TIME}" \
      org.opencontainers.image.description="Lighttpd on Alpine linux" \
      org.opencontainers.image.vendor="Jitesoft" \
      org.opencontainers.image.source="https://gitlab.com/jitesoft/dockerfiles/lighttpd" \
      # Artifact hub annotations
      io.artifacthub.package.alternative-locations="oci://index.docker.io/jitesoft/lighttpd,oci://ghcr.io/jitesoft/lighttpd,oci://registry.gitlab.com/jitesoft/dockerfiles/lighttpd" \
      io.artifacthub.package.readme-url="https://gitlab.com/jitesoft/dockerfiles/lighttpd/-/raw/master/README.md" \
      io.artifacthub.package.logo-url="https://jitesoft.com/favicon-96x96.png"

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
 && cp /tmp/lighty-bin/entrypoint /tmp/lighty-bin/healthcheck /usr/local/bin \
 && chmod -R +x /usr/local/bin \
 && apk add --no-cache --virtual .req pcre2 brotli libressl3.8-libcrypto libress3.8-libssl \
 && tar -xzhf /tmp/lighty-bin/lighttpd-${TARGETARCH}.tar.gz -C /usr/local \
 && mkdir -p /etc/lighttpd/conf.d /usr/local/lighttpd.d \
 && cp /tmp/lighty-bin/lighttpd.conf /etc/lighttpd \
 && cp /tmp/lighty-bin/conf.d/*.conf /etc/lighttpd/conf.d/ \
 # Sanity check \
 && lighttpd -V

HEALTHCHECK --interval=1m --timeout=5s --start-period=30s CMD healthcheck
ENTRYPOINT ["entrypoint"]
CMD ["-D"]
