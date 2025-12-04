#!/bin/bash

set -ouex pipefail

### Download and unpack Eclipes IDE

# TODO: Add desktop icon

STUDIO_VER="2025.2.1.8"

SRC_URL="https://dl.google.com/dl/android/studio/ide-zips/$STUDIO_VER/android-studio-$STUDIO_VER-linux.tar.gz"

curl -s -L -o /tmp/studio.tar.gz $SRC_URL

install -d /usr/lib/android-studio
install -d /usr/bin

tar \
  --no-same-owner \
  -xf /tmp/studio.tar.gz \
  -C /usr/lib/android-studio \
  --strip-components=1

ln -s /usr/lib/android-studio/bin/studio /usr/bin/android-studio

install -Dm0644 \
  /usr/lib/android-studio/bin/studio.svg \
  /usr/share/icons/hicolor/scalable/apps/android-studio.svg

# cleanup tmp files to save space
rm -r /tmp/studio.tar.gz
