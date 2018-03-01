#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "* soft noproc   65535" >> /etc/security/limits.conf
echo "* hard noproc   65535" >> /etc/security/limits.conf
echo "* soft nofile   65535" >> /etc/security/limits.conf
echo "* hard nofile   65535" >> /etc/security/limits.conf

echo "ulimit -u 65535" >> /etc/profile
echo "ulimit -n 65535" >> /etc/profile
echo "ulimit -d unlimited" >> /etc/profile
echo "ulimit -m unlimited" >> /etc/profile
echo "ulimit -s unlimited" >> /etc/profile
echo "ulimit -t unlimited" >> /etc/profile
echo "ulimit -v unlimited" >> /etc/profile
source /etc/profile
#cd /etc/ && mv my.cnf /tmp/my.cnf.bak
#wget http://10.215.97.201:85/doc/my.cnf
#service mysqld restart
