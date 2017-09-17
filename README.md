
# docker-vertcoind

[![Docker Stars](https://img.shields.io/docker/stars/lukechilds/vertcoind.svg)](https://hub.docker.com/r/lukechilds/vertcoind/)
[![Docker Pulls](https://img.shields.io/docker/pulls/lukechilds/vertcoind.svg)](https://hub.docker.com/r/lukechilds/vertcoind/)

> Run a full Vertcoin node with one command

A Docker configuration with sane defaults for running a full
Vertcoin node.

## Usage

```
docker run -v /home/username/vertcoin:/data -p 8333:8333 lukechilds/vertcoind
```

If there is a `vertcoin.conf` in the `/data` volume it will be used. If not, one will be created for you. A secure unique JSON-RPC password will also be generated.

### JSON-RPC

To access JSON-RPC you'll also need to expose port 8332. You probably only want this available to localhost:

```
docker run -v /home/username/vertcoin:/data -p 8333:8333 -p 127.0.0.1:8332:8332 lukechilds/vertcoind
```
