#!/usr/local/bin/bash

echo "clean docker images with tag none, if exist¨"
for docker_tag in $(docker images | grep -w none | awk '{print $3}'); do echo "delete tag ${docker_tag}" ; docker rmi -f "${docker_tag}";done