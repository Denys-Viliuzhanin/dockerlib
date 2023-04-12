#!/bin/bash

LOCKS_FOLDER=$1
INSTANCE_ID=$2
MAX_DIFF=30

_term() { 
  echo "Caught SIGTERM signal!" 
  rm ${LOCK_FILE}
}
trap _term SIGTERM

HAS_LOCK=1
while [[ $HAS_LOCK -eq 1  ]];  
do
    echo "Waiting until all lockes are realeased"
    sleep 2
    HAS_LOCK=0
    for OTHER_LOCK in ${LOCKS_FOLDER}/*.lock; do
        echo "Check ${OTHER_LOCK} file"
        TIMESTAMP=`date +%s`
        LOCK_TIME=`cat ${OTHER_LOCK}`
        
        DIFF="$((TIMESTAMP - LOCK_TIME))"
        if [ "$DIFF" -lt "$MAX_DIFF" ];
        then
            HAS_LOCK=1
            echo "Lock is not realsed: ${OTHER_LOCK} "
        elif [ -f "$OTHER_LOCK" ];
        then
            echo "Removing stale lock ${OTHER_LOCK}"
            rm ${OTHER_LOCK}
        fi
    done
done

echo "Locks are released"

${SCRIPT_DIR}/lock.sh ${LOCKS_FOLDER}/${INSTANCE_ID}.lock &

sleep 1

