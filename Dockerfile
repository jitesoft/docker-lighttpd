FROM alpine:3.7
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>"

ARG VERSION=1.4.49
ARG KEYS="6FE198C8 \
42909B84 \
1E95BAD7"

ENV PORT=80 \
    SERVER_NAME="localhost" \
    SERVER_ROOT="/var/www/html/"

RUN apk add --no-cache --virtual .trash curl gnupg \
    && curl -OsS https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-${VERSION}.tar.xz \
            -OsS https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-${VERSION}.tar.xz.asc \
            -OsS https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-${VERSION}.sha256sum \
    && for key in ${KEYS}; do \
        gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
        gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
        gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" ; \
    done \
    && gpg --verify lighttpd-${VERSION}.tar.xz.asc lighttpd-${VERSION}.tar.xz \
    && grep " lighttpd-${VERSION}.tar.xz\$" lighttpd-${VERSION}.sha256sum | sha256sum -c - \
    && tar -xf lighttpd-${VERSION}.tar.xz \
    && rm lighttpd-${VERSION}.tar.xz.asc lighttpd-${VERSION}.sha256sum lighttpd-${VERSION}.tar.xz \
    && apk del .trash \
    && apk add --no-cache --virtual .build-deps build-base flex pcre-dev libressl-dev zlib-dev  bzip2-dev lua5.3-dev automake autoconf openldap-dev libxml2-dev sqlite-dev libev-dev gamin-dev \
    && ./lighttpd-${VERSION}/configure --with-lua --with-openssl --with-ldap \
    && make lighttpd-${VERSION} \
    && make install lighttpd-${VERSION} \
    && rm -rf lighttpd-${VERSION} \
    && apk del .build-deps

ADD lighttpd.conf /etc/lighttpd/lighttpd.conf

CMD ["lighttpd", "-D", "-f", ${CONFIG_FILE}]