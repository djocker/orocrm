# OroCRM Community Edition Monolithic Image
The docker image includes nginx with php-fpm and wrappers. Mysql server and mail server will be provided by third party images.

## Usage

**[Install docker compose](http://docs.docker.com/compose/install/)**

```
curl -o docker-compose -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m`
chmod a+x docker-compose
sudo mv docker-compose /usr/local/bin/
```

**OroCRM Stack with web installation wizard**

run docker containers
```
docker-compose -f <(curl https://raw.githubusercontent.com/djocker/orocrm/master/compose/webinstall/docker-compose.yml) up
```

stop docker containers

```
docker-compose -f <(curl https://raw.githubusercontent.com/djocker/orocrm/master/compose/webinstall/docker-compose.yml) stop
```

**OroCRM Stack with automated installation**

default login: `admin` default password: `admin1111`

run docker containers

```
docker-compose -f <(curl https://raw.githubusercontent.com/djocker/orocrm/master/compose/autoinstall/docker-compose.yml) up
```

stop docker containers

```
docker-compose -f <(curl https://raw.githubusercontent.com/djocker/orocrm/master/compose/autoinstall/docker-compose.yml) stop 
```

## Docker Cloud

Also you can use stack files from [stackfile.io](https://stackfiles.io/registry/56fc345c416a1001004d39cc) to deploy via [cloud.docker.com](https://cloud.docker.com)

## Additional Info

**Parameters.yml Variables:**

`APP_DB_DRIVER=pdo_mysql`  
`APP_DB_HOST=db`  
`APP_DB_PORT=3306`  
`APP_DB_USER=orocrm`  
`APP_DB_PASSWORD=orocrm`  
`APP_DB_NAME=orocrm`  
`APP_DB_HOST=db`  
`APP_HOSTNAME=localhost`  
`APP_MAILER_TRANSPORT=smtp`  
`APP_MAILER_HOST=127.0.0.1`  
`APP_MAILER_PORT=`  
`APP_MAILER_ENCRYPTION=`  
`APP_MAILER_USER=`  
`APP_MAILER_PASSWORD=`  
`APP_WEBSOCKET_HOST=websocket`  
`APP_WEBSOCKET_PORT=8080`  
`APP_IS_INSTALLED=`  

**Advanced Variables:**

`CMD_INIT_BEFORE` - Command will be executed before initialization (or installation)  
`CMD_INIT_CLEAN` - Command will be used if application not installed (here you can initiate installation via cli)
`CMD_INIT_INSTALLED` - Command will be used for initialization of already installed application  
`CMD_INIT_AFTER` - Command will be executed after initialization (or installation
  
### Stackfile (docker-compose.yml) - Web installer

```
data:
  image: djocker/orodata
db:
  image: mysql:5.5
  expose:
    - "3306"
  environment:
    - MYSQL_ROOT_PASSWORD=root
    - MYSQL_DATABASE=orocrm
    - MYSQL_USER=orocrm
    - MYSQL_PASSWORD=orocrm
  volumes_from:
    - data
mail:
  image: catatnight/postfix
  expose:
    - "25"
  environment:
    - maildomain=localhost
    - smtp_user=user@localhost:password
web:
  image: djocker/orocrm
  links:
    - "db"
    - "mail"
  ports:
    - "80:80"
    - "8080:8080"
  volumes_from:
    - data
  environment:
    - CMD_INIT_BEFORE=
    - CMD_INIT_CLEAN=
    - CMD_INIT_INSTALLED=
    - CMD_INIT_AFTER=
    - APP_DB_DRIVER=pdo_mysql
    - APP_DB_HOST=db
    - APP_DB_PORT=3306
    - APP_DB_USER=orocrm
    - APP_DB_PASSWORD=orocrm
    - APP_DB_NAME=orocrm
    - APP_HOSTNAME=localhost
    - APP_MAILER_TRANSPORT=smtp
    - APP_MAILER_HOST=mail
    - APP_MAILER_PORT=25
    - APP_MAILER_ENCRYPTION=
    - APP_MAILER_USER=user
    - APP_MAILER_PASSWORD=password
    - APP_WEBSOCKET_HOST=
    - APP_WEBSOCKET_PORT=8080
    - APP_IS_INSTALLED=
```

### Stackfile (docker-compose.yml) - Automated installation

`login: admin, password: admin1111`

```
data:
  image: djocker/orodata
db:
  image: mysql:5.5
  expose:
    - "3306"
  environment:
    - MYSQL_ROOT_PASSWORD=root
    - MYSQL_DATABASE=orocrm
    - MYSQL_USER=orocrm
    - MYSQL_PASSWORD=orocrm
  volumes_from:
    - data
mail:
  image: catatnight/postfix
  expose:
    - "25"
  environment:
    - maildomain=localhost
    - smtp_user=user@localhost:password
web:
  image: djocker/orocrm
  links:
    - "db"
    - "mail"
  ports:
    - "80:80"
    - "8080:8080"
  volumes_from:
    - data
  environment:
    - CMD_INIT_BEFORE=
    - CMD_INIT_CLEAN=sudo -u www-data -E /usr/bin/php /var/www/app/console oro:install --timeout 3600 --force --drop-database --env=prod --user-name=admin --user-firstname=John --user-lastname=Doe --user-password="admin1111" --user-email="johndoe@example.com" --organization-name="Acme" --application-url="http://oro.loc/"
    - CMD_INIT_INSTALLED=
    - CMD_INIT_AFTER=
    - APP_DB_DRIVER=pdo_mysql
    - APP_DB_HOST=db
    - APP_DB_PORT=3306
    - APP_DB_USER=orocrm
    - APP_DB_PASSWORD=orocrm
    - APP_DB_NAME=orocrm
    - APP_HOSTNAME=localhost
    - APP_MAILER_TRANSPORT=smtp
    - APP_MAILER_HOST=mail
    - APP_MAILER_PORT=25
    - APP_MAILER_ENCRYPTION=
    - APP_MAILER_USER=user
    - APP_MAILER_PASSWORD=password
    - APP_WEBSOCKET_HOST=
    - APP_WEBSOCKET_PORT=8080
    - APP_IS_INSTALLED=
```
