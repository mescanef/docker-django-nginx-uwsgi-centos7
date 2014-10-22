# Dockerfile by mescanef
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from centos:centos7
MAINTAINER mescanef <zone@mescanef.net>

ENV DOMAIN domainname.org
ENV PORT 8080

# upgrade...
RUN yum upgrade -y
# add EPEL repo
RUN rpm -Uvhf http://mirrors.kernel.org/fedora-epel/7/x86_64/e/epel-release-7-2.noarch.rpm 
RUN yum install -y python-pip python-setuptools nginx sqlite3 gcc python-devel unzip wget --enablerepo=epel
# install uwsgi 
RUN pip install uwsgi

# add files
RUN mkdir -p /${DOMAIN}/cfg/
ADD requirements.txt /${DOMAIN}/cfg/
ADD nginx.conf /${DOMAIN}/cfg/
ADD django.params /${DOMAIN}/cfg/
ADD django.ini /${DOMAIN}/cfg/

# define mountable dirs
VOLUME ["/var/log/nginx"]

# add user for later usage..
RUN adduser --home=/${DOMAIN}/code -u 1000 djangouser

# setup the configfiles
RUN ln -s /${DOMAIN}/cfg/django.params /etc/nginx/conf.d/
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf_orig
RUN ln -s /${DOMAIN}/cfg/nginx.conf /etc/nginx/

# run pip install
RUN pip install -r /${DOMAIN}/cfg/requirements.txt
ADD run.sh /run.sh
ADD setup.sh /setup.sh
RUN chmod 775 /*.sh

RUN /setup.sh

#EXPOSE 8080
# Since docker 1.3.0 we can use variables "anywhere". See #6054.
EXPOSE ${PORT}

CMD ["/run.sh"]

