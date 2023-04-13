#!/bin/bash

ACTION=$1
LOCK_FILE=$2


acuire () {
    TIMESTAMP=`date +%s`
	echo ${TIMESTAMP} > ${LOCK_FILE}
}

keeping() {
  while :
    do
        acuire
        sleep 1
    done
}

case $ACTION in
  acuire)
    echo "Create lock: ${LOCK_FILE}"
    acuire
    ;;
  keep)
    echo "Keeping lock: ${LOCK_FILE}"
    keeping
    ;;
  *)
    echo -n "unknown"
    ;;
esac
