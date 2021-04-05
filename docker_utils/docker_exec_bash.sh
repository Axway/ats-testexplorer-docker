#!/usr/bin/env bash

. ./env.sh

#docker exec -it $IMAGE_NAME /bin/bash

HAS_CONTAINER=`docker container ps | grep $IMAGE_NAME | wc -l`

if [ "$HAS_CONTAINER" -eq 1 ];
then
    CONTAINER_ID=`docker container ps | grep $IMAGE_NAME | awk '{n=split($0,a," "); print a[1]}'`
    docker exec -it $CONTAINER_ID /bin/bash
else
    echo "Container with image name $IMAGE_NAME is not running or there are multiple running containers."
fi