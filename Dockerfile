FROM debian:stable-slim
LABEL maintainer="Luke Childs <lukechilds123@gmail.com>"

COPY ./bin /usr/local/bin
COPY ./VERSION /tmp
COPY ./CHECKSUM /tmp

RUN VERSION=`cat /tmp/VERSION` && \
    chmod a+x /usr/local/bin/* && \
    apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates unzip && \
    curl -L https://github.com/vertcoin/vertcoin/releases/download/$VERSION/vertcoin-$VERSION-linux-64bit.zip --output /tmp/prebuilt.zip && \
    echo "$(cat /tmp/CHECKSUM)  /tmp/prebuilt.zip" | sha256sum -c && \
    unzip /tmp/prebuilt.zip -d /tmp && \
    mv /tmp/vertcoind /usr/local/bin && \
    apt-get purge -y curl ca-certificates unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/data"]
ENV HOME /data
WORKDIR /data

EXPOSE 8332 8333

ENTRYPOINT ["init"]
