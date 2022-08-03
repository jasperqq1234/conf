#/bin/bash

#mv redis config
cp /root/conf/redis.conf /etc/redis.conf

#mv php-config
cp /root/conf/php.ini /etc/php.ini

#mv php-fpm_config
cp /root/conf/www.conf /etc/php-fpm.d/www.conf

#mv nginx_config
cp /root/conf/nginx.conf /etc/nginx/nginx.conf

systemctl start redis
systemctl start php-fpm
systemctl start nginx
systemctl enable redis
systemctl enable php-fpm
systemctl enable nginx

