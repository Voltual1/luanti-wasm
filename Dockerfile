FROM ubuntu:22.04

# install deps
RUN \
    apt-get update \
    && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y \
        wget \
        python3 \
        git \
        build-essential \
        cmake \
        tclsh \
        zip \
        zstd \
        gettext \
        ca-certificates \
        curl \
        gnupg \
    # 安装 Node.js 24
    && curl -fsSL https://deb.nodesource.com/setup_24.x | bash - \
    && apt-get install -y nodejs \
    && node --version \
    && rm -rf /var/lib/apt/lists/*

COPY . /luanti-wasm

# Build luanti-wasm
RUN \
    cd /luanti-wasm \
    && ls -la \
    && ./install_emsdk.sh \
    && ./build_all.sh
