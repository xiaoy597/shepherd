#!/bin/bash
# This script is for starting spider-agent process in docker container.

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

source $SHEPHERD_BASE/spider-agent_0.1.0/spider-agent-env.docker

env

onSignal()
{
    echo "Stopping background process ..."
    if [ "$!" != "" -a "$!" != "0" ]; then
		echo "Sending stop signal to process $! ..."
        kill -SIGTERM "$!" 
    fi
	# Wait for twistd to clean-up.
	sleep 2
    exit 2
}

trap onSignal SIGTERM SIGHUP SIGINT

while true
do
    if [ "$!" != "" -a "$!" != "0" ]; then
        wait "$!"
    fi

	python $SPIDER_AGENT_HOME/spider-agent.py&
done

