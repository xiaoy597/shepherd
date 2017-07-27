#!/bin/sh

function check_xvfb {
        ps -ef|grep Xvfb|while read MYUID MYPID MYPPID MYC MSTIME MYTTY MYTIME MYCMD MYREST
        do
                if [ "$MYCMD" = "Xvfb" ]; then
                        echo "Found Xvfb!"
                        return 1
                fi
        done
        return $?
}

check_xvfb
if [ $? -ne 1 ]; then
        echo "Xvfb is not found, starting Xvfb ..."
        Xvfb :1 -screen 0 1024x768x24 -nolisten tcp&
fi

export DISPLAY=:1

