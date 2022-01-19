FROM node AS builder
ARG WB_VERSION=1.4.0

RUN cd /root && git clone https://github.com/neopostmodern/wohnungsbot --branch v$WB_VERSION && \
    cd wohnungsbot && npm i && cp app/constants/keys.json.example app/constants/keys.json && \
    npm run-script package-linux


FROM ubuntu:latest
ARG WB_VERSION=1.4.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y git x11vnc xvfb openbox libnss3 libgbm-dev libasound2 && \
    apt-get autoclean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -md /app -s /bin/bash bot
RUN cd /app && git clone https://github.com/novnc/noVNC.git && \
    cd /app/noVNC/utils && git clone https://github.com/kanaka/websockify websockify && \
    mkdir /data && mkdir /app/.config && ln -s /data /app/.config/Wohnungsbot
ADD startup.sh /app/startup.sh
COPY --from=builder /root/wohnungsbot/release/Wohnungsbot-$WB_VERSION.AppImage /app/Wohnungsbot.AppImage
RUN chmod 0755 /app/startup.sh && chown -R bot /app && chown -R bot /data

VOLUME /data
USER bot
WORKDIR /app

ENTRYPOINT /app/startup.sh