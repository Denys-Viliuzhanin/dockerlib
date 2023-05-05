#!/bin/bash

ID=$(droplet-id $1)

doctl compute droplet list --format "ID, PublicIPv4" | grep "$ID" | cut -c14-28
