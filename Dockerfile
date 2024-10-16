# Usar uma imagem base do PHP
FROM php:8.2-fpm

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    sqlite3 \
    libsqlite3-dev \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_sqlite

# Instalar o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Definir o diretório de trabalho
WORKDIR /var/www/html

# Copiar os arquivos da aplicação para o contêiner
COPY . .

COPY .env.example .env

# Instalar dependências da aplicação
RUN composer install --no-dev --optimize-autoloader

# Ajustar permissões
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache /var/www/database

# Definindo variáveis de ambiente de produção
ENV APP_ENV=production
ENV APP_DEBUG=false

RUN php artisan key:generate

# Otimizando a aplicação para produção
RUN php artisan migrate --force

# Expor a porta que o PHP-FPM está escutando
EXPOSE 9000

# Iniciar o PHP-FPM
CMD ["php-fpm", "--nodaemonize"]

