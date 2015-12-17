#!/bin/bash

set -xue

for d in \
    repos/apt/debian/db \
    repos/apt/debian/dists \
    repos/apt/debian/pool \
    repos/deb-control \
    repos/deb-control.tar.xz \
    repos/list \
    repos/list.tar.xz \
    repos/log \
    repos/log.tar.xz \
    repos/tar; \
do
    [ -e $d ] && echo 'run "git clean -fdx"' && exit 1
done

MXEDIR=$1
export REPREPRO_BASE_DIR=$(pwd)/repos/apt/debian

for dist in wheezy jessie; do
    reprepro -C main includedeb $dist \
        $MXEDIR/mxe-*.deb \
        $MXEDIR/$dist/mxe-*.deb
    # copy directories wheezy/ and jessie/
    cp -r $MXEDIR/$dist repos/
done

for ext in tar.xz list deb-control; do
    DIR=repos/$(echo $ext | sed 's/.xz//')
    mkdir -p $DIR
    cp $MXEDIR/*.$ext $DIR
    for target in \
        $($MXEDIR/ext/config.guess) \
        i686-w64-mingw32.static \
        i686-w64-mingw32.shared \
        x86_64-w64-mingw32.static \
        x86_64-w64-mingw32.shared; \
    do
        target2=$(echo $target | sed 's/_/-/g')
        mkdir -p $DIR/mxe-$target2
        mv \
            $DIR/mxe-$target2-*.$ext \
            $DIR/mxe-$target2/
    done
done

cp -r $MXEDIR/log repos/

for d in list deb-control log; do
    tar -C repos -cJf repos/$d.tar.xz $d
done
