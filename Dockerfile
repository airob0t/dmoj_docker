FROM debian:jessie
RUN apt update && apt install -y vim mysql-client libmysqlclient-dev gnupg wget git gcc g++ make python-dev libxml2-dev libxslt1-dev zlib1g-dev gettext curl wget openssl ruby ruby-dev gem 
RUN git clone https://github.com/sass/sass.git
WORKDIR /sass
RUN gem build sass.gemspec
RUN gem install sass-*.gem
WORKDIR /
RUN wget -q --no-check-certificate -O- https://bootstrap.pypa.io/get-pip.py | python
RUN wget -O- https://deb.nodesource.com/setup_4.x | bash -
RUN apt install -y nodejs
RUN npm install -g pleeease-cli

RUN git clone https://github.com/DMOJ/site.git
WORKDIR /site
RUN git submodule init
RUN git submodule update
RUN pip install -r requirements.txt
RUN pip install mysqlclient
RUN pip install django_select2
RUN npm install qu ws simplesets
RUN pip install websocket-client
WORKDIR /site/dmoj
ADD local_settings.py /site/dmoj
WORKDIR /site
#RUN python manage.py check
RUN sh make_style.sh
RUN echo yes | python manage.py collectstatic
RUN python manage.py compilemessages
RUN python manage.py compilejsi18n
ADD loaddata.sh /site
#RUN python manage.py createsuperuser
#RUN python manage.py loaddata navbar
#RUN python manage.py loaddata language_small

RUN mkdir /uwsgi
WORKDIR /uwsgi
ADD uwsgi.ini /uwsgi
RUN curl http://uwsgi.it/install | bash -s default $PWD/uwsgi
RUN apt install -y supervisor
ADD site.conf /etc/supervisor/conf.d/site.conf
ADD bridged.conf /etc/supervisor/conf.d/bridged.conf
ADD wsevent.conf /etc/supervisor/conf.d/wsevent.conf
#RUN supervisord
#RUN supervisorctl update
RUN apt install -y nginx
RUN rm /etc/nginx/sites-enabled/*
ADD nginx.conf /etc/nginx/sites-enabled
RUN service nginx reload
WORKDIR /site

EXPOSE 80
EXPOSE 9999
EXPOSE 9998
EXPOSE 15100
EXPOSE 15101
EXPOSE 15102

