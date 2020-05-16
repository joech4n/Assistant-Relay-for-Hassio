ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8


RUN mkdir /assistant_relay \
&& npm i pm2 -g

WORKDIR /assistant_relay

RUN wget https://github.com/greghesp/assistant-relay/releases/download/v3.2.0/release.zip \
&& unzip release.zip \
&& rm release.zip \
&& sed -i -e 's#./bin/config.json#/data/config.json#g' /assistant_relay/helpers/server.js \
&& sed -i -e 's#./bin/config.json#/data/config.json#g' /assistant_relay/helpers/assistant.js \
&& sed -i -e 's#./bin/config.json#/data/config.json#g' /assistant_relay/helpers/auth.js \
&& sed -i -e 's#./bin/config.json#/data/config.json#g' /assistant_relay/routes/index.js \
&& sed -i -e 's#./bin/config.json#/data/config.json#g' /assistant_relay/routes/server.js \
&& sed -i -e 's#./bin/config.json#/data/config.json#g' /assistant_relay/bin/www \
&& sed -i -e 's#./bin/config.json#/data/config.json#g' /assistant_relay/routes/server.js \
&& sed -i -e 's#../bin/audio-responses/#/data/audio-responses/#g' /assistant_relay/helpers/server.js \
&& sed -i -e 's#../bin/audio-responses/#/data/audio-responses/#g' /assistant_relay/routes/server.js \
&& sed -i -e 's#bin/audio-responses/#/data/audio-responses/#g' /assistant_relay/helpers/server.js \
&& npm i

WORKDIR /
RUN wget https://raw.githubusercontent.com/Apipa169/Assistant-Relay-for-Hassio/master/dockerfiles/armv7/run.sh
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
