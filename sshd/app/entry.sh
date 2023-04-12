#!/bin/bash

BUILD_NUMBER=`cat /app/sshd/build_number.txt`
echo "SSHD Image Build: ${BUILD_NUMBER}"

SSHD_VERSION=`cat /app/sshd/version.txt`
echo "SSHD Image Version: ${SSHD_VERSION}"

ssh-keygen -lf /etc/ssh/ssh_host_ecdsa_key.pub

if [[ -n "${USER_PASSWORD}" ]]; 
then
  echo "user:${USER_PASSWORD}" | chpasswd
  echo "Password is specified"
else
  echo "Password is not specified"
fi

if [[ "$1" == "bash" ]]; 
then
  echo "Runnig bash ..."
  bash
else
  echo "Runnig SSHD daemon ..."
  /usr/sbin/sshd -D
fi
