FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN rm -f /etc/localtime && \
    ln -snf /usr/share/zoneinfo/America/Santiago /etc/localtime && \
    echo "America/Santiago" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && \
    apt-get install -y \
    apache2 \
    curl \
    gnupg2 \
    unixodbc \
    unixodbc-dev \
    libgssapi-krb5-2 \
    locales \
    nano \
    unzip \
    wget \
    zip \
    git \
    sendmail \
    ca-certificates \
    apt-transport-https \
    lsb-release && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg && \
    curl https://packages.microsoft.com/config/debian/12/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql18 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y \
    php8.2 \
    php8.2-cli \
    php8.2-curl \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip \
    php8.2-odbc \
    php8.2-memcached \
    libapache2-mod-php8.2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN localedef -i es_CL -c -f UTF-8 -A /usr/share/locale/locale.alias es_CL.UTF-8 && \
    a2enmod rewrite && \
    mkdir -p /var/intradev/smarty/cache \
    /var/intradev/smarty/conf \
    /var/intradev/smarty/configs \
    /var/intradev/smarty/templates_c \
    /var/intradev/sessions && \
    chown www-data -R /var/intradev/ && \
    chmod 755 -R /var/intradev/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD default /etc/apache2/sites-available/000-default.conf
ADD odbcinst.ini /etc/odbcinst.ini
ADD php.ini /etc/php/8.2/apache2/php.ini

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80

WORKDIR /var/www

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]