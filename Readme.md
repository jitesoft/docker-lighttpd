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
PORT
SERVER_NAME
SERVER_ROOT
CONFIG_FILE
```

The default configuration file is located at `/etc/lighttpd/lighttpd.conf` but your own can be included in whatever way you wish. If you are not replacing the default file you can use the  `CONFIG_FILE` variable to point to your own file and ignore the default. `PORT` 80 is exposed and used by default, if changed, the default configuration will use the port defined in the env variable but you will have to expose it by yourself. `SERVER_NAME` defaults to localhost. `SERVER_ROOT` defaults to `/var/www/html`.
