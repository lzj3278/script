#! /bin/bash

################################################
# File Name: install.sh
# Author: zhongjie.li
# email: zhongjie.li@viziner.cn
# Created Time: 2017-12-22 17:14:00
# Last Modified: 2017-12-22 17:21:24
################################################

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#配置yum源
cd /etc/yum.repos.d
mv * /tmp
wget http://10.215.97.201:85/doc/local-yum.repo
yum clean all && yum makecache

#安装docker
yum install docker -y
mv /etc/docker/daemon.json /tmp
cd /etc/docker/
wget http://10.215.97.201:85/doc/daemon.json
service docker restart
mkdir /data/
mkdir /var/www/html -p
docker run -d -p81:80 -v /var/www/html:/var/www/html -v /data/:/data/wwwlogs/ --restart always 10.215.97.201:5000/nginx-fpm-php7
iptables -I INPUT -p tcp --dport 5666 -j ACCEPT
iptables -I INPUT -p tcp --dport 4245 -j ACCEPT
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp --dport 6739 -j ACCEPT
iptables-save

#安装 nrpe
cd /opt
wget http://10.215.97.201:85/doc/nrpe-3.2.1.tar.gz
wget http://10.215.97.201:85/doc/nagios-plugins-2.2.1.tar.gz
wget http://10.215.97.201:85/doc/nagios_nrpe_new.sh
chmod 755 *.gz
chmod 755 nagios_nrpe_new.sh

