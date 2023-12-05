FROM debian:stable-slim

COPY ./bin /usr/local/bin
COPY ./VERSION /tmp
COPY ./CHECKSUM /tmp

RUN VERSION=`cat /tmp/VERSION` && \
    chmod a+x /usr/local/bin/* && \
    apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates unzip && \
    curl -L https://github.com/vertcoin-project/vertcoin-core/releases/download/v$VERSION/vertcoin-$VERSION-x86_64-linux-gnu.tar.gz --output /tmp/prebuilt.tar.gz && \
    echo "$(cat /tmp/CHECKSUM)  /tmp/prebuilt.tar.gz" | sha256sum -c && \
    tar -xvzf /tmp/prebuilt.tar.gz -C /tmp && \
    mv /tmp/vertcoin-$VERSION/bin/vertcoind /usr/local/bin && \
    mv /tmp/vertcoin-$VERSION/bin/vertcoin-cli /usr/local/bin && \
    apt-get purge -y curl ca-certificates unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/data"]
ENV HOME /data
ENV DATA /data
WORKDIR /data

EXPOSE 5888 5889

ENTRYPOINT ["init"]
