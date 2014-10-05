#!/bin/bash

# run uwsgi in background
DOMAIN=`cat /.django` 
uwsgi --ini /${DOMAIN}/cfg/django.ini --uid 1000 --gid 1000 &

# start nginx
exec nginx

