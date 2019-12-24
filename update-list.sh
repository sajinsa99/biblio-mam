#!/bin/bash

set -e +x

cd /root/
. .bashrc

cd /biblio-mam/

git pull ; git status
echo

perl -w list.pl > results.txt
cat results.txt
echo
git status
echo

current_date=`date`
git commit -am "$current_date"
git push
git status

