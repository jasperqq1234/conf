#! /bin/bash
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
