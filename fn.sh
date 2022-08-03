#!/bin/bash
#install nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
wait
. ~/.nvm/nvm.sh

#git clone project
mkdir /var/www/html/
cd /var/www/html/
sh /root/conf/gitclone.sh

#install laravel module
dir=$(ls)
cd $dir
composer install
wait
npm install
wait
mkdir public public/images/ storage/ storage/app storage/debugbar storage/framework storage/logs storage/framework/sessions storage/framework/views storage/framework/cache
mv /root/conf/index.php public/

#setup .env

#setup package
npm run dev
npm run prod
npm run  css

#setup permission
chown -R nginx:nginx storage/
chmod -R 755 storage/
chown -R nginx:nginx public/
chmod -R 755 public/

