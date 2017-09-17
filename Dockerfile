FROM ubuntu:16.04
MAINTAINER Luke Childs <lukechilds123@gmail.com>

RUN apt-get update
RUN apt-get install -y curl unzip
RUN curl -L https://github.com/vertcoin/vertcoin/releases/download/v0.11.1.0/vertcoin-v0.11.1.0-linux-64bit.zip --output prebuilt.zip
RUN unzip prebuilt.zip
RUN mv vertcoind /usr/local/bin

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

VOLUME ["/data"]
ENV HOME /data
WORKDIR /data

EXPOSE 8332 8333

ENTRYPOINT ["init"]
