#!/bin/bash

ID=$(doctl compute ssh-key list --format "ID, Name" | grep "$1" | cut -c1-8)
COUNT=$(doctl compute ssh-key list --format "ID, Name" | grep "$1" | cut -c1-8 | wc -l)

if [ "$COUNT" -eq "0" ]; then
    >&2 echo "Key '$1' can't be found"
    exit 1
elif [ "$COUNT" -gt "1" ]; then
    >&2 echo "Multiple keys matches the name '$1': $ID"
    exit 2
fi

echo $ID
