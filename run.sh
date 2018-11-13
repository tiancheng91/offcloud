#!/bin/bash
export PATH=/opt/node8/bin:$PATH

ulimit -n 8192
TOKEN=${TOKEN:-offcloud}
PORT=${PORT:-18080}

aria2c --conf-path=conf/aria2.conf --rpc-secret=$TOKEN -D 

nohup gost -L=mws://:8443 > /dev/null 2>&1 &

caddy --conf conf/Caddyfile --port $PORT