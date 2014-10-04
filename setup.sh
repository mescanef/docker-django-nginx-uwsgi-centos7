#!/bin/bash

if [ -z ${DOMAIN} ]; then
    echo "Error - empty domain name!"
    exit 1
fi

HOST=`echo ${DOMAIN} | cut -f1 -d '.'`
sed -i "s/DOMAIN/${DOMAIN}/g" /${DOMAIN}/cfg/*
sed -i "s/HOST/${HOST}/g" /${DOMAIN}/cfg/*
sed -i "s/PORT/${PORT}/g" /${DOMAIN}/cfg/*

# setup place for our uwsgi socket
mkdir /${DOMAIN}/run/
chown djangouser:nginx /${DOMAIN}/run/
chmod 775 /${DOMAIN}/run/

# start first django project
su - djangouser -c "cd /${DOMAIN}/code/ && django-admin.py startproject ${HOST} . && python manage.py migrate"
# set perms
chown -R djangouser:nginx /${DOMAIN}/code/${HOST}/
chmod +x /${DOMAIN}/code/

echo "Your project's code is located in: /${DOMAIN}/code/${HOST}/" 

# save used domainname 
echo "${DOMAIN}" > /.django

