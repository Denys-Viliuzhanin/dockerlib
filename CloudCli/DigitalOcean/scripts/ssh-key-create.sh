#!/bin/bash


KEY_NAME=$1

ssh-keygen -t rsa -b 4096 -f "$WORKSPACE_PATH/$KEY_NAME"

PUBLIC_KEY=$(cat $WORKSPACE_PATH/$KEY_NAME.pub)
doctl compute ssh-key create $KEY_NAME --public-key "$PUBLIC_KEY"