FROM php:7.0.7-apache
MAINTAINER Raul Jimenez Ortega <hhkaos@gmail.com>

ENV src_folder /var/www/html

# Prepare and install CURL for composer
RUN apt-get update && apt-get install -y \
    curl \
    php5-curl \
    git \
    unzip \
    zip \
    nano

# Install and enable mysql extension
RUN docker-php-ext-install mysqli

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the permissions for smarty
RUN mkdir -p ${src_folder}/smarty/templates_c/
RUN chmod 777 ${src_folder}/smarty/templates_c/

# Enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite
