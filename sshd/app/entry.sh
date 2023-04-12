#!/bin/bash

BUILD_NUMBER=$(</app/build_number.txt)
echo "SSHD Image Build: ${BUILD_NUMBER}"

ssh-keygen -lf /etc/ssh/ssh_host_ecdsa_key.pub

if [[ -n "${USER_PASSWORD}" ]]; then
  echo "user:${USER_PASSWORD}" | chpasswd
  echo "Password is specified"
else
  echo "Password is not specified"
fi


/usr/sbin/sshd -D
