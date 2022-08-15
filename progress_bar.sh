#!/bin/bash

PROGRESS=0
RANDOM=$$
SYMBOL="="
PERC_PER_SYMBOL=$1

populate_completion_bar () {
    local curr_progress=$1
    local iter=$(($curr_progress / $PERC_PER_SYMBOL))
    #if [ $curr_progress -le 0 ]; then echo " "; return ; fi

    local bar=""
    for (( i=1 ; i<=$iter ; i++ )) ;
    do
        bar+=$SYMBOL
    done
    bar+=">"

    echo "$bar"
}

print_completion_bar () {
    printf "  [%-$((1+(100/$PERC_PER_SYMBOL)))s] (%d%%)\r" $(populate_completion_bar $PROGRESS) $PROGRESS
}

waiting () {
    #sleep $((1+($RANDOM % 2)))
    local sleep_time=$((1000 + ($RANDOM % 4)*($RANDOM % 500 )))
    sleep $(($sleep_time/1000))
}

echo 'Starting operation'
print_completion_bar
waiting

while [ $PROGRESS -lt 100 ]
do
    new_progress=$((1 + ($RANDOM % 10)))
    ((PROGRESS+=new_progress))
    if [ $PROGRESS -gt 100 ] ; then PROGRESS=100; fi

    print_completion_bar
    waiting
done
echo ; echo "Operation finished"; echo ;
