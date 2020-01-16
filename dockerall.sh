#!/usr/local/bin/bash

set -e +x

echo
echo "==== START ===="
echo
date

echo docker build
./dockerbuild.sh 
echo

echo docker run
./dockerrun.sh
echo

echo
echo" ==== STOP ===="
date
echo

