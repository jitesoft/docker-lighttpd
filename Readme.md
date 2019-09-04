# Lighttpd


[![Docker Pulls](https://img.shields.io/docker/pulls/jitesoft/lighttpd.svg)](https://hub.docker.com/r/jitesoft/lighttpd)
[![Back project](https://img.shields.io/badge/Open%20Collective-Tip%20the%20devs!-blue.svg)](https://opencollective.com/jitesoft-open-source)

Alpine linux with Lighttpd built from source.

_Please take a moment and check so that the configuration file is suitable for your case before using the image in production. 
Jitesoft takes no responsibility for how you use the image._

## Tags

### Docker Hub

* `jitesoft/lighttpd`
    * `latest`, `1.4.54`
    * `1.4.53`
    * `1.4.49`
    * `fpm`, `latest-fpm`, `1.4.54`
    * `1.4.53-fpm`
    * `1.4.49-fpm`

### GitLab

* `registry.gitlab.com/jitesoft/dockerfiles/lighttpd`
    * `latest`, `1.4.54`
    * `1.4.53`
    * `1.4.49`
    * `fpm`, `latest-fpm`, `1.4.54`
    * `1.4.53-fpm`
    * `1.4.49-fpm`

### Quay.io

* `quay.io/jitesoft/lighttpd`
    * `latest`, `1.4.54`
    * `1.4.53`
    * `1.4.49`
    * `fpm`, `latest-fpm`, `1.4.54`
    * `1.4.53-fpm`
    * `1.4.49-fpm`

Dockerfiles can be found at [GitLab](https://gitlab.com/jitesoft/dockerfiles/lighttpd/blob/master/cgi/Dockerfile) and
[GitHub](https://github.com/jitesoft/docker-lighttpd).

## What is Lighttpd?

[Lighttpd](https://lighttpd.net) (lighty) is a lightweight web-server which is designed and optimized for high performance environments.
Lighttpd is open source under the revised BSD license.

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
SKIP_HEALTHCHECK=false
```

The default configuration file is located at `/etc/lighttpd/lighttpd.conf` but your own can be included in whatever way you wish. 
If you are not replacing the default file you can use the  `CONFIG_FILE` variable to point to your own file and ignore the default. 
`PORT` 80 is exposed and used by default, if changed, the default configuration will use the port defined in the env variable but 
you will have to expose it by yourself. `SERVER_NAME` defaults to localhost. `SERVER_ROOT` defaults to `/var/www/html`.

The `SKIP_HEALTHCHECK` flag will, if set to `"true"` mark the container as healthy as long as it is running, while if left default or set to 
`"false"` will run a query on the `127.0.0.1:${PORT}` endpoint every minute.  
It's exposed as an environment variable due to the fact that a 404 will be reported as an error and exit the health check with a none-`0` exit code.

## FPM tag

The `fpm` tagged image have mod_fcgi_fpm enabled with env variables set to enable connection to a php-fpm container. 
The lighttpd container will await the fpm container before starting. This image still requires the same volumes as the php fpm container (the files to serve).

```txt
FPM_CONTAINER="fpm"
FPM_PORT=9000
```

### Image labels

This image follows the [Jitesoft image label specification 1.0.0](https://gitlab.com/snippets/1866155).

## Licenses

This repository is realeased under the [MIT license](https://gitlab.com/jitesoft/dockerfiles/lighttpd/blob/master/LICENSE).  
You can find the Lighttpd license [here](https://git.lighttpd.net/lighttpd/lighttpd1.4.git/tree/COPYING).
