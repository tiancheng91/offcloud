#!/bin/bash
export PATH=/opt/node8/bin:$PATH

TOKEN=${TOKEN:-offline}
PORT=${PORT:-18080}

aria2c --conf-path=conf/aria2.conf --rpc-secret=$TOKEN -D 

nohup gost -L=mws://:8443 > /dev/null 2&1 &
nohup serve -p 8001 /data/download > /dev/null 2>&1 &

micro-proxy -r conf/rules.json -p $PORT -H 0.0.0.0

