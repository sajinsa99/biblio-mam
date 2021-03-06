#!/bin/bash

echo
date
echo

set -e +x

cd /root/
source .bashrc

cd /biblio-mam/

git pull ; git status
echo

perl -w list.pl > results.txt 2>&1
cat results.txt
echo
git status
echo

current_date=$(date)
echo "git commit -am $current_date"
git commit -am "$current_date"
echo
git push
echo
git status
echo

