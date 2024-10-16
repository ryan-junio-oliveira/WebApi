# Usando a imagem base do PHP
FROM php:8.3-cli

# Atualizando os pacotes e instalando as extensões necessárias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    libsqlite3-dev \
    libonig-dev \
    libpng-dev \
    && docker-php-ext-install zip pdo pdo_mysql pdo_sqlite mysqli

# Instalando o Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copiando o código da aplicação Laravel para dentro do contêiner
COPY . /var/www/html

# Definindo o diretório de trabalho
WORKDIR /var/www/html

# Instalando as dependências do Laravel
RUN composer install

# Ajustando permissões para o diretório de cache e logs
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expondo a porta 8000, usada pelo php artisan serve
EXPOSE 8000

# Definindo o comando para rodar o servidor embutido do Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
