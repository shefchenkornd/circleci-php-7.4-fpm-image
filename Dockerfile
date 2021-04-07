FROM php:7.4-fpm

ADD deployment/configs/common/php-fpm/uploads.ini /usr/local/etc/php/conf.d/uploads.ini

RUN apt-get update && apt-get install --assume-yes zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev

RUN docker-php-ext-install exif
RUN docker-php-ext-configure exif \
            --enable-exif

RUN docker-php-ext-install pdo_mysql

# soap
RUN rm /etc/apt/preferences.d/no-debian-php && \
    apt-get update && apt-get install -y \
    libssl-dev \
    libxml2-dev \
    php-soap \
    && apt-get clean -y \
    && docker-php-ext-install soap \
    && docker-php-ext-enable soap

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev \
        libonig-dev \
        graphviz \
    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-source delete

RUN apt-get update
RUN apt-get install unzip

RUN apt-get install -y nano less
