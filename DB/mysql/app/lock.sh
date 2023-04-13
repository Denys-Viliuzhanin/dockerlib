#!/bin/bash


#############################################################################################
# Lock script is responsible for creating a lock file as well as constantly keeping it up to date 
# via updating timestamp that is stored in it. 
#############################################################################################


#####################################
# Input parameters
#####################################

# action that must be done. There are two actions: acuire and keep
# 1. acquire - means create a lock and exit
# 2. keep   - constantly update lock time
ACTION=$1

#absolute path to lock file.
LOCK_FILE=$2


#####################################
# Acuire action handler
#####################################

#Generate a current timestamp and store in in lock file. File content must be overiden 
acquire () {
    TIMESTAMP=`date +%s`
	echo ${TIMESTAMP} > ${LOCK_FILE}
}


#####################################
# Keep action handler
#####################################

# Contantly updating timestamp in lock file via executing acuire function 
keeping() {
  while :
    do
        acquire
        sleep ${LOCK_REFRESH_INTERVAL:-1}
    done
}

#####################################
# Handle input action
#####################################

case $ACTION in
  acquire)
    echo "Create lock: ${LOCK_FILE}"
    acquire
    ;;
  keep)
    echo "Keeping lock: ${LOCK_FILE}"
    keeping
    ;;
  *)
    echo "unknown action $ACTION"
    ;;
esac
