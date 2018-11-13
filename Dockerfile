FROM ubuntu:xenial

WORKDIR /data

RUN mkdir -p /data/download && mkdir -p /data/www

RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends aria2 wget curl

RUN wget --no-check-certificate "https://caddyserver.com/download/linux/amd64?license=personal&telemetry=on" -O caddy.tar.gz \
    && tar -zxvf caddy.tar.gz \
    && mv caddy /usr/local/bin/

RUN wget --no-check-certificate https://github.com/ginuerzh/gost/releases/download/v2.5/gost_2.5_linux_amd64.tar.gz -O gost.tar.gz \
    && tar -zxvf gost.tar.gz \
    && mv gost_2.5_linux_amd64/gost /usr/local/bin/

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ADD . /data/
ADD ./.profile.d /app/.profile.d

CMD bash run.sh
