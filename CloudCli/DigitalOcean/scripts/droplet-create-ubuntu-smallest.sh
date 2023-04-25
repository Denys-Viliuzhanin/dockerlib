#!/bin/bash

doctl compute droplet create $1 --image ubuntu-22-10-x64 --size s-1vcpu-512mb-10gb --region fra1