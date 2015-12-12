#!/bin/bash

set -xue

cd apt/debian

MXEDIR=$1
BASEDIR=$(pwd)

sed "s@BASEDIR@$BASEDIR@" < conf/options.in > conf/options
