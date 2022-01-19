#!/bin/bash
export DISPLAY=:1
Xvfb :1 -screen 0 1600x900x16 &
sleep 5
openbox-session&
x11vnc -display :1 -nopw -listen localhost -xkb -forever &
cd /app/noVNC && ln -s vnc_lite.html index.html && ./utils/novnc_proxy --vnc localhost:5900