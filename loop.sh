#!/bin/sh

cd /usr/src/node-red && /usr/local/bin/npm start -- --dataDir /data
 
while [ 1 ]; do
    sleep 1
done
 
