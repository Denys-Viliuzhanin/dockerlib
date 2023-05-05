#!/bin/bash

KEY_ID=$(ssh-key-id $1)
doctl compute ssh-key delete $KEY_ID