#!/usr/bin/env bash

echo '---------------------------------------------'
echo 'Run docker compose container '


if [ -x "$(command -v docker)" ]; then
    echo "Update docker"

    cp .env.example .env

    docker-compose up -d

    open http://localhost:8008

    #docker exec -it webid-php-fpm /bin/bash -c "make install"


else
    echo "Install docker !!!"
    open https://docs.docker.com/docker-for-mac/install/
fi


echo "END"
echo '****************************************************'



################## UTILS ################################


# docker-compose down #stop all container
# docker ps # inspect container

# docker rm $(docker ps -a -q) --force
# docker rmi $(docker images -q) --force


