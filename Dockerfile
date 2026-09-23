FROM php:8.5-fpm-alpine

# System-Abhängigkeiten installieren
RUN apk add --no-cache \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libzip-dev \
    zip \
    unzip

# PHP-Erweiterungen EINZELN installieren (isoliert die Prozesse)
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo_mysql

RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install gd

RUN docker-php-ext-install zip

# Webseiten-Optimierungen (Limits erhöhen)
RUN echo "upload_max_filesize = 256M" > /usr/local/etc/php/conf.d/custom-limits.ini \
    && echo "post_max_size = 256M" >> /usr/local/etc/php/conf.d/custom-limits.ini \
    && echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/custom-limits.ini \
    && echo "date.timezone = Europe/Berlin" >> /usr/local/etc/php/conf.d/custom-limits.ini \
    && echo "expose_php = Off" >> /usr/local/etc/php/conf.d/custom-limits.ini \
    && echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/custom-limits.ini \
    && echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/custom-limits.ini \
    && echo "opcache.memory_consumption=128" >> /usr/local/etc/php/conf.d/custom-limits.ini \
    && echo "opcache.interned_strings_buffer=16" >> /usr/local/etc/php/conf.d/custom-limits.ini \
    && echo "opcache.max_accelerated_files=4000" >> /usr/local/etc/php/conf.d/custom-limits.ini \
    && echo "opcache.revalidate_freq=0" >> /usr/local/etc/php/conf.d/custom-limits.ini \
    && echo "opcache.save_comments=1" >> /usr/local/etc/php/conf.d/custom-limits.ini \
    && echo "opcache.jit_buffer_size=64M" >> /usr/local/etc/php/conf.d/custom-limits.ini \
    && echo "opcache.jit=tracing" >> /usr/local/etc/php/conf.d/custom-limits.ini