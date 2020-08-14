FROM heroku/heroku:18

WORKDIR /data

RUN mkdir -p /data/download && mkdir -p /data/www

RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends aria2 wget curl gzip unzip openssl bash python python3 fuse

RUN wget --no-check-certificate "https://caddyserver.com/download/linux/amd64?license=personal&telemetry=on" -O caddy.tar.gz \
    && tar -zxvf caddy.tar.gz \
    && mv caddy /usr/local/bin/ && rm -rf caddy*

RUN wget --no-check-certificate https://github.com/ginuerzh/gost/releases/download/v2.11.1/gost-linux-amd64-2.11.1.gz -O gost.gz \
    && gunzip gost.gz \
    && mv gost /usr/local/bin/ && rm -rf gost.gz

RUN wget --no-check-certificate https://github.com/ncw/rclone/releases/download/v1.45/rclone-v1.45-linux-amd64.zip -O rclone.zip \
    && unzip rclone.zip \
    && mv rclone-v1.45-linux-amd64/rclone /usr/local/bin/ && rm -rf rclone*

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ADD ./.profile.d /app/.profile.d
ADD . /data/

CMD bash run.sh
