#!/bin/bash

#set -e

LOCKS_FOLDER=$1
INSTANCE_ID=$2
MAX_DIFF=15

_term() { 
  echo "Caught SIGTERM signal!" 
  rm ${LOCK_FILE}
}
trap _term SIGTERM

for ATTEMPT in {0..60}
do

#while [[ $HAS_LOCK -eq 1  ]];  
#do
    echo "Waiting until all lockes are realeased ($ATTEMPT attempt)"
    
    HAS_LOCK=0
    for OTHER_LOCK in ${LOCKS_FOLDER}/*.lock; do
        echo "Check ${OTHER_LOCK} file"
        TIMESTAMP=`date +%s`
        LOCK_TIME=`cat ${OTHER_LOCK}`
        
        DIFF="$((TIMESTAMP - LOCK_TIME))"
        if [ "$DIFF" -lt "$MAX_DIFF" ];
        then
            HAS_LOCK=1
            echo "Lock is not released: ${OTHER_LOCK} "
        elif [ -f "$OTHER_LOCK" ];
        then
            echo "Removing stale lock ${OTHER_LOCK}"
            rm ${OTHER_LOCK}
        fi
    done


    if [ "$HAS_LOCK" -eq "0" ]; then
        echo "Locks are released"

        echo "Acuiring lock...."
        ${SCRIPT_DIR}/lock.sh acuire ${LOCKS_FOLDER}/${INSTANCE_ID}.lock 

        sleep 5

        CONCURRENT_LOCKS_COUNT=`ls -1 | wc -l`

        if [[ "$CONCURRENT_LOCKS_COUNT" -ne "1" ]]; then
            echo "Concurrent processes are detected"

            FIRST_LOCK=`ls -A ${LOCKS_FOLDER} | head -1`

            if [[ "${INSTANCE_ID}.lock" != "$FIRST_LOCK" ]]; then
                echo "Losing lock because top lock is ${FIRST_LOCK}"
                rm ${LOCKS_FOLDER}/${INSTANCE_ID}.lock 
                HAS_LOCK=1
            else
                echo "Lock is confirmed"
            fi
        fi

    fi

    if [ "$HAS_LOCK" -eq 0 ]; then
        echo "Lock acuired".
        ${SCRIPT_DIR}/lock.sh keep ${LOCKS_FOLDER}/${INSTANCE_ID}.lock &
        break
    else 
        sleep 1
    fi

done



if [ "$HAS_LOCK" -eq 0 ]; then
    exit 0
else 
    exit 1
fi



