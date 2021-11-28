#!/bin/ash

echo "--------------------------------------------------------------------------------"
echo "DEPRECATION WARNING"
echo "This image is deprecated and will stop getting updates"
echo "For a new image, please see the jitespft/lighttpd:*-cgi tags"
echo "See readme at https://github.com/jitesoft/docker-lighttpd for more information"
echo "--------------------------------------------------------------------------------"
echo "Awaiting CGI container..."
while ! nc -z ${FPM_CONTAINER} ${FPM_PORT}; do sleep 5; done
echo "CGI container is up. Starting lighttpd."
lighttpd -D -f ${CONFIG_FILE}
