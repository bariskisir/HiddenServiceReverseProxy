# HiddenServiceReverseProxy
HiddenServiceReverseProxy is a reverse proxy that help you host applications on tor network with docker.

## Single usage
```sh
docker run -e HIDDEN_SERVICE_DIR="/var/lib/tor/hidden_service/" -e HIDDEN_SERVICE_PORT="80 192.168.1.10:80" --name hiddenservicereverseproxy bariskisir/hiddenservicereverseproxy
```

## Docker compose
```sh
version: '3.4'

services:

  web:
    image: nginx
    networks: 
      - network01
    restart: always

  hiddenservice:
    image: bariskisir/hiddenservicereverseproxy
    environment: 
      HIDDEN_SERVICE_DIR: /var/lib/tor/hidden_service/
      HIDDEN_SERVICE_PORT: 80 web:80
    networks: 
      - network01
    restart: always

networks:
    network01:
      driver: bridge
```

### Getting the domain from container
```sh
docker exec hiddenservicereverseproxy cat /var/lib/tor/hidden_service/hostname
```

### (Option 1) Testing with Brave Browser
[Brave Browser](https://brave.com/)

### (Option 2) Testing with tor browser
Create tor browser on docker
```sh
docker run -d --name torbrowser -p 5800:5800 domistyle/tor-browser
```
Navigate http://localhost:5800

[Dockerhub](https://hub.docker.com/r/bariskisir/hiddenservicereverseproxy)
