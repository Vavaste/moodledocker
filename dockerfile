# Usa un'immagine di base con PHP e Apache
FROM php:8.1.13-apache

# Installa le estensioni PHP necessarie per Moodle e l'estensione zip
RUN apt-get update && apt-get install -y \
        libzip-dev \
        zip \
        git \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libxml2-dev \
        libxslt1-dev \
        libicu-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo pdo_mysql zip intl soap exif \
    && docker-php-ext-enable opcache

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Abilita il modulo rewrite di Apache
RUN a2enmod rewrite

# Copia la configurazione
COPY config.php /moodle


# Crea la cartella moodledata e imposta i permessi adeguati
RUN mkdir /var/www/moodledata \
    && chown -R www-data:www-data /var/www \
    && chmod -R 777 /var/www/moodledata

# Assegna i permessi appropriati alla cartella Moodle
RUN chown -R www-data:www-data /var/www/html

# Aggiungi configurazioni personalizzate al php.ini, incluso opcache
RUN { \
        echo 'opcache.enable=1'; \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'max_input_vars = 5000'; \
    } > /usr/local/etc/php/conf.d/custom.ini

# Installa PHP CodeSniffer
RUN composer global require "squizlabs/php_codesniffer=*"

# Installa Moodle PHPdoc Check
RUN composer global require moodlehq/moodle-local_codechecker
