#!/bin/bash

counter=$(ps -C nginx --no-heading|wc -l)
if [ "${counter}" = "0" ]; then
        /usr/sbin/nginx
        counter=$(ps -C nginx --no-heading|wc -l)
        if [ "${counter}" = "0" ]; then
                /bin/systemctl stop keepalived.service
        fi
fi
