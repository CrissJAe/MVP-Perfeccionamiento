#!/bin/bash
set -e

cd /var/www

if [ ! -d vendor ]; then
    echo ">>> Instalando dependencias con Composer..."
    composer install --no-interaction --optimize-autoloader
fi

mkdir -p storage/sessions storage/cache storage/templates_c documentos
chown -R www-data:www-data storage documentos

exec apachectl -D FOREGROUND