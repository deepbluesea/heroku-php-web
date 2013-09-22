# Heroku PHP web server buildpack

This is a custom Heroku buildpack providing an [Nginx] web server dispatching to
[PHP-FPM], with [Composer] integration. For the current software versions, see
[versions.bash].

If the web server is not required, use [jmalloc/heroku-php] instead.

## Installation

On a new Heroku app:

    heroku create <app-name> --buildpack https://github.com/jmalloc/heroku-php-web.git

On an existing Heroku app:

    heroku config:set BUILDPACK_URL=https://github.com/jmalloc/heroku-php-web.git

## Application structure

### PHP

  - `web/` - Any content in this folder will be served statically.
  - `bin/heroku` - Any requests that do not match a file in `web/` are routed
    to this PHP script. Executable permissions are not required.
  - `composer.json` - If present, non-development Composer dependencies will be
    installed.
  - `etc/` - Any configuration files in this folder will supplement or override
    the files supplied in this buildpack.
    - `php/php.ini` - The primary PHP configuration file.
    - `php/conf.d/` - Directory for additional PHP configuration files. Any file
      ending in `.ini` will be parsed.
    - `nginx.conf` - The Nginx configuration file.
    - `php-fpm.conf` - The PHP-FPM configuration file.

### Heroku hooks

If any of the following files are present they are executed at the appropriate
point:

  - `bin/heroku-hooks/compile-start` - Before slug compilation is started; PHP
    is not available.
  - `bin/heroku-hooks/compile-complete` - After slug compilation; PHP and
    Composer dependencies available.
  - `bin/heroku-hooks/dyno-start` - Before Nginx and PHP-FPM are started.

<!-- References -->

[Composer]: http://getcomposer.org/
[jmalloc/heroku-php]: https://github.com/jmalloc/heroku-php
[PHP-FPM]: http://php-fpm.org/
[Nginx]: http://nginx.org/
[versions.bash]: lib/versions.bash
