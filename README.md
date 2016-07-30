# OROCrm source code image
The docker image contains source code of OROCrm application.
This image are used as part of docker stack (see compose configs).

## Requirements

1. [Docker](https://www.docker.com/)
2. [Docker Compose](http://docs.docker.com/compose)

## Usage
**OROCrm stack with web installation**

For more information [see compose config](compose/webinstall/docker-compose.yml)

Run stack 

```
docker-compose -f <(curl https://raw.githubusercontent.com/djocker/orocrm/master/compose/webinstall/docker-compose.yml) up
```

Stop stack

```
docker-compose -f <(curl https://raw.githubusercontent.com/djocker/orocrm/master/compose/webinstall/docker-compose.yml) stop
```

**OROCrm stack with automated installation**

For more information [see compose config](compose/autoinstall/docker-compose.yml)

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
