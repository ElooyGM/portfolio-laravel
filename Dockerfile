# Usa la imagen oficial de PHP con Apache
FROM php:8.1-apache

# Instala dependencias de Laravel
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git && docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install gd && docker-php-ext-install pdo pdo_mysql

# Configura el directorio de trabajo
WORKDIR /var/www/html

# Copia los archivos del proyecto al contenedor
COPY . /var/www/html/

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instala las dependencias de Laravel
RUN composer install

# Exponer el puerto de Apache
EXPOSE 80

# Comando para iniciar Apache y PHP
CMD ["apache2-foreground"]
