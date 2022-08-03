#!/bin/bash

#git clone project
mkdir /var/www/html/
cd /var/www/html/
sh /root/conf/gitclone.sh

#install laravel module
dir=$(ls)
cd $dir
composer install
wait
mkdir public public/images/ storage/ storage/app storage/debugbar storage/framework storage/logs storage/framework/sessions storage/framework/views storage/framework/cache

#setup .env

#setup permission
chown -R nginx:nginx storage/
chmod -R 755 storage/
chown -R nginx:nginx public/
chmod -R 755 public/

