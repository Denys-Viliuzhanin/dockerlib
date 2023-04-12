#!/bin/bash

if [[ -n "${USER_PASSWORD}" ]]; then
  echo "user:${USER_PASSWORD}" | chpasswd
  echo "Password is updated"
fi


/usr/sbin/sshd -D
