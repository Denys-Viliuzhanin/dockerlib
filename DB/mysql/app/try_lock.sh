#!/bin/bash

#############################################################################################
# Exclusive Lock acquiring logic.
# The idea is based on following:
# 1. Make sure that there are no existing locks that are still kept by other process. It can be 
#    checked by computing a difference between current timestamp and timestamp stored in lock file. 
#    If it older than configured value than it means that there is no owner and we can remove it
# 2. When there are no other locks it means that a new lock can be acquired. For this current process 
#    creates a new lock file (format "{INSTANCE_ID}.lock"). It can be done via calling `./lock.sh acquire` 
#    script with
# 3. After that there is achange that other processes tries to acquire lock as well. So we should wait some time
#    to let them create there lock files and after that the "winner" is defined by simple alphabetic order of ids.
#    A owner of the first lock file in a list is considered as owner. All other not. They continue to try until all 
#    attempts will be done
# 4. When lock is acquired scripts returns exit code 0 otherwise 1
#############################################################################################

#####################################
# Input parameters
#####################################
# Folder where all lock files are stored
LOCKS_FOLDER=$1
# Current process instance ID.
INSTANCE_ID=$2

#####################################
# Properties
#####################################
#Current script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


#####################################
# Acquiring attempts
#####################################
for ATTEMPT in {0..60}
do

    echo "Waiting until all lockes are realeased ($ATTEMPT attempt)"
    
    # flag that is used to indicate whether other locks exists. 
    HAS_LOCK=0

    #####################################
    # Step 1. Check existing locks to find stale. 
    #####################################
    for OTHER_LOCK in ${LOCKS_FOLDER}/*.lock; do
        echo "Check ${OTHER_LOCK} file"

        #Current time
        TIMESTAMP=`date +%s`
        #load lock timestampe
        LOCK_TIME=`cat ${OTHER_LOCK}`
        #Compute lock lifetime
        DIFF="$((TIMESTAMP - LOCK_TIME))"
        MAX_LIFE_TIME=${LOCK_LIFETIME:-10}

        # Check wether lock is stale and can be deleted
        if [ $DIFF -lt $MAX_LIFE_TIME ]; then
            HAS_LOCK=1
            echo "Lock is not released: ${OTHER_LOCK} ($DIFF < $MAX_LIFE_TIME)"
        elif [ -f "$OTHER_LOCK" ]; then
            echo "Removing stale lock ${OTHER_LOCK}"
            rm ${OTHER_LOCK}
        fi
    done

    #####################################
    # Step 2. Try acquire lock
    #####################################
    if [ "$HAS_LOCK" -eq "0" ]; then
        echo "Locks are released"

        # Acquire new lock
        echo "Acquiring lock...."
        ${SCRIPT_DIR}/lock.sh acquire ${LOCKS_FOLDER}/${INSTANCE_ID}.lock 


        sleep ${RACE_CONDITION_WAIT_TIME:-30}

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
    
    #####################################
    # Step 3. Try acquire lock
    #####################################
    if [ "$HAS_LOCK" -eq 0 ]; then
        echo "Lock acuired".
        ${SCRIPT_DIR}/lock.sh keep ${LOCKS_FOLDER}/${INSTANCE_ID}.lock &
        break
    else 
        sleep ${LOCK_REFRESH_INTERVAL:-1}
    fi

done


#####################################
# Make a final decision whether lock is acquired
#####################################
if [ "$HAS_LOCK" -eq 0 ]; then
    exit 0
else 
    exit 1
fi



