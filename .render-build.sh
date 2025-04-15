#!/usr/bin/env bash

# Instalar PHP
apt-get update
apt-get install -y php php-cli php-mbstring unzip curl php-xml php-curl php-bcmath php-zip

# Instalar Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Instalar dependencias Laravel
composer install --no-dev --optimize-autoloader

# Generar clave de aplicación
php artisan key:generate

# Cachear configuración
php artisan config:cache
php artisan route:cache
