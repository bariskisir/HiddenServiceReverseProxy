# HiddenServiceReverseProxy

**HiddenServiceReverseProxy** is a Docker-based reverse proxy that helps you host applications on the Tor network. It makes it easy to expose web applications through the Tor network without manually setting up Tor's hidden service configuration.

## Features

- Easily host any web application (e.g., Nginx, Apache) as a hidden service on the Tor network.
- Minimal configuration: Just set your backend IP/domain and port, and the proxy will handle everything.
- Automatically generates and exposes the `.onion` address for your service.
- Persist Tor data using Docker volumes, ensuring service easy to move.

## Prerequisites

- **Docker** and **Docker Compose** installed on your system.


## Single usage
```sh
docker run -d \
  -e APP_IP_DOMAIN="192.168.1.10" \ 
  -e APP_PORT="80" \ 
  -v tor_data:/var/lib/tor \ 
  --name hiddenservicereverseproxy \ 
  --restart unless-stopped \ 
  bariskisir/hiddenservicereverseproxy
```

## Docker compose
```sh
services:

  web:
    image: nginx
    networks: 
      - tor_network
    restart: unless-stopped

  hiddenservicereverseproxy:
    image: bariskisir/hiddenservicereverseproxy
    environment:
      APP_IP_DOMAIN: web
      APP_PORT: 80
    networks:
      - tor_network
    volumes:
      - tor_data:/var/lib/tor
    restart: unless-stopped

networks:
  tor_network:
    driver: bridge

volumes:
  tor_data:
    driver: local

```

### Getting the .onion domain from container
```sh
docker logs hiddenservicereverseproxy
```

### Testing with Brave Browser
[Brave Browser](https://brave.com/)
Alt+Shift+N for tor mode.

[Dockerhub](https://hub.docker.com/r/bariskisir/hiddenservicereverseproxy)
