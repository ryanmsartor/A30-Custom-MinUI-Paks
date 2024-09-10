#!/bin/sh

while :; do
    syncsettings.elf
    sleep 1  # Adding a short sleep to avoid busy-waiting
done &
LOOP_PID=$!

mydir=$(dirname "$0")

export HOME=$mydir
export PATH=$mydir/bin:$PATH
export LD_LIBRARY_PATH=$mydir/libs:/usr/miyoo/lib:/usr/lib:$LD_LIBRARY_PATH
cd $mydir
ffplay -vf transpose=2 -fs -i "$1"

kill $LOOP_PID


