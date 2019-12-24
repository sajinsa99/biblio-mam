docker run -v `pwd`:/biblio-mam:rw -v $HOME/.ssh:/root/.ssh:ro -v $HOME/.gitconfig:/root/.gitconfig:ro -it `docker images | grep biblio-mam | awk {'print $3'}` $1
