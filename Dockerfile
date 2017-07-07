FROM node:6-alpine

# Home directory for Node-RED application source code.
RUN mkdir -p /usr/src/node-red

# User data directory, contains flows, config and nodes.
RUN mkdir /data

WORKDIR /usr/src/node-red
# COPY loop.sh /usr/src/node-red/
# RUN chmod 777 /usr/src/node-red/loop.sh


#Add node-red user so we aren't running as root.
# RUN adduser -h /usr/src/node-red -D -H -u 900 -G root node-red && chown -R node-red:root /data && chown -R node-red:root /usr/src/node-red
# RUN adduser -h /usr/src/node-red -D -H -u 900 node-red && chown -R node-red:node-red /data && chown -R node-red:node-red /usr/src/node-red

# USER node-red

# package.json contains Node-RED NPM module and node dependencies
COPY package.json /usr/src/node-red/
RUN npm install
RUN npm install node-red-contrib-modbus
ENV PATH "$PATH:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin"

# User configuration directory volume
EXPOSE 1880

# Environment variable holding file path for flows configuration
ENV FLOWS=flows.json

LABEL \
    cisco.info.name="node-red" \
    cisco.info.description="devon energy node-red" \
    cisco.info.version="4.0" \
    cisco.info.author-name="Cisco" \
    cisco.type="docker" \
    cisco.resources.network.0.interface-name="eth0" \
    cisco.cpuarch="x86_64" \
    cisco.resources.profile="c1.large"

#CMD ["npm", "start", "--", "--userDir", "/data"]
CMD npm start --prefix /usr/src/node-red --userDir /data
