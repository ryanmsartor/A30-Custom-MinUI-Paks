#!/bin/sh
export HOME=`dirname "$0"`
export LD_LIBRARY_PATH=lib:/usr/miyoo/lib:/usr/lib

cd $HOME
./DinguxCommander
sync
