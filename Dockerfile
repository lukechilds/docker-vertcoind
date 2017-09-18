FROM debian:stable-slim
LABEL maintainer="Luke Childs <lukechilds123@gmail.com>"

ADD ./bin /usr/local/bin

RUN chmod a+x /usr/local/bin/* && \
    apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates unzip && \
    curl -L https://github.com/vertcoin/vertcoin/releases/download/v0.11.1.0/vertcoin-v0.11.1.0-linux-64bit.zip --output /tmp/prebuilt.zip && \
    unzip /tmp/prebuilt.zip -d /tmp && \
    mv /tmp/vertcoind /usr/local/bin && \
    apt-get purge -y curl ca-certificates unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/data"]
ENV HOME /data
WORKDIR /data

EXPOSE 8332 8333

ENTRYPOINT ["init"]
