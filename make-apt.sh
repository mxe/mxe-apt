#!/bin/bash

set -xue

MXEDIR=$1
BASEDIR=$(pwd)

cd apt/debian
sed "s@BASEDIR@$BASEDIR@" < conf/options.in > conf/options
for dist in wheezy jessie; do
    reprepro includedeb $dist \
        $MXEDIR/mxe-*.deb \
        $MXEDIR/$dist/mxe-*.deb
done
cd ../..

for ext in tar.xz list deb-control do
    DIR=$(echo $ext | sed 's/.xz//')
    mkdir -p $DIR
    for target in
        i686-w64-mingw32.static \
        i686-w64-mingw32.shared \
        x86_64-w64-mingw32.static \
        x86_64-w64-mingw32.shared \
    do
        mkdir -p $DIR/mxe-$target
        cp \
            $MXEDIR/mxe-$target-*.$ext \
            $DIR/mxe-$target/
    done
done

mkdir -p log
cp -r $MXEDIR/log log
