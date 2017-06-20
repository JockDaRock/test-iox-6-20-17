FROM node:6-alpine

# Home directory for Node-RED application source code.
RUN mkdir -p /usr/src/node-red

# User data directory, contains flows, config and nodes.
RUN mkdir /data

WORKDIR /usr/src/node-red
COPY loop.sh /usr/src/node-red/
RUN chmod 777 /usr/src/node-red/loop.sh

# Add node-red user so we aren't running as root.
RUN adduser -h /usr/src/node-red -D -H node-red \
    && chown -R node-red:node-red /data \
    && chown -R node-red:node-red /usr/src/node-red

USER node-red

# package.json contains Node-RED NPM module and node dependencies
COPY package.json /usr/src/node-red/
RUN npm install
RUN npm install node-red-contrib-modbus
ENV PATH "$PATH:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin"

# User configuration directory volume
EXPOSE 1880

# Environment variable holding file path for flows configuration
ENV FLOWS=flows.json


CMD ["npm", "start", "--", "--userDir", "/data"]

