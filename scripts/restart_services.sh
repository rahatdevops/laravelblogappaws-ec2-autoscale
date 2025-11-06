#!/bin/bash
sudo systemctl restart nginx
sudo systemctl restart php-fpm

# Switch to deployer user to run Laravel optimizations
sudo -u deployer bash <<EOF
cd /var/www/laravelblogapp/

# Run Laravel optimizations
php artisan config:cache
php artisan route:cache
php artisan view:cache
