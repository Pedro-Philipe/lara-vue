#!/bin/bash
set -e

echo "[ ****************** ] Starting Endpoint of Application [ ****************** ]"

if ! [ -d "./vendor" ]; then
    echo " Install depedences whit composer..."
    composer install --ignore-platform-reqs  --no-interaction --verbose --no-suggest
fi

exec "$@"

set -- php-fpm

exec "$@"
