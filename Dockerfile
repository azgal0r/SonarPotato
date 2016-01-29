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
WORKDIR /tmp

RUN apt-get update \
&& apt-get install -qy libcurl4-openssl-dev bzip2 supervisor wget \
&& wget -q https://github.com/Jackett/Jackett/releases/download/$(wget -q https://github.com/Jackett/Jackett/releases/latest -O - | grep -E \/tag\/ | awk -F "[><]" '{print $3}')/Jackett.Binaries.Mono.tar.gz \
&& tar -xvf Jackett* \
&& mkdir -p /opt/jackett \
&& mv Jackett/* /opt/jackett

#Supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf
EXPOSE 9117
