# Etapa de build de socat
FROM ubuntu:20.04 AS socat-builder

ENV DEBIAN_FRONTEND=noninteractive
ENV SOCAT_VERSION=1.7.4.4

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LO http://www.dest-unreach.org/socat/download/socat-${SOCAT_VERSION}.tar.gz && \
    tar -xzf socat-${SOCAT_VERSION}.tar.gz

WORKDIR /socat-${SOCAT_VERSION}

RUN ./configure \
    --disable-openssl \
    --disable-readline \
    --disable-sctp \
    --disable-ipv6 \
    --disable-unix \
    --disable-proxy \
    --disable-socks \
    --disable-tun \
    --disable-termios \
    --disable-libwrap \
    --disable-system \
    --disable-fdnum \
    && make \
    && strip socat