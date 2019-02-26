#!/bin/bash

#############################
# Specifications
#############################

# Project name
PROJECT_NAME="Apache Nifi"

#Docker names
DOCKER_IMAGE_NAME="nifi-standalone"
DOCKER_CONTAINER_NAME="nifi-standalone"

#############################
# Input Parameters
#############################

TASK=$1

#############################
# Environment
#############################

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#############################
# Logic
#############################

#Print helpe if requested
if [ "$TASK" = "help" ]
then
	echo "Commands:"
	echo "	1. Initialize container: docker.sh init"
	echo "	2. Run container: docker.sh"
	echo "	3. Remove container: docker.sh clear"
	exit 0
fi

case $TASK in
init)	
	sudo docker build "$SCRIPT_DIR" -f "$SCRIPT_DIR/Dockerfile" --tag=$DOCKER_IMAGE_NAME
	echo "=-----"
	sudo docker run -p 8080:8080 --name $DOCKER_CONTAINER_NAME -it $DOCKER_IMAGE_NAME 
	;;
clear)
	sudo docker container rm $DOCKER_CONTAINER_NAME 
	sudo docker image rm $DOCKER_CONTAINER_NAME 
	;;
*)	
	sudo docker start -i $DOCKER_CONTAINER_NAME
	;;
esac

