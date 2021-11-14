#!/bin/bash
sudo apt install gcc
BIN=udpxy
mkdir -p target
make clean
make LDFLAGS=-static release && strip ./${BIN} && mv  ./${BIN} target/${BIN}.`gcc -dumpmachine` && \
for abi in aarch64-linux-gnu arm-linux-gnueabihf mips-linux-gnu mips64-linux-gnuabi64 mipsel-linux-gnu mips64el-linux-gnuabi64;do
    sudo apt install gcc-${abi} -y && \
    CC=${abi}-gcc && \
    STRIP=${abi}-strip && \
    make clean && \
    make LDFLAGS=-static  CC=${CC} release && \
    $STRIP ./${BIN} && \
    file ./${BIN} && \
    mv ./${BIN} ./target/${BIN}.${abi}
done
file target/${BIN}*
