# lighttpd

Alpine linux with lighttpd built from source.

Observe: The image is not intended to be used for production environment, but feel free to, just make sure that you check the dockerfile and configuration and make sure that the security and settings are good enough for you.

## What is lighttpd

[Lighttpd](https://lighttpd.net) (lighty) is a lightweight webserver which is designed and optimized for high performance environments.
Lighttpd is open source under the reviced BSD license.

## The image

This image contains lighttpd built from source, it runs on the alpine linux distro, making it a small image keeping the disk, cpu and ram at a minimum!

The default configuration is a very basic config and you should probably [create your own](https://redmine.lighttpd.net/projects/lighttpd/wiki) instead!

## Environment variables

The following environment variables are used and exposed in the dockerfile:

```txt
PORT=80
SERVER_NAME=localhost
SERVER_ROOT=/var/www/html
CONFIG_FILE=/etc/lighttpd/lighttpd.conf
```

The default configuration file is located at `/etc/lighttpd/lighttpd.conf` but your own can be included in whatever way you wish. If you are not replacing the default file you can use the  `CONFIG_FILE` variable to point to your own file and ignore the default. `PORT` 80 is exposed and used by default, if changed, the default configuration will use the port defined in the env variable but you will have to expose it by yourself. `SERVER_NAME` defaults to localhost. `SERVER_ROOT` defaults to `/var/www/html`.

## FPM tag

The `fpm` tagged image have mod_fcgi_fpm enabeled with env variables set to enable connection to a php-fpm container. The lighttpd container will await the fpm container before starting. This image still requires the same volumes as the php fpm container (the files to serve).

```txt
FPM_CONTAINER="fpm"
FPM_PORT=9000
```