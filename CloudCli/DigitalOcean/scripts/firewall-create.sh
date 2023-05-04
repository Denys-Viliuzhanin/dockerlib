#!/bin/bash

NAME=$1
DROPLET_ID=$(droplet-id $2)
PROTOCOL=$3
PORT=$4

doctl compute firewall create --name "$NAME" \
                              --droplet-ids "$DROPLET_ID" \
                              --inbound-rules="protocol:$PROTOCOL,ports:$PORT,address:$MY_IP"