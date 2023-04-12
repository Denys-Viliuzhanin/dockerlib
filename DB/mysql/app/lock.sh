#!/bin/bash

LOCK_FILE=$1

while :
do
    TIMESTAMP=`date +%s`
	echo ${TIMESTAMP} > ${LOCK_FILE}
	sleep 1
done

