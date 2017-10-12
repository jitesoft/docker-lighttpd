FROM alpine:3.6
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>"

ENV PORT=80

RUN apk add --no-cache lighttpd lighttpd-mod_auth
ADD ./lighttpd.conf /etc/lighttpd/lighttpd.conf
EXPOSE 80

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]