#!/bin/bash
#=============================================

#This onestep.sh shell function is mainly to automatically install packages and configuration files

#=============================================
#setting log
sed  -i '/Subsystem/d' /etc/ssh/sshd_config
sed -i '131a\Subsystem   sftp  /usr/libexec/openssh/sftp-server -l INFO -f AUTH'  /etc/ssh/sshd_config
sed -i '74a/auth.*  /var/log/sftp.log/' /etc/rsyslog.conf
systemctl restart  sshd
systemctl restart rsyslog

#install package
yum install -y epel-release net-tools settools wget ntp libxml2-devel libtool re2c gcc-c++ gcc git net-tools zip unzip ntsysv tmux yum-utils
amazon-linux-extras  install -y epel
yum update -y

#disable ipv6
echo " " >>/etc/sysctl.conf
echo "#made for disabled IPV6 in $(date +%F)" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6=1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6=1" >> /etc/sysctl.conf
tail -5 /etc/sysctl.conf
echo "NETWORKING_IPV6=no" >> /etc/sysconfig/network
echo  "IPV6_AUTOCONF=no"    >>  /etc/sysconfig/network
sysctl -p

#postfix
systemctl disable postfix
systemctl stop postfix

#disable ipv6 model
sed -i 's/crashkernel=auto rd.lvm.lv=/crashkernel=auto ipv6.disbale=1 rd.lvm.lv=/i' /etc/default/grub
sysctl -p

#Enable BBR
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf

#install redis
yum install -y redis

#install php
sudo amazon-linux-extras  install -y php7.2
yum install -y php php-mysqlnd php-pdo php-xml php-pear php-devel php-mbstring php-fpm php-gd php-soap
yum install -y php-zip php-bcmath php-dom php-gd php-mbstring php-posix php-redis

#install nginx
sed -i 's/enabled=1/enable=0/g' /etc/yum.repos.d/epel.repo
sed -i 's/enabled=1/enable=0/g' /etc/yum.repos.d/amzn2-core.repo
amazon-linux-extras install -y nginx1.12
yum install -y php-pecl-mcrypt
sed -i 's/enabled=0/enable=1/g' /etc/yum.repos.d/epel.repo
sed -i 's/enabled=0/enable=1/g' /etc/yum.repos.d/amzn2-core.repo
rm -f /etc/nginx/conf.d/php-fpm.conf
rm -f /etc/nginx/default.d/php.conf

#install mysql-client
yum install -y mysql

#set timezone
systemctl enable ntpd
timedatectl set-timezone Asia/Taipei
systemctl restart network

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

#install aws project environment
LANG=C

#Install Composer 
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/bin/composer

#option select fn or bn
echo please input fn or bn to execute process : 
read INPUT
case $INPUT in
fn) sh fn.sh;;
bn) sh bn.sh;;
e)  echo bye bye && exit;;
esac


#install nodejs
#curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
#wait
#. ~/.nvm/nvm.sh
#nvm install node
#node -e "console.log('Running Node.js ' + process.version)"

#git clone project
#mkdir /var/www/html/
#cd /var/www/html/
#sh /root/conf/gitclone.sh

#install laravel module
#dir=$(ls)
#cd $dir
#composer install
#npm install
#mkdir public public/images/ storage/ storage/app storage/debugbar storage/framework storage/logs storage/framework/sessions storage/framework/views storage/framework/cache
#mv /root/conf/index.php public/


#setup package
#npm run dev
#npm run prod 
#npm run  css

#setup permission
#chown -R nginx:nginx storage/
#chmod -R 755 storage/
#chown -R nginx:nginx public/
#chmod -R 755 public/
