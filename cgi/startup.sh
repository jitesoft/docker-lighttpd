#!/bin/ash
echo "Awaiting CGI container..."
while ! nc -z ${FPM_CONTAINER} ${FPM_PORT}; do sleep 5; done
echo "CGI container is up. Starting lighttpd."
lighttpd -D -f ${CONFIG_FILE}
