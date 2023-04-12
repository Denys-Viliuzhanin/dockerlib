#!/bin/bash

source .env

SSHD_VERSION=`cat ./app/version.txt`
BUILD_NUMBER=`date +%s`

IMAGE=${REPOSITORY}/sshd

echo "Building ${IMAGE}, version=${SSHD_VERSION}, build_number=${BUILD_NUMBER}"
docker build --no-cache \
    --build-arg BUILD_NUMBER=${BUILD_NUMBER} \
    -t ${IMAGE}:latest \
    -t ${IMAGE}:${SSHD_VERSION} \
    . 
