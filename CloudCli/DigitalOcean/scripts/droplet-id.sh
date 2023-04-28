#!/bin/bash

if [ -z "$2" ]
then
  ATTEMPTS=1
else
  ATTEMPTS="$2"
fi
for  ((i=1;i<=ATTEMPTS;i++));  do
  ID=$(doctl compute droplet get $1 --format "ID" --no-header)
  if [ -z "$ID" ]
  then
    sleep 1
  else 
    break
  fi
done

if [ -z "$ID" ]
then
    >&2 echo "Droplet $1 can't be found"
fi

echo "$ID"
