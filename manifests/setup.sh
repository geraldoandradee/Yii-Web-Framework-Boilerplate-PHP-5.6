#!/usr/bin/env bash

sudo su
echo "################################## SETUP ITEMS #################################"

echo "Installing openssl openssl-devel wget vim git-core..."
yum install openssl openssl-devel wget vim git-core -y
echo "DONE!"

echo "Installing epel and webtatic repos"
cd /root
rm -rf /root/*
rm -rf /etc/yum.repos.d/epel*

wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh epel-release*.rpm

rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
echo "DONE!"

echo "Installing Apache, MySQL and PHP 5.6 (and ruby for sass using)..."
yum install php56w php56w-devel php56w-mysql gcc libtool rubygems ruby-devel php56w-pear php56w-pecl-xdebug php56w-pecl-apcu php56w-gd php56w-embedded php56w-pdo php56w-mcrypt php56w-intl php56w-mbstring -y
gem install sass compass
yum install httpd php56w mysql-server -y
echo "DONE"

echo "Configuring virtualhost and setting up services"
echo "Coping virtualhost configuration"
cp /www/yiiboilerplate.com/manifests/httpd/yiiboilerplate.com.conf /etc/httpd/conf.d/yiiboilerplate.com.conf
cp /www/yiiboilerplate.com/manifests/httpd/xdebug.ini /etc/php.d/xdebug.ini
echo "Done"
echo "Starting and registering httpd service"
service httpd restart
chkconfig httpd on
echo "Done"

echo "Starting and registering mysqld service"
service mysqld start
chkconfig mysqld on
echo "Done"

echo "Setting mysql root password and running setup.sql"
mysqladmin -u root password 'root'
mysql -u root -proot < /www/yiiboilerplate.com/manifests/database/setup.sql
echo "Done"

echo "Setting hosts for site resolution"
RESULT=$(grep -i yiiboilerplate.com /etc/hosts)
if [ -z "$RESULT" ]; then
    echo "127.0.1.1	yiiboilerplate.com" >> /etc/hosts
fi
echo "Done"

echo "Running PHP composer"
cd ..
php composer.phar install
php composer.phar update
echo "Done"

echo "################################################################################"
echo "######################### All requirements installed ###########################"
echo "################################################################################"
