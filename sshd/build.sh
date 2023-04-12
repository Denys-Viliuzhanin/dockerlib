#!/bin/bash

SSHD_VERSION=`cat ./app/version.txt`
BUILD_NUMBER=`date +%s`
docker build --no-cache \
    --build-arg BUILD_NUMBER=${BUILD_NUMBER} \
    -t makitradigitalappsrepo.azurecr.io/sshd:latest \
    -t makitradigitalappsrepo.azurecr.io/sshd:${SSHD_VERSION} \
    . 
