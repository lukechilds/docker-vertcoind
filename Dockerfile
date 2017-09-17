FROM alpine:3.6
MAINTAINER Luke Childs <lukechilds123@gmail.com>

ADD ./bin /usr/local/bin

RUN chmod a+x /usr/local/bin/* && \
    apk add --no-cache curl unzip && \
    curl -L https://github.com/vertcoin/vertcoin/releases/download/v0.11.1.0/vertcoin-v0.11.1.0-linux-64bit.zip --output /tmp/prebuilt.zip && \
    unzip /tmp/prebuilt.zip -d /tmp && \
    mv /tmp/vertcoind /usr/local/bin && \
    apk del curl unzip && \
    rm -rf /tmp/* /var/tmp/*

RUN mkdir /lib64 && \
    ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

VOLUME ["/data"]
ENV HOME /data
WORKDIR /data

EXPOSE 8332 8333

ENTRYPOINT ["init"]
