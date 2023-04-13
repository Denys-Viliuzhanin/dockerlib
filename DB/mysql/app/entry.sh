#!/bin/bash

echo "DB Startup..."

echo "Acquiring exclusive lock"

export SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

INSTANCE_ID=`echo $RANDOM | md5sum | head -c 20; echo;`
echo "Instance ${INSTANCE_ID}"

${SCRIPT_DIR}/try_lock.sh $SCRIPT_DIR/locks $INSTANCE_ID

sleep 1

/usr/local/bin/docker-entrypoint.sh mysqld
