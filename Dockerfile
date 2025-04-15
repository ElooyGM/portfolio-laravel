# Imagen base con PHP
FROM php:8.2-cli

# Instala extensiones necesarias
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    libzip-dev \
    libonig-dev \
    curl \
    && docker-php-ext-install zip mbstring

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo
WORKDIR /var/www

# Copia el código del proyecto
COPY . .

# Instala dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Genera APP_KEY si no está
RUN php artisan key:generate || true

# Cachea configuración y rutas
RUN php artisan config:cache && php artisan route:cache

# Expone el puerto (Render usa 10000 internamente)
EXPOSE 8080

# Comando para iniciar la app
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
