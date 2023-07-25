#!/bin/bash

MY_IP=$($UTILS_PATH/my-public-ip.sh)

firewall-create "fr-$1-in-allow-ssh" $1 "tcp" 22 "$MY_IP"
