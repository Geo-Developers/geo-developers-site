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
RUN docker-php-ext-install mysqli

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


EXPOSE 80

# This is the default command for the container
# CMD ["/run.sh"]
# RUN /create_mysql_admin_user.sh

#--------------------------------------------

# Install GeoDevelopers site dependencies
# RUN git clone https://github.com/Geo-Developers/geo-developers-site.git ${src_folder}
# WORKDIR ${src_folder}
# RUN composer install

# Set the permissions for smarty
RUN mkdir -p ${src_folder}/smarty/templates_c/
RUN chmod 777 ${src_folder}/smarty/templates_c/

# Setup default values for the app
ADD geodev_config.php ${src_folder}/config.php

# Enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite
