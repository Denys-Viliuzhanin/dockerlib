#!/bin/bash

doctl compute droplet delete $1

firewall-delete "fr-$1-in-frobid-all"


droplet-ssh-disable "$1"

KEY_ID=$(ssh-key-id $1)
ssh-key-delete $KEY_ID


