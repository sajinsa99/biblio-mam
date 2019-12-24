#!/bin/bash

set -e +x

cd /root/
. .bashrc

cd /biblio-mam/
perl -w list.pl > results.txt
cat results.txt
