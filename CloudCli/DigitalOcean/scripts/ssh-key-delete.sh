#!/bin/bash

ID=$(ssh-key-id $1)
doctl compute ssh-key delete $ID 