#!/bin/bash
cp /var/www/.env /var/www/laravelblogapp/

sudo chown -R deployer:www-data /var/www/laravelblogapp
sudo chmod -R 775 /var/www/laravelblogapp/storage /var/www/laravelblogapp/bootstrap/cache

sudo -u deployer bash <<EOF
cd /var/www/laravelblogapp

# Install/update dependencies
composer install --no-dev --prefer-dist --optimize-autoloader

# Set correct permissions for storage and cache
chmod -R 775 storage bootstrap/cache
EOF
