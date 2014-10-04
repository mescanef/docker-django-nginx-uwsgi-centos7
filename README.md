docker-django-nginx-uwsgi-centos7
=================================

A dockerfile with few shell scripts to run an empty Django project, combined with Nginx, uWsgi and sqlite3 tools in a Centos 7.x based container.


Usage
-----

To create the image `docker-django-nginx-uwsgi-centos7/django`, execute the following command on the docker-django-nginx-uwsgi-centos7 folder:

        docker build -t docker-django-nginx-uwsgi-centos7/django .

To run the image and bind to port 8080:

        docker run -d -p 8080:8080 docker-django-nginx-uwsgi-centos7/django

To check the logs of the container run the below command:

        docker logs <CONTAINER_ID>


