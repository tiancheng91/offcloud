#!/bin/bash
export PATH=/opt/node8/bin:$PATH

# config
ulimit -n 8192
TOKEN=${TOKEN:-offcloud}
PORT=${PORT:-18080}

# gost
nohup gost -L=mws://:8443 > /dev/stdout 2>&1 &
# 下载
aria2c --conf-path=conf/aria2.conf --rpc-secret=$TOKEN -D

# rclone挂载
mkdir -p $HOME/.config/rclone
echo "[drive]
type = drive
scope = drive
token = {\"access_token\":\"ya29.GlyLBkBUF4oxHrO0rgBCTfwsvAHkMTMETd6wvgnzTSF5Izp9HGiLrCXI8uhkbgJWLzXrRMIfX3nACeeuLsXBci4E1MLxAwPPOiQ0j0asc8zBiDE9LOcFxMIrrODEiA\",\"token_type\":\"Bearer\",\"refresh_token\":\"${TOKEN_DRIVE}\",\"expiry\":\"2019-01-07T14:10:51.465723254Z\"}
" > $HOME/.config/rclone/rclone.conf
mkdir -p /etc/ssl/certs/
curl --insecure -o /etc/ssl/certs/ca-certificates.crt https://raw.githubusercontent.com/bagder/ca-bundle/master/ca-bundle.crt
nohup rclone serve http drive: --no-modtime --vfs-cache-max-age 24h > /dev/stdout 2>&1 &

caddy --conf conf/Caddyfile --port $PORT
