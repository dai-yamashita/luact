#!/bin/bash
# install build tools
apt-get -y install git
apt-get -y install gcc
apt-get -y install g++
apt-get -y install make
apt-get -y install autoconf
apt-get -y install automake
apt-get -y install autotools-dev
apt-get -y install libtool
apt-get -y install pkg-config
apt-get -y install python3.4-dev

# install dependency modules
# -- jemalloc
apt-get -y install libjemalloc-dev 
# -- openssl 
apt-get -y install openssl
pushd /tmp
# -- luajit
git clone http://luajit.org/git/luajit-2.0.git --branch $LUAJIT_VERSION
pushd luajit-2.0
make && make install
popd
rm -rf luajit-2.0
# -- rocksdb
git clone https://github.com/facebook/rocksdb.git --branch $ROCKSDB_VERSION
pushd rocksdb
make shared_lib && objcopy -S librocksdb.so && make install
popd
rm -rf rocksdb
# -- nghttp2
git clone https://github.com/tatsuhiro-t/nghttp2.git --branch $NGHTTP2_VERSION
pushd nghttp2
apt-get -y install libxml2-dev
autoreconf -i && automake && autoconf && ./configure && make && make install
objcopy -S /usr/local/lib/libnghttp2.so
popd
rm -rf nghttp2
popd

# cleanup unnecessary modules
apt-get -y remove gcc
apt-get -y remove g++
apt-get -y remove make
apt-get -y remove autoconf
apt-get -y remove automake
apt-get -y remove autotools-dev
apt-get -y remove libtool
apt-get -y remove pkg-config
apt-get -y remove libxml2-dev
apt-get -y remove python3.4-dev
