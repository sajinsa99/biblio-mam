docker_image_tag=`./docker-get-tag.sh`
echo docker image tag = $docker_image_tag
docker run --entrypoint "/bin/bash" -v `pwd`:/biblio-mam:rw -v $HOME/.ssh:/root/.ssh:ro -v $HOME/.gitconfig:/root/.gitconfig:ro -it $docker_image_tag
