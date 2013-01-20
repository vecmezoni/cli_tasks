#!/bin/bash
configfile='./screenshotd.config'

source "$configfile"


shoot () {
    while [ 1 ]
    do 
    screenshot_date=`date +%Y-%m-%d_%H-%M-%S`
    import -window $1 "$STORAGE/$1_$screenshot_date.jpg"
    sleep $2
    done
    }
for userna in ${USERS[@]}; do
    interval_variable="${userna}_INTERVAL"
    dump_interval=$DUMP_INTEVAL
    if [[ "${!interval_variable}" != "" ]]
    then
         let dump_interval="${!interval_variable}"
    fi
    shoot $userna $dump_interval &
done