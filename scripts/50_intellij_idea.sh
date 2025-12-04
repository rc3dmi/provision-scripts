#!/bin/bash

set -ouex pipefail

### Download and unpack Eclipes IDE

# TODO: Add desktop icon

IDEA_REL="2025.1.1.1"

SRC_FILENAME="ideaIU-$IDEA_REL.tar.gz"
SRC_URL="https://download.jetbrains.com/idea/$SRC_FILENAME"

curl -s -L -o /tmp/idea.tar.gz $SRC_URL

install -d /usr/lib/jetbrains-intellij-idea-ultimate
install -d /usr/bin

tar \
  --no-same-owner \
  -xf /tmp/idea.tar.gz \
  -C /usr/lib/jetbrains-intellij-idea-ultimate \
  --strip-components=1

install -Dm0644 \
  /usr/lib/jetbrains-intellij-idea-ultimate/bin/idea.svg \
  /usr/share/icons/hicolor/scalable/apps/jetbrains-intellij-idea-ultimate.svg

# cleanup tmp files to save space
rm -r /tmp/idea.tar.gz
