FROM ubuntu
MAINTAINER azgal0r
RUN apt-get update && apt-get install -y --no-install-recommends \
	git-core \
	libffi-dev \
	libssl-dev \
	zlib1g-dev \
	libxslt1-dev \
	libxml2-dev \
	python \
	python-pip \
	python-dev \
	build-essential
RUN pip install lxml cryptography pyopenssl
EXPOSE 5050
RUN git clone https://github.com/RuudBurger/CouchPotatoServer /opt/couchpotato
VOLUME ["/config"]

#Sonarr
ENV APTLIST="libmono-cil-dev python nzbdrone"

# Configure nzbdrone's apt repository
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC && \
echo "deb http://apt.sonarr.tv/ master main" > /etc/apt/sources.list.d/sonarr.list && \
apt-get update -q && \
apt-get install $APTLIST -qy && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh
VOLUME /config
EXPOSE 8989

#Jackett
RUN apt-get update \
&& apt-get install -qy libcurl4-openssl-dev bzip2 supervisor wget
EXPOSE 9117

#Subliminal
RUN pip install -U subliminal && apt-get install -qy php5-cli php5-readline
ADD postscript/ /postscript/ 
RUN chmod -R 755 /postscript

#Supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf

VOLUME /jackett
VOLUME /media_data
VOLUME /root/.config/Jackett
VOLUME /config

ENTRYPOINT ["/etc/service/sonarr/run"]
