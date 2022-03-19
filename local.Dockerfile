FROM php:8.0-fpm

ARG DEBIAN_FRONTEND=noninteractive

# Update
RUN apt-get -y update --fix-missing && \
    apt-get upgrade -y && \
    apt-get --no-install-recommends install -y apt-utils && \
    rm -rf /var/lib/apt/lists/*

# Install tools and libaries
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install vim wget zip openssl dialog \
    libsqlite3-dev libsqlite3-0 zlib1g-dev libzip-dev libicu-dev \
    build-essential git curl libonig-dev libcurl4 libcurl4-openssl-dev \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev && \
    rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt install -y nodejs && \
    npm install -g yarn

# Install and set up PHP 8 extensions
RUN docker-php-ext-install pdo_mysql && \
    docker-php-ext-install mysqli && \
    docker-php-ext-install zip && \
    docker-php-ext-install -j$(nproc) intl && \
    docker-php-ext-install gettext && \
    docker-php-ext-install exif && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-configure gd --with-freetype --with-jpeg

# Install xdebug
RUN pecl install xdebug-3.0.0 && \
    docker-php-ext-enable xdebug

WORKDIR /srv/sylius
