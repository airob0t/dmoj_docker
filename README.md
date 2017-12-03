# Install the site
## Install the docker

```
curl -sSL https://get.daocloud.io/docker | sh
```

## clone the code

```
git clone https://github.com/airob0t/dmoj_docker.git
```

## change the settings
create the database first,then change the settings.
```
cd dmoj_docker
#edit the createdb.sql
#after that execute this
mysql>source createdb.sql;
>exit;
```
Edit the nginx.conf:
```
#listen
#server_name
```
Edit the dmoj/local_settings.py
```
#SECRET_KEY
#DEBUG
#ALLOWED_HOSTS
#DATABASES
#PROBLEM_DATA_ROOT = '/problems'
#LANGUAGE_CODE
#TIME_ZONE
#USE_I18N = True
#USE_L10N = True
#USE_TZ = True
#EMAIL_USE_TLS = True
#EMAIL_HOST = 'smtp.gmail.com'
#EMAIL_HOST_USER = '<your account>@gmail.com'
#EMAIL_HOST_PASSWORD = '<your password>'
#EMAIL_PORT = 587
#ADMINS
#SITE_NAME
#SITE_LONG_NAME
#SITE_ADMIN_EMAIL
#TERMS_OF_SERVICE_URL
#BRIDGED_JUDGE_HOST
#BRIDGED_JUDGE_PORT
#BRIDGED_DJANGO_HOST
#BRIDGED_DJANGO_PORT

```

## build image

```
docker build -t airobot/dmoj ./
```

## create container

```
sh run.sh
```

## enter the container

```
docker exec -it dmoj_site /bin/bash
```

## load the navbar,...

```
sh loaddata.sh
```

## run the services

```
supervisord
supervisorctl
supervisorctl> start all
service nginx start
```
## commonly used commands
```
docker images #list all images
docker ps -a #list all containers
docker start <name/id> #start the container
docker stop <name/id> #stop the container
docker run <imagename> #create the container
```

---

# Install the judger
## Installing the prerequisites
```
$ apt install git python-dev python-pip build-essential
$ git clone https://github.com/DMOJ/judge
$ cd judge
$ pip install -r requirements.txt
$ python setup.py develop
Configuring the judge
```
Start by taking the runtime block from the output of the command dmoj-autoconf and put it in a new file config.yml. Next, add a problem_storage_root node where you specify where your problem data is located.
```
problem_storage_root: /judge/problems
runtime:
   ...
```
You should now be able to run dmoj-cli -c config.yml to enter a CLI environment for the judge. For additional configuration options, an [example configuration file](https://github.com/DMOJ/docs/blob/master/sample_files/judge_conf.yml) is provided.


---

# Reference
1. https://dmoj.readthedocs.io/en/latest/
