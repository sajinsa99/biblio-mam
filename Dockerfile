FROM alpine

LABEL maintainer="bruno.fablet@sap.com"

RUN apk update ; apk upgrade

# install some tools
#RUN apk add --no-cache vim bash tree wget curl git git-lfs openssh-client openssl rsync dos2unix terraform perl ruby

#install install minimal tools
RUN apk add --no-cache bash vim dos2unix tree perl wget curl git openssh
# install prerequistes for perl cpan
RUN apk add --no-cache  make gcc perl-utils

# install perl module(s)
RUN export PERL_MM_USE_DEFAULT=1 ; cd / root ;  cpan -u ; cpan -i Text::Unaccent::PurePerl

# clean install
RUN cd /root ; rm -rf .cpan ; cd /tmp ; rm -rf * ; 
RUN apk del gcc make ; rm -rf /var/cache/apk/*

# set some custom env
ADD .alias /root/
ADD .promptrc /root/
ADD .vimrc /root/

RUN unalias -a ;\
    echo ". .alias"     >> /root/.bashrc ;\
    echo ". .promptrc"  >> /root/.bashrc ;\
    chmod 700 /root/.alias ;\
    chmod 700 /root/.promptrc ;\
	chmod 700 /root/.vimrc ;\
    chmod 700 /root/.bashrc

# execute perl script
ADD update-list.sh /root/update-list.sh
RUN chmod 700 /root/update-list.sh

ENTRYPOINT ["/root/update-list.sh"]
WORKDIR /root
