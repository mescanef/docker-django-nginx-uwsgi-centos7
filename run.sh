#!/bin/bash

# run uwsgi in background
DOMAIN=`cat /.django` 
su - djangouser -c "cd /${DOMAIN}/cfg/ && uwsgi --ini django.ini --uid 1000 --gid 1000 &"

# start nginx
exec nginx

