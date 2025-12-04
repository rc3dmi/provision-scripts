#!/bin/bash

set -ouex pipefail

### Install MongoDB

dnf install -y \
  mongodb-org

### Install NoSQLBooster

BOOSTER_VER="9.1.6"
BOOSTER_VER_MAJ="${BOOSTER_VER%%.*}"

SRC_FILENAME="nosqlbooster4mongo-$BOOSTER_VER.tar.gz"
SRC_URL="https://s3.nosqlbooster.com/download/releasesv$BOOSTER_VER_MAJ/$SRC_FILENAME"

curl -s -L -o /tmp/nosqlbooster4mongo.tar.gz $SRC_URL

install -d /usr/lib/nosqlbooster4mongo
install -d /usr/bin

tar --no-same-owner -xf /tmp/nosqlbooster4mongo.tar.gz -C /usr/lib/nosqlbooster4mongo --strip-components=1
ln -s /usr/lib/nosqlbooster4mongo/nosqlbooster4mongo  /usr/bin/nosqlbooster4mongo

# cleanup tmp files to save space

rm /tmp/nosqlbooster4mongo.tar.gz
