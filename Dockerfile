FROM php:7.4-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www
COPY . .
RUN composer install

# Configuracion de Usuario, con esto ya no tiene problemas con los permisos
RUN addgroup -g 1000 -S www && \
    adduser -u 1000 -S www -G www
USER www
COPY --chown=www:www . /var/www

# correr el web server
CMD php artisan serve --host=0.0.0.0
