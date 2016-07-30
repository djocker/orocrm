# OROCrm source code image
The docker image contains source code of OROCrm application.
This image are used as part of docker stack (see compose configs).

## Requirements

1. [Docker](https://www.docker.com/)
2. [Docker Compose](http://docs.docker.com/compose)

## Usage
**OROCrm stack with web installation**

For more information [see compose config](./compose/webinstall/docker-compose.yml)

Run stack 

```
docker-compose -f <(curl https://raw.githubusercontent.com/djocker/orocrm/master/compose/webinstall/docker-compose.yml) up
```

Stop stack

```
docker-compose -f <(curl https://raw.githubusercontent.com/djocker/orocrm/master/compose/webinstall/docker-compose.yml) stop
```

**OROCrm stack with automated installation**

For more information [see compose config](./compose/autoinstall/docker-compose.yml)

default login: `admin` default password: `admin1111`

Run stack

```
docker-compose -f <(curl https://raw.githubusercontent.com/djocker/orocrm/master/compose/autoinstall/docker-compose.yml) up
```

Stop stack

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
