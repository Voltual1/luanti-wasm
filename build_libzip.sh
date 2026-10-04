#!/bin/bash -eux

source common.sh

# 直接使用你已经放在 sources/ 里的包
mkdir -p "$BUILD_DIR/libzip"
pushd "$BUILD_DIR/libzip"

# 解压（如果还没解压的话）
if [ ! -d "libzip-1.11.4" ]; then
  tar xf "$SOURCES_DIR/libzip-1.11.4.tar.gz"
fi

pushd libzip-1.11.4

emcmake cmake \
  -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
  -DBUILD_SHARED_LIBS=OFF \
  -DENABLE_COMMONCRYPTO=OFF \
  -DENABLE_GNUTLS=OFF \
  -DENABLE_MBEDTLS=OFF \
  -DENABLE_OPENSSL=OFF \
  -DENABLE_WINDOWS_CRYPTO=OFF \
  -DENABLE_BZIP2=OFF \
  -DENABLE_LZMA=OFF \
  -DENABLE_ZSTD=ON \
  -DZLIB_LIBRARY="$INSTALL_DIR/lib/libz.a" \
  -DZLIB_INCLUDE_DIR="$INSTALL_DIR/include" \
  -DZSTD_LIBRARY="$INSTALL_DIR/lib/libzstd.a" \
  -DZSTD_INCLUDE_DIR="$INSTALL_DIR/include" \
  -DCMAKE_BUILD_TYPE=Release \
  .

emmake make -j$(nproc)
emmake make install

echo "libzip OK"