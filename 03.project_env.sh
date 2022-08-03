#!/bin/bash

#install aws project environment
LANG=C

#Install Composer 
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/bin/composer

#install nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
wait
. ~/.nvm/nvm.sh
nvm install node
node -e "console.log('Running Node.js ' + process.version)"

#git clone project
mkdir /var/www/html/
cd /var/www/html/
sh /root/conf/gitclone.sh

#install laravel module
dir=$(ls)
cd $dir
composer install
npm install
mkdir public public/images/ storage/ storage/app storage/debugbar storage/framework storage/logs storage/framework/sessions storage/framework/views storage/framework/cache
mv /root/conf/index.php public/

#setup .env


#setup db connect src host


#setup package
npm run dev
npm run prod 
npm run  css

#setup permission
chown -R nginx:nginx storage/
chmod -R 755 storage/
chown -R nginx:nginx public/
chmod -R 755 public/
