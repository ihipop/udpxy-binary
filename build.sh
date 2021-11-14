#!/bin/bash
sudo apt install gcc
BIN=udpxy
mkdir -p target
make clean
abi=`gcc -dumpmachine`
make LDFLAGS=-static release && strip ./${BIN} && tar zcvf ${BIN}_${abi}.tar.gz ${BIN} && mv ${BIN}_${abi}.tar.gz target/ && \
for abi in aarch64-linux-gnu arm-linux-gnueabihf mips-linux-gnu mips64-linux-gnuabi64 mipsel-linux-gnu mips64el-linux-gnuabi64;do
    sudo apt install gcc-${abi} -y && \
    CC=${abi}-gcc && \
    STRIP=${abi}-strip && \
    make clean && \
    make LDFLAGS=-static  CC=${CC} release && \
    $STRIP ./${BIN} && \
    file ./${BIN} && \
    mkdir -p target/${BIN}_${abi}/ && cp -f ${BIN} target/${BIN}_${abi}/${BIN} && \
    tar zcvf ${BIN}_${abi}.tar.gz ${BIN} && mv ${BIN}_${abi}.tar.gz target/
done
file target/*/udpxy
