#! /bin/bash

################################################
# File Name: mount-disk.sh
# Author: zhongjie.li
# email: zhongjie.li@viziner.cn
# Created Time: 2017-09-25 11:34:32
# Last Modified: 2017-09-25 15:56:47
################################################
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH


mount -t cifs -o username=zhongjie.li,password=123456 //192.168.0.10/viziner/Backup/test /mnt
if [[ $? != 0 ]]; then
    disk_mount=$(mount -l -t cifs | awk '{print $3}')
    if [[ ${disk_mount} == "/mnt" ]];then
        umount -v /mnt
    fi
fi
cd /mnt && tree -H . -I 'Thumbs.db|index.html' > /mnt/index.html
if [[ $? == 0 ]]; then
    cd /opt && umount -v /mnt
fi
