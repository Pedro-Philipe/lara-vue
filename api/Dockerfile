FROM php:7.4.2-fpm

WORKDIR "/application"

RUN apt-get update --fix-missing \
    && apt install -y apt-utils \
    && apt install -y libcurl4-gnutls-dev \
    && apt install -y libxml2-dev \
    && apt install -y freetds-dev \
    && apt install -y curl \
    && apt install -y libpq-dev \
    && apt install -y zip \
    && docker-php-ext-install calendar \
    && docker-php-ext-configure pgsql --with-pgsql=/usr/local/pgsql \
    && docker-php-ext-configure pdo_pgsql --with-pdo-pgsql=/usr/local/pgsql \
    && docker-php-ext-install pgsql pdo_pgsql

WORKDIR "/tmp"

RUN ls -la /tmp \
    && curl --silent --show-error https://getcomposer.org/installer | php \
    && ls -la /tmp/composer.phar \
    && mv /tmp/composer.phar /usr/local/bin/ \
    && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

WORKDIR "/application"

COPY . /application
COPY ./docker/php-fpm/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

RUN chmod 777 /usr/local/bin/docker-entrypoint.sh \
    && ln -s /usr/local/bin/docker-entrypoint.sh / \
    && chmod 777 -R storage/ \
    && chmod 777 -R bootstrap/cache/
