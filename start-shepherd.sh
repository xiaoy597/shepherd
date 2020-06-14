#!/bin/bash
# This script is for starting shepherd process in docker container.

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/conda/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/conda/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/conda/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/conda/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

source $SHEPHERD_BASE/shepherd_0.1.0/shepherd-env.docker

env

onSignal()
{
	echo "Stopping background process ..."
	if [ "$!" != "" -a "$!" != "0" ]; then
		kill -SIGTERM "$!" > /dev/null 2>&1
	fi
	exit 2
}

trap onSignal SIGTERM SIGHUP SIGINT

while true
do
mysql -h$SHEPHERD_DB_HOST -P$SHEPHERD_DB_PORT -u$SHEPHERD_DB_USER -p$SHEPHERD_DB_PASS <<EOF
use $SHEPHERD_DB_NAME;
EOF
if [ $? -ne 0 ]; then
	echo "Waiting for MySQL to startup ..."
	sleep 5
else
	break
fi
done 


while true
do
	if [ "$!" != "" -a "$!" != "0" ]; then
		wait "$!"
	fi
	
	cd $SHEPHERD_HOME && python ./shepherd/shepherd.py&
done

