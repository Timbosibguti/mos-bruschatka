FROM ubuntu:16.04

# Environment variables
ENV PROJECT_PATH=/var/www \
    PROJECT_PUBLIC_DIR=public \
    DEBIAN_FRONTEND=noninteractive \
    APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_LOCK_DIR=/var/lock/apache2 \
    PHP_INI=/etc/php/7.0/apache2/php.ini

# Update, upgrade and cURL installation
RUN apt update -q && apt install -yqq curl locales gnupg

# Locale generator
RUN locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Utilities, Apache, PHP, and supplementary programs
RUN apt update -q && apt install -yqq --force-yes \
    git \
    bash \
    gettext \
    wget \
    zip \
    apache2 \
    libapache2-mod-php \
    php \
    php-bcmath \
    php-curl \
    php-dom \
    php-mbstring \
    php-intl \
    php-gd \
    php-zip \
    php-mysql

# Install ioncube
RUN wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
RUN tar xvfz ioncube_loaders_lin_x86-64.tar.gz
RUN ["bin/bash", "-c", "cp ioncube/*.so /usr/lib/php/2*/"]
RUN ["bin/bash", "-c", "cd /etc/php/7*/apache2/conf.d && echo zend_extension = /usr/lib/php/2*/ioncube_loader_lin_7.0.so > 00-ioncube.ini"]

# Apache mods
RUN a2enmod rewrite expires headers ssl substitute

# Apache2 conf
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
RUN a2enconf fqdn

# php.ini configs
RUN sed -i "s/short_open_tag = .*/short_open_tag = On/" $PHP_INI && \
    sed -i "s/memory_limit = .*/memory_limit = 256M/" $PHP_INI && \
    sed -i "s/display_errors = .*/display_errors = On/" $PHP_INI && \
    sed -i "s/display_startup_errors = .*/display_startup_errors = Off/" $PHP_INI && \
    sed -i "s/post_max_size = .*/post_max_size = 64M/" $PHP_INI && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 32M/" $PHP_INI && \
    sed -i "s/max_file_uploads = .*/max_file_uploads = 10/" $PHP_INI && \
    sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_DEPRECATED \& ~E_STRICT/" $PHP_INI

# Cleanup
RUN apt purge -yq \
      patch \
      software-properties-common && \
    apt autoremove -yqq
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/apache2/access.log \
    && ln -sf /dev/stderr /var/log/apache2/error.log

# Port to expose
EXPOSE 80 443

# Workdir
WORKDIR $PROJECT_PATH

# permissions and owner files changes
RUN chown -R www-data:www-data .

# Start apache
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
