#!/bin/bash


KEY_NAME=$1

ssh-keygen -t rsa -b 4096 -f "$WORKSPACE_PATH/$KEY_NAME"


doctl compute ssh-key create $KEY_NAME --public-key "$(cat $WORKSPACE_PATH/$KEY_NAME.pub)"