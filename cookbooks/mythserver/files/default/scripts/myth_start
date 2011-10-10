#!/bin/sh

MYTHEXISTS=`/bin/ps -e | grep mythfrontend | grep -v grep | awk '{print $1}'`;

if [ "$MYTHEXISTS" != "" ]; then
        for MYTHPROCESS in `/bin/ps -e | grep mythfrontend | grep -v grep | awk '{print $1}'`
        do
                echo $MYTHPROCESS;
                kill -9 $MYTHPROCESS;
        done
fi

DISPLAY=:0 mythfrontend &
