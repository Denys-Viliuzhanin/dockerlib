#!/bin/bash

source "./$1.droplet.sh"



doctl compute droplet create $1 --image "$IMAGE" --size "$SIZE" --region "$REGION"