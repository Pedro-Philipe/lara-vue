#!/bin/bash
set -e

echo "[ ****************** ] Starting Endpoint of Application [ ****************** ]"

if ! [ -d "./vendor" ]; then
    echo " Install depedences whit composer..."
    composer install --ignore-platform-reqs  --no-interaction --verbose --no-suggest
fi

echo "Granting 777 access to laravel storage and cache paths"
chmod 777 -R storage/
chmod 777 -R bootstrap/cache/

exec "$@"

set -- php-fpm

exec "$@"
