#!/bin/bash
set -e

echo "[ ****************** ] Starting Endpoint of Application [ ****************** ]"

echo "Granting 777 access to laravel storage path"
chmod 777 -R storage/
chmod 777 -R bootstrap/cache/

exec "$@"

set -- php-fpm

exec "$@"
