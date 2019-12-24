#!/bin/bash

set -e +x

cd /root/
. .bashrc

cd /biblio-mam/
git pull
perl -w list.pl > results.txt
cat results.txt
