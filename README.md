docker-wohnungsbot
============

This repository packages [Wohnungsbot](https://github.com/neopostmodern/wohnungsbot) with [NoVNC](https://github.com/novnc/NoVNC) to make it run in docker and still be able to interact with it for CAPTCHA solving.

## How to use

### Default use case
```
docker build -t wohnungsbot https://github.com/Wyrrrd/docker-wohnungsbot.git
docker run -td -p 6080:6080 wohnungsbot
```

The interface is then available under http://privateip:6080

If the bot gets stuck, press ESC to restart it.

### Advanced use case

You can build a specific tag of [Wohnungsbot](https://github.com/neopostmodern/wohnungsbot) by using the following syntax. The data is generally automatically persisted in an unnamed docker volume, but that volume can also be named.

```
docker build -t wohnungsbot --build-arg WB_VERSION=1.4.0 https://github.com/Wyrrrd/docker-wohnungsbot.git
docker run -td -p 6080:6080 -v wohnungsbot_data:/data wohnungsbot
```

If you are limiting the available memory for your containers, 500m should be enough. It is a GUI application after all.

## Credits

* [Wohnungsbot](https://github.com/neopostmodern/wohnungsbot)
* [NoVNC](https://github.com/novnc/NoVNC)
* [Original docker-novnc project](https://github.com/paimpozhil/docker-novnc)
