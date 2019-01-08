FROM ubuntu:xenial

WORKDIR /data

RUN mkdir -p /data/download && mkdir -p /data/www

RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends aria2 wget curl unzip openssl bash python python3 fuse

RUN wget --no-check-certificate "https://caddyserver.com/download/linux/amd64?license=personal&telemetry=on" -O caddy.tar.gz \
    && tar -zxvf caddy.tar.gz \
    && mv caddy /usr/local/bin/ && rm -rf caddy*

RUN wget --no-check-certificate https://github.com/ginuerzh/gost/releases/download/v2.5/gost_2.5_linux_amd64.tar.gz -O gost.tar.gz \
    && tar -zxvf gost.tar.gz \
    && mv gost_2.5_linux_amd64/gost /usr/local/bin/ && rm -rf gost*

RUN wget --no-check-certificate https://github.com/ncw/rclone/releases/download/v1.45/rclone-v1.45-linux-amd64.zip -O rclone.zip \
    && unzip rclone.zip \
    && mv rclone-v1.45-linux-amd64/rclone /usr/local/bin/ && rm -rf rclone*

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ADD ./.profile.d /app/.profile.d
ADD . /data/

CMD bash run.sh
