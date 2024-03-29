# Lighttpd


[![Docker Pulls](https://img.shields.io/docker/pulls/jitesoft/lighttpd.svg)](https://hub.docker.com/r/jitesoft/lighttpd)
[![Back project](https://img.shields.io/badge/Open%20Collective-Tip%20the%20devs!-blue.svg)](https://opencollective.com/jitesoft-open-source)

Alpine linux with Lighttpd built from source.

[Lighttpd](https://lighttpd.net) (lighty) is a lightweight web-server which is designed and optimized for high performance environments.
Lighttpd is open source under the revised BSD license.

To add a new configurations (more than the default configuration), add a new `*.conf` file to the `/usr/local/lighttpd.d` directory.
Each file in that directory will be included into the configuration.  
If you wish to replace the base configuration fully, replace the `/etc/lighttpd/conf.d/lighttpd.conf` file or add a new file
and change the `CONFIG_FILE` env variable to your preferred path.

### Deprecation  of FPM / introduction of CGI

The -fpm tagged images are deprecated as of 2021-11-28 and will stop receiving updates.  
For a replacement, see the -cgi tagged images, which will be similar but with some differences.

## Tags

Tags are based on lighttpd version where latest is the latest version at build time.  
Older versions are not re-built, only latest version.  

Images can be found at:

* [Docker hub](https://hub.docker.com/r/jitesoft/lighttpd): `jitesoft/lighttpd`  
* [GitLab](https://gitlab.com/jitesoft/dockerfiles/lighttpd): `registry.gitlab.com/jitesoft/dockerfiles/lighttpd`
* [GitHub](https://github.com/orgs/jitesoft/packages/container/package/lighttpd): `ghcr.io/jitesoft/lighttpd`
* [Quay](https://quay.io/repository/jitesoft/lighttpd) `quay.io/jitesoft/httpd`

Dockerfiles can be found at [GitLab](https://gitlab.com/jitesoft/dockerfiles/lighttpd/blob/master/cgi/Dockerfile) and
[GitHub](https://github.com/jitesoft/docker-lighttpd).

## The image

This image contains lighttpd built from source, it runs on the alpine linux distro, making it a small image keeping the disk, cpu and ram at a minimum!

### www-data user

Prior to 2021 07 23, the image used the user lighttpd (1000/1000) to run the image.  
This have been changed to use the default www-data group and a www-data user with id 82
to comply with standard www-data user in alpine images.

Containers created runs as root (easily changed in production with the appropriate flags),
while the lighttpd process runs as the www-data user (82) by default.

## Environment variables

The following environment variables are used and exposed in the dockerfile:

```txt
PORT=80
SERVER_NAME=localhost
SERVER_ROOT=/var/www/html
CONFIG_FILE=/etc/lighttpd/lighttpd.conf
SKIP_HEALTHCHECK=false
MAX_FDS=1024
```

The default configuration file is located at `/etc/lighttpd/lighttpd.conf` but your own can be included in whatever way you wish. 
If you are not replacing the default file you can use the  `CONFIG_FILE` variable to point to your own file and ignore the default. 
`PORT` 80 is exposed and used by default, if changed, the default configuration will use the port defined in the env variable but 
you will have to expose it by yourself. `SERVER_NAME` defaults to localhost. `SERVER_ROOT` defaults to `/var/www/html`.

The `SKIP_HEALTHCHECK` flag will, if set to `"true"` mark the container as healthy as long as it is running, while if left default or set to 
`"false"` will run a query on the `127.0.0.1:${PORT}` endpoint every minute.  
It's exposed as an environment variable due to the fact that a 404 will be reported as an error and exit the health check with a none-`0` exit code.

The `MAX_FDS` variable sets the maximum file descriptors used by lighttpd and could be tweaked if needed.

## CGI tag

The `cgi` tagged image have `mod_fastcgi` enabled with env variables set to enable connection to a separate cgi host. 
The lighttpd container will await the cgi host before starting by checking the host with nc (netcat, busybox version).  

```txt
CGI_HOST="fpm"
CGI_PORT="9000"
CHECK_LOCAL="enable"
CGI_FILE_EXT=".php"
```

If you do not want to share data between your containers, set the `CHECK_LOCAL` to "disable" to ignore 
local files in the lighttpd container.

The default configuration (which resides in `/etc/lighttpd/conf.d`) contains the following configuration:

```txt
server.modules += ("mod_fastcgi")
fastcgi.server += ( env.CGI_FILE_EXT =>
        ((
                "host" => env.CGI_HOST,
                "port" => env.CGI_PORT,
                "broken-scriptfilename" => "enable",
                "docroot" => env.SERVER_ROOT,
                "check-local" => env.CHECK_LOCAL

        ))
)
```

Once the cgi container have connected, it will create an empty file in `/tmp/ready` which can be used
as a startup indicator if needed.

### Image labels

This image follows the [Jitesoft image label specification 1.0.0](https://gitlab.com/snippets/1866155).

## Licenses

This repository is released under the [MIT license](https://gitlab.com/jitesoft/dockerfiles/lighttpd/blob/master/LICENSE).  
You can find the Lighttpd license [here](https://git.lighttpd.net/lighttpd/lighttpd1.4.git/tree/COPYING).

### Sponsors

Jitesoft images are built via GitLab CI on runners hosted by the following wonderful organisations:

<a href="https://osuosl.org/" target="_blank" title="Oregon State University - Open Source Lab">
    <img src="https://jitesoft.com/images/oslx128.webp" alt="Oregon State University - Open Source Lab">
</a>

_The companies above are not affiliated with Jitesoft or any Jitesoft Projects directly._

---

Sponsoring is vital for the further development and maintaining of open source.  
Questions and sponsoring queries can be made by <a href="mailto:sponsor@jitesoft.com">email</a>.  
If you wish to sponsor our projects, reach out to the email above or visit any of the following sites:  

[Open Collective](https://opencollective.com/jitesoft-open-source)  
[GitHub Sponsors](https://github.com/sponsors/jitesoft)  
[Patreon](https://www.patreon.com/jitesoft)
