FROM alpine:latest

# install tools

RUN apk update --no-cache --quiet --no-progress && apk upgrade --no-cache --quiet --no-progress && apk add --quiet --no-progress --no-cache bash wget curl tar dos2unix git vim tree rsync which openssl openssh shellcheck util-linux ncurses less fd exa ripgrep

# set CET timezone
RUN apk add --quiet --no-progress --no-cache tzdata && cp -vf /usr/share/zoneinfo/CET /etc/localtime && echo CET > /etc/timezone && date && apk del --quiet --no-progress --no-cache tzdata

# install prerequisites for compiling perl
RUN apk add --quiet --no-progress --no-cache expat-dev \
	gcc \
	libc-dev \
	make \
	musl-dev \
	openssl-dev \
	zlib-dev

# download, compile and install perl, the one coming from alpine distribution, is bugged using diagnostics perl module
ENV PERL_VERSION=5.38.2 \
	PERL_MM_USE_DEFAULT=1
RUN cd /tmp ;\
	wget --no-proxy --no-check-certificate -nv https://www.cpan.org/src/5.0/perl-$PERL_VERSION.tar.gz ;\
	tar -xzf perl-$PERL_VERSION.tar.gz
RUN cd /tmp/perl-$PERL_VERSION ;\
	./Configure -des > /tmp/configure-perl.log 2>&1
RUN cd /tmp/perl-$PERL_VERSION ;\
	make > /tmp/make-perl.log 2>&1
RUN cd /tmp/perl-$PERL_VERSION ;\
	make install > /tmp/make-install-perl.log 2>&1
RUN cd /tmp ;\
	curl -L https://cpanmin.us | perl - App::cpanminus  > /tmp/cpanminus.log 2>&1 ;\
	cpanm -n App::cpanoutdated > /tmp/install-cpanoutdated.log 2>&1
RUN cd /tmp ;\
	cpan-outdated -p | cpanm > /tmp/cpan-outdated.log 2>&1

RUN cd /tmp ; cpanm -n Text::Unaccent::PurePerl > /tmp/Text-Unaccent-PurePerl.log 2>&1
RUN cd /tmp ; cpanm -n Text::CSV > /tmp/Text-CSV.log 2>&1

# remove prerequisites for perl, not needed anymore
RUN apk del --quiet --no-progress --no-cache expat-dev \
	gcc \
	libc-dev \
	make \
	musl-dev \
	openssl-dev \
	zlib-dev

# some cleans + Cleanup apk cache to save space
RUN rm -f /tmp/*.* ;\
  rm -rf /tmp/* ;\
  rm -rf /var/cache/apk/*

RUN cd /opt && git clone https://github.com/so-fancy/diff-so-fancy.git && cd /usr/local/bin/ && ln -s /opt/diff-so-fancy/diff-so-fancy . && ln -s /opt/diff-so-fancy/third_party/diff-highlight/diff-highlight .
ADD .gitconfig /root/
ADD .gitignore /root/
ADD .gitignore_global /root/

# set some custom env
ADD .alias /root/
ADD .promptrc /root/
ADD .vimrc /root/

RUN unalias -a ;\
    echo ". .alias"    >> /root/.bashrc ;\
    echo ". .promptrc" >> /root/.bashrc ;\
    chmod 700 /root/.alias    ;\
    chmod 700 /root/.promptrc ;\
    chmod 700 /root/.vimrc    ;\
    chmod 700 /root/.bashrc

# execute perl script
ADD update-list.sh /root/update-list.sh
RUN chmod 700 /root/update-list.sh
ENV EDITOR vim

ENTRYPOINT ["/root/update-list.sh"]
WORKDIR /root
