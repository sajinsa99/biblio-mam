#!/usr/local/bin/bash


docker images | grep biblio-mam | awk '{print $3}'
