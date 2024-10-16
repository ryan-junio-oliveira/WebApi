# Usando a imagem base do PHP com FastCGI Process Manager (FPM)
FROM php:8.3-fpm

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

# Ajustando permissões para o diretório de cache e logs
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expondo a porta 9000, que é a porta padrão para PHP-FPM
EXPOSE 9000

# Definindo o comando de inicialização para PHP-FPM
CMD ["php-fpm"]
