#!/bin/bash

IP=$(droplet-ip $1)

ssh -i "$WORKSPACE_PATH/$1" "root@$IP"