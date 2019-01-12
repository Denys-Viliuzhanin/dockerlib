#!/bin/bash

TASK=$1

PROJECT_NAME=javadev
DOCKER_IMAGE_NAME="$PROJECT_NAME-builder"
DOCKER_CONTAINER_NAME="$PROJECT_NAME-builder"

echo $TASK

case $TASK in
init)
	sudo docker build . -f builder.Dockerfile --tag=$DOCKER_IMAGE_NAME
	sudo docker run --name $DOCKER_CONTAINER_NAME -it $DOCKER_IMAGE_NAME 
	;;
clear)
	sudo docker container rm $DOCKER_CONTAINER_NAME 
	sudo docker image rm $DOCKER_CONTAINER_NAME 
	;;
*)	
	sudo docker start -i $DOCKER_CONTAINER_NAME 
	;;
esac

