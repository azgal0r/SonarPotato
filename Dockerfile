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
