#!/bin/bash

set -xue

for d in \
    apt/debian/db \
    apt/debian/dists \
    apt/debian/pool \
    deb-control \
    deb-control.tar.xz \
    list \
    list.tar.xz \
    log \
    log.tar.xz \
    tar; \
do
    [ -e $d ] && echo 'run "git clean -fdx"' && exit 1
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
        $($MXEDIR/ext/config.guess) \
        i686-w64-mingw32.static \
        i686-w64-mingw32.shared \
        x86_64-w64-mingw32.static \
        x86_64-w64-mingw32.shared; \
    do
        target2=$(echo $target | sed 's/_/-/g')
        mkdir -p $DIR/mxe-$target2
        cp \
            $MXEDIR/mxe-$target2-*.$ext \
            $DIR/mxe-$target2/
    done
done

cp -r $MXEDIR/log .

for d in list deb-control log; do
    tar -cJf $d.tar.xz $d
done
