#!/bin/bash

set -xue

for d in \
    apt/debian/db \
    apt/debian/dists \
    apt/debian/pool \
    deb-control \
    list \
    log \
    tar; \
do
    [ -d $d ] && echo 'run "git clean -fdx"' && exit 1
done

MXEDIR=$1
export REPREPRO_BASE_DIR=$(pwd)/apt/debian

for dist in wheezy jessie; do
    reprepro -C main includedeb $dist \
        $MXEDIR/mxe-*.deb \
        $MXEDIR/$dist/mxe-*.deb
done

for ext in tar.xz list deb-control; do
    DIR=$(echo $ext | sed 's/.xz//')
    mkdir -p $DIR
    for target in \
        i686-w64-mingw32.static \
        i686-w64-mingw32.shared \
        x86-64-w64-mingw32.static \
        x86-64-w64-mingw32.shared; \
    do
        mkdir -p $DIR/mxe-$target
        cp \
            $MXEDIR/mxe-$target-*.$ext \
            $DIR/mxe-$target/
    done
done

cp -r $MXEDIR/log .
