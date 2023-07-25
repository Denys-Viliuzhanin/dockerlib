#!/bin/bash

docker run -ti \
    -v "$(pwd)"/workspace:/workspace:z \
    digitalocean-cli