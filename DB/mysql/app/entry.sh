#!/bin/bash

echo "DB Startup..."

#####################################
# Define variables
#####################################
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#####################################
# Generate a unique instance ID
#####################################

INSTANCE_ID=`echo $RANDOM | md5sum | head -c 20; echo;`
echo "Instance ${INSTANCE_ID}"

#####################################
# Acuiring exclusive lock
#####################################
echo "Acquiring exclusive lock"
${SCRIPT_DIR}/try_lock.sh $SCRIPT_DIR/locks $INSTANCE_ID


#####################################
# Run DB instance if exclusive lock is acuired
#####################################

if [ "$?" -eq 0 ]; then
    echo "Exclusive lock is acuired so we can start a DB"
    /usr/local/bin/docker-entrypoint.sh mysqld
else 
    echo "Exclusive lock isn't acuired so we can't start a DB"
    exit 1
fi
