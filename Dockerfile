FROM ubuntu:xenial

WORKDIR /data

RUN mkdir -p /data/download && mkdir -p /data/www

RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends aria2 wget

RUN wget --no-check-certificate https://nodejs.org/dist/v8.11.1/node-v8.11.1-linux-x64.tar.gz \
    && tar -zxvf node-v8.11.1-linux-x64.tar.gz \
    && mv node-v8.11.1-linux-x64 /opt/node8

RUN wget --no-check-certificate https://github.com/ginuerzh/gost/releases/download/v2.5/gost_2.5_linux_amd64.tar.gz -O gost.tar.gz \
    && tar -zxvf gost.tar.gz \
    && mv gost_2.5_linux_amd64/gost /usr/local/bin/

RUN export PATH=/opt/node8/bin:$PATH && npm install -g serve micro-proxy

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ADD . /data/
ADD ./.profile.d /app/.profile.d

CMD bash run.sh
