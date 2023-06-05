#!/opt/homebrew/bin/bash

echo
./clean-docker-none.sh

echo
docker build -f Dockerfile -t biblio-mam .
