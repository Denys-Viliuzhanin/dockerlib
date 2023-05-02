#!/bin/bash

source "./$1.droplet.sh"

DROPLET_ID=$(droplet-id $1)


#VM_KEY=$((1 + RANDOM % 9999999999999999))

DROPLET_NAME="$1"

if [ ! -z "$DROPLET_ID" ]; then
  echo "Droplet $1 already exists"
  exit 1
fi

echo "Creating $DROPLET_NAME...."
# Create droplet
doctl compute droplet create $DROPLET_NAME --image "$IMAGE" --size "$SIZE" --region "$REGION" #--format "ID" --no-header

sleep 1

DROPLET_ID=$(droplet-id $1 10) 
echo "Droplet: $DROPLET_NAME@$DROPLET_ID"


#Forbit all incoming traffic
doctl compute firewall create --name "fr-$1-in-frobid-all" --droplet-ids "$DROPLET_ID" --inbound-rules="protocol:tcp,ports:all"
