#!/bin/bash

# Ensure both scripts are executed with niceness 10
nice -n 10 bash /home/mdicosta/FlowDplus/FinalResults/3040final/multitrial/run_multitrial.sh "$@" &
nice -n 10 bash /home/mdicosta/FlowDplus/FinalResults/4050final/multitrial/run_multitrial.sh "$@" &

# Wait for all background processes to finish
wait
