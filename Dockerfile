FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    libsqlite3-dev \
    libonig-dev \
    libpng-dev \
    && docker-php-ext-install zip pdo pdo_mysql pdo_sqlite mysqli

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY ./src /var/www/html

EXPOSE 9000
