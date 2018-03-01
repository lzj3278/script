#! /bin/bash

################################################
# Author: zhongjie.li
# email: zhongjie.li@viziner.cn
################################################

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


yum clean all && yum makecache
yum install -y iptables*

iptables-save > /tmp/iptables
mv /etc/sysconfig/iptables-config /tmp/iptables-config
cd /etc/sysconfig/
wget http://10.215.97.201:85/doc/iptables-config
service iptables restart

iptables-restore < /tmp/iptables
iptables-save
service iptables restart
