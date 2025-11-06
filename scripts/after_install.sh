#!/bin/bash
set -e  # Exit immediately if a command fails

PROJECT_PATH="/var/www/laravelblogapp"

echo "→ Setting correct ownership..."
sudo chown -R www-data:www-data $PROJECT_PATH

echo "→ Switching to project directory..."
cd $PROJECT_PATH

echo "→ Installing dependencies (optimized for production)..."
sudo -u www-data composer install --no-dev --prefer-dist --optimize-autoloader

echo "→ Setting permissions for storage and cache..."
sudo chmod -R 775 storage bootstrap/cache
sudo chown -R www-data:www-data storage bootstrap/cache

echo "→ Clearing and rebuilding Laravel caches..."
sudo -u www-data php artisan config:clear
sudo -u www-data php artisan cache:clear
sudo -u www-data php artisan route:cache
sudo -u www-data php artisan view:cache
sudo -u www-data php artisan config:cache

echo "→ Restarting Supervisor queue workers..."
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl restart laravel-queue:*

echo "✅ Deployment complete!"

