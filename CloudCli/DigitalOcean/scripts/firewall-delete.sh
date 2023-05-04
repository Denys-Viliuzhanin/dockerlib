#!/bin/bash


ID=$(firewall-id "$1")


if [ -z "$ID" ]; then
  echo "Firewall $1 doesn't exist"
  exit 1
fi

doctl compute firewall delete $ID