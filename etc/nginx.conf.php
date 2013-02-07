daemon off;
worker_processes 1;

events {
    worker_connections 1024;
}

http {
    include             mime.types;
    default_type        application/octet-stream;
    sendfile            on;
    gzip                on;
    keepalive_timeout   30;

    access_log /app/heroku/vendor/nginx/logs/http.log;
    error_log  /app/heroku/vendor/nginx/logs/http.log;

    server {
        listen          <?php echo $_SERVER['PORT']; ?>;
        server_name     localhost;
        root            /app/public;

        location = /favicon.ico {
          return        204;
          access_log    off;
          log_not_found off;
        }

        location / {
            try_files $uri @app;
        }

        location @app {
            include         fastcgi_params;
            fastcgi_param   SCRIPT_FILENAME /app/bin/heroku;
            fastcgi_pass    unix:/tmp/php-fpm.socket;
        }
    }
}
