#!/bin/bash


docker build \
       --build-arg UID="$(id -u)" \
       --build-arg GID="$(id -g)" \
       -t digitalocean-cli:latest \
       . #--no-cache \