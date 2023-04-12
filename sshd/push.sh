#!/bin/bash



docker push makitradigitalappsrepo.azurecr.io/sshd:latest

SSHD_VERSION=`cat ./app/version.txt`
docker push makitradigitalappsrepo.azurecr.io/sshd:${SSHD_VERSION}
