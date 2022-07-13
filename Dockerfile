FROM node AS builder
ARG WB_VERSION=1.6.0

RUN cd /root && git clone https://github.com/neopostmodern/wohnungsbot --branch v$WB_VERSION && \
    cd wohnungsbot && npm i && cp app/constants/keys.json.example app/constants/keys.json && \
    npm run-script package-linux


FROM ubuntu:latest
ARG WB_VERSION=1.6.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y git curl x11vnc xvfb openbox hsetroot libnss3 libgbm-dev libasound2 && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -md /app -s /bin/bash bot

ADD startup.sh /app/startup.sh
ADD replacements.sed /app/replacements.sed
ADD openbox/* /app/.config/openbox/

RUN cd /app && git clone https://github.com/novnc/noVNC.git && \
    cd noVNC/ && cp vnc_lite.html index.html && chmod +x /app/replacements.sed && /app/replacements.sed -i index.html && \
    cd utils && git clone https://github.com/novnc/websockify websockify && \
    mkdir /data && ln -s /data /app/.config/Wohnungsbot

COPY --from=builder /root/wohnungsbot/release/Wohnungsbot-$WB_VERSION.AppImage /app/Wohnungsbot.AppImage
COPY --from=builder /root/wohnungsbot/resources/icon.ico /app/noVNC/favicon.ico
COPY --from=builder /root/wohnungsbot/resources/icons/512x512.png /app/background.png

RUN chmod 0755 /app/startup.sh && chown -R bot /app && chown -R bot /data

HEALTHCHECK CMD pidof Wohnungsbot.AppImage && curl --fail http://localhost:6080/ || exit 1
VOLUME /data
USER bot
WORKDIR /app

ENTRYPOINT /app/startup.sh
