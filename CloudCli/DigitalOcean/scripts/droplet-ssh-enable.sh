#!/bin/bash

MY_IP=$(/app/digitalocean-cli/utils/my-public-ip.sh)

DROPLET_ID=$(droplet-id $1)

doctl compute firewall create --name "fr-$1-in-allow-ssh" \
                              --droplet-ids "$DROPLET_ID" \
                              --inbound-rules="protocol:tcp,ports:22,address:$MY_IP"
