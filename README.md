# Heroku PHP

This is a custom Heroku buildpack providing an Nginx server dispatching to PHP-FPM.

## Installation

On a new Heroku app:

    $ heroku create <app-name> --buildpack https://github.com/IcecaveStudios/heroku-php-web.git

On an existing Heroku app:

    $ heroku config:set BUILDPACK_URL=https://github.com/IcecaveStudios/heroku-php-web.git

## Application structure

### PHP

 * **/public/** - Any content in this folder will be served statically
 * **/bin/heroku** - Any requests that do not match a file in **public/** are routed to this PHP script
 * **/composer.json** - If a composer.json file is present, non-development [Composer](https://getcomposer.org) dependencies will be installed

### Heroku hooks

 * **/bin/heroku-hooks/compile-start** - Executed before slug compilation is started (PHP is not available)
 * **/bin/heroku-hooks/compile-complete** - Executed after slug compilation (PHP and all Composer dependencies has been installed)
 * **/bin/heroku-hooks/compile-complete** - Executed before Nginx and PHP-FPM are started.
