<img width="200" alt="docker-wohnungsbot logo" src="https://github.com/Wyrrrd/docker-wohnungsbot/raw/main/icon.png">

docker-wohnungsbot
============

This repository packages [Wohnungsbot](https://github.com/neopostmodern/wohnungsbot) with [NoVNC](https://github.com/novnc/NoVNC) to make it run in docker and still be able to interact with it for CAPTCHA solving.

## How to use

### Default use case

Using the prebuilt image:

```
docker run -td -p 6080:6080 wyrrrd/wohnungsbot:latest
```

The interface is then available under http://privateip:6080

If the bot gets stuck, press ESC to restart it.

### Advanced use case

You can also build it yourself. The data is generally automatically persisted in an unnamed docker volume, but that volume can also be named.

```
docker build -t wohnungsbot https://github.com/Wyrrrd/docker-wohnungsbot.git
docker run -td -p 6080:6080 -v wohnungsbot_data:/data wohnungsbot
```

You can even build a specific tag of [Wohnungsbot](https://github.com/neopostmodern/wohnungsbot) by using the following syntax. 

```
docker build -t wohnungsbot --build-arg WB_VERSION=1.6.0 https://github.com/Wyrrrd/docker-wohnungsbot.git
```

If you are limiting the available memory for your containers, 500m should be enough. It is a GUI application after all.

## Credits

This repository is licensed under [AGPL-3.0](https://github.com/Wyrrrd/docker-wohnungsbot/blob/main/LICENSE). For the projects this repository depends on, see below. 

* [**Wohnungsbot**](https://github.com/neopostmodern/wohnungsbot) ([License](https://github.com/neopostmodern/wohnungsbot/blob/master/LICENSE), no modifications)
* [**NoVNC**](https://github.com/novnc/noVNC) ([License](https://github.com/novnc/noVNC/blob/master/LICENSE.txt), vnc_lite.html modified by [replacements.sed](https://github.com/Wyrrrd/docker-wohnungsbot/blob/main/replacements.sed) during build)
* [**Websockify**](https://github.com/novnc/websockify) ([License](https://github.com/novnc/websockify/blob/master/COPYING), no modifications)
* [**Original docker-novnc project**](https://github.com/paimpozhil/docker-novnc) (No license included, therefore all rights reserved by the author(s), forked basically for credits and inspiration, code widely replaced)
* [**Ubuntu Docker Image**](https://hub.docker.com/_/ubuntu/) ([License](https://ubuntu.com/legal/intellectual-property-policy), no modifications)